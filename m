From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCHv2 1/3] Documentation/git-branch: cleanups
Date: Tue,  6 Mar 2012 10:32:43 +0100
Message-ID: <1331026365-7044-1-git-send-email-user@vincent-VirtualBox>
References: <1331023866-5658-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Cc: trast@inf.ethz.ch, gitster@pobox.com,
	Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 10:34:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4qmb-0007ZC-SI
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 10:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758395Ab2CFJdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 04:33:55 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35114 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758083Ab2CFJdP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 04:33:15 -0500
Received: by eekc41 with SMTP id c41so1810023eek.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 01:33:14 -0800 (PST)
Received-SPF: pass (google.com: domain of  designates 10.14.28.16 as permitted sender) client-ip=10.14.28.16;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of  designates 10.14.28.16 as permitted sender) smtp.mail=
Received: from mr.google.com ([10.14.28.16])
        by 10.14.28.16 with SMTP id f16mr13139494eea.121.1331026394547 (num_hops = 1);
        Tue, 06 Mar 2012 01:33:14 -0800 (PST)
Received: by 10.14.28.16 with SMTP id f16mr9982601eea.121.1331026394408;
        Tue, 06 Mar 2012 01:33:14 -0800 (PST)
Received: from localhost.localdomain (wlan-145-94-169-074.wlan.tudelft.nl. [145.94.169.74])
        by mx.google.com with ESMTPS id d54sm26363433eei.9.2012.03.06.01.33.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 01:33:14 -0800 (PST)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1331023866-5658-1-git-send-email-vfr@lyx.org>
X-Gm-Message-State: ALoCoQkcIPFqnQaOZFrlS9bYroY76sivwVYb7zEPupCM/TpYZ/fpqb2QYIZZopYsm9BG9wL8e124
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192323>

From: Vincent van Ravesteijn <vfr@lyx.org>

Changes:
- add a period to a sentence,
- unify the use of backticks.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 Documentation/git-branch.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0427e80..d3a923a 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -24,7 +24,7 @@ be highlighted with an asterisk.  Option `-r` causes the remote-tracking
 branches to be listed, and option `-a` shows both. This list mode is also
 activated by the `--list` option (see below).
 <pattern> restricts the output to matching branches, the pattern is a shell
-wildcard (i.e., matched using fnmatch(3))
+wildcard (i.e., matched using fnmatch(3)).
 Multiple patterns may be given; if any of them matches, the tag is shown.
 
 With `--contains`, shows only the branches that contain the named commit
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
@@ -154,9 +154,9 @@ start-point is either a local or remote-tracking branch.
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
-- 
1.7.5.4
