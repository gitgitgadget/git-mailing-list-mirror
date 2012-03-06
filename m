From: vfr@lyx.org
Subject: [PATCH] Documentation update for 'git branch'
Date: Tue,  6 Mar 2012 09:51:06 +0100
Message-ID: <1331023866-5658-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Cc: gitster@pobox.com, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 09:51:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4q7D-0003lE-EY
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 09:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758766Ab2CFIvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 03:51:19 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44291 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758365Ab2CFIvS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 03:51:18 -0500
Received: by eaaq12 with SMTP id q12so1729829eaa.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 00:51:17 -0800 (PST)
Received-SPF: pass (google.com: domain of vfr@lyx.org designates 10.213.9.204 as permitted sender) client-ip=10.213.9.204;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of vfr@lyx.org designates 10.213.9.204 as permitted sender) smtp.mail=vfr@lyx.org
Received: from mr.google.com ([10.213.9.204])
        by 10.213.9.204 with SMTP id m12mr4256198ebm.97.1331023877004 (num_hops = 1);
        Tue, 06 Mar 2012 00:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=Cso3dT5oRzjCacunNwxdy8umh/T2N6IIRzcG6JWxG8A=;
        b=DQRQPyc8FPYLyV45XJDK1vje+Zb3kGM3Vy+2cBwBWDV6MgBewPQhLmo+4fkgQkwIX7
         2DqaOSSSgRv8O0v1dMnbkdRTPDdDo8ceJ9dB9nNK7KYZiiOLppu7sPoMPQPN1pR2DdFJ
         SVCRnKzIb3aEfEZa5nyQth3WtRcR9+R2wjmOL74aOKUbfajTIon5kwMVyDBRiwv8ekcb
         YsY+80D+EXz8bBmGZzwGTj9G1FxCoxCcgtSfzqOqRQv/Y/Zxqq+PHdG38D/N024ftkG9
         tU5+OCkoLB/1BXwjeOmhS3meblv8KCmJrdXtcMdGwVrX0h40gTQZk6UEKw406ZrlC7zt
         Xm3g==
Received: by 10.213.9.204 with SMTP id m12mr3214632ebm.97.1331023876777;
        Tue, 06 Mar 2012 00:51:16 -0800 (PST)
Received: from localhost.localdomain (wlan-145-94-169-074.wlan.tudelft.nl. [145.94.169.74])
        by mx.google.com with ESMTPS id h47sm7890370eea.10.2012.03.06.00.51.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 00:51:16 -0800 (PST)
X-Mailer: git-send-email 1.7.5.4
X-Gm-Message-State: ALoCoQmh4aKWLRyFXmyvj+6vs41K/QXHjXdmtXhM0AFUtLSIdPB9p3GZSVxA9omjOs420jBxk5wB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192315>

From: Vincent van Ravesteijn <vfr@lyx.org>

Changes:
- add a period to a sentence,
- correct 'tag' into 'branch',
- unify the use of backticks,
- indicate that the commit parameter of --contains defaults to HEAD.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 Documentation/git-branch.txt |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0427e80..6410c3d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -24,8 +24,8 @@ be highlighted with an asterisk.  Option `-r` causes the remote-tracking
 branches to be listed, and option `-a` shows both. This list mode is also
 activated by the `--list` option (see below).
 <pattern> restricts the output to matching branches, the pattern is a shell
-wildcard (i.e., matched using fnmatch(3))
-Multiple patterns may be given; if any of them matches, the tag is shown.
+wildcard (i.e., matched using fnmatch(3)).
+Multiple patterns may be given; if any of them matches, the branch is shown.
 
 With `--contains`, shows only the branches that contain the named commit
 (in other words, the branches whose tip commits are descendants of the
@@ -49,7 +49,7 @@ the remote-tracking branch. This behavior may be changed via the global
 overridden by using the `--track` and `--no-track` options, and
 changed later using `git branch --set-upstream`.
 
-With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
+With a `-m` or `-M` option, <oldbranch> will be renamed to <newbranch>.
 If <oldbranch> had a corresponding reflog, it is renamed to match
 <newbranch>, and a reflog entry is created to remember the branch
 renaming. If <newbranch> exists, -M must be used to force the rename
@@ -59,7 +59,7 @@ With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
 has a reflog then the reflog will also be deleted.
 
-Use -r together with -d to delete remote-tracking branches. Note, that it
+Use `-r` together with `-d` to delete remote-tracking branches. Note, that it
 only makes sense to delete remote-tracking branches if they no longer exist
 in the remote repository or if 'git fetch' was configured not to fetch
 them again. See also the 'prune' subcommand of linkgit:git-remote[1] for a
@@ -154,17 +154,18 @@ start-point is either a local or remote-tracking branch.
 	branch.autosetupmerge configuration variable is true.
 
 --set-upstream::
-	If specified branch does not exist yet or if '--force' has been
-	given, acts exactly like '--track'. Otherwise sets up configuration
-	like '--track' would when creating the branch, except that where
+	If specified branch does not exist yet or if `--force` has been
+	given, acts exactly like `--track`. Otherwise sets up configuration
+	like `--track` would when creating the branch, except that where
 	branch points to is not changed.
 
 --edit-description::
 	Open an editor and edit the text to explain what the branch is
 	for, to be used by various other commands (e.g. `request-pull`).
 
---contains <commit>::
-	Only list branches which contain the specified commit.
+--contains [<commit>]::
+	Only list branches which contain the specified commit (HEAD
+	if not specified).
 
 --merged [<commit>]::
 	Only list branches whose tips are reachable from the
-- 
1.7.5.4
