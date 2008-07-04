From: Eric Hanchrow <offby1@blarg.net>
Subject: [PATCH]: fix typos in docs
Date: Fri, 04 Jul 2008 10:39:52 -0700
Message-ID: <877ic1sg47.fsf@offby1.atm01.sea.blarg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 04 20:05:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEpeD-0005gq-UT
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 20:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbYGDSDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 14:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbYGDSDo
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 14:03:44 -0400
Received: from smtp61.avvanta.com ([206.124.128.61]:47030 "EHLO
	mail.avvanta.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751831AbYGDSDn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 14:03:43 -0400
X-Greylist: delayed 1429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jul 2008 14:03:43 EDT
Received: from mail.avvanta.com (localhost [127.0.0.1])
	by mail.avvanta.com (Postfix) with ESMTP id 3A1C8276D99
	for <git@vger.kernel.org>; Fri,  4 Jul 2008 10:39:34 -0700 (PDT)
Received: from offby1.atm01.sea.blarg.net (q-static-138-125.avvanta.com [206.124.138.125])
	by mail.avvanta.com (Postfix) with ESMTP id 07875276D8D
	for <git@vger.kernel.org>; Fri,  4 Jul 2008 10:39:34 -0700 (PDT)
Received: from erich by offby1.atm01.sea.blarg.net with local (Exim 4.69)
	(envelope-from <offby1@blarg.net>)
	id 1KEpGC-0002yQ-JU
	for git@vger.kernel.org; Fri, 04 Jul 2008 10:39:52 -0700
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-BlargAV-Status: No viruses detected, BlargAV v1.1 on localhost.scooter.p.blarg.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87406>

>From 098e3ec480254069d944e494a42afcf2013d08d7 Mon Sep 17 00:00:00 2001
From: Eric Hanchrow <offby1@blarg.net>
Date: Mon, 30 Jun 2008 23:34:08 -0700
Subject: [PATCH] Fix typos

---
 Documentation/.gitignore           |   10 ++++++----
 Documentation/config.txt           |    2 +-
 Documentation/git.txt              |    2 +-
 Documentation/gitcore-tutorial.txt |    2 +-
 Documentation/gitglossary.txt      |    2 +-
 Documentation/user-manual.txt      |   18 +++++++++---------
 6 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index d8edd90..ce24e4a 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -1,10 +1,12 @@
-*.xml
-*.html
 *.[1-8]
+*.html
 *.made
 *.texi
+*.xml
+cmds-*.txt
+doc.dep
+fancytooltips.js
+favicon.ico
 git.info
 gitman.info
 howto-index.txt
-doc.dep
-cmds-*.txt
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 561ff64..e891745 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -680,7 +680,7 @@ gitcvs.usecrlfattr
 	treat it as text. If `crlf` is explicitly unset, the file
 	will be set with '-kb' mode, which supresses any newline munging
 	the client might otherwise do. If `crlf` is not specified,
-	then 'gitcvs.allbinary' is used. See linkgit:gitattribute[5].
+	then 'gitcvs.allbinary' is used. See linkgit:gitattributes[5].
 
 gitcvs.allbinary::
 	This is used if 'gitcvs.usecrlfattr' does not resolve
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 22702c2..fa67383 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -591,7 +591,7 @@ contributors on the git-list <git@vger.kernel.org>.
 SEE ALSO
 --------
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
+linkgit:everyday[7], linkgit:gitcvs-migration[7],
 linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
 linkgit:gitcli[7], link:user-manual.html[The Git User's Manual]
 
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 7d721c5..9195997 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1690,7 +1690,7 @@ to follow, not easier.
 SEE ALSO
 --------
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
+linkgit:everyday[7], linkgit:gitcvs-migration[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/gitglossary.txt b/Documentation/gitglossary.txt
index 5c5c31d..565719e 100644
--- a/Documentation/gitglossary.txt
+++ b/Documentation/gitglossary.txt
@@ -17,7 +17,7 @@ include::glossary-content.txt[]
 SEE ALSO
 --------
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
+linkgit:everyday[7], linkgit:gitcvs-migration[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index ca13266..ae6525a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -518,7 +518,7 @@ $ git bisect visualize
 -------------------------------------------------
 
 which will run gitk and label the commit it chose with a marker that
-says "bisect".  Chose a safe-looking commit nearby, note its commit
+says "bisect".  Choose a safe-looking commit nearby, note its commit
 id, and check it out with:
 
 -------------------------------------------------
@@ -1988,8 +1988,8 @@ intend to manage the branch.
 
 It's also possible for a push to fail in this way when other people have
 the right to push to the same repository.  In that case, the correct
-solution is to retry the push after first updating your work by either a
-pull or a fetch followed by a rebase; see the
+solution is to retry the push after first updating your work: either by a
+pull, or by a fetch followed by a rebase; see the
 <<setting-up-a-shared-repository,next section>> and
 linkgit:gitcvs-migration[7] for more.
 
@@ -2861,7 +2861,7 @@ There are four different types of objects: "blob", "tree", "commit", and
 "tag".
 
 - A <<def_blob_object,"blob" object>> is used to store file data.
-- A <<def_tree_object,"tree" object>> is an object that ties one or more
+- A <<def_tree_object,"tree" object>> ties one or more
   "blob" objects into a directory structure. In addition, a tree object
   can refer to other tree objects, thus creating a directory hierarchy.
 - A <<def_commit_object,"commit" object>> ties such directory hierarchies
@@ -3036,7 +3036,7 @@ Tag Object
 
 A tag object contains an object, object type, tag name, the name of the
 person ("tagger") who created the tag, and a message, which may contain
-a signature, as can be seen using the linkgit:git-cat-file[1]:
+a signature, as can be seen using linkgit:git-cat-file[1]:
 
 ------------------------------------------------
 $ git cat-file tag v1.5.0
@@ -3986,13 +3986,13 @@ $ mv -f hello.c~2 hello.c
 $ git update-index hello.c
 -------------------------------------------------
 
-When a path is in unmerged state, running `git-update-index` for
+When a path is in the "unmerged" state, running `git-update-index` for
 that path tells git to mark the path resolved.
 
 The above is the description of a git merge at the lowest level,
 to help you understand what conceptually happens under the hood.
-In practice, nobody, not even git itself, uses three `git-cat-file`
-for this.  There is `git-merge-index` program that extracts the
+In practice, nobody, not even git itself, runs `git-cat-file` three times
+for this.  There is a `git-merge-index` program that extracts the
 stages to temporary files and calls a "merge" script on it:
 
 -------------------------------------------------
@@ -4061,7 +4061,7 @@ Note that terminology has changed since that revision.  For example, the
 README in that revision uses the word "changeset" to describe what we
 now call a <<def_commit_object,commit>>.
 
-Also, we do not call it "cache" any more, but "index", however, the
+Also, we do not call it "cache" any more, but rather "index"; however, the
 file is still called `cache.h`.  Remark: Not much reason to change it now,
 especially since there is no good single name for it anyway, because it is
 basically _the_ header file which is included by _all_ of Git's C sources.
-- 
1.5.4.3


-- 
People studying literature rarely say anything that would be of the
slightest use to those producing it.
        -- Paul Graham
