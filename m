From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Fix typos in the documentation.
Date: Thu, 27 Nov 2008 08:32:01 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20081127073201.GD8267@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 08:53:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5bh6-0007pH-Lt
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 08:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbYK0HvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 02:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbYK0HvQ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 02:51:16 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:46862 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbYK0HvP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 02:51:15 -0500
X-Greylist: delayed 1146 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Nov 2008 02:51:14 EST
Received: from localhost.localdomain (xdsl-87-78-127-29.netcologne.de [87.78.127.29])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id B2A0040002609
	for <git@vger.kernel.org>; Thu, 27 Nov 2008 08:32:06 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1L5bM1-0002LF-NN
	for git@vger.kernel.org; Thu, 27 Nov 2008 08:32:01 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101796>

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---

This patch is against pu.

Cheers, and thanks for git,
Ralf

 Documentation/RelNotes-1.6.0.4.txt        |    2 +-
 Documentation/RelNotes-1.6.1.txt          |    6 +++---
 Documentation/config.txt                  |    2 +-
 Documentation/git-add.txt                 |    2 +-
 Documentation/git-bisect.txt              |    6 +++---
 Documentation/git-commit.txt              |    2 +-
 Documentation/git-svn.txt                 |    2 +-
 Documentation/technical/pack-protocol.txt |    4 ++--
 Documentation/user-manual.txt             |    2 +-
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/RelNotes-1.6.0.4.txt b/Documentation/RelNotes-1.6.0.4.txt
index fba3f30..d522661 100644
--- a/Documentation/RelNotes-1.6.0.4.txt
+++ b/Documentation/RelNotes-1.6.0.4.txt
@@ -30,7 +30,7 @@ Fixes since v1.6.0.3
 * 'git status' incorrectly reported a submodule directory as an untracked
   directory.
 
-* 'git svn' used deprecated 'git-foo' form of subcommand invocaition.
+* 'git svn' used deprecated 'git-foo' form of subcommand invocation.
 
 * 'git update-ref -d' to remove a reference did not honor --no-deref option.
 
diff --git a/Documentation/RelNotes-1.6.1.txt b/Documentation/RelNotes-1.6.1.txt
index 7fdf83f..848541a 100644
--- a/Documentation/RelNotes-1.6.1.txt
+++ b/Documentation/RelNotes-1.6.1.txt
@@ -55,9 +55,9 @@ on.
   to a non-zero value to accept the suggestion when git can uniquely
   guess.
 
-* The packfile machinery hopefully is more robust when dealilng with
+* The packfile machinery hopefully is more robust when dealing with
   corrupt packs if redundant objects involved in the corruption are
-  available elsehwere.
+  available elsewhere.
 
 * "git add -N path..." adds the named paths as an empty blob, so that
   subsequent "git diff" will show a diff as if they are creation events.
@@ -157,7 +157,7 @@ on.
 * "git log" learned "--source" to show what ref each commit was reached
   from.
 
-* "git log" also learned "--simplify-by-decration" to show the
+* "git log" also learned "--simplify-by-decoration" to show the
   birds-eye-view of the topology of the history.
 
 * "git log --pretty=format:" learned "%d" format element that inserts
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2283300..6d51967 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -841,7 +841,7 @@ gui.fastcopyblame::
 	repositories at the expense of less thorough copy detection.
 
 gui.copyblamethreshold::
-	Specifies the theshold to use in 'git gui blame' original location
+	Specifies the threshold to use in 'git gui blame' original location
 	detection, measured in alphanumeric characters. See the
 	linkgit:git-blame[1] manual for more information on copy detection.
 
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 6fc20b0..7c129cb 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -98,7 +98,7 @@ OPTIONS
 	Record only the fact that the path will be added later. An entry
 	for the path is placed in the index with no content. This is
 	useful for, among other things, showing the unstaged content of
-	such files with 'git diff' and commiting them with 'git commit
+	such files with 'git diff' and committing them with 'git commit
 	-a'.
 
 --refresh::
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 2ac77fb..75083e6 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -192,10 +192,10 @@ Bisect replace
 
 This subcommand can help when you have a branch or a part of a
 branch that isn't easily bisectable because of a bug that has been
-fixed latter.
+fixed later.
 
 We suppose that a bug as been introduced at some point, say A, and
-that it has been fixed latter at another point, say B, but that
+that it has been fixed later at another point, say B, but that
 between these points the code is not easily testable because of the
 bug, so it's not easy to bisect between these points.
 
@@ -244,7 +244,7 @@ because the bug introduced by commit A and fixed by commit B will not
 annoy you anymore.
 
 As the refs created by "git bisect replace" can be shared between
-developers, this feature might be especially usefull on big projects
+developers, this feature might be especially useful on big projects
 where many people often bisect the same code base.
 
 If you give the `--no-replace` to "git bisect start", then the
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a1ce9a8..6203461 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -95,7 +95,7 @@ OPTIONS
 
 -s::
 --signoff::
-	Add Signed-off-by line by the commiter at the end of the commit
+	Add Signed-off-by line by the committer at the end of the commit
 	log message.
 
 -n::
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ba94cd1..8d0c421 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -109,7 +109,7 @@ COMMANDS
 
 This works similarly to `svn update` or 'git-pull' except that
 it preserves linear history with 'git-rebase' instead of
-'git-merge' for ease of dcommiting with 'git-svn'.
+'git-merge' for ease of dcommitting with 'git-svn'.
 
 This accepts all options that 'git-svn fetch' and 'git-rebase'
 accept.  However, '--fetch-all' only fetches from the current
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 7396f69..696dd00 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -59,13 +59,13 @@ When tellme-more extension is used:
 	C: SHA1 old-SHA1 -- This is ancestor of that, you might know
 	C: SHA1 old-SHA1
 	C: ...
-	C: # flush -- have you heard ehough?
+	C: # flush -- have you heard enough?
 	S: tellme-more old-SHA1' -- I still want to know more about this one
 	S: # flush -- please give me more
 	C: SHA1 old-SHA1'
 	C: SHA1 old-SHA1'
 	C: ...
-	C: # flush -- have you heard ehough?
+	C: # flush -- have you heard enough?
 	S: # flush -- yes, thanks, we've heard enough
 	S: XXXXXXX --- packfile contents.
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index c0d8caf..da9c6b2 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -546,7 +546,7 @@ $ git bisect skip
 -------------------------------------------------
 
 In this case, though, git may not eventually be able to tell the first
-bad one between some first skipped commits and a latter bad commit.
+bad one between some first skipped commits and a later bad commit.
 
 There are also ways to automate the bisecting process if you have a
 test script that can tell a good from a bad commit. See
-- 
1.6.0.4.766.g6fc4a
