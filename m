From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Fix: Support for the standard mime.types map in gitweb
Date: Tue, 20 Jun 2006 06:19:31 +0000 (UTC)
Message-ID: <11507843541678-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 20 08:19:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsZa6-0006Ay-6J
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 08:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbWFTGTT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 02:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWFTGTT
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 02:19:19 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:50641 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S965086AbWFTGTS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 02:19:18 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5K6Itt7019030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Jun 2006 08:18:55 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5K6JEUo001861;
	Tue, 20 Jun 2006 08:19:14 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5K6JEaA001860;
	Tue, 20 Jun 2006 08:19:14 +0200
To: git@vger.kernel.org
Date: wto, 20 cze 2006 08:19:14 +0200
X-Mailer: git-send-email 1.3.0
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22172>

Temporary fix: commented out offending line in mimetype_guess.

---

 gitweb/gitweb.cgi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

718a3b4c1e56c0330fa2c7ced2e66be5b095b541
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 11cc71f..1b254df 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1524,7 +1524,7 @@ sub mimetype_guess {
 
 	if ($mimetypes_file) {
 		my $file = $mimetypes_file;
-		$file =~ m#^/# or $file = "$projectroot/$path/$file";
+		#$file =~ m#^/# or $file = "$projectroot/$path/$file";
 		$mime = mimetype_guess_file($filename, $file);
 	}
 	$mime ||= mimetype_guess_file($filename, '/etc/mime.types');
-- 
1.3.0
