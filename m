From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH 1/3] Alphabetize the glossary.
Date: Wed, 03 May 2006 23:15:46 -0500
Message-ID: <E1FbVFi-0004Tt-Aw@jdl.com>
X-From: git-owner@vger.kernel.org Thu May 04 06:16:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbVFv-0002dT-A9
	for gcvg-git@gmane.org; Thu, 04 May 2006 06:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWEDEPu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 00:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWEDEPu
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 00:15:50 -0400
Received: from www.jdl.com ([66.118.10.122]:61163 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1751096AbWEDEPt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 May 2006 00:15:49 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FbVFi-0004Tt-Aw
	for git@vger.kernel.org; Wed, 03 May 2006 23:15:48 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19547>


Signed-off-by: Jon Loeliger <jdl@jdl.com>

---

Yeah, there is a script that also alphabetize the glossary.
But let's just be explicit and complete here.


 Documentation/glossary.txt |  339 ++++++++++++++++++++++----------------------
 1 files changed, 170 insertions(+), 169 deletions(-)

374314abaefe3509c6016eb811b09e115ec4f2a8
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 02a9d9c..075c078 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -1,79 +1,37 @@
-object::
-	The unit of storage in git. It is uniquely identified by
-	the SHA1 of its contents. Consequently, an object can not
-	be changed.
-
-object name::
-	The unique identifier of an object. The hash of the object's contents
-	using the Secure Hash Algorithm 1 and usually represented by the 40
-	character hexadecimal encoding of the hash of the object (possibly
-	followed by a white space).
-
-SHA1::
-	Synonym for object name.
-
-object identifier::
-	Synonym for object name.
-
-hash::
-	In git's context, synonym to object name.
-
-object database::
-	Stores a set of "objects", and an individual object is identified
-	by its object name. The objects usually live in `$GIT_DIR/objects/`.
+alternate object database::
+	Via the alternates mechanism, a repository can inherit part of its
+	object database from another object database, which is called
+	"alternate".
 
 blob object::
 	Untyped object, e.g. the contents of a file.
 
-tree object::
-	An object containing a list of file names and modes along with refs
-	to the associated blob and/or tree objects. A tree is equivalent
-	to a directory.
-
-tree::
-	Either a working tree, or a tree object together with the
-	dependent blob and tree objects (i.e. a stored representation
-	of a working tree).
-
-DAG::
-	Directed acyclic graph. The commit objects form a directed acyclic
-	graph, because they have parents (directed), and the graph of commit
-	objects is acyclic (there is no chain which begins and ends with the
-	same object).
-
-index::
-	A collection of files with stat information, whose contents are
-	stored as objects. The index is a stored version of your working
-	tree. Truth be told, it can also contain a second, and even a third
-	version of a working tree, which are used when merging.
-
-index entry::
-	The information regarding a particular file, stored in the index.
-	An index entry can be unmerged, if a merge was started, but not
-	yet finished (i.e. if the index contains multiple versions of
-	that file).
-
-unmerged index:
-	An index which contains unmerged index entries.
+branch::
+	A non-cyclical graph of revisions, i.e. the complete history of
+	a particular revision, which is called the branch head. The
+	branch heads are stored in `$GIT_DIR/refs/heads/`.
 
 cache::
 	Obsolete for: index.
 
-working tree::
-	The set of files and directories currently being worked on,
-	i.e. you can work in your working tree without using git at all.
-
-directory::
-	The list you get with "ls" :-)
+chain::
+	A list of objects, where each object in the list contains a
+	reference to its successor (for example, the successor of a commit
+	could be one of its parents).
 
-revision::
-	A particular state of files and directories which was stored in
-	the object database. It is referenced by a commit object.
+changeset::
+	BitKeeper/cvsps speak for "commit". Since git does not store
+	changes, but states, it really does not make sense to use
+	the term "changesets" with git.
 
 checkout::
 	The action of updating the working tree to a revision which was
 	stored in the object database.
 
+clean::
+	A working tree is clean, if it corresponds to the revision
+	referenced by the current head.  Also see "dirty".
+
 commit::
 	As a verb: The action of storing the current state of the index in the
 	object database. The result is a revision.
@@ -85,73 +43,72 @@ commit object::
 	tree object which corresponds to the top directory of the
 	stored revision.
 
-parent::
-	A commit object contains a (possibly empty) list of the logical
-	predecessor(s) in the line of development, i.e. its parents.
+core git::
+	Fundamental data structures and utilities of git. Exposes only
+	limited source code management tools.
 
-changeset::
-	BitKeeper/cvsps speak for "commit". Since git does not store
-	changes, but states, it really does not make sense to use
-	the term "changesets" with git.
+DAG::
+	Directed acyclic graph. The commit objects form a directed acyclic
+	graph, because they have parents (directed), and the graph of commit
+	objects is acyclic (there is no chain which begins and ends with the
+	same object).
 
-clean::
-	A working tree is clean, if it corresponds to the revision
-	referenced by the current head.
+dircache::
+	You are *waaaaay* behind.
 
 dirty::
 	A working tree is said to be dirty if it contains modifications
 	which have not been committed to the current branch.
 
-head::
-	The top of a branch. It contains a ref to the corresponding
-	commit object.
+directory::
+	The list you get with "ls" :-)
 
-branch::
-	A non-cyclical graph of revisions, i.e. the complete history of
-	a particular revision, which is called the branch head. The
-	branch heads are stored in `$GIT_DIR/refs/heads/`.
+ent::
+	Favorite synonym to "tree-ish" by some total geeks. See
+	`http://en.wikipedia.org/wiki/Ent_(Middle-earth)` for an in-depth
+	explanation.
 
-master::
-	The default branch. Whenever you create a git repository, a branch
-	named "master" is created, and becomes the active branch. In most
-	cases, this contains the local development.
+fetch::
+	Fetching a branch means to get the branch's head ref from a
+	remote repository, to find out which objects are missing from
+	the local object database, and to get them, too.
 
-origin::
-	The default upstream branch. Most projects have one upstream
-	project which they track, and by default 'origin' is used for
-	that purpose.  New updates from upstream will be fetched into
-	this branch; you should never commit to it yourself.
+file system::
+	Linus Torvalds originally designed git to be a user space file
+	system, i.e. the infrastructure to hold files and directories.
+	That ensured the efficiency and speed of git.
 
-ref::
-	A 40-byte hex representation of a SHA1 pointing to a particular
-	object. These may be stored in `$GIT_DIR/refs/`.
+git archive::
+	Synonym for repository (for arch people).
+
+hash::
+	In git's context, synonym to object name.
+
+head::
+	The top of a branch. It contains a ref to the corresponding
+	commit object.
 
 head ref::
 	A ref pointing to a head. Often, this is abbreviated to "head".
 	Head refs are stored in `$GIT_DIR/refs/heads/`.
 
-tree-ish::
-	A ref pointing to either a commit object, a tree object, or a
-	tag object pointing to a tag or commit or tree object.
+index::
+	A collection of files with stat information, whose contents are
+	stored as objects. The index is a stored version of your working
+	tree. Truth be told, it can also contain a second, and even a third
+	version of a working tree, which are used when merging.
 
-ent::
-	Favorite synonym to "tree-ish" by some total geeks. See
-	`http://en.wikipedia.org/wiki/Ent_(Middle-earth)` for an in-depth
-	explanation.
+index entry::
+	The information regarding a particular file, stored in the index.
+	An index entry can be unmerged, if a merge was started, but not
+	yet finished (i.e. if the index contains multiple versions of
+	that file).
 
-tag object::
-	An object containing a ref pointing to another object, which can
-	contain a message just like a commit object. It can also
-	contain a (PGP) signature, in which case it is called a "signed
-	tag object".
+master::
+	The default branch. Whenever you create a git repository, a branch
+	named "master" is created, and becomes the active branch. In most
+	cases, this contains the local development.
 
-tag::
-	A ref pointing to a tag or commit object. In contrast to a head,
-	a tag is not changed by a commit. Tags (not tag objects) are
-	stored in `$GIT_DIR/refs/tags/`. A git tag has nothing to do with
-	a Lisp tag (which is called object type in git's context).
-	A tag is most typically used to mark a particular point in the
-	commit ancestry chain.
 
 merge::
 	To merge branches means to try to accumulate the changes since a
@@ -159,55 +116,57 @@ merge::
 	merge uses heuristics to accomplish that. Evidently, an automatic
 	merge can fail.
 
-octopus::
-	To merge more than two branches. Also denotes an intelligent
-	predator.
+object::
+	The unit of storage in git. It is uniquely identified by
+	the SHA1 of its contents. Consequently, an object can not
+	be changed.
 
-resolve::
-	The action of fixing up manually what a failed automatic merge
-	left behind.
+object database::
+	Stores a set of "objects", and an individual object is identified
+	by its object name. The objects usually live in `$GIT_DIR/objects/`.
 
-rewind::
-	To throw away part of the development, i.e. to assign the head to
-	an earlier revision.
+object identifier::
+	Synonym for object name.
 
-rebase::
-	To clean a branch by starting from the head of the main line of
-	development ("master"), and reapply the (possibly cherry-picked)
-	changes from that branch.
+object name::
+	The unique identifier of an object. The hash of the object's contents
+	using the Secure Hash Algorithm 1 and usually represented by the 40
+	character hexadecimal encoding of the hash of the object (possibly
+	followed by a white space).
 
-repository::
-	A collection of refs together with an object database containing
-	all objects, which are reachable from the refs, possibly accompanied
-	by meta data from one or more porcelains. A repository can
-	share an object database with other repositories.
+object type:
+	One of the identifiers "commit","tree","tag" and "blob" describing
+	the type of an object.
 
-git archive::
-	Synonym for repository (for arch people).
+octopus::
+	To merge more than two branches. Also denotes an intelligent
+	predator.
 
-file system::
-	Linus Torvalds originally designed git to be a user space file
-	system, i.e. the infrastructure to hold files and directories.
-	That ensured the efficiency and speed of git.
+origin::
+	The default upstream branch. Most projects have one upstream
+	project which they track, and by default 'origin' is used for
+	that purpose.  New updates from upstream will be fetched into
+	this branch; you should never commit to it yourself.
 
-alternate object database::
-	Via the alternates mechanism, a repository can inherit part of its
-	object database from another object database, which is called
-	"alternate".
+pack::
+	A set of objects which have been compressed into one file (to save
+	space or to transmit them efficiently).
 
-reachable::
-	An object is reachable from a ref/commit/tree/tag, if there is a
-	chain leading from the latter to the former.
+pack index::
+	The list of identifiers, and other information, of the objects in a
+	pack, to assist in efficiently accessing the contents of a pack. 
 
-chain::
-	A list of objects, where each object in the list contains a
-	reference to its successor (for example, the successor of a commit
-	could be one of its parents).
+parent::
+	A commit object contains a (possibly empty) list of the logical
+	predecessor(s) in the line of development, i.e. its parents.
 
-fetch::
-	Fetching a branch means to get the branch's head ref from a
-	remote repository, to find out which objects are missing from
-	the local object database, and to get them, too.
+plumbing::
+	Cute name for core git.
+
+porcelain::
+	Cute name for programs and program suites depending on core git,
+	presenting a high level access to core git. Porcelains expose
+	more of a SCM interface than the plumbing.
 
 pull::
 	Pulling a branch means to fetch it and merge it.
@@ -221,33 +180,75 @@ push::
 	the remote head ref. If the remote head is not an ancestor to the
 	local head, the push fails.
 
-pack::
-	A set of objects which have been compressed into one file (to save
-	space or to transmit them efficiently).
+reachable::
+	An object is reachable from a ref/commit/tree/tag, if there is a
+	chain leading from the latter to the former.
 
-pack index::
-	The list of identifiers, and other information, of the objects in a
-	pack, to assist in efficiently accessing the contents of a pack. 
+rebase::
+	To clean a branch by starting from the head of the main line of
+	development ("master"), and reapply the (possibly cherry-picked)
+	changes from that branch.
 
-core git::
-	Fundamental data structures and utilities of git. Exposes only
-	limited source code management tools.
+ref::
+	A 40-byte hex representation of a SHA1 pointing to a particular
+	object. These may be stored in `$GIT_DIR/refs/`.
 
-plumbing::
-	Cute name for core git.
+repository::
+	A collection of refs together with an object database containing
+	all objects, which are reachable from the refs, possibly accompanied
+	by meta data from one or more porcelains. A repository can
+	share an object database with other repositories.
 
-porcelain::
-	Cute name for programs and program suites depending on core git,
-	presenting a high level access to core git. Porcelains expose
-	more of a SCM interface than the plumbing.
+resolve::
+	The action of fixing up manually what a failed automatic merge
+	left behind.
 
-object type:
-	One of the identifiers "commit","tree","tag" and "blob" describing
-	the type of an object.
+revision::
+	A particular state of files and directories which was stored in
+	the object database. It is referenced by a commit object.
+
+rewind::
+	To throw away part of the development, i.e. to assign the head to
+	an earlier revision.
 
 SCM::
 	Source code management (tool).
 
-dircache::
-	You are *waaaaay* behind.
+SHA1::
+	Synonym for object name.
+
+tree object::
+	An object containing a list of file names and modes along with refs
+	to the associated blob and/or tree objects. A tree is equivalent
+	to a directory.
+
+tree::
+	Either a working tree, or a tree object together with the
+	dependent blob and tree objects (i.e. a stored representation
+	of a working tree).
+
+tree-ish::
+	A ref pointing to either a commit object, a tree object, or a
+	tag object pointing to a tag or commit or tree object.
+
+tag object::
+	An object containing a ref pointing to another object, which can
+	contain a message just like a commit object. It can also
+	contain a (PGP) signature, in which case it is called a "signed
+	tag object".
+
+tag::
+	A ref pointing to a tag or commit object. In contrast to a head,
+	a tag is not changed by a commit. Tags (not tag objects) are
+	stored in `$GIT_DIR/refs/tags/`. A git tag has nothing to do with
+	a Lisp tag (which is called object type in git's context).
+	A tag is most typically used to mark a particular point in the
+	commit ancestry chain.
+
+unmerged index:
+	An index which contains unmerged index entries.
+
+working tree::
+	The set of files and directories currently being worked on,
+	i.e. you can work in your working tree without using git at all.
 
-- 
1.3.1.g3d990
