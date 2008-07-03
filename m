From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 14/15] manpages: italicize git subcommand names (which were
 in teletype font)
Date: Thu, 3 Jul 2008 00:59:09 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807030055290.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>,
	Eric Wong <normalperson@yhbt.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7t-0002yW-DX
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531AbYGCG74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbYGCG6O
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:58:14 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:55561 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084AbYGCF7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 01:59:14 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m635x9eN024423;
	Thu, 3 Jul 2008 00:59:09 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m635x90Z019631;
	Thu, 3 Jul 2008 00:59:09 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87253>

Italicize those git subcommand names already in teletype we missed.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/config.txt           |    8 ++++----
 Documentation/git-svn.txt          |    2 +-
 Documentation/gitcore-tutorial.txt |    6 +++---
 Documentation/gitcvs-migration.txt |    4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b431747..a7071df 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -118,8 +118,8 @@ core.fileMode::
 	See linkgit:git-update-index[1]. True by default.
 
 core.quotepath::
-	The commands that output paths (e.g. `ls-files`,
-	`diff`), when not given the `-z` option, will quote
+	The commands that output paths (e.g. 'ls-files',
+	'diff'), when not given the `-z` option, will quote
 	"unusual" characters in the pathname by enclosing the
 	pathname in a double-quote pair and with backslashes the
 	same way strings in C source code are quoted.  If this
@@ -557,7 +557,7 @@ diff.autorefreshindex::
 	contents in the work tree match the contents in the
 	index.  This option defaults to true.  Note that this
 	affects only 'git-diff' Porcelain, and not lower level
-	`diff` commands, such as 'git-diff-files'.
+	'diff' commands, such as 'git-diff-files'.
 
 diff.external::
 	If this config variable is set, diff generation is not
@@ -636,7 +636,7 @@ gc.packrefs::
 	prevent `git pack-refs` from being run from 'git-gc'.
 
 gc.pruneexpire::
-	When 'git-gc' is run, it will call `prune --expire 2.weeks.ago`.
+	When 'git-gc' is run, it will call 'prune --expire 2.weeks.ago'.
 	Override the grace period with this config variable.
 
 gc.reflogexpire::
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index dc5b8f6..e7c0f1c 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -551,7 +551,7 @@ CAVEATS
 
 For the sake of simplicity and interoperating with a less-capable system
 (SVN), it is recommended that all 'git-svn' users clone, fetch and dcommit
-directly from the SVN server, and avoid all 'git-clone'/`pull`/`merge`/`push`
+directly from the SVN server, and avoid all 'git-clone'/'pull'/'merge'/'push'
 operations between git repositories and branches.  The recommended
 method of exchanging code between git branches and users is
 'git-format-patch' and 'git-am', or just 'dcommit'ing to the SVN repository.
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 5acdeb7..dd6a268 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -235,7 +235,7 @@ $ git diff-files
 ------------
 
 Oops. That wasn't very readable. It just spit out its own internal
-version of a `diff`, but that internal version really just tells you
+version of a 'diff', but that internal version really just tells you
 that it has noticed that "hello" has been modified, and that the old object
 contents it had have been replaced with something else.
 
@@ -468,7 +468,7 @@ Inspecting Changes
 
 While creating changes is useful, it's even more useful if you can tell
 later what changed. The most useful command for this is another of the
-`diff` family, namely 'git-diff-tree'.
+'diff' family, namely 'git-diff-tree'.
 
 'git-diff-tree' can be given two arbitrary trees, and it will tell you the
 differences between them. Perhaps even more commonly, though, you can
@@ -1006,7 +1006,7 @@ the tree of your branch to that of the `master` branch. This is
 often called 'fast forward' merge.
 
 You can run `gitk \--all` again to see how the commit ancestry
-looks like, or run `show-branch`, which tells you this.
+looks like, or run 'show-branch', which tells you this.
 
 ------------------------------------------------
 $ git show-branch master mybranch
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index 2737d10..2eb6972 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -46,7 +46,7 @@ them first before running git pull.
 
 [NOTE]
 ================================
-The `pull` command knows where to get updates from because of certain
+The 'pull' command knows where to get updates from because of certain
 configuration variables that were set by the first 'git-clone'
 command; see `git config -l` and the linkgit:git-config[1] man
 page for details.
@@ -67,7 +67,7 @@ push again.
 In the 'git-push' command above we specify the name of the remote branch
 to update (`master`).  If we leave that out, 'git-push' tries to update
 any branches in the remote repository that have the same name as a branch
-in the local repository.  So the last `push` can be done with either of:
+in the local repository.  So the last 'push' can be done with either of:
 
 ------------
 $ git push origin
-- 
1.5.5.GIT
