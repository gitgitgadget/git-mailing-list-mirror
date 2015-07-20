From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/5] Documentation/git-worktree: consistently use term "linked working tree"
Date: Mon, 20 Jul 2015 01:29:18 -0400
Message-ID: <1437370162-8031-2-git-send-email-sunshine@sunshineco.com>
References: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 07:29:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZH3eF-0008Ex-2W
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 07:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbbGTF3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 01:29:46 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35958 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074AbbGTF3p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 01:29:45 -0400
Received: by igbij6 with SMTP id ij6so74640466igb.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 22:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BdlaUBil00Xo4ji2v4Bmp113dsR+MT9z6TVw4S2a9Zc=;
        b=QVoSIsEtJ7RiG1tHCg5uVe+599NZjQ84cmY4kfxGCT7Y+FSCKsZ31qOwPzOVmeG83V
         Sw5H4o+j7oHKLGFx1gUkxyNtZeF/Kmi/9IygCbSwtE8djj5UdjSNpWp3mcGMBnXIYGuV
         mCuFVQoa6C2sqfa2vjsA8qxWJjWz835sRTe6C6fP34b2Df0hM2ZRzaU9QLAxTGTVnJ0z
         XPGGunJ2+h9TQpaVAJEysdR6Frwx1VIex/qCqftPXra9Veia9Ot+4OqLD1uTzMAo94ge
         TLwhVYc0h8in+u2V+KdlMM0jlFLcpzvP0p+8bcZan0ixyn6nQVQb0Jm3fA3e7ZQ2NQI1
         pm5Q==
X-Received: by 10.107.3.224 with SMTP id e93mr25478135ioi.160.1437370185060;
        Sun, 19 Jul 2015 22:29:45 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm13104584iod.25.2015.07.19.22.29.43
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 22:29:44 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.386.g87d813d
In-Reply-To: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274306>

From: Michael Haggerty <mhagger@alum.mit.edu>

Sometimes linked working trees were called "linked working
directories" or "linked worktrees". Always refer to them as "linked
working trees" for consistency.

[es: fix additional occurrences]

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt         | 36 +++++++++++++++++-----------------
 Documentation/gitrepository-layout.txt | 10 +++++-----
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 3387e2f..60e5cf9 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -3,7 +3,7 @@ git-worktree(1)
 
 NAME
 ----
-git-worktree - Manage multiple worktrees
+git-worktree - Manage multiple working trees
 
 
 SYNOPSIS
@@ -15,7 +15,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Manage multiple worktrees attached to the same repository.
+Manage multiple working trees attached to the same repository.
 
 A git repository can support multiple working trees, allowing you to check
 out more than one branch at a time.  With `git worktree add` a new working
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
 
@@ -64,22 +64,22 @@ OPTIONS
 
 -f::
 --force::
-	By default, `add` refuses to create a new worktree when	`<branch>`
-	is already checked out by another worktree. This option overrides
+	By default, `add` refuses to create a new working tree when `<branch>`
+	is already checked out by another working tree. This option overrides
 	that safeguard.
 
 -b <new-branch>::
 -B <new-branch>::
 	With `add`, create a new branch named `<new-branch>` starting at
-	`<branch>`, and check out `<new-branch>` into the new worktree.
+	`<branch>`, and check out `<new-branch>` into the new working tree.
 	If `<branch>` is omitted, it defaults to HEAD.
 	By default, `-b` refuses to create a new branch if it already
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
 	`<branch>`.
 
 --detach::
-	With `add`, detach HEAD in the new worktree. See "DETACHED HEAD" in
-	linkgit:git-checkout[1].
+	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
+	in linkgit:git-checkout[1].
 
 -n::
 --dry-run::
@@ -91,7 +91,7 @@ OPTIONS
 	With `prune`, report all removals.
 
 --expire <time>::
-	With `prune`, only expire unused worktrees older than <time>.
+	With `prune`, only expire unused working trees older than <time>.
 
 DETAILS
 -------
@@ -139,9 +139,9 @@ EXAMPLES
 You are in the middle of a refactoring session and your boss comes in and
 demands that you fix something immediately. You might typically use
 linkgit:git-stash[1] to store your changes away temporarily, however, your
-worktree is in such a state of disarray (with new, moved, and removed files,
-and other bits and pieces strewn around) that you don't want to risk
-disturbing any of it. Instead, you create a temporary linked worktree to
+working tree is in such a state of disarray (with new, moved, and removed
+files, and other bits and pieces strewn around) that you don't want to risk
+disturbing any of it. Instead, you create a temporary linked working tree to
 make the emergency fix, remove it when done, and then resume your earlier
 refactoring session.
 
@@ -164,12 +164,12 @@ checkouts of a superproject.
 git-worktree could provide more automation for tasks currently
 performed manually, such as:
 
-- `remove` to remove a linked worktree and its administrative files (and
-  warn if the worktree is dirty)
-- `mv` to move or rename a worktree and update its administrative files
-- `list` to list linked worktrees
+- `remove` to remove a linked working tree and its administrative files (and
+  warn if the working tree is dirty)
+- `mv` to move or rename a working tree and update its administrative files
+- `list` to list linked working trees
 - `lock` to prevent automatic pruning of administrative files (for instance,
-  for a worktree on a portable device)
+  for a working tree on a portable device)
 
 GIT
 ---
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 7173b38..b53979c 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -251,9 +251,9 @@ modules::
 	Contains the git-repositories of the submodules.
 
 worktrees::
-	Contains worktree specific information of linked
-	checkouts. Each subdirectory contains the worktree-related
-	part of a linked checkout. This directory is ignored if
+	Contains working tree specific information of linked
+	working trees. Each subdirectory contains the working tree-related
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
2.5.0.rc2.386.g87d813d
