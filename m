From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH v3 5/5] git-checkout.txt: better docs for '--patch'
Date: Thu,  5 May 2011 20:48:48 +0200
Message-ID: <1304621328-17184-5-git-send-email-valentin.haenel@gmx.de>
References: <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 20:50:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3d1-00061A-Hn
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152Ab1EESuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:50:15 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:60230 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab1EESuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 14:50:11 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p45Int3t017268;
	Thu, 5 May 2011 20:49:55 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p45IntL4017267;
	Thu, 5 May 2011 20:49:55 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172872>

* Include '-p' in synopsis and options
* Include a link to the git-add manpage for a description of the patch-mode.

Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
Helped-by: Jeff King <peff@peff.net>
Mentored-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-checkout.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 1063f69..9d53582 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [--detach] [<commit>]
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
-'git checkout' --patch [<tree-ish>] [--] [<paths>...]
+'git checkout' -p|--patch [<tree-ish>] [--] [<paths>...]
 
 DESCRIPTION
 -----------
@@ -45,7 +45,7 @@ $ git checkout <branch>
 that is to say, the branch is not reset/created unless "git checkout" is
 successful.
 
-'git checkout' [--patch] [<tree-ish>] [--] <pathspec>...::
+'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
 
 	When <paths> or `--patch` are given, 'git checkout' does *not*
 	switch branches.  It updates the named paths in the working tree
@@ -183,7 +183,8 @@ the conflicted merge in the specified paths.
 	working tree (and if a <tree-ish> was specified, the index).
 +
 This means that you can use `git checkout -p` to selectively discard
-edits from your current working tree.
+edits from your current working tree. See the ``Interactive Mode''
+section of linkgit:git-add[1] to learn how to operate the `\--patch` mode.
 
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
-- 
1.7.1
