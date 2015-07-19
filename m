From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/6] worktree: consistently use term "linked working tree" in manpages
Date: Sat, 18 Jul 2015 19:10:53 -0700
Message-ID: <097393a343401706ac8041eb01a9e61949a31d2d.1437271363.git.mhagger@alum.mit.edu>
References: <cover.1437271363.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 04:11:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGe52-0008Qc-VJ
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 04:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbbGSCLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 22:11:42 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61558 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752545AbbGSCLj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2015 22:11:39 -0400
X-AuditID: 12074414-f794f6d000007852-41-55ab0756a005
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 0C.18.30802.6570BA55; Sat, 18 Jul 2015 22:11:34 -0400 (EDT)
Received: from localhost.localdomain ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6J2BUOb011238
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jul 2015 22:11:33 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1437271363.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqBvGvjrU4GSjhkXXlW4mi4beK8wW
	t1fMZ7bonvKW0eLMm0ZGB1aPv+8/MHnsnHWX3ePiJWWPxQ+8PD5vkgtgjeK2SUosKQvOTM/T
	t0vgzljV1MRYsFWmovH4XpYGxmXiXYycHBICJhKLu08xQthiEhfurWfrYuTiEBK4zChx+N5F
	FghnPZPErxuXWUCq2AR0JRb1NDOB2CICmxglWl/ng9jMAg4Smz83gk0SFgiTePy7D6ieg4NF
	QFXiwSFVkDCvQJTEgQVv2CCWyUmcP/6TGcTmFLCQmPSqBSwuJGAucXveP+YJjLwLGBlWMcol
	5pTm6uYmZuYUpybrFicn5uWlFula6OVmluilppRuYoQElMgOxiMn5Q4xCnAwKvHwWnxZFSrE
	mlhWXJl7iFGSg0lJlLf0FVCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG8+4+pQId6UxMqq1KJ8
	mJQ0B4uSOO+3xep+QgLpiSWp2ampBalFMFkZDg4lCV4VNqBGwaLU9NSKtMycEoQ0EwcnyHAu
	KZHi1LyU1KLE0pKMeFBkxBcDYwMkxQO09xUryN7igsRcoChE6ylGY441s++vZeJYsuvBWiYh
	lrz8vFQpcV4HkE0CIKUZpXlwi2Cp5BWjONDfwrzNIFU8wDQEN+8V0ComoFWdq1eArCpJREhJ
	NTCGRrIo8dl+eJS+1W9aeoh529m7fMVvQ6LtVh7eLKIfm6nQELe8++T6OwJRTDtttorY1M7X
	2rzunMz7Y2rfbf+wn29t1DAx3qNZfGn3jinPkgXmSX3gcz0qrHHueaqxYNabZWdO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274189>

Sometimes linked working trees were called "linked working
directories" or "linked worktrees". Always refer to them as "linked
working trees" for consistency.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-worktree.txt         | 10 +++++-----
 Documentation/gitrepository-layout.txt |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index da71f50..c8dd0e5 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -31,9 +31,9 @@ The working tree's administrative files in the repository (see
 `git worktree prune` in the main or any linked working tree to
 clean up any stale administrative files.
 
-If you move a linked working directory to another file system, or
+If you move a linked working tree to another file system, or
 within a file system that does not support hard links, you need to run
-at least one git command inside the linked working directory
+at least one git command inside the linked working tree
 (e.g. `git status`) in order to update its administrative files in the
 repository so that they do not get automatically pruned.
 
@@ -141,7 +141,7 @@ demands that you fix something immediately. You might typically use
 linkgit:git-stash[1] to store your changes away temporarily, however, your
 worktree is in such a state of disarray (with new, moved, and removed files,
 and other bits and pieces strewn around) that you don't want to risk
-disturbing any of it. Instead, you create a temporary linked worktree to
+disturbing any of it. Instead, you create a temporary linked working tree to
 make the emergency fix, remove it when done, and then resume your earlier
 refactoring session.
 
@@ -163,10 +163,10 @@ recommended to make multiple checkouts of a superproject.
 git-worktree could provide more automation for tasks currently
 performed manually, such as:
 
-- `remove` to remove a linked worktree and its administrative files (and
+- `remove` to remove a linked working tree and its administrative files (and
   warn if the worktree is dirty)
 - `mv` to move or rename a worktree and update its administrative files
-- `list` to list linked worktrees
+- `list` to list linked working trees
 - `lock` to prevent automatic pruning of administrative files (for instance,
   for a worktree on a portable device)
 
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 7173b38..fe7fa96 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -252,8 +252,8 @@ modules::
 
 worktrees::
 	Contains worktree specific information of linked
-	checkouts. Each subdirectory contains the worktree-related
-	part of a linked checkout. This directory is ignored if
+	working trees. Each subdirectory contains the worktree-related
+	part of a linked working tree. This directory is ignored if
 	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/worktrees" will be
 	used instead.
 
@@ -265,9 +265,9 @@ worktrees/<id>/gitdir::
 	updated every time the linked repository is accessed.
 
 worktrees/<id>/locked::
-	If this file exists, the linked repository may be on a
+	If this file exists, the linked working tree may be on a
 	portable device and not available. It does not mean that the
-	linked repository is gone and `worktrees/<id>` could be
+	linked working tree is gone and `worktrees/<id>` could be
 	removed. The file's content contains a reason string on why
 	the repository is locked.
 
-- 
2.1.4
