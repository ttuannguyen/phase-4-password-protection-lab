class UsersController < ApplicationController

    before_action :authorize, only: [:show]

    def create
        user = User.create(user_params)
        if user.valid?
            render json: user, status: :created
        else
            render json: { error: user.error.full_messages },  status: :unprocessable_entity
    end

    def show
        user = user.find(session[:user_id])
        render json: user
    end

    private 

    def authorize
        return return json: { error: "Not Authorized" }, status: :unathorized unless session include? :user_id
    end

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
