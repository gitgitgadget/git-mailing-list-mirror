From: Thomas Rast <trast@student.ethz.ch>
Subject: [NON-PATCH 3/2] Documentation/git-merge: format full commands in typewriter font
Date: Thu, 7 Jan 2010 18:03:28 +0100
Message-ID: <ebbb4e2b0e98490a64b3cd52c33d3a995fa7e980.1262883414.git.trast@student.ethz.ch>
References: <2e53c91e536e1ff585bc7464c1b8863e6cc45c45.1262883414.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 07 18:03:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSvm1-0000lo-5n
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838Ab0AGRDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 12:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185Ab0AGRDq
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:03:46 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:5568 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781Ab0AGRDp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 12:03:45 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Thu, 7 Jan
 2010 18:03:42 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Thu, 7 Jan
 2010 18:03:28 +0100
X-Mailer: git-send-email 1.6.6.202.gdf32a
In-Reply-To: <2e53c91e536e1ff585bc7464c1b8863e6cc45c45.1262883414.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136355>

Use `code snippet` style instead of 'emphasis' for the full commands
specified in the "how to resolve conflicts" section.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Not intended for application, but for discussion.

I originally wanted to tack this on the series as an "obvious
cleanup", but then I noticed two things:

* While the general trend as per

    git grep '`git '
    git grep \''git '

  seems to go towards the `code` style where full commands are
  concerned, and the 'emphasis' where only a git-command is named,
  this is not consistent yet.  Especially the git-svn manpage seems to
  have a few hybrids.

* More importantly, while `code` style seems to be an improvement in
  HTML output (because it gives typewriter font), my local 'man'
  renders 'emphasis' as underlines -- which actually makes the code
  snippets much more visible than `literal` quotes which are not
  rendered specially at all.

So which way should it be changed?


 Documentation/git-merge.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index b224daf..e04c800 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -193,7 +193,7 @@ After seeing a conflict, you can do two things:
 
  * Decide not to merge.  The only clean-ups you need are to reset
    the index file to the `HEAD` commit to reverse 2. and to clean
-   up working tree changes made by 2. and 3.; 'git-reset --hard' can
+   up working tree changes made by 2. and 3.; `git-reset --hard` can
    be used for this.
 
  * Resolve the conflicts.  Git will mark the conflicts in
@@ -202,19 +202,19 @@ After seeing a conflict, you can do two things:
 
 You can work through the conflict with a number of tools:
 
- * Use a mergetool.  'git mergetool' to launch a graphical
+ * Use a mergetool.  `git mergetool` to launch a graphical
    mergetool which will work you through the merge.
 
- * Look at the diffs.  'git diff' will show a three-way diff,
+ * Look at the diffs.  `git diff` will show a three-way diff,
    highlighting changes from both the HEAD and 'theirs' versions.
 
- * Look at the diffs on their own. 'git log --merge -p <path>'
+ * Look at the diffs on their own. `git log --merge -p <path>`
    will show diffs first for the HEAD version and then the
    'theirs' version.
 
- * Look at the originals.  'git show :1:filename' shows the
-   common ancestor, 'git show :2:filename' shows the HEAD
-   version and 'git show :3:filename' shows 'their' version.
+ * Look at the originals.  `git show :1:filename` shows the
+   common ancestor, `git show :2:filename` shows the HEAD
+   version and `git show :3:filename` shows 'their' version.
 
 
 EXAMPLES
-- 
1.6.6.202.gdf32a
