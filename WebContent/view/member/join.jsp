<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>join page</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- CSS
================================================== -->
<link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap-responsive.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/custom-styles.css">

<!-- Favicons
================================================== -->
<link rel="shortcut icon" href="<%= request.getContextPath() %>/img/titlelogo.ico">
<link rel="apple-touch-icon" href="<%= request.getContextPath() %>/img/titlelogo.ico">
<link rel="apple-touch-icon" sizes="72x72"   href="<%= request.getContextPath() %>/img/titlelogo.ico">
<link rel="apple-touch-icon" sizes="114x114" href="<%= request.getContextPath() %>/img/titlelogo.ico">


<!-- JS
================================================== -->
<script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script src="<%= request.getContextPath() %>/js/bootstrap.js"></script>
<script src="<%= request.getContextPath() %>/js/jquery.custom.js"></script>
<script src="validation/jquery.validate.js"></script>

<!-- 우편번호 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample4_execDaumPostcode() {
    	/* 기본테마 색상 변경 */
    	var themeObj = {
    			   bgColor: "##ECECEC", 
    			   searchBgColor: "#FFFFFF",
    			   contentBgColor: "#FFFFFF", 
    			   pageBgColor: "#FAFAFA", 
    			   textColor: "#333333", 
    			   queryTextColor: "#222222", 
    			   postcodeTextColor: "#FA4256", 
    			   emphTextColor: "#008BD3", 
    			   outlineColor: "#E0E0E0" 
    			};
    	new daum.Postcode({
    		theme: themeObj,
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
                

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('roadAddress').value = fullRoadAddr;
                document.getElementById('jibunAddress').value = data.jibunAddress;

                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
    

    //회원가입창의 아이디 입력란의 값을 가져온다.
    function openIdChk(){
    	 
    	window.name = "parentForm";
    	window.open("member_id_check.jsp",
    			"chkForm", "width=500, height=300, resizable=1, scrollbars=1");
    	
    }
    
    function inputIdChk(){
    	document.frm.idDuplication.value = "idUncheck";
    }
    
    function checkValue(){
    	 var form = document.frm;         
         if(form.idDuplication.value != "idCheck"){
             alert("아이디 중복체크를 해주세요.");
             return false;
         }

    }

    
</script>
<style type="text/css">
label {
	color:#d8450b;
}
</style>

<!-- validation -->
<script type="text/javascript">
	$(function(){
		 $("#frm").validate({
             
	           rules: { //규칙
	               zipcode: {
	                   required : true
	               },
	               dong: {
	                   required : true     
	               },
	               ho: {
	                   required : true
	               },
	               id: {
	                   required : true
	               },
	               pwd: {
	                   required : true
	               },
	               pwdcheck: {
	                   required : true
	               }
	                        
	           },        
	           messages : {//규칙체크 실패시 출력될 메시지
	        	   zipcode: {
	                   required : "우편번호를 입력하세요"
	               },
	               dong: {
	                   required : "동을 입력하세요"
	               },
	               ho: {
	                   required : "호를 입력하세요"
	               },
	               id: {
	                   required : "아이디를 입력하세요"
	               },
	               pwd: {
	                   required : "비밀번호를 입력하세요"
	               },
	               pwdcheck: {
	                   required : "확인비밀번호 입력하세요"
	               }
	               
	           }
	       });
	});
	


</script>
</head>

<body>
	<div class="color-bar-1"></div>
    <div class="color-bar-2 color-bg"></div>    
    <div class="container main-container">    
      <div class="row header"><!-- Begin Header -->      
	     <!-- Logo
        ================================================== -->
         <div class="span5 logo">
            <a href="<%= request.getContextPath() %>/view/homepage.jsp">
            <img src="<%= request.getContextPath() %>/img/piccolo-logo.png" alt="" /></a>
            <h5>Apartment Community</h5>
         </div>

          <!-- Main Navigation
        ================================================== -->
        <div class="span7 navigation">
            <div class="navbar hidden-phone">
            
            <ul class="nav">
            <li class="dropdown active">
                <a href="<%= request.getContextPath() %>/view/homepage.jsp">Home</a>
            </li>
            <li><a href="<%= request.getContextPath() %>/view/member/login.jsp">Login</a></li>
            </ul>
            </div>
        </div>
        
      </div><!-- End Header -->


    <!-- Page Content
    ================================================== --> 
    
        <div class="row">
           <div class="span12 contact" align="center">
    <!-- (s)content -->
    <div>
        <div>
            <div style="margin-top:50px;">
                <h2>Join Us</h2>
            </div>
            <fieldset>
                <form name="frm" id="frm" action="MemberJoinOk.member"	method="post" 
                			onsubmit="return checkValue()">
                    <div class="input-prepend" style="margin-bottom: 20px">
                        <div>
                        	<span class="add-on"><i class="icon-home"></i></span>
		                    <input type="text" class="span4" id="zipcode" name="zipcode" placeholder="우편번호" onclick="sample4_execDaumPostcode()">
							<span id="guide" style="color:#999"></span>
                    	</div>
	                    <div class="input-prepend">  
	                        <div>
	                        	<span class="add-on"><i class="icon-home"></i></span>
		                        <input type="text" class="span4" id="roadAddress" name="roadAddress" placeholder="도로명주소">
		                        <span id="guide" style="color:#999"></span>
	                        </div>
	                        <div>
	                        	<span class="add-on"><i class="icon-home"></i></span>
		                        <input type="text" class="span4" id="jibunAddress" name="jibunAddress" placeholder="지번주소">
	                        	<span id="guide" style="color:#999"></span>
	                        </div>
                        </div>
                    </div>
                    
                    <div class="input-prepend" style="margin-bottom: 20px">
                        <div>
                        	<span class="add-on"><i class="icon-home"></i></span>
                            <input type="text" class="span4" maxlength="40" id="dong" name="dong" placeholder="동"> 
                        </div>
                        <div>
                        	<span class="add-on"><i class="icon-home"></i></span>
                            <input type="text" class="span4" maxlength="40" id="ho" name="ho" placeholder="호수">
                        </div>
                    </div>
                    
                    <div class="input-prepend" style="margin-bottom: 20px">
                    	<span class="add-on"><i class="icon-user"></i></span>
                        <input type="email" class="span3" maxlength="40" name="id" id="id" placeholder="코끼리Email" onkeydown="inputIdChk()">
                        <input type="button" class="btn btn-inverse" value="중복확인" onclick="openIdChk()" style="width:100px">
                   		<input type="hidden" name="idDuplication" value="idUncheck">
                    </div>
                    
                    <div class="input-prepend" style="margin-bottom: 20px">
                        <div>
                        	<span class="add-on"><i class="icon-lock"></i></span>
                            <input type="password" class="span4" maxlength="20" name="pwd" id="pwd" placeholder="비밀번호" >
                        </div>
                        <div>
                        	<span class="add-on"><i class="icon-ok"></i></span>
                            <input type="password" class="span4" maxlength="20" name="pwdcheck" id="pwdcheck" placeholder="비밀번호 재입력">

                        </div>
                    </div>
                    
                    <div align="center" style="margin-bottom:150px">
                    	<input type="submit" class="btn btn-inverse" value="가입하기" style="width:380px">
                    </div>
                   
                </form>
            </fieldset>
        </div>
    </div>
    <!-- (e)content -->

</div>            
        </div><!--//container-->
 
</div> <!-- End Container -->

    <!-- Footer Area
        ================================================== -->

  <!-- Footer Area
        ================================================== -->
	<div class="footer-container"><!-- Begin Footer -->
        <div class="container">        	
		       <div class="row"><!-- Begin Sub Footer -->
		                <div class="span12 footer-col footer-sub">
		                    <div class="row no-margin">
		                        <div class="span6"><span class="left">Copyright 2017 KOGGIRI Theme. All rights reserved.</span></div>
		                        <div class="span6">
		                            <span class="right">
		                            <a href="<%=request.getContextPath()%>/view/homepage.jsp">Home</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
		                            <a href="<%=request.getContextPath()%>/AllList.board">Board</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
		                            <a href="<%=request.getContextPath()%>/Gallery.board">Gallery</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
		                            <a href="<%= request.getContextPath() %>/view/calendar/calendar_list.jsp">Calendar</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
		                            <a href="<%= request.getContextPath() %>/view/reservation/Reservation.jsp">Reservation</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
		                            <a href="<%=request.getContextPath()%>/MemberList.member">Manager</a>
		                            </span>
		                        </div>
		                    </div>
		                </div>
		       </div><!-- End Sub Footer -->		
		</div>
	</div>
      <!-- End Footer -->       
    
</body>
</html>