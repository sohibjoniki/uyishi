import 'package:dio/dio.dart';

import 'package:imd/PhotoModel.dart';
import 'package:imd/Urls.dart';

class PhotoService {
  Future<dynamic> getPhotos() async {
    try {
      Response response = await Dio().get(Urls.api);
      if (response.statusCode == 200) {
        return (response.data as List<dynamic>)
            .map((e) => PhotoModel.fromJson(e))
            .toList();
      } else {
        return response.statusMessage.toString();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        return "Iltimos internetingizni tekshiring";
      } else {
        return e.message.toString();
      }
    }
  }
}