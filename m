From: freku045@student.liu.se
Subject: [PATCH 11/25] git-revert: Fix usage message
Date: Sat, 10 Dec 2005 20:37:58 +0100
Message-ID: <11342434781344-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:40:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYk-0002PO-Rm
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbVLJTif (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbVLJTie
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:34 -0500
Received: from [85.8.31.11] ([85.8.31.11]:21709 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161042AbVLJTiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:09 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 4E0BF411C; Sat, 10 Dec 2005 20:48:15 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXe-0006zM-00; Sat, 10 Dec 2005 20:37:58 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13468>

Also syncs the usage message in the documentation with the usage message in
the implementation.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 Documentation/git-revert.txt |    2 +-
 git-revert.sh                |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

3fbfe1e03eba7db1e484b7d00ac77820e6a11907
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index e27c680..6684a60 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -7,7 +7,7 @@ git-revert - Revert an existing commit.
 
 SYNOPSIS
 --------
-'git-revert' [--edit | --no-edit] [-n] <commit>
+'git-revert' [--edit | --no-edit] [-n | --no-commit] <commit>
 
 DESCRIPTION
 -----------
diff --git a/git-revert.sh b/git-revert.sh
index 9d499c4..0a94344 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -19,10 +19,10 @@ esac
 usage () {
 	case "$me" in
 	cherry-pick)
-		die "usage git $me [--edit] [-n] [-r] <commit-ish>"
+		die "usage: $0 [--edit] [-n | --no-commit] [-r] <commit>"
 		;;
 	revert)
-		die "usage git $me [--edit | --no-edit] [-n] <commit-ish>"
+		die "usage $0 [--edit | --no-edit] [-n | --no-commit] <commit>"
 		;;
 	esac
 }
-- 
0.99.9.GIT
