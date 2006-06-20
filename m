From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb.cgi: whitespace cleanup
Date: Tue, 20 Jun 2006 21:52:05 +0000 (UTC)
Message-ID: <11508402972406-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 20 23:52:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fso8c-0000M5-Sb
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 23:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWFTVvs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 17:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWFTVvr
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 17:51:47 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:19334 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1751122AbWFTVvq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 17:51:46 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5KLpIcd008986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Jun 2006 23:51:18 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5KLpbca024490;
	Tue, 20 Jun 2006 23:51:37 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5KLpb9a024489;
	Tue, 20 Jun 2006 23:51:37 +0200
To: git@vger.kernel.org
Date: wto, 20 cze 2006 23:51:37 +0200
X-Mailer: git-send-email 1.3.0
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22231>

Signed-off-by: Jakub Narebski
---

 gitweb/gitweb.cgi |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

370a5cd4c8151c10809f03f0e32c7ef3767d4bb1
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 42f3296..11cc71f 100755
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
-my $stylesheet =	"gitweb.css";
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
-- 
1.3.0
