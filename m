From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Make CSS file gitweb/gitweb.css more readable
Date: Tue, 20 Jun 2006 03:48:36 +0000 (UTC)
Message-ID: <11507752922146-git-send-email-jnareb@gmail.com>
References: <7vwtbc9a45.fsf@assigned-by-dhcp.cox.net>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 20 05:48:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsXDx-0000sH-FH
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 05:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965456AbWFTDsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 23:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965457AbWFTDsS
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 23:48:18 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:12445 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S965456AbWFTDsR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 23:48:17 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5K3lrXM002466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Jun 2006 05:47:53 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5K3mCGY032688;
	Tue, 20 Jun 2006 05:48:12 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5K3mCJh032687;
	Tue, 20 Jun 2006 05:48:12 +0200
To: git@vger.kernel.org
Date: wto, 20 cze 2006 05:48:12 +0200
X-Mailer: git-send-email 1.3.0
In-Reply-To: <7vwtbc9a45.fsf@assigned-by-dhcp.cox.net>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22164>

---

 gitweb/gitweb.css |  273 +++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 223 insertions(+), 50 deletions(-)

72888c0a080d95117d54dc9578dc2a0de7b19abd
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 5900916..9d91426 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -1,58 +1,231 @@
 body {
-	font-family: sans-serif; font-size: 12px; border:solid #d9d8d1; border-width:1px;
-	margin:10px; background-color:#ffffff; color:#000000;
-}
-a { color:#0000cc; }
-a:hover, a:visited, a:active { color:#880000; }
-div.page_header { height:25px; padding:8px; font-size:18px; font-weight:bold; background-color:#d9d8d1; }
-div.page_header a:visited, a.header { color:#0000cc; }
-div.page_header a:hover { color:#880000; }
-div.page_nav { padding:8px; }
-div.page_nav a:visited { color:#0000cc; }
-div.page_path { padding:8px; border:solid #d9d8d1; border-width:0px 0px 1px}
-div.page_footer { height:17px; padding:4px 8px; background-color: #d9d8d1; }
-div.page_footer_text { float:left; color:#555555; font-style:italic; }
-div.page_body { padding:8px; }
+	font-family: sans-serif;
+	font-size: 12px;
+	border:solid #d9d8d1;
+	border-width: 1px;
+	margin: 10px;
+	background-color: #ffffff;
+	color: #000000;
+}
+
+a { 
+	color: #0000cc;
+}
+
+a:hover, a:visited, a:active {
+	color: #880000;
+}
+
+div.page_header {
+	height: 25px;
+	padding: 8px;
+	font-size: 18px;
+	font-weight: bold;
+	background-color: #d9d8d1;
+}
+
+div.page_header a:visited, a.header {
+	color: #0000cc;
+}
+
+div.page_header a:hover {
+	color: #880000;
+}
+
+div.page_nav {
+	padding:8px;
+}
+
+div.page_nav a:visited {
+	color: #0000cc;
+}
+
+div.page_path {
+	padding: 8px;
+	border: solid #d9d8d1;
+	border-width: 0px 0px 1px;
+}
+
+div.page_footer {
+	height: 17px;
+	padding: 4px 8px;
+	background-color: #d9d8d1;
+}
+
+div.page_footer_text {
+	float: left;
+	color: #555555;
+	font-style: italic;
+}
+
+div.page_body {
+	padding: 8px;
+}
+
 div.title, a.title {
-	display:block; padding:6px 8px;
-	font-weight:bold; background-color:#edece6; text-decoration:none; color:#000000;
+	display: block;
+	padding: 6px 8px;
+	font-weight: bold;
+	background-color: #edece6;
+	text-decoration: none;
+	color: #000000;
+}
+
+a.title:hover {
+	background-color: #d9d8d1;
+}
+
+div.title_text {
+	padding: 6px 0px;
+	border: solid #d9d8d1;
+	border-width: 0px 0px 1px;
 }
-a.title:hover { background-color: #d9d8d1; }
-div.title_text { padding:6px 0px; border: solid #d9d8d1; border-width:0px 0px 1px; }
-div.log_body { padding:8px 8px 8px 150px; }
-span.age { position:relative; float:left; width:142px; font-style:italic; }
+
+div.log_body {
+	padding: 8px 8px 8px 150px;
+}
+
+span.age {
+	position: relative;
+	float: left;
+	width: 142px;
+	font-style:italic;
+}
+
 div.log_link {
-	padding:0px 8px;
-	font-size:10px; font-family:sans-serif; font-style:normal;
-	position:relative; float:left; width:136px;
-}
-div.list_head { padding:6px 8px 4px; border:solid #d9d8d1; border-width:1px 0px 0px; font-style:italic; }
-a.list { text-decoration:none; color:#000000; }
-a.list:hover { text-decoration:underline; color:#880000; }
-a.text { text-decoration:none; color:#0000cc; }
-a.text:visited { text-decoration:none; color:#880000; }
-a.text:hover { text-decoration:underline; color:#880000; }
-table { padding:8px 4px; }
-th { padding:2px 5px; font-size:12px; text-align:left; }
-tr.light:hover { background-color:#edece6; }
-tr.dark { background-color:#f6f6f0; }
-tr.dark:hover { background-color:#edece6; }
-td { padding:2px 5px; font-size:12px; vertical-align:top; }
-td.link { padding:2px 5px; font-family:sans-serif; font-size:10px; }
-div.pre { font-family:monospace; font-size:12px; white-space:pre; }
-div.diff_info { font-family:monospace; color:#000099; background-color:#edece6; font-style:italic; }
-div.index_include { border:solid #d9d8d1; border-width:0px 0px 1px; padding:12px 8px; }
-div.search { margin:4px 8px; position:absolute; top:56px; right:12px }
-a.linenr { color:#999999; text-decoration:none }
+	padding: 0px 8px;
+	font-size: 10px;
+	font-family: sans-serif;
+	font-style:normal;
+	position: relative;
+	float: left;
+	width: 136px;
+}
+
+div.list_head {
+	padding: 6px 8px 4px;
+	border: solid #d9d8d1;
+	border-width: 1px 0px 0px;
+	font-style: italic;
+}
+
+a.list {
+	text-decoration: none;
+	color: #000000;
+}
+
+a.list:hover {
+	text-decoration: underline;
+	color: #880000;
+}
+
+a.text {
+	text-decoration: none;
+	color: #0000cc;
+}
+
+a.text:visited {
+	text-decoration: none;
+	color: #880000;
+}
+
+a.text:hover {
+	text-decoration: underline;
+	color: #880000;
+}
+
+table {
+	padding: 8px 4px;
+}
+
+th {
+	padding: 2px 5px;
+	font-size: 12px;
+	text-align: left;
+}
+
+tr.light:hover {
+	background-color: #edece6;
+}
+
+tr.dark {
+	background-color: #f6f6f0;
+}
+
+tr.dark:hover {
+	background-color: #edece6;
+}
+
+
+td {
+	padding: 2px 5px;
+	font-size: 12px;
+	vertical-align:top;
+}
+
+td.link {
+	padding: 2px 5px;
+	font-family: sans-serif;
+	font-size: 10px;
+}
+
+div.pre {
+	font-family: monospace;
+	font-size: 12px;
+	white-space: pre;
+	/* padding-left: 5px; */
+}
+
+div.diff_info {
+	font-family: monospace;
+	color: #000099;
+	background-color: #edece6;
+	font-style: italic;
+}
+
+div.index_include {
+	border: solid #d9d8d1;
+	border-width: 0px 0px 1px;
+	padding: 12px 8px;
+}
+
+div.search {
+	margin: 4px 8px;
+	position: absolute;
+	top: 56px;
+	right: 12px
+}
+
+a.linenr {
+	color: #999999;
+	text-decoration: none
+}
+
 a.rss_logo {
-	float:right; padding:3px 0px; width:35px; line-height:10px;
-	border:1px solid; border-color:#fcc7a5 #7d3302 #3e1a01 #ff954e;
-	color:#ffffff; background-color:#ff6600;
-	font-weight:bold; font-family:sans-serif; font-size:10px;
-	text-align:center; text-decoration:none;
+	float: right;
+	padding: 3px 0px;
+	width: 35px;
+	line-height: 10px;
+	border: 1px solid;
+	border-color: #fcc7a5 #7d3302 #3e1a01 #ff954e;
+	color: #ffffff;
+	background-color: #ff6600;
+	font-weight: bold;
+	font-family: sans-serif;
+	font-size: 10px;
+	text-align: center;
+	text-decoration: none;
+}
+
+a.rss_logo:hover {
+	background-color: #ee5500;
 }
-a.rss_logo:hover { background-color:#ee5500; }
+
 span.tag {
-	padding:0px 4px; font-size:10px; font-weight:normal;
-	background-color:#ffffaa; border:1px solid; border-color:#ffffcc #ffee00 #ffee00 #ffffcc;
+	padding: 0px 4px;
+	font-size: 10px;
+	font-weight: normal;
+	background-color: #ffffaa;
+	border: 1px solid;
+	border-color: #ffffcc #ffee00 #ffee00 #ffffcc;
 }
-- 
1.3.0
