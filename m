From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH v3 4/5] git-stash.txt: better docs for '--patch'
Date: Thu,  5 May 2011 20:48:47 +0200
Message-ID: <1304621328-17184-4-git-send-email-valentin.haenel@gmx.de>
References: <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 20:50:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3cs-0005v4-CS
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142Ab1EESuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:50:09 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:60227 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab1EESuI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 14:50:08 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p45Int4m017264;
	Thu, 5 May 2011 20:49:55 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p45IntKb017263;
	Thu, 5 May 2011 20:49:55 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172871>

* Include '-p' in synopsis and options.
* Fix a typo.
* Include a link to the git-add manpage for a description of the patch-mode.

Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
Helped-by: Jeff King <peff@peff.net>
Mentored-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-stash.txt |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 79abc38..15f051f 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet] [<message>]]
+'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet] [<message>]]
 'git stash' clear
 'git stash' create
 
@@ -42,7 +42,7 @@ is also possible).
 OPTIONS
 -------
 
-save [--patch] [--[no-]keep-index] [-q|--quiet] [<message>]::
+save [-p|--patch] [--[no-]keep-index] [-q|--quiet] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  The <message> part is optional and gives
@@ -54,12 +54,13 @@ save [--patch] [--[no-]keep-index] [-q|--quiet] [<message>]::
 If the `--keep-index` option is used, all changes already added to the
 index are left intact.
 +
-With `--patch`, you can interactively select hunks from in the diff
+With `--patch`, you can interactively select hunks from the diff
 between HEAD and the working tree to be stashed.  The stash entry is
 constructed such that its index state is the same as the index state
 of your repository, and its worktree contains only the changes you
 selected interactively.  The selected changes are then rolled back
-from your worktree.
+from your worktree. See the ``Interactive Mode'' section of
+linkgit:git-add[1] to learn how to operate the `\--patch` mode.
 +
 The `--patch` option implies `--keep-index`.  You can use
 `--no-keep-index` to override this.
-- 
1.7.1
