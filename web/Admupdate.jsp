<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="util.DbConnect" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改一名联系人</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
</head>
<body>
<div  class="jumbotron jumbotron-fluid">
    <div class="container">
        <h1 class="display-4">修改联系人信息</h3>

    </div>
</div>
<%!
    String id;
    String name;
    String pwd;
    String phone;
%>
<%
    response.setContentType("text/html");
    request.setCharacterEncoding("utf-8");
    response.setCharacterEncoding("utf-8");
    id = request.getParameter("id");
    Connection connection = DbConnect.getConnection();
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    HttpSession httpSession = request.getSession();
    List users = null;
    String sql = "select * from users where user_id ="+id;
    try {
        preparedStatement = connection.prepareStatement(sql);
        resultSet=preparedStatement.executeQuery();
        httpSession.setMaxInactiveInterval(7200);
        if(resultSet!=null && resultSet.next()){
            name = resultSet.getString(2);
            pwd = resultSet.getString(3);
            phone = resultSet.getString(4);
        }else{
            httpSession.setAttribute("message", "更新失败！");
            response.sendRedirect("error.jsp");
        }
    }catch (Exception e) {
        e.printStackTrace();
    }
%>
<center>
    <form action="/addressList/AdmupdateServlet" method="post">
        <table border="1" style="margin: 5%" class="table table-bordered" >
            <tr>
                <td>序号</td>
                <td><input type="text" name="updateid" value="<%=id%>" readonly="true" class="form-control"></td>
            </tr>
            <tr>
                <td>用户名</td>
                <td><input type="text" name="updatename" value="<%=name%>" class="form-control"></td>
            </tr>
            <tr>
                <td>密码</td>
                <td><input type="text" name="updatepwd" value="<%=pwd%>" class="form-control"></td>
            </tr>
            <tr>
                <td>电话</td>
                <td><input type="text" name="updatephone" value="<%=phone%>" class="form-control"></td>
            </tr>
        </table>
        <br />
        <input type="submit" value="保存" class="btn btn-primary"/>
        <button class="btn btn-light">
            <a href="userslist.jsp">返回</a>
        </button>

    </form>
</center>
</body>
</html>