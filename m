From: freku045@student.liu.se
Subject: [PATCH 2/25] git-branch: Use $0 instead of program name in usage message.
Date: Sat, 10 Dec 2005 20:37:57 +0100
Message-ID: <1134243477755-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:38:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAXx-0002Gb-9f
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbVLJTiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbVLJTiL
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:11 -0500
Received: from [85.8.31.11] ([85.8.31.11]:15565 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S965062AbVLJTiH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:07 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 206F94102; Sat, 10 Dec 2005 20:48:14 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXd-0006ym-00; Sat, 10 Dec 2005 20:37:57 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13447>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-branch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

57d5239afe20cda3f902d2deab4cd3777f82eca6
diff --git a/git-branch.sh b/git-branch.sh
index 5306b27..90a1b5b 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -8,7 +8,7 @@ die () {
 }
 
 usage () {
-    echo >&2 "usage: $(basename $0)"' [-d <branch>] | [[-f] <branch> [start-point]]
+    echo >&2 "usage: $0"' [-d <branch>] | [[-f] <branch> [start-point]]
 
 If no arguments, show available branches and mark current branch with a star.
 If one argument, create a new branch <branchname> based off of current HEAD.
-- 
0.99.9.GIT
