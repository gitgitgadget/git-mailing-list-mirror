From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] Move $gitbin earlier in gitweb.cgi
Date: Wed, 21 Jun 2006 11:25:54 +0200
Message-ID: <1150881955533-git-send-email-jnareb@gmail.com>
References: <1150881954924-git-send-email-jnareb@gmail.com> <115088195576-git-send-email-jnareb@gmail.com> <1150881955505-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 21 11:26:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsyyK-0008Fb-9y
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 11:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWFUJZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 05:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWFUJZ7
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 05:25:59 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:62422 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932499AbWFUJZ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 05:25:58 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5L9PYSw013059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 21 Jun 2006 11:25:34 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5L9PtMP006946;
	Wed, 21 Jun 2006 11:25:55 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5L9PtIV006945;
	Wed, 21 Jun 2006 11:25:55 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <1150881955505-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22246>

(cherry picked from 9dca843086356b964f27d8fabe1e3c48074a9f02 commit)

Signed-off-by: Jakub Narebski <jnareb@gmail.com>


---
Cherry picked commit is from feature branch in my repository:
  http://front.fuw.edu.pl/cgi-bin/jnareb/gitweb.cgi?p=git.git;a=summary
  http://front.fuw.edu.pl/jnareb/scm/git.git/

 gitweb/gitweb.cgi |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

f8bd1032e0d6ec88f540a820b4f5b4789562ee05
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 87ec565..ef7fcbd 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -22,13 +22,13 @@ my $my_url = $cgi->url();
 my $my_uri = $cgi->url(-absolute => 1);
 my $rss_link = "";
 
+# location of the git-core binaries
+my $gitbin = "/usr/bin";
+
 # absolute fs-path which will be prepended to the project path
 #my $projectroot = "/pub/scm";
 my $projectroot = "/home/kay/public_html/pub/scm";
 
-# location of the git-core binaries
-my $gitbin = "/usr/bin";
-
 # version of the git-core binaries
 my $git_version = qx($gitbin/git --version);
 if ($git_version =~ m/git version (.*)$/) {
-- 
1.3.0
