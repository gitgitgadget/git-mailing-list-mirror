From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH] Documentation update for 'git branch --list'
Date: Mon, 21 Nov 2011 15:33:20 +0100
Message-ID: <1321886000-4163-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, git@drmicha.warpmail.net,
	Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 15:33:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSUwN-0007en-Rs
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 15:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000Ab1KUOdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 09:33:42 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61754 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab1KUOdl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 09:33:41 -0500
Received: by bke11 with SMTP id 11so6617613bke.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 06:33:40 -0800 (PST)
Received: by 10.205.127.20 with SMTP id gy20mr14969051bkc.138.1321886020277;
        Mon, 21 Nov 2011 06:33:40 -0800 (PST)
Received: from localhost.localdomain (221-44.206-83.static-ip.oleane.fr. [83.206.44.221])
        by mx.google.com with ESMTPS id dq2sm7437455bkb.11.2011.11.21.06.33.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 06:33:39 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185744>

Indicate that the <pattern>... argument is only valid when using --list.
Otherwise a branch with the name <pattern> will be created. The current
synopsis also suggests that 'git branch -d <pattern>...' would be a valid
command.

Minor changes:
- add a period to a sentence,
- change tag into branch.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 Documentation/git-branch.txt |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index f46013c..9f49db4 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,8 +9,9 @@ SYNOPSIS
 --------
 [verse]
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
-	[--list] [-v [--abbrev=<length> | --no-abbrev]]
-	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
+	[-v [--abbrev=<length> | --no-abbrev]]
+	[(--merged | --no-merged | --contains) [<commit>]]
+	[--list [<pattern>...]]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
@@ -23,8 +24,8 @@ be highlighted with an asterisk.  Option `-r` causes the remote-tracking
 branches to be listed, and option `-a` shows both. This list mode is also
 activated by the `--list` option (see below).
 <pattern> restricts the output to matching branches, the pattern is a shell
-wildcard (i.e., matched using fnmatch(3))
-Multiple patterns may be given; if any of them matches, the tag is shown.
+wildcard (i.e., matched using fnmatch(3)).
+Multiple patterns may be given; if any of them matches, the branch is shown.
 
 With `--contains`, shows only the branches that contain the named commit
 (in other words, the branches whose tip commits are descendants of the
@@ -114,7 +115,7 @@ OPTIONS
 --all::
 	List both remote-tracking branches and local branches.
 
---list::
+--list [<pattern>...]::
 	Activate the list mode. `git branch <pattern>` would try to create a branch,
 	use `git branch --list <pattern>` to list matching branches.
 
-- 
1.7.4.1
