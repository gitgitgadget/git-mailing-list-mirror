From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/2] user-manual: general quoting improvements (p2)
Date: Sat, 23 Jan 2010 02:18:55 +0200
Message-ID: <1264205935-19203-3-git-send-email-felipe.contreras@gmail.com>
References: <1264205935-19203-1-git-send-email-felipe.contreras@gmail.com>
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:19:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTiz-0007y0-EX
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429Ab0AWATf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755460Ab0AWATc
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:19:32 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44817 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429Ab0AWATM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:19:12 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so1544233bwz.21
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0g8JUULlPUSgpOKYDG6n86XaQJBW3TCWG5GrkEScMw4=;
        b=dnSbkbnt64YB1gvAkunejKJWQuu60bud8rZ7kXiJ0vsQX5rxyZp0pjS6atiwJ6CxTB
         E6n7RxBkukAwgJxq4qwyrMbFFPstzslwciz0iSepOsw76jhmQ09uY49RMEJ5sCYPmqge
         nihMfUHiXFdB8mEeCmy4ejDXSmumnztHaewGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Sjia1DGrXpwqoAv8MBZ+frcsM0Uw4wCOk754+WWLzx6H+M08Wap17PiYG8RODG5ZqP
         e2w306080dg1koUoNmskRLyiU1uDAQnZuh9yVY/9MibugGMgEsVCCzpnYYfU8UzhVny8
         8iQt7dTl30PYZAPFx4+JRzdMNOMUaue0PIySU=
Received: by 10.204.18.211 with SMTP id x19mr1994229bka.116.1264205951076;
        Fri, 22 Jan 2010 16:19:11 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 14sm1239281bwz.13.2010.01.22.16.19.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 16:19:09 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1264205935-19203-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137792>

note: should be squashed with p1
---
 Documentation/user-manual.txt |  458 ++++++++++++++++++++--------------------
 1 files changed, 229 insertions(+), 229 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 8ab8968..d3e509d 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2524,7 +2524,7 @@ with
 $ git tag bad mywork~5
 -------------------------------------------------
 
-(Either gitk or `git log` may be useful for finding the commit.)
+(Either `gitk` or `git log` may be useful for finding the commit.)
 
 Then check out that commit, edit it, and rebase the rest of the series
 on top of it (note that we could check out the commit on a temporary
@@ -2537,8 +2537,8 @@ $ git commit --amend
 $ git rebase --onto HEAD bad mywork
 -------------------------------------------------
 
-When you're done, you'll be left with mywork checked out, with the top
-patches on mywork reapplied on top of your modified commit.  You can
+When you're done, you'll be left with 'mywork' checked out, with the top
+patches on 'mywork' reapplied on top of your modified commit.  You can
 then clean up with
 
 -------------------------------------------------
@@ -2546,7 +2546,7 @@ $ git tag -d bad
 -------------------------------------------------
 
 Note that the immutable nature of git history means that you haven't really
-"modified" existing commits; instead, you have replaced the old commits with
+`modified' existing commits; instead, you have replaced the old commits with
 new commits having new object names.
 
 [[reordering-patch-series]]
@@ -2555,20 +2555,20 @@ Reordering or selecting from a patch series
 
 Given one existing commit, the linkgit:git-cherry-pick[1] command
 allows you to apply the change introduced by that commit and create a
-new commit that records it.  So, for example, if "mywork" points to a
-series of patches on top of "origin", you might do something like:
+new commit that records it.  So, for example, if 'mywork' points to a
+series of patches on top of 'origin', you might do something like:
 
 -------------------------------------------------
 $ git checkout -b mywork-new origin
 $ gitk origin..mywork &
 -------------------------------------------------
 
-and browse through the list of patches in the mywork branch using gitk,
-applying them (possibly in a different order) to mywork-new using
-cherry-pick, and possibly modifying them as you go using `git commit --amend`.
+and browse through the list of patches in the 'mywork' branch using `gitk`,
+applying them (possibly in a different order) to 'mywork-new' using
+`git cherry-pick`, and possibly modifying them as you go using `git commit --amend`.
 The linkgit:git-gui[1] command may also help as it allows you to
 individually select diff hunks for inclusion in the index (by
-right-clicking on the diff hunk and choosing "Stage Hunk for Commit").
+right-clicking on the diff hunk and choosing '"Stage Hunk for Commit"').
 
 Another technique is to use `git format-patch` to create a series of
 patches, then reset the state to before the patches:
@@ -2585,7 +2585,7 @@ them again with linkgit:git-am[1].
 Other tools
 -----------
 
-There are numerous other tools, such as StGit, which exist for the
+There are numerous other tools, such as 'StGit', which exist for the
 purpose of maintaining a patch series.  These are outside of the scope of
 this manual.
 
@@ -2656,26 +2656,26 @@ Imagine this history:
 ................................................
 
 Suppose that on the upper line of development, the meaning of one
-of the functions that exists at Z is changed at commit X.  The
-commits from Z leading to A change both the function's
-implementation and all calling sites that exist at Z, as well
+of the functions that exists at 'Z' is changed at commit 'X'.  The
+commits from 'Z' leading to A change both the function's
+implementation and all calling sites that exist at 'Z', as well
 as new calling sites they add, to be consistent.  There is no
-bug at A.
+bug at 'A'.
 
 Suppose that in the meantime on the lower line of development somebody
-adds a new calling site for that function at commit Y.  The
-commits from Z leading to B all assume the old semantics of that
+adds a new calling site for that function at commit 'Y'.  The
+commits from 'Z' leading to 'B' all assume the old semantics of that
 function and the callers and the callee are consistent with each
-other.  There is no bug at B, either.
+other.  There is no bug at 'B', either.
 
-Suppose further that the two development lines merge cleanly at C,
+Suppose further that the two development lines merge cleanly at 'C',
 so no conflict resolution is required.
 
-Nevertheless, the code at C is broken, because the callers added
+Nevertheless, the code at 'C' is broken, because the callers added
 on the lower line of development have not been converted to the new
 semantics introduced on the upper line of development.  So if all
-you know is that D is bad, that Z is good, and that
-linkgit:git-bisect[1] identifies C as the culprit, how will you
+you know is that 'D' is bad, that 'Z' is good, and that
+linkgit:git-bisect[1] identifies 'C' as the culprit, how will you
 figure out that the problem is due to this change in semantics?
 
 When the result of a `git bisect` is a non-merge commit, you should
@@ -2688,16 +2688,16 @@ make matters worse, the change in semantics in the problematic
 function may be just one small part of the changes in the upper
 line of development.
 
-On the other hand, if instead of merging at C you had rebased the
-history between Z to B on top of A, you would have gotten this
+On the other hand, if instead of merging at 'C' you had rebased the
+history between 'Z' to 'B' on top of 'A', you would have gotten this
 linear history:
 
 ................................................................
     ---Z---o---X--...---o---A---o---o---Y*--...---o---B*--D*
 ................................................................
 
-Bisecting between Z and D* would hit a single culprit commit Y*,
-and understanding why Y* was broken would probably be easier.
+Bisecting between 'Z' and 'D*' would hit a single culprit commit 'Y*',
+and understanding why 'Y*' was broken would probably be easier.
 
 Partly for this reason, many experienced git users, even when
 working on an otherwise merge-heavy project, keep the history
@@ -2720,10 +2720,10 @@ arbitrary name:
 $ git fetch origin todo:my-todo-work
 -------------------------------------------------
 
-The first argument, "origin", just tells git to fetch from the
+The first argument, 'origin', just tells git to fetch from the
 repository you originally cloned from.  The second argument tells git
-to fetch the branch named "todo" from the remote repository, and to
-store it locally under the name refs/heads/my-todo-work.
+to fetch the branch named 'todo' from the remote repository, and to
+store it locally under the name 'refs/heads/my-todo-work'.
 
 You can also fetch branches from other repositories; so
 
@@ -2731,9 +2731,9 @@ You can also fetch branches from other repositories; so
 $ git fetch git://example.com/proj.git master:example-master
 -------------------------------------------------
 
-will create a new branch named "example-master" and store in it the
-branch named "master" from the repository at the given URL.  If you
-already have a branch named example-master, it will attempt to
+will create a new branch named '"example-master"' and store in it the
+branch named '"master"' from the repository at the given URL.  If you
+already have a branch named 'example-master', it will attempt to
 <<fast-forwards,fast-forward>> to the commit given by example.com's
 master branch.  In more detail:
 
@@ -2747,7 +2747,7 @@ branch is a descendant of the most recent commit on your copy of the
 branch before updating your copy of the branch to point at the new
 commit.  Git calls this process a <<fast-forwards,fast-forward>>.
 
-A fast-forward looks something like this:
+A 'fast-forward' looks something like this:
 
 ................................................
  o--o--o--o <-- old head of the branch
@@ -2771,36 +2771,36 @@ In this case, "git fetch" will fail, and print out a warning.
 
 In that case, you can still force git to update to the new head, as
 described in the following section.  However, note that in the
-situation above this may mean losing the commits labeled "a" and "b",
+situation above this may mean losing the commits labeled '"a"' and '"b"',
 unless you've already created a reference of your own pointing to
 them.
 
 [[forcing-fetch]]
-Forcing git fetch to do non-fast-forward updates
+Forcing `git fetch` to do non-fast-forward updates
 ------------------------------------------------
 
-If git fetch fails because the new head of a branch is not a
+If `git fetch` fails because the new head of a branch is not a
 descendant of the old head, you may force the update with:
 
 -------------------------------------------------
 $ git fetch git://example.com/proj.git +master:refs/remotes/example/master
 -------------------------------------------------
 
-Note the addition of the "+" sign.  Alternatively, you can use the "-f"
+Note the addition of the '"+"' sign.  Alternatively, you can use the `-f`
 flag to force updates of all the fetched branches, as in:
 
 -------------------------------------------------
 $ git fetch -f origin
 -------------------------------------------------
 
-Be aware that commits that the old version of example/master pointed at
+Be aware that commits that the old version of 'example/master' pointed at
 may be lost, as we saw in the previous section.
 
 [[remote-branch-configuration]]
 Configuring remote branches
 ---------------------------
 
-We saw above that "origin" is just a shortcut to refer to the
+We saw above that '"origin"' is just a shortcut to refer to the
 repository that you originally cloned from.  This information is
 stored in git configuration variables, which you can see using
 linkgit:git-config[1]:
@@ -2845,7 +2845,7 @@ $ git fetch example master:refs/remotes/example/master
 $ git fetch example
 -------------------------------------------------
 
-You can also add a "+" to force the update each time:
+You can also add a '"+"' to force the update each time:
 
 -------------------------------------------------
 $ git config remote.example.fetch +master:ref/remotes/example/master
@@ -2855,7 +2855,7 @@ Don't do this unless you're sure you won't mind "git fetch" possibly
 throwing away commits on 'example/master'.
 
 Also note that all of the above configuration can be performed by
-directly editing the file .git/config instead of using
+directly editing the file `.git/config` instead of using
 linkgit:git-config[1].
 
 See linkgit:git-config[1] for more details on the configuration
@@ -2879,10 +2879,10 @@ The Object Database
 
 
 We already saw in <<understanding-commits>> that all commits are stored
-under a 40-digit "object name".  In fact, all the information needed to
+under a 40-digit 'object name'.  In fact, all the information needed to
 represent the history of a project is stored in objects with such names.
-In each case the name is calculated by taking the SHA-1 hash of the
-contents of the object.  The SHA-1 hash is a cryptographic hash function.
+In each case the name is calculated by taking the `SHA-1` hash of the
+contents of the object.  The `SHA-1` hash is a cryptographic hash function.
 What that means to us is that it is impossible to find two different
 objects with the same name.  This has a number of advantages; among
 others:
@@ -2893,25 +2893,25 @@ others:
   same content stored in two repositories will always be stored under
   the same name.
 - Git can detect errors when it reads an object, by checking that the
-  object's name is still the SHA-1 hash of its contents.
+  object's name is still the `SHA-1` hash of its contents.
 
 (See <<object-details>> for the details of the object formatting and
-SHA-1 calculation.)
+`SHA-1` calculation.)
 
-There are four different types of objects: "blob", "tree", "commit", and
-"tag".
+There are four different types of objects: 'blob', 'tree', 'commit', and
+'tag'.
 
-- A <<def_blob_object,"blob" object>> is used to store file data.
-- A <<def_tree_object,"tree" object>> ties one or more
-  "blob" objects into a directory structure. In addition, a tree object
+- A <<def_blob_object,'blob' object>> is used to store file data.
+- A <<def_tree_object,'tree' object>> ties one or more
+  'blob' objects into a directory structure. In addition, a tree object
   can refer to other tree objects, thus creating a directory hierarchy.
-- A <<def_commit_object,"commit" object>> ties such directory hierarchies
+- A <<def_commit_object,'commit' object>> ties such directory hierarchies
   together into a <<def_DAG,directed acyclic graph>> of revisions--each
   commit contains the object name of exactly one tree designating the
   directory hierarchy at the time of the commit. In addition, a commit
-  refers to "parent" commit objects that describe the history of how we
+  refers to 'parent' commit objects that describe the history of how we
   arrived at that directory hierarchy.
-- A <<def_tag_object,"tag" object>> symbolically identifies and can be
+- A <<def_tag_object,`tag` object>> symbolically identifies and can be
   used to sign other objects. It contains the object name and type of
   another object, a symbolic name (of course!) and, optionally, a
   signature.
@@ -2922,8 +2922,8 @@ The object types in some more detail:
 Commit Object
 ~~~~~~~~~~~~~
 
-The "commit" object links a physical state of a tree with a description
-of how we got there and why.  Use the --pretty=raw option to
+The 'commit' object links a physical state of a tree with a description
+of how we got there and why.  Use the `--pretty=raw` option to
 linkgit:git-show[1] or linkgit:git-log[1] to examine your favorite
 commit:
 
@@ -2942,19 +2942,19 @@ committer Junio C Hamano <gitster@pobox.com> 1187591163 -0700
 
 As you can see, a commit is defined by:
 
-- a tree: The SHA-1 name of a tree object (as defined below), representing
+- a 'tree': The `SHA-1` name of a tree object (as defined below), representing
   the contents of a directory at a certain point in time.
-- parent(s): The SHA-1 name of some number of commits which represent the
+- 'parent(s)': The `SHA-1` name of some number of commits which represent the
   immediately previous step(s) in the history of the project.  The
   example above has one parent; merge commits may have more than
-  one.  A commit with no parents is called a "root" commit, and
+  one.  A commit with no parents is called a 'root' commit, and
   represents the initial revision of a project.  Each project must have
   at least one root.  A project can also have multiple roots, though
   that isn't common (or necessarily a good idea).
-- an author: The name of the person responsible for this change, together
+- an 'author': The name of the person responsible for this change, together
   with its date.
-- a committer: The name of the person who actually created the commit,
-  with the date it was done.  This may be different from the author, for
+- a 'committer': The name of the person who actually created the commit,
+  with the date it was done.  This may be different from the 'author', for
   example, if the author was someone who wrote a patch and emailed it
   to the person who used it to create the commit.
 - a comment describing this commit.
@@ -2965,11 +2965,11 @@ of the tree referred to by this commit with the trees associated with
 its parents.  In particular, git does not attempt to record file renames
 explicitly, though it can identify cases where the existence of the same
 file data at changing paths suggests a rename.  (See, for example, the
--M option to linkgit:git-diff[1]).
+`-M` option to linkgit:git-diff[1]).
 
 A commit is usually created by linkgit:git-commit[1], which creates a
-commit whose parent is normally the current HEAD, and whose tree is
-taken from the content currently stored in the index.
+commit whose parent is normally the current `HEAD`, and whose tree is
+taken from the content currently stored in the `index`.
 
 [[tree-object]]
 Tree Object
@@ -2993,13 +2993,13 @@ $ git ls-tree fb3a8bdd0ce
 ------------------------------------------------
 
 As you can see, a tree object contains a list of entries, each with a
-mode, object type, SHA-1 name, and name, sorted by name.  It represents
+mode, object type, `SHA-1` name, and name, sorted by name.  It represents
 the contents of a single directory tree.
 
 The object type may be a blob, representing the contents of a file, or
 another tree, representing the contents of a subdirectory.  Since trees
-and blobs, like all other objects, are named by the SHA-1 hash of their
-contents, two trees have the same SHA-1 name if and only if their
+and blobs, like all other objects, are named by the `SHA-1` hash of their
+contents, two trees have the same `SHA-1` name if and only if their
 contents (including, recursively, the contents of all subdirectories)
 are identical.  This allows git to quickly determine the differences
 between two related tree objects, since it can ignore any entries with
@@ -3016,7 +3016,7 @@ Blob Object
 ~~~~~~~~~~~
 
 You can use linkgit:git-show[1] to examine the contents of a blob; take,
-for example, the blob in the entry for "COPYING" from the tree above:
+for example, the blob in the entry for 'COPYING' from the tree above:
 
 ------------------------------------------------
 $ git show 6ff87c4664
@@ -3027,7 +3027,7 @@ $ git show 6ff87c4664
 ...
 ------------------------------------------------
 
-A "blob" object is nothing but a binary blob of data.  It doesn't refer
+A 'blob' object is nothing but a binary blob of data.  It doesn't refer
 to anything else or have attributes of any kind.
 
 Since the blob is entirely defined by its data, if two files in a
@@ -3037,7 +3037,7 @@ is totally independent of its location in the directory tree, and
 renaming a file does not change the object that file is associated with.
 
 Note that any tree or blob object can be examined using
-linkgit:git-show[1] with the <revision>:<path> syntax.  This can
+linkgit:git-show[1] with the '<revision>:<path>' syntax.  This can
 sometimes be useful for browsing the contents of a tree that is not
 currently checked out.
 
@@ -3045,27 +3045,27 @@ currently checked out.
 Trust
 ~~~~~
 
-If you receive the SHA-1 name of a blob from one source, and its contents
+If you receive the `SHA-1` name of a blob from one source, and its contents
 from another (possibly untrusted) source, you can still trust that those
-contents are correct as long as the SHA-1 name agrees.  This is because
-the SHA-1 is designed so that it is infeasible to find different contents
+contents are correct as long as the `SHA-1` name agrees.  This is because
+the `SHA-1` is designed so that it is infeasible to find different contents
 that produce the same hash.
 
-Similarly, you need only trust the SHA-1 name of a top-level tree object
+Similarly, you need only trust the `SHA-1` name of a top-level tree object
 to trust the contents of the entire directory that it refers to, and if
-you receive the SHA-1 name of a commit from a trusted source, then you
+you receive the `SHA-1` name of a commit from a trusted source, then you
 can easily verify the entire history of commits reachable through
 parents of that commit, and all of those contents of the trees referred
 to by those commits.
 
 So to introduce some real trust in the system, the only thing you need
-to do is to digitally sign just 'one' special note, which includes the
+to do is to digitally sign just *one* special note, which includes the
 name of a top-level commit.  Your digital signature shows others
 that you trust that commit, and the immutability of the history of
 commits tells others that they can trust the whole history.
 
 In other words, you can easily validate a whole archive by just
-sending out a single email that tells the people the name (SHA-1 hash)
+sending out a single email that tells the people the name (`SHA-1` hash)
 of the top commit, and digitally sign that email using something
 like GPG/PGP.
 
@@ -3075,9 +3075,9 @@ To assist in this, git also provides the tag object...
 Tag Object
 ~~~~~~~~~~
 
-A tag object contains an object, object type, tag name, the name of the
-person ("tagger") who created the tag, and a message, which may contain
-a signature, as can be seen using linkgit:git-cat-file[1]:
+A 'tag' object contains an 'object', 'object type', 'tag name', the name of the
+person ('tagger') who created the tag, and a message, which may contain
+a 'signature', as can be seen using linkgit:git-cat-file[1]:
 
 ------------------------------------------------
 $ git cat-file tag v1.5.0
@@ -3098,15 +3098,15 @@ nLE/L9aUXdWeTFPron96DLA=
 
 See the linkgit:git-tag[1] command to learn how to create and verify tag
 objects.  (Note that linkgit:git-tag[1] can also be used to create
-"lightweight tags", which are not tag objects at all, but just simple
-references whose names begin with "refs/tags/").
+``lightweight tags'', which are not tag objects at all, but just simple
+references whose names begin with 'refs/tags/').
 
 [[pack-files]]
 How git stores objects efficiently: pack files
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Newly created objects are initially created in a file named after the
-object's SHA-1 hash (stored in .git/objects).
+object's `SHA-1` hash (stored in '.git/objects').
 
 Unfortunately this system becomes inefficient once a project has a
 lot of objects.  Try this on an old project:
@@ -3118,14 +3118,14 @@ $ git count-objects
 
 The first number is the number of objects which are kept in
 individual files.  The second is the amount of space taken up by
-those "loose" objects.
+those 'loose' objects.
 
 You can save space and make git faster by moving these loose objects in
-to a "pack file", which stores a group of objects in an efficient
+to a 'pack file', which stores a group of objects in an efficient
 compressed format; the details of how pack files are formatted can be
 found in link:technical/pack-format.txt[technical/pack-format.txt].
 
-To put the loose objects into a pack, just run git repack:
+To put the loose objects into a pack, just run `git repack`:
 
 ------------------------------------------------
 $ git repack
@@ -3145,11 +3145,11 @@ You can then run
 $ git prune
 ------------------------------------------------
 
-to remove any of the "loose" objects that are now contained in the
+to remove any of the 'loose' objects that are now contained in the
 pack.  This will also remove any unreferenced objects (which may be
-created when, for example, you use "git reset" to remove a commit).
+created when, for example, you use `git reset` to remove a commit).
 You can verify that the loose objects are gone by looking at the
-.git/objects directory or by running
+'.git/objects' directory or by running
 
 ------------------------------------------------
 $ git count-objects
@@ -3176,20 +3176,20 @@ branch still exists, as does everything it pointed to. The branch
 pointer itself just doesn't, since you replaced it with another one.
 
 There are also other situations that cause dangling objects. For
-example, a "dangling blob" may arise because you did a "git add" of a
+example, a 'dangling blob' may arise because you did a `git add` of a
 file, but then, before you actually committed it and made it part of the
 bigger picture, you changed something else in that file and committed
 that *updated* thing--the old state that you added originally ends up
 not being pointed to by any commit or tree, so it's now a dangling blob
 object.
 
-Similarly, when the "recursive" merge strategy runs, and finds that
+Similarly, when the 'recursive' merge strategy runs, and finds that
 there are criss-cross merges and thus more than one merge base (which is
 fairly unusual, but it does happen), it will generate one temporary
 midway tree (or possibly even more, if you had lots of criss-crossing
 merges and more than two merge bases) as a temporary internal merge
 base, and again, those are real objects, but the end result will not end
-up pointing to them, so they end up "dangling" in your repository.
+up pointing to them, so they end up 'dangling' in your repository.
 
 Generally, dangling objects aren't anything to worry about. They can
 even be very useful: if you screw something up, the dangling objects can
@@ -3219,15 +3219,15 @@ $ git show <dangling-blob/tree-sha-goes-here>
 ------------------------------------------------
 
 to show what the contents of the blob were (or, for a tree, basically
-what the "ls" for that directory was), and that may give you some idea
+what the 'ls' for that directory was), and that may give you some idea
 of what the operation was that left that dangling object.
 
 Usually, dangling blobs and trees aren't very interesting. They're
 almost always the result of either being a half-way mergebase (the blob
 will often even have the conflict markers from a merge in it, if you
 have had conflicting merges that you fixed up by hand), or simply
-because you interrupted a "git fetch" with ^C or something like that,
-leaving _some_ of the new objects in the object database, but just
+because you interrupted a `git fetch` with '^C' or something like that,
+leaving *some* of the new objects in the object database, but just
 dangling and useless.
 
 Anyway, once you are sure that you're not interested in any dangling
@@ -3237,17 +3237,17 @@ state, you can just prune all unreachable objects:
 $ git prune
 ------------------------------------------------
 
-and they'll be gone. But you should only run "git prune" on a quiescent
-repository--it's kind of like doing a filesystem fsck recovery: you
+and they'll be gone. But you should only run `git prune` on a quiescent
+repository--it's kind of like doing a filesystem 'fsck' recovery: you
 don't want to do that while the filesystem is mounted.
 
-(The same is true of "git fsck" itself, btw, but since
+(The same is true of `git fsck` itself, btw, but since
 `git fsck` never actually *changes* the repository, it just reports
 on what it found, `git fsck` itself is never 'dangerous' to run.
 Running it while somebody is actually changing the repository can cause
 confusing and scary messages, but it won't actually do anything bad. In
-contrast, running "git prune" while somebody is actively changing the
-repository is a *BAD* idea).
+contrast, running `git prune` while somebody is actively changing the
+repository is a *bad* idea).
 
 [[recovering-from-repository-corruption]]
 Recovering from repository corruption
@@ -3258,7 +3258,7 @@ the absence of bugs in git itself, it is still possible that hardware or
 operating system errors could corrupt data.
 
 The first defense against such problems is backups.  You can back up a
-git directory using clone, or just using cp, tar, or any other backup
+git directory using `git clone`, or just using 'cp', 'tar', or any other backup
 mechanism.
 
 As a last resort, you can search for the corrupted objects and attempt
@@ -3281,13 +3281,13 @@ broken link from    tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
 missing blob 4b9458b3786228369c63936db65827de3cc06200
 ------------------------------------------------
 
-(Typically there will be some "dangling object" messages too, but they
+(Typically there will be some 'dangling object' messages too, but they
 aren't interesting.)
 
-Now you know that blob 4b9458b3 is missing, and that the tree 2d9263c6
+Now you know that blob '4b9458b3' is missing, and that the tree '2d9263c6'
 points to it.  If you could find just one copy of that missing blob
 object, possibly in some other repository, you could move it into
-.git/objects/4b/9458b3... and be done.  Suppose you can't.  You can
+'.git/objects/4b/9458b3...' and be done.  Suppose you can't.  You can
 still examine the tree that pointed to it with linkgit:git-ls-tree[1],
 which might output something like:
 
@@ -3302,10 +3302,10 @@ $ git ls-tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
 ------------------------------------------------
 
 So now you know that the missing blob was the data for a file named
-"myfile".  And chances are you can also identify the directory--let's
-say it's in "somedirectory".  If you're lucky the missing copy might be
+'myfile'.  And chances are you can also identify the directory--let's
+say it's in 'somedirectory'.  If you're lucky the missing copy might be
 the same as the copy you have checked out in your working tree at
-"somedirectory/myfile"; you can test whether that's right with
+'somedirectory/myfile'; you can test whether that's right with
 linkgit:git-hash-object[1]:
 
 ------------------------------------------------
@@ -3313,8 +3313,8 @@ $ git hash-object -w somedirectory/myfile
 ------------------------------------------------
 
 which will create and store a blob object with the contents of
-somedirectory/myfile, and output the SHA-1 of that object.  if you're
-extremely lucky it might be 4b9458b3786228369c63936db65827de3cc06200, in
+'somedirectory/myfile', and output the `SHA-1` of that object.  if you're
+extremely lucky it might be '4b9458b3786228369c63936db65827de3cc06200', in
 which case you've guessed right, and the corruption is fixed!
 
 Otherwise, you need more information.  How do you tell which version of
@@ -3345,12 +3345,12 @@ Date:
 ------------------------------------------------
 
 This tells you that the immediately preceding version of the file was
-"newsha", and that the immediately following version was "oldsha".
-You also know the commit messages that went with the change from oldsha
-to 4b9458b and with the change from 4b9458b to newsha.
+'newsha', and that the immediately following version was 'oldsha'.
+You also know the commit messages that went with the change from 'oldsha'
+to '4b9458b' and with the change from '4b9458b' to 'newsha'.
 
 If you've been committing small enough changes, you may now have a good
-shot at reconstructing the contents of the in-between state 4b9458b.
+shot at reconstructing the contents of the in-between state '4b9458b'.
 
 If you can do that, you can now recreate the missing object with
 
@@ -3360,13 +3360,13 @@ $ git hash-object -w <recreated-file>
 
 and your repository is good again!
 
-(Btw, you could have ignored the fsck, and started with doing a
+(Btw, you could have ignored the 'fsck', and started with doing a
 
 ------------------------------------------------
 $ git log --raw --all
 ------------------------------------------------
 
-and just looked for the sha of the missing object (4b9458b..) in that
+and just looked for the sha of the missing object ('4b9458b..') in that
 whole thing. It's up to you - git does *have* a lot of information, it is
 just missing one particular blob version.
 
@@ -3374,8 +3374,8 @@ just missing one particular blob version.
 The index
 -----------
 
-The index is a binary file (generally kept in .git/index) containing a
-sorted list of path names, each with permissions and the SHA-1 of a blob
+The index is a binary file (generally kept in `.git/index'` containing a
+sorted list of path names, each with permissions and the `SHA-1` of a blob
 object; linkgit:git-ls-files[1] can show you the contents of the index:
 
 -------------------------------------------------
@@ -3392,7 +3392,7 @@ $ git ls-files --stage
 -------------------------------------------------
 
 Note that in older documentation you may see the index called the
-"current directory cache" or just the "cache".  It has three important
+``current directory cache'' or just the ``cache''.  It has three important
 properties:
 
 1. The index contains all the information necessary to generate a single
@@ -3418,7 +3418,7 @@ associated with sufficient information about the trees involved that
 you can create a three-way merge between them.
 +
 We saw in <<conflict-resolution>> that during a merge the index can
-store multiple versions of a single file (called "stages").  The third
+store multiple versions of a single file (called ``stages'').  The third
 column in the linkgit:git-ls-files[1] output above is the stage
 number, and will take on values other than 0 for files with merge
 conflicts.
@@ -3464,7 +3464,7 @@ Git's submodule support allows a repository to contain, as a subdirectory, a
 checkout of an external project.  Submodules maintain their own identity;
 the submodule support just stores the submodule repository location and
 commit ID, so other developers who clone the containing project
-("superproject") can easily clone all the submodules at the same revision.
+(``superproject'') can easily clone all the submodules at the same revision.
 Partial checkouts of the superproject are possible: you can tell Git to
 clone none, some or all of the submodules.
 
@@ -3491,7 +3491,7 @@ do
 done
 -------------------------------------------------
 
-Now create the superproject and add all the submodules:
+Now create the 'superproject' and add all the submodules:
 
 -------------------------------------------------
 $ mkdir super
@@ -3503,7 +3503,7 @@ do
 done
 -------------------------------------------------
 
-NOTE: Do not use local URLs here if you plan to publish your superproject!
+*NOTE*: Do not use local URLs here if you plan to publish your superproject!
 
 See what files `git submodule` created:
 
@@ -3514,7 +3514,7 @@ $ ls -a
 
 The `git submodule add <repo> <path>` command does a couple of things:
 
-- It clones the submodule from <repo> to the given <path> under the
+- It clones the submodule from '<repo>' to the given '<path>' under the
   current directory and by default checks out the master branch.
 - It adds the submodule's clone path to the linkgit:gitmodules[5] file and
   adds this file to the index, ready to be committed.
@@ -3547,9 +3547,9 @@ $ git submodule status
 -d96249ff5d57de5de093e6baff9e0aafa5276a74 d
 -------------------------------------------------
 
-NOTE: The commit object names shown above would be different for you, but they
-should match the HEAD commit object names of your repositories.  You can check
-it by running `git ls-remote ../a`.
+*NOTE*: The commit object names shown above would be different for you, but they
+should match the `HEAD` commit object names of your repositories.  You can check
+it by running '"git ls-remote ../a"'.
 
 Pulling down the submodules is a two-step process. First run `git submodule
 init` to add the submodule repository URLs to `.git/config`:
@@ -3660,7 +3660,7 @@ $ cat a.txt
 module a
 -------------------------------------------------
 
-NOTE: The changes are still visible in the submodule's reflog.
+*NOTE*: The changes are still visible in the submodule's `reflog`.
 
 This is not the case if you did not commit your changes.
 
@@ -3701,7 +3701,7 @@ between the working tree, the index, and the object database.  Git
 provides low-level operations which perform each of these steps
 individually.
 
-Generally, all "git" operations work on the index file. Some operations
+Generally, all git operations work on the index file. Some operations
 work *purely* on the index file (showing the current state of the
 index), but most operations move data between the index file and either
 the database or the working directory. Thus there are four main
@@ -3728,7 +3728,7 @@ To tell git that yes, you really do realize that certain files no
 longer exist, or that new files should be added, you
 should use the `--remove` and `--add` flags respectively.
 
-NOTE! A `--remove` flag does 'not' mean that subsequent filenames will
+*NOTE!* A `--remove` flag does *not* mean that subsequent filenames will
 necessarily be removed: if the files still exist in your directory
 structure, the index will be updated with their new status, not
 removed. The only thing `--remove` means is that update-index will be
@@ -3736,8 +3736,8 @@ considering a removed file to be a valid thing, and if the file really
 does not exist any more, it will update the index accordingly.
 
 As a special case, you can also do `git update-index --refresh`, which
-will refresh the "stat" information of each index to match the current
-stat information. It will 'not' update the object status itself, and
+will refresh the 'stat' information of each index to match the current
+stat information. It will *not* update the object status itself, and
 it will only update the fields that are used to quickly test whether
 an object still matches its old backing store object.
 
@@ -3748,7 +3748,7 @@ linkgit:git-update-index[1].
 index -> object database
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-You write your current index file to a "tree" object with the program
+You write your current index file to a 'tree' object with the program
 
 -------------------------------------------------
 $ git write-tree
@@ -3764,7 +3764,7 @@ other direction:
 object database -> index
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-You read a "tree" file from the object database, and use that to
+You read a 'tree' file from the object database, and use that to
 populate (and overwrite--don't do this if your index contains any
 unsaved state that you might want to restore later!) your current
 index.  Normal operation is just
@@ -3781,7 +3781,7 @@ directory contents have not been modified.
 index -> working directory
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-You update your working directory from the index by "checking out"
+You update your working directory from the index by `checking out'
 files. This is not a very common operation, since normally you'd just
 keep your files updated, and rather than write to your working
 directory, you'd tell the index files about the changes in your
@@ -3798,9 +3798,9 @@ $ git checkout-index filename
 
 or, if you want to check out all of the index, use `-a`.
 
-NOTE! `git checkout-index` normally refuses to overwrite old files, so
+*NOTE!* `git checkout-index` normally refuses to overwrite old files, so
 if you have an old version of the tree already checked out, you will
-need to use the "-f" flag ('before' the "-a" flag or the filename) to
+need to use the `-f` flag (*before* the `-a` flag or the filename) to
 'force' the checkout.
 
 
@@ -3811,19 +3811,19 @@ from one representation to the other:
 Tying it all together
 ~~~~~~~~~~~~~~~~~~~~~
 
-To commit a tree you have instantiated with "git write-tree", you'd
-create a "commit" object that refers to that tree and the history
+To commit a tree you have instantiated with `git write-tree`, you'd
+create a 'commit' object that refers to that tree and the history
 behind it--most notably the "parent" commits that preceded it in
 history.
 
-Normally a "commit" has one parent: the previous state of the tree
+Normally a commit has one parent: the previous state of the tree
 before a certain change was made. However, sometimes it can have two
-or more parent commits, in which case we call it a "merge", due to the
-fact that such a commit brings together ("merges") two or more
+or more parent commits, in which case we call it a 'merge', due to the
+fact that such a commit brings together (merges) two or more
 previous states represented by other commits.
 
-In other words, while a "tree" represents a particular directory state
-of a working directory, a "commit" represents that state in "time",
+In other words, while a 'tree' represents a particular directory state
+of a working directory, a 'commit' represents that state in 'time',
 and explains how we got there.
 
 You create a commit object by giving it the tree that describes the
@@ -3903,12 +3903,12 @@ usually implicit in where you find the object), you can use
 $ git cat-file blob|tree|commit|tag <objectname>
 -------------------------------------------------
 
-to show its contents. NOTE! Trees have binary content, and as a result
+to show its contents. *NOTE!* Trees have binary content, and as a result
 there is a special helper for showing that content, called
 `git ls-tree`, which turns the binary content into a more easily
 readable form.
 
-It's especially instructive to look at "commit" objects, since those
+It's especially instructive to look at `commit` objects, since those
 tend to be small and fairly self-explanatory. In particular, if you
 follow the convention of having the top commit name in `.git/HEAD`,
 you can do
@@ -3925,16 +3925,16 @@ Merging multiple trees
 
 Git helps you do a three-way merge, which you can expand to n-way by
 repeating the merge procedure arbitrary times until you finally
-"commit" the state.  The normal situation is that you'd only do one
+'commit' the state.  The normal situation is that you'd only do one
 three-way merge (two parents), and commit it, but if you like to, you
 can do multiple parents in one go.
 
-To do a three-way merge, you need the two sets of "commit" objects
+To do a three-way merge, you need the two sets of 'commit' objects
 that you want to merge, use those to find the closest common parent (a
-third "commit" object), and then use those commit objects to find the
-state of the directory ("tree" object) at these points.
+third 'commit' object), and then use those commit objects to find the
+state of the directory ('tree' object) at these points.
 
-To get the "base" for the merge, you first look up the common parent
+To get the 'base' for the merge, you first look up the common parent
 of two commits with
 
 -------------------------------------------------
@@ -3942,7 +3942,7 @@ $ git merge-base <commit1> <commit2>
 -------------------------------------------------
 
 which will return you the commit they are both based on.  You should
-now look up the "tree" objects of those commits, which you can easily
+now look up the 'tree'; objects of those commits, which you can easily
 do with (for example)
 
 -------------------------------------------------
@@ -3952,9 +3952,9 @@ $ git cat-file commit <commitname> | head -1
 since the tree object information is always the first line in a commit
 object.
 
-Once you know the three trees you are going to merge (the one "original"
-tree, aka the common tree, and the two "result" trees, aka the branches
-you want to merge), you do a "merge" read into the index. This will
+Once you know the three trees you are going to merge (the one '`original''
+tree, aka the common tree, and the two '`result'' trees, aka the branches
+you want to merge), you do a 'merge' read into the index. This will
 complain if it has to throw away your old index contents, so you should
 make sure that you've committed those--in fact you would normally
 always do a merge against your last commit (which should thus match what
@@ -3978,7 +3978,7 @@ Merging multiple trees, continued
 Sadly, many merges aren't trivial. If there are files that have
 been added, moved or removed, or if both branches have modified the
 same file, you will be left with an index tree that contains "merge
-entries" in it. Such an index tree can 'NOT' be written out to a tree
+entries" in it. Such an index tree can *not* be written out to a tree
 object, and you will have to resolve any such merge clashes using
 other tools before you can write out the result.
 
@@ -3994,20 +3994,20 @@ $ git ls-files --unmerged
 ------------------------------------------------
 
 Each line of the `git ls-files --unmerged` output begins with
-the blob mode bits, blob SHA-1, 'stage number', and the
+the blob mode bits, blob `SHA-1`, 'stage number', and the
 filename.  The 'stage number' is git's way to say which tree it
-came from: stage 1 corresponds to `$orig` tree, stage 2 `HEAD`
-tree, and stage3 `$target` tree.
+came from: stage 1 corresponds to '$orig' tree, stage 2 'HEAD'
+tree, and stage3 '$target' tree.
 
 Earlier we said that trivial merges are done inside
 `git read-tree -m`.  For example, if the file did not change
-from `$orig` to `HEAD` nor `$target`, or if the file changed
-from `$orig` to `HEAD` and `$orig` to `$target` the same way,
-obviously the final outcome is what is in `HEAD`.  What the
-above example shows is that file `hello.c` was changed from
-`$orig` to `HEAD` and `$orig` to `$target` in a different way.
+from '$orig' to 'HEAD' nor '$target', or if the file changed
+from '$orig' to 'HEAD' and '$orig' to '$target' the same way,
+obviously the final outcome is what is in 'HEAD'.  What the
+above example shows is that file 'hello.c' was changed from
+'$orig' to 'HEAD' and '$orig' to '$target' in a different way.
 You could resolve this by running your favorite 3-way merge
-program, e.g.  `diff3`, `merge`, or git's own merge-file, on
+program, e.g.  'diff3', 'merge', or git's own `merge-file`, on
 the blob objects from these three stages yourself, like this:
 
 ------------------------------------------------
@@ -4017,7 +4017,7 @@ $ git cat-file blob cc44c73... >hello.c~3
 $ git merge-file hello.c~2 hello.c~1 hello.c~3
 ------------------------------------------------
 
-This would leave the merge result in `hello.c~2` file, along
+This would leave the merge result in 'hello.c~2' file, along
 with conflict markers if there are conflicts.  After verifying
 the merge result makes sense, you can tell git what the final
 merge result for this file is by:
@@ -4027,14 +4027,14 @@ $ mv -f hello.c~2 hello.c
 $ git update-index hello.c
 -------------------------------------------------
 
-When a path is in the "unmerged" state, running `git update-index` for
+When a path is in the 'unmerged' state, running `git update-index` for
 that path tells git to mark the path resolved.
 
 The above is the description of a git merge at the lowest level,
 to help you understand what conceptually happens under the hood.
 In practice, nobody, not even git itself, runs `git cat-file` three times
 for this.  There is a `git merge-index` program that extracts the
-stages to temporary files and calls a "merge" script on it:
+stages to temporary files and calls a 'merge' script on it:
 
 -------------------------------------------------
 $ git merge-index git-merge-one-file hello.c
@@ -4053,27 +4053,27 @@ probably only git developers need to understand.
 Object storage format
 ---------------------
 
-All objects have a statically determined "type" which identifies the
+All objects have a statically determined '"type"' which identifies the
 format of the object (i.e. how it is used, and how it can refer to other
-objects).  There are currently four different object types: "blob",
-"tree", "commit", and "tag".
+objects).  There are currently four different object types: 'blob',
+'tree', 'commit', and 'tag'.
 
 Regardless of object type, all objects share the following
 characteristics: they are all deflated with zlib, and have a header
 that not only specifies their type, but also provides size information
-about the data in the object.  It's worth noting that the SHA-1 hash
+about the data in the object.  It's worth noting that the `SHA-1` hash
 that is used to name the object is the hash of the original data
-plus this header, so `sha1sum` 'file' does not match the object name
+plus this header, so 'sha1sum file' does not match the object name
 for 'file'.
 (Historical note: in the dawn of the age of git the hash
-was the SHA-1 of the 'compressed' object.)
+was the `SHA-1` of the 'compressed' object.)
 
 As a result, the general consistency of an object can always be tested
 independently of the contents or the type of the object: all objects can
 be validated by verifying that (a) their hashes match the content of the
 file and (b) the object successfully inflates to a stream of bytes that
-forms a sequence of <ascii type without space> {plus} <space> {plus} <ascii decimal
-size> {plus} <byte\0> {plus} <binary object data>.
+forms a sequence of '"<ascii type without space> {plus} <space> {plus} <ascii decimal
+size> {plus} <byte\0> {plus} <binary object data>"'.
 
 The structured objects can further have their structure and
 connectivity to other objects verified. This is generally done with
@@ -4099,39 +4099,39 @@ The initial revision lays the foundation for almost everything git has
 today, but is small enough to read in one sitting.
 
 Note that terminology has changed since that revision.  For example, the
-README in that revision uses the word "changeset" to describe what we
+'README' in that revision uses the word '`changeset'' to describe what we
 now call a <<def_commit_object,commit>>.
 
-Also, we do not call it "cache" any more, but rather "index"; however, the
-file is still called `cache.h`.  Remark: Not much reason to change it now,
+Also, we do not call it 'cache' any more, but rather 'index'; however, the
+file is still called 'cache.h'.  Remark: Not much reason to change it now,
 especially since there is no good single name for it anyway, because it is
-basically _the_ header file which is included by _all_ of Git's C sources.
+basically *the* header file which is included by *all* of Git's C sources.
 
 If you grasp the ideas in that initial commit, you should check out a
-more recent version and skim `cache.h`, `object.h` and `commit.h`.
+more recent version and skim 'cache.h', 'object.h' and 'commit.h'.
 
 In the early days, Git (in the tradition of UNIX) was a bunch of programs
 which were extremely simple, and which you used in scripts, piping the
 output of one into another. This turned out to be good for initial
 development, since it was easier to test new things.  However, recently
 many of these parts have become builtins, and some of the core has been
-"libified", i.e. put into libgit.a for performance, portability reasons,
+``libified'', i.e. put into 'libgit.a' for performance, portability reasons,
 and to avoid code duplication.
 
 By now, you know what the index is (and find the corresponding data
-structures in `cache.h`), and that there are just a couple of object types
+structures in 'cache.h'), and that there are just a couple of object types
 (blobs, trees, commits and tags) which inherit their common structure from
-`struct object`, which is their first member (and thus, you can cast e.g.
-`(struct object *)commit` to achieve the _same_ as `&commit->object`, i.e.
+'"struct object"', which is their first member (and thus, you can cast e.g.
+'"(struct object *)commit"' to achieve the _same_ as '"&commit->object"', i.e.
 get at the object name and flags).
 
 Now is a good point to take a break to let this information sink in.
 
 Next step: get familiar with the object naming.  Read <<naming-commits>>.
 There are quite a few ways to name an object (and not only revisions!).
-All of these are handled in `sha1_name.c`. Just have a quick look at
-the function `get_sha1()`. A lot of the special handling is done by
-functions like `get_sha1_basic()` or the likes.
+All of these are handled in 'sha1_name.c'. Just have a quick look at
+the function 'get_sha1()'. A lot of the special handling is done by
+functions like 'get_sha1_basic()' or the likes.
 
 This is just to get you into the groove for the most libified part of Git:
 the revision walker.
@@ -4146,7 +4146,7 @@ $ git-rev-list --pretty $(git-rev-parse --default HEAD "$@") | \
 What does this mean?
 
 `git rev-list` is the original version of the revision walker, which
-_always_ printed a list of revisions to stdout.  It is still functional,
+*always* printed a list of revisions to stdout.  It is still functional,
 and needs to, since most new Git commands start out as scripts using
 `git rev-list`.
 
@@ -4154,38 +4154,38 @@ and needs to, since most new Git commands start out as scripts using
 options that were relevant for the different plumbing commands that were
 called by the script.
 
-Most of what `git rev-list` did is contained in `revision.c` and
-`revision.h`.  It wraps the options in a struct named `rev_info`, which
+Most of what `git rev-list` did is contained in 'revision.c' and
+'revision.h'.  It wraps the options in a struct named 'rev_info', which
 controls how and what revisions are walked, and more.
 
 The original job of `git rev-parse` is now taken by the function
-`setup_revisions()`, which parses the revisions and the common command line
+'setup_revisions()', which parses the revisions and the common command line
 options for the revision walker. This information is stored in the struct
-`rev_info` for later consumption. You can do your own command line option
-parsing after calling `setup_revisions()`. After that, you have to call
-`prepare_revision_walk()` for initialization, and then you can get the
-commits one by one with the function `get_revision()`.
+'rev_info' for later consumption. You can do your own command line option
+parsing after calling 'setup_revisions()'. After that, you have to call
+'prepare_revision_walk()' for initialization, and then you can get the
+commits one by one with the function 'get_revision()'.
 
 If you are interested in more details of the revision walking process,
-just have a look at the first implementation of `cmd_log()`; call
-`git show v1.3.0{tilde}155^2{tilde}4` and scroll down to that function (note that you
-no longer need to call `setup_pager()` directly).
+just have a look at the first implementation of 'cmd_log()'; call
+'"git show v1.3.0{tilde}155^2{tilde}4"' and scroll down to that function (note that you
+no longer need to call 'setup_pager()' directly).
 
-Nowadays, `git log` is a builtin, which means that it is _contained_ in the
+Nowadays, `git log` is a builtin, which means that it is *contained* in the
 command `git`.  The source side of a builtin is
 
-- a function called `cmd_<bla>`, typically defined in `builtin-<bla>.c`,
-  and declared in `builtin.h`,
+- a function called 'cmd_<bla>', typically defined in 'builtin-<bla>.c',
+  and declared in 'builtin.h',
 
-- an entry in the `commands[]` array in `git.c`, and
+- an entry in the 'commands[]' array in 'git.c', and
 
-- an entry in `BUILTIN_OBJECTS` in the `Makefile`.
+- an entry in 'BUILTIN_OBJECTS' in the 'Makefile'.
 
 Sometimes, more than one builtin is contained in one source file.  For
-example, `cmd_whatchanged()` and `cmd_log()` both reside in `builtin-log.c`,
+example, 'cmd_whatchanged()' and 'cmd_log()' both reside in 'builtin-log.c',
 since they share quite a bit of code.  In that case, the commands which are
-_not_ named like the `.c` file in which they live have to be listed in
-`BUILT_INS` in the `Makefile`.
+_not_ named like the '.c' file in which they live have to be listed in
+'BUILT_INS' in the 'Makefile'.
 
 `git log` looks more complicated in C than it does in the original script,
 but that allows for a much greater flexibility and performance.
@@ -4205,10 +4205,10 @@ For the sake of clarity, let's stay with `git cat-file`, because it
 - is plumbing, and
 
 - was around even in the initial commit (it literally went only through
-  some 20 revisions as `cat-file.c`, was renamed to `builtin-cat-file.c`
+  some 20 revisions as 'cat-file.c', was renamed to 'builtin-cat-file.c'
   when made a builtin, and then saw less than 10 versions).
 
-So, look into `builtin-cat-file.c`, search for `cmd_cat_file()` and look what
+So, look into 'builtin-cat-file.c', search for 'cmd_cat_file()' and look what
 it does.
 
 ------------------------------------------------------------------
@@ -4220,22 +4220,22 @@ it does.
 ------------------------------------------------------------------
 
 Let's skip over the obvious details; the only really interesting part
-here is the call to `get_sha1()`.  It tries to interpret `argv[2]` as an
+here is the call to 'get_sha1()'.  It tries to interpret 'argv[2]' as an
 object name, and if it refers to an object which is present in the current
-repository, it writes the resulting SHA-1 into the variable `sha1`.
+repository, it writes the resulting `SHA-1` into the variable 'sha1'.
 
 Two things are interesting here:
 
-- `get_sha1()` returns 0 on _success_.  This might surprise some new
+- 'get_sha1()' returns 0 on _success_.  This might surprise some new
   Git hackers, but there is a long tradition in UNIX to return different
   negative numbers in case of different errors--and 0 on success.
 
-- the variable `sha1` in the function signature of `get_sha1()` is `unsigned
-  char \*`, but is actually expected to be a pointer to `unsigned
-  char[20]`.  This variable will contain the 160-bit SHA-1 of the given
-  commit.  Note that whenever a SHA-1 is passed as `unsigned char \*`, it
+- the variable 'sha1' in the function signature of 'get_sha1()' is '"unsigned
+  char \*"', but is actually expected to be a pointer to '"unsigned
+  char[20]"'.  This variable will contain the 160-bit `SHA-1` of the given
+  commit.  Note that whenever a `SHA-1` is passed as '"unsigned char \*"', it
   is the binary representation, as opposed to the ASCII representation in
-  hex characters, which is passed as `char *`.
+  hex characters, which is passed as '"char *"'.
 
 You will see both of these things throughout the code.
 
@@ -4247,12 +4247,12 @@ Now, for the meat:
 -----------------------------------------------------------------------------
 
 This is how you read a blob (actually, not only a blob, but any type of
-object).  To know how the function `read_object_with_reference()` actually
-works, find the source code for it (something like `git grep
-read_object_with | grep ":[a-z]"` in the git repository), and read
+object).  To know how the function 'read_object_with_reference()' actually
+works, find the source code for it (something like 'git grep
+read_object_with | grep ":[a-z]"' in the git repository), and read
 the source.
 
-To find out how the result can be used, just read on in `cmd_cat_file()`:
+To find out how the result can be used, just read on in 'cmd_cat_file()':
 
 -----------------------------------
         write_or_die(1, buf, size);
@@ -4263,15 +4263,15 @@ it helps to search through the output of `git log`, and then `git show` the
 corresponding commit.
 
 Example: If you know that there was some test case for `git bundle`, but
-do not remember where it was (yes, you _could_ `git grep bundle t/`, but that
+do not remember where it was (yes, you _could_ '"git grep bundle t/"', but that
 does not illustrate the point!):
 
 ------------------------
 $ git log --no-merges t/
 ------------------------
 
-In the pager (`less`), just search for "bundle", go a few lines back,
-and see that it is in commit 18449ab0...  Now just copy this object name,
+In the pager ('less'), just search for '"bundle"', go a few lines back,
+and see that it is in commit '18449ab0...'  Now just copy this object name,
 and paste it into the command line
 
 -------------------
@@ -4336,7 +4336,7 @@ $ git branch new     # create branch "new" starting at current HEAD
 $ git branch -d new  # delete branch "new"
 -----------------------------------------------
 
-Instead of basing a new branch on current HEAD (the default), use:
+Instead of basing a new branch on current `HEAD` (the default), use:
 
 -----------------------------------------------
 $ git branch new test    # branch named "test"
@@ -4501,7 +4501,7 @@ branch with your commits:
 $ git push ssh://example.com/project.git mybranch:theirbranch
 -----------------------------------------------
 
-When remote and local branch are both named "test":
+When remote and local branch are both named '"test"':
 
 -----------------------------------------------
 $ git push ssh://example.com/project.git test
@@ -4545,14 +4545,14 @@ The basic requirements:
   should be specifically mentioned as they arise.
 - Whenever possible, section headings should clearly describe the task
   they explain how to do, in language that requires no more knowledge
-  than necessary: for example, "importing patches into a project" rather
-  than "the `git am` command"
+  than necessary: for example, ``importing patches into a project'' rather
+  than ``the `git am` command''
 
 Think about how to create a clear chapter dependency graph that will
 allow people to get to important topics without necessarily reading
 everything in between.
 
-Scan Documentation/ for other stuff left out; in particular:
+Scan 'Documentation/' for other stuff left out; in particular:
 
 - howto's
 - some of technical/?
-- 
1.6.6.1
