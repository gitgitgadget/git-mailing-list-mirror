From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/7] gitweb: Fix typo in git_patchset_body
Date: Sat, 26 Aug 2006 19:14:23 +0200
Message-ID: <11566124672334-git-send-email-jnareb@gmail.com>
References: <1156612392716-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 26 19:14:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH1jy-0003zu-64
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 19:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWHZROe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 13:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWHZROd
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 13:14:33 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:32902 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S964808AbWHZROc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 13:14:32 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7QHDF9G004447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Aug 2006 19:13:16 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7QHERwe032741;
	Sat, 26 Aug 2006 19:14:27 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7QHERKo032740;
	Sat, 26 Aug 2006 19:14:27 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <1156612392716-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26055>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c29ffa8..093deab 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1657,7 +1657,7 @@ sub git_patchset_body {
 	print "<div class=\"patchset\">\n";
 
 	LINE:
-	while (my $patch_line @$fd>) {
+	while (my $patch_line = <$fd>) {
 		chomp $patch_line;
 
 		if ($patch_line =~ m/^diff /) { # "git diff" header
-- 
1.4.1.1
