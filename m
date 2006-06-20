From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: add type="text/css" to stylesheet link
Date: Tue, 20 Jun 2006 04:11:32 +0000 (UTC)
Message-ID: <11507766482902-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 20 06:11:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsXZo-0004jT-PP
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 06:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWFTEKx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 00:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWFTEKx
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 00:10:53 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:59027 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932548AbWFTEKx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 00:10:53 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5K4ATE4004629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Jun 2006 06:10:29 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5K4AmKj000466;
	Tue, 20 Jun 2006 06:10:48 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5K4Am3p000465;
	Tue, 20 Jun 2006 06:10:48 +0200
To: git@vger.kernel.org
Date: wto, 20 cze 2006 06:10:48 +0200
X-Mailer: git-send-email 1.3.0
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22165>

---

 gitweb/gitweb.cgi |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

75b6977d185f946fcab8b86011f37869948c1dac
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index fa90c51..c582424 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -39,7 +39,7 @@ # html text to include at home page
 my $home_text =		"indextext.html";
 
 # URI of default stylesheet
-my $stylesheet =	"gitweb.css";
+my $stylesheet = 	"gitweb.css";
 
 # source of projects list
 #my $projects_list =	$projectroot;
@@ -272,7 +272,7 @@ sub git_header_html {
 <head>
 <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
 <meta name="robots" content="index, nofollow"/>
-<link rel="stylesheet" href="$stylesheet"/>
+<link rel="stylesheet" type="text/css" href="$stylesheet"/> 
 <title>$title</title>
 $rss_link
 </head>
-- 
1.3.0
