require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = ('a'..'z').to_a.sample(10)
    alphabet.each do |letter|
      @letters << letter
    end
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    @exist = exist?(@word)
    @include = include?
  end

  private

  def exist?(word)
    url = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(url.read)
    json['found']
  end

  def include?
    params[:word].chars.all? { |letter| params[:word].count(params[:letters]) <= letter.count(params[:letters]) }
  end
end
