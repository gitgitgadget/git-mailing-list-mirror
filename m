From: freku045@student.liu.se
Subject: [PATCH 25/25] git-mv: Clean-up usage message.
Date: Sat, 10 Dec 2005 20:38:00 +0100
Message-ID: <11342434801467-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:40:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYh-0002PO-S5
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbVLJTiY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbVLJTiX
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:23 -0500
Received: from [85.8.31.11] ([85.8.31.11]:24269 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161052AbVLJTiK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:10 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 3E00B412A; Sat, 10 Dec 2005 20:48:17 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXg-00070K-00; Sat, 10 Dec 2005 20:38:00 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13462>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-mv.perl |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

a213190dc8f25c133046a35593e027cb748f662b
diff --git a/git-mv.perl b/git-mv.perl
index 83dc7e4..db6699d 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -12,13 +12,21 @@ use strict;
 use Getopt::Std;
 
 sub usage() {
-	print <<EOT;
+	print STDERR <<EOT;
 $0 [-f] [-n] <source> <destination>
 $0 [-f] [-n] [-k] <source> ... <destination directory>
 EOT
 	exit(1);
 }
 
+sub HELP_MESSAGE() {
+	usage;
+}
+
+sub VERSION_MESSAGE() {
+	usage;
+}
+
 my $GIT_DIR = `git rev-parse --git-dir`;
 exit 1 if $?; # rev-parse would have given "not a git dir" message.
 chomp($GIT_DIR);
-- 
0.99.9.GIT
