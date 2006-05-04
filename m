From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH 3/3] Add a few more words to the glossary.
Date: Wed, 03 May 2006 23:19:54 -0500
Message-ID: <E1FbVJi-0004UJ-59@jdl.com>
X-From: git-owner@vger.kernel.org Thu May 04 06:20:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbVJn-0003BC-5e
	for gcvg-git@gmane.org; Thu, 04 May 2006 06:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWEDET4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 00:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWEDET4
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 00:19:56 -0400
Received: from www.jdl.com ([66.118.10.122]:62443 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1751211AbWEDET4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 May 2006 00:19:56 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FbVJi-0004UJ-59
	for git@vger.kernel.org; Wed, 03 May 2006 23:19:55 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19549>


Clean up a few entries and fix typos.

    bare repository
    cherry-picking
    hook
    symbolic ref
    topic branch

Signed-off-by: Jon Loeliger <jdl@jdl.com>


---

 Documentation/glossary.txt |   68 ++++++++++++++++++++++++++++++++++++--------
 1 files changed, 55 insertions(+), 13 deletions(-)

b7524dc93e17807a3657f017adcbe129e16c4b94
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 86196c4..f166d4f 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -3,6 +3,17 @@ alternate object database::
 	object database from another object database, which is called
 	"alternate".
 
+bare repository::
+	A bare repository is normally an appropriately named
+	directory with a `.git` suffix that does not have a
+	locally checked-out copy of any of the files under revision
+	control.  That is, all of the `git` administrative and
+	control files that would normally be present in the
+	hidden `.git` sub-directory are directly present in
+	the `repository.git` directory instead, and no other files
+	are present and checked out.  Usually publishers of public
+	repositories make bare repositories available.
+
 blob object::
 	Untyped object, e.g. the contents of a file.
 
@@ -28,6 +39,15 @@ checkout::
 	The action of updating the working tree to a revision which was
 	stored in the object database.
 
+cherry-picking::
+	In SCM jargon, "cherry pick" means to choose a subset of
+	changes out of a series of changes (typically commits)
+	and record them as a new series of changes on top of
+	different codebase.  In GIT, this is performed by
+	"git cherry-pick" command to extract the change
+	introduced by an existing commit and to record it based
+	on the tip of the current branch as a new commit.
+
 clean::
 	A working tree is clean, if it corresponds to the revision
 	referenced by the current head.  Also see "dirty".
@@ -100,6 +120,16 @@ head ref::
 	A ref pointing to a head. Often, this is abbreviated to "head".
 	Head refs are stored in `$GIT_DIR/refs/heads/`.
 
+hook::
+	During the normal execution of several git commands,
+	call-outs are made to optional scripts that allow
+	a developer to add functionality or checking.
+	Typically, the hooks allow for a command to be pre-verified
+	and potentially aborted, and allow for a post-notification
+	after the operation is done.
+	The hook scripts are found in the `$GIT_DIR/hooks/` directory,
+	and are enabled by simply making them executable.
+
 index::
 	A collection of files with stat information, whose contents are
 	stored as objects. The index is a stored version of your working
@@ -113,10 +143,10 @@ index entry::
 	that file).
 
 master::
-	The default branch. Whenever you create a git repository, a branch
-	named "master" is created, and becomes the active branch. In most
-	cases, this contains the local development.
-
+	The default development branch. Whenever you create a git
+	repository, a branch named "master" is created, and becomes
+	the active branch. In most cases, this contains the local
+	development, though that is purely conventional and not required.
 
 merge::
 	To merge branches means to try to accumulate the changes since a
@@ -151,10 +181,11 @@ octopus::
 	predator.
 
 origin::
-	The default upstream branch. Most projects have one upstream
-	project which they track, and by default 'origin' is used for
-	that purpose.  New updates from upstream will be fetched into
-	this branch; you should never commit to it yourself.
+	The default upstream tracking branch. Most projects have at
+	least one upstream project which they track. By default
+	'origin' is used for that purpose.  New upstream updates
+	will be fetched into this branch; you should never commit
+	to it yourself.
 
 pack::
 	A set of objects which have been compressed into one file (to save
@@ -168,7 +199,8 @@ parent::
 	A commit object contains a (possibly empty) list of the logical
 	predecessor(s) in the line of development, i.e. its parents.
 
-pickaxe:: The term pickaxe refers to an option to the diffcore routines
+pickaxe::
+	The term pickaxe refers to an option to the diffcore routines
 	that help select changes that add or delete a given text string.
 	With the --pickaxe-all option, it can be used to view the
 	full changeset that introduced or removed, say, a particular
@@ -204,8 +236,8 @@ rebase::
 	changes from that branch.
 
 ref::
-	A 40-byte hex representation of a SHA1 pointing to a particular
-	object. These may be stored in `$GIT_DIR/refs/`.
+	A 40-byte hex representation of a SHA1 or a name that denotes
+	a particular object. These may be stored in `$GIT_DIR/refs/`.
 
 refspec::
 	A refspec is used by fetch and push to describe the mapping
@@ -243,10 +275,20 @@ SCM::
 SHA1::
 	Synonym for object name.
 
+symbolic ref::
+	See "ref".
+
+topic branch::
+	A regular git branch that is used by a developer to
+	identify a conceptual line of development.  Since branches
+	are very easy and inexpensive, it is often desirable to
+	have several small branches that each contain very well
+	defined concepts or small incremental yet related changes.
+
 tracking branch::
-	A regular git branch that is used to follow changes from
+	A regular git branch that is used to follow changes frompointing
 	another repository.  A tracking branch should not contain
-	direct modifications or made commits made locally.
+	direct modifications or have local commits made to it.
 	A tracking branch can usually be identified as the
 	right-hand-side ref in a Pull: refspec.
 
-- 
1.3.1.g3d990
