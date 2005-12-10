From: freku045@student.liu.se
Subject: [PATCH 17/25] git-relink: Print usage message to stderr.
Date: Sat, 10 Dec 2005 20:37:59 +0100
Message-ID: <11342434794009-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:40:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYd-0002PO-FN
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbVLJTia (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbVLJTi2
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:28 -0500
Received: from [85.8.31.11] ([85.8.31.11]:22477 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161046AbVLJTiK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:10 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 339714123; Sat, 10 Dec 2005 20:48:16 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXf-0006zo-00; Sat, 10 Dec 2005 20:37:59 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13455>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-relink.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

c8f3a2016fcd16470507af70bf4de17de3881f6f
diff --git a/git-relink.perl b/git-relink.perl
index f6b4f6a..816e238 100755
--- a/git-relink.perl
+++ b/git-relink.perl
@@ -163,11 +163,11 @@ sub link_two_files($$) {
 
 
 sub usage() {
-	print("Usage: $0 [--safe] <dir> [<dir> ...] <master_dir> \n");
-	print("All directories should contain a .git/objects/ subdirectory.\n");
-	print("Options\n");
-	print("\t--safe\t" .
+	print STDERR "usage: $0 [--safe] <dir> [<dir>...] <master_dir>\n";
+	print STDERR "All directories should contain a .git/objects/ subdirectory.\n";
+	print STDERR "Options\n";
+	print STDERR "\t--safe\t" .
 		"Stops if two objects with the same hash exist but " .
-		"have different sizes.  Default is to warn and continue.\n");
+		"have different sizes.  Default is to warn and continue.\n";
 	exit(1);
 }
-- 
0.99.9.GIT
