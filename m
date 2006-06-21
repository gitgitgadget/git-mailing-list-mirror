From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: whitespace cleanup
Date: Wed, 21 Jun 2006 11:25:52 +0200
Message-ID: <115088195576-git-send-email-jnareb@gmail.com>
References: <1150881954924-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 21 11:26:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsyyL-0008Fb-Ty
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 11:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWFUJ0B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 05:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWFUJ0B
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 05:26:01 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:62934 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932504AbWFUJZ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 05:25:58 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5L9PXSD013055
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 21 Jun 2006 11:25:33 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5L9Pt9j006934;
	Wed, 21 Jun 2006 11:25:55 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5L9Ptv2006933;
	Wed, 21 Jun 2006 11:25:55 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <1150881954924-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22248>

Do not use tabs to align variable initialization (actually use
tabs only at the beginning of line, for code indent).  Remove trailing
whitespace.  Make whitespace usage more consistent.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>


---

 gitweb/gitweb.cgi |   38 +++++++++++++++++++-------------------
 gitweb/gitweb.css |    4 ++--
 2 files changed, 21 insertions(+), 21 deletions(-)

691405ab79e0dacbe3b96a404740faf3f10bffd7
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 44896bb..89224e6 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -17,33 +17,33 @@ use Fcntl ':mode';
 binmode STDOUT, ':utf8';
 
 my $cgi = new CGI;
-my $version =		"267";
-my $my_url =		$cgi->url();
-my $my_uri =		$cgi->url(-absolute => 1);
-my $rss_link =		"";
+my $version = "267";
+my $my_url = $cgi->url();
+my $my_uri = $cgi->url(-absolute => 1);
+my $rss_link = "";
 
 # absolute fs-path which will be prepended to the project path
-#my $projectroot =	"/pub/scm";
-my $projectroot =	"/home/kay/public_html/pub/scm";
+#my $projectroot = "/pub/scm";
+my $projectroot = "/home/kay/public_html/pub/scm";
 
 # location of the git-core binaries
-my $gitbin =		"/usr/bin";
+my $gitbin = "/usr/bin";
 
 # location for temporary files needed for diffs
-my $git_temp =		"/tmp/gitweb";
+my $git_temp = "/tmp/gitweb";
 
 # target of the home link on top of all pages
-my $home_link =		$my_uri;
+my $home_link = $my_uri;
 
 # html text to include at home page
-my $home_text =		"indextext.html";
+my $home_text = "indextext.html";
 
 # URI of default stylesheet
-my $stylesheet = 	"gitweb.css";
+my $stylesheet = "gitweb.css";
 
 # source of projects list
-#my $projects_list =	$projectroot;
-my $projects_list =	"index/index.aux";
+#my $projects_list = $projectroot;
+my $projects_list = "index/index.aux";
 
 # default blob_plain mimetype and default charset for text/plain blob
 my $default_blob_plain_mimetype = 'text/plain';
@@ -51,7 +51,7 @@ my $default_text_plain_charset  = undef;
 
 # file to use for guessing MIME types before trying /etc/mime.types
 # (relative to the current git repository)
-my $mimetypes_file              = undef;
+my $mimetypes_file = undef;
 
 
 # input validation and dispatch
@@ -349,7 +349,7 @@ sub git_footer_html {
 
 sub die_error {
 	my $status = shift || "403 Forbidden";
-	my $error = shift || "Malformed query, file missing or permission denied"; 
+	my $error = shift || "Malformed query, file missing or permission denied";
 
 	git_header_html($status);
 	print "<div class=\"page_body\">\n" .
@@ -1066,7 +1066,7 @@ sub git_summary {
 			      "<td>";
 			if (length($co{'title_short'}) < length($co{'title'})) {
 				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"), -class => "list", -title => "$co{'title'}"},
-			              "<b>" . esc_html($co{'title_short'}) . "$ref</b>");
+				      "<b>" . esc_html($co{'title_short'}) . "$ref</b>");
 			} else {
 				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"), -class => "list"},
 				      "<b>" . esc_html($co{'title'}) . "$ref</b>");
@@ -1124,7 +1124,7 @@ sub git_summary {
 				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'reftype'};h=$tag{'refid'}")}, $tag{'reftype'});
 				if ($tag{'reftype'} eq "commit") {
 				      print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}")}, "shortlog") .
-				            " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'refid'}")}, "log");
+					    " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'refid'}")}, "log");
 				}
 				print "</td>\n" .
 				      "</tr>";
@@ -1362,7 +1362,7 @@ sub git_tags {
 			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'reftype'};h=$tag{'refid'}")}, $tag{'reftype'});
 			if ($tag{'reftype'} eq "commit") {
 			      print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}")}, "shortlog") .
-			            " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'refid'}")}, "log");
+				    " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'refid'}")}, "log");
 			}
 			print "</td>\n" .
 			      "</tr>";
@@ -1942,7 +1942,7 @@ sub git_commit {
 		      "</td>" .
 		      "</tr>\n";
 	}
-	print "</table>". 
+	print "</table>".
 	      "</div>\n";
 	print "<div class=\"page_body\">\n";
 	my $comment = $co{'comment'};
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index ac6a3c7..98410f5 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -1,7 +1,7 @@
 body {
 	font-family: sans-serif;
 	font-size: 12px;
-	border:solid #d9d8d1;
+	border: solid #d9d8d1;
 	border-width: 1px;
 	margin: 10px;
 	background-color: #ffffff;
@@ -33,7 +33,7 @@ div.page_header a:hover {
 }
 
 div.page_nav {
-	padding:8px;
+	padding: 8px;
 }
 
 div.page_nav a:visited {
-- 
1.3.0
