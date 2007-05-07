From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 2/6] user-manual: add section ID's
Date: Mon,  7 May 2007 01:13:58 -0400
Message-ID: <6238.32334899834$1178514859@news.gmane.org>
References: <11785148422793-git-send-email->
 <11785148433801-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 07 07:14:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkvY6-0008TI-Ou
	for gcvg-git@gmane.org; Mon, 07 May 2007 07:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbXEGFOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 01:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbXEGFOJ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 01:14:09 -0400
Received: from mail.fieldses.org ([66.93.2.214]:53661 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981AbXEGFOH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 01:14:07 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HkvXw-0005Zh-5C; Mon, 07 May 2007 01:14:04 -0400
X-Mailer: git-send-email 1.5.1.1.98.gedb4f
In-Reply-To: <11785148433801-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46411>

From: J. Bruce Fields <bfields@citi.umich.edu>

Any section lacking an id gets an annoying warning when you build
the manual.  More seriously, the table of contents then generates
volatile id's which change with every build, with the effect that
we get URL's that change all the time.

The ID's are manually generated and sometimes inconsistent, but
that's OK.

XXX: what to do about the preface?

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   84 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 54fd413..d353d08 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -23,12 +23,14 @@ pages.  For a command such as "git clone", just use
 $ man git-clone
 ------------------------------------------------
 
+[[git-quick-start]]
 Git Quick Start
 ===============
 
 This is a quick summary of the major commands; the following chapters
 will explain how these work in more detail.
 
+[[quick-creating-a-new-repository]]
 Creating a new repository
 -------------------------
 
@@ -50,6 +52,7 @@ $ git clone git://example.com/pub/project.git
 $ cd project
 -----------------------------------------------
 
+[[managing-branches]]
 Managing branches
 -----------------
 
@@ -112,6 +115,7 @@ $ git branch -r			# list all remote branches
 -----------------------------------------------
 
 
+[[exploring-history]]
 Exploring history
 -----------------
 
@@ -147,6 +151,7 @@ $ git bisect bad		# if this revision is bad.
 				# repeat until done.
 -----------------------------------------------
 
+[[making-changes]]
 Making changes
 --------------
 
@@ -177,6 +182,7 @@ $ git commit d.txt # use latest content only of d.txt
 $ git commit -a	   # use latest content of all tracked files
 -----------------------------------------------
 
+[[merging]]
 Merging
 -------
 
@@ -187,6 +193,7 @@ $ git pull git://example.com/project.git master
 $ git pull . test  # equivalent to git merge test
 -----------------------------------------------
 
+[[sharing-your-changes]]
 Sharing your changes
 --------------------
 
@@ -232,6 +239,7 @@ $ git remote add example ssh://example.com/project.git
 $ git push example test
 -----------------------------------------------
 
+[[repository-maintenance]]
 Repository maintenance
 ----------------------
 
@@ -247,9 +255,11 @@ Recompress, remove unused cruft:
 $ git gc
 -----------------------------------------------
 
+[[repositories-and-branches]]
 Repositories and Branches
 =========================
 
+[[how-to-get-a-git-repository]]
 How to get a git repository
 ---------------------------
 
@@ -280,6 +290,7 @@ contains all the information about the history of the project.
 In most of the following, examples will be taken from one of the two
 repositories above.
 
+[[how-to-check-out]]
 How to check out a different version of a project
 -------------------------------------------------
 
@@ -352,6 +363,7 @@ particular point in history, then resetting that branch may leave you
 with no way to find the history it used to point to; so use this command
 carefully.
 
+[[understanding-commits]]
 Understanding History: Commits
 ------------------------------
 
@@ -407,6 +419,7 @@ In fact, in <<git-internals>> we shall see that everything stored in git
 history, including file data and directory contents, is stored in an object
 with a name that is a hash of its contents.
 
+[[understanding-reachability]]
 Understanding history: commits, parents, and reachability
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -431,6 +444,7 @@ if commit X is an ancestor of commit Y.  Equivalently, you could say
 that Y is a descendent of X, or that there is a chain of parents
 leading from commit Y to commit X.
 
+[[history-diagrams]]
 Understanding history: History diagrams
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -450,6 +464,7 @@ lines drawn with - / and \.  Time goes left to right:
 If we need to talk about a particular commit, the character "o" may
 be replaced with another letter or number.
 
+[[what-is-a-branch]]
 Understanding history: What is a branch?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -463,6 +478,7 @@ the line of three commits leading up to that point as all being part of
 However, when no confusion will result, we often just use the term
 "branch" both for branches and for branch heads.
 
+[[manipulating-branches]]
 Manipulating branches
 ---------------------
 
@@ -538,6 +554,7 @@ This is an easy way to check out a particular version without having to
 make up a name for the new branch.   You can still create a new branch
 (or tag) for this version later if you decide to.
 
+[[examining-remote-branches]]
 Examining branches from a remote repository
 -------------------------------------------
 
@@ -611,6 +628,7 @@ remote-tracking branches to the latest version found in her
 repository.  It will not touch any of your own branches--not even the
 "master" branch that was created for you on clone.
 
+[[fetching-branches]]
 Fetching branches from other repositories
 -----------------------------------------
 
@@ -653,6 +671,7 @@ or delete these configuration options by editing .git/config with a
 text editor.  (See the "CONFIGURATION FILE" section of
 gitlink:git-config[1] for details.)
 
+[[exploring-git-history]]
 Exploring git history
 =====================
 
@@ -667,6 +686,7 @@ history of a project.
 We start with one specialized tool that is useful for finding the
 commit that introduced a bug into a project.
 
+[[using-bisect]]
 How to use bisect to find a regression
 --------------------------------------
 
@@ -734,6 +754,7 @@ $ git reset --hard fb47ddb2db...
 then test, run "bisect good" or "bisect bad" as appropriate, and
 continue.
 
+[[naming-commits]]
 Naming commits
 --------------
 
@@ -798,6 +819,7 @@ $ git rev-parse origin
 e05db0fd4f31dde7005f075a84f96b360d05984b
 -------------------------------------------------
 
+[[creating-tags]]
 Creating tags
 -------------
 
@@ -815,6 +837,7 @@ share with others, and possibly sign cryptographically, then you
 should create a tag object instead; see the gitlink:git-tag[1] man
 page for details.
 
+[[browsing-revisions]]
 Browsing revisions
 ------------------
 
@@ -856,6 +879,7 @@ backwards through the parents; however, since git history can contain
 multiple independent lines of development, the particular order that
 commits are listed in may be somewhat arbitrary.
 
+[[generating-diffs]]
 Generating diffs
 ----------------
 
@@ -877,6 +901,7 @@ but not from master.  Note that if master also has commits which are
 not reachable from test, then the combined result of these patches
 will not be the same as the diff produced by the git-diff example.
 
+[[viewing-old-file-versions]]
 Viewing old file versions
 -------------------------
 
@@ -892,9 +917,11 @@ $ git show v2.5:fs/locks.c
 Before the colon may be anything that names a commit, and after it
 may be any path to a file tracked by git.
 
+[[history-examples]]
 Examples
 --------
 
+[[checking-for-equal-branches]]
 Check whether two branches point at the same history
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -927,6 +954,7 @@ $ git log origin...master
 
 will return no commits when the two branches are equal.
 
+[[finding-tagged-descendants]]
 Find first tagged version including a given fix
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -1012,9 +1040,11 @@ Which shows that e05db0fd is reachable from itself, from v1.5.0-rc1, and
 from v1.5.0-rc2, but not from v1.5.0-rc0.
 
 
+[[Developing-with-git]]
 Developing with git
 ===================
 
+[[telling-git-your-name]]
 Telling git your name
 ---------------------
 
@@ -1033,6 +1063,7 @@ EOF
 details on the configuration file.)
 
 
+[[creating-a-new-repository]]
 Creating a new repository
 -------------------------
 
@@ -1149,6 +1180,7 @@ $ git diff	    # difference between the index file and your
 $ git status	    # a brief per-file summary of the above.
 -------------------------------------------------
 
+[[creating-good-commit-messages]]
 Creating good commit messages
 -----------------------------
 
@@ -1159,6 +1191,7 @@ description.  Tools that turn commits into email, for example, use
 the first line on the Subject line and the rest of the commit in the
 body.
 
+[[how-to-merge]]
 How to merge
 ------------
 
@@ -1236,6 +1269,7 @@ your own if desired.
 The above is all you need to know to resolve a simple merge.  But git
 also provides more information to help resolve conflicts:
 
+[[conflict-resolution]]
 Getting conflict-resolution help during a merge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -1359,6 +1393,7 @@ throw away a commit you have already committed if that commit may
 itself have been merged into another branch, as doing so may confuse
 further merges.
 
+[[fast-forwards]]
 Fast-forward merges
 -------------------
 
@@ -1374,6 +1409,7 @@ already contained in the other--then git just performs a
 moved forward to point at the head of the merged-in branch, without
 any new commits being created.
 
+[[fixing-mistakes]]
 Fixing mistakes
 ---------------
 
@@ -1398,6 +1434,7 @@ fundamentally different ways to fix the problem:
 	change, and cannot correctly perform repeated merges from
 	a branch that has had its history changed.
 
+[[reverting-a-commit]]
 Fixing a mistake with a new commit
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -1452,6 +1489,7 @@ It is also possible to edit commits further back in the history, but
 this is an advanced topic to be left for
 <<cleaning-up-history,another chapter>>.
 
+[[checkout-of-path]]
 Checking out an old version of a file
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -1478,6 +1516,7 @@ $ git show HEAD^:path/to/file
 
 which will display the given version of the file.
 
+[[ensuring-good-performance]]
 Ensuring good performance
 -------------------------
 
@@ -1494,9 +1533,12 @@ $ git gc
 to recompress the archive.  This can be very time-consuming, so
 you may prefer to run git-gc when you are not doing other work.
 
+
+[[ensuring-reliability]]
 Ensuring reliability
 --------------------
 
+[[checking-for-corruption]]
 Checking the repository for corruption
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -1532,9 +1574,11 @@ other git operations are in progress in the same repository.
 For more about dangling objects, see <<dangling-objects>>.
 
 
+[[recovering-lost-changes]]
 Recovering lost changes
 ~~~~~~~~~~~~~~~~~~~~~~~
 
+[[reflogs]]
 Reflogs
 ^^^^^^^
 
@@ -1582,6 +1626,7 @@ While normal history is shared by every repository that works on the
 same project, the reflog history is not shared: it tells you only about
 how the branches in your local repository have changed over time.
 
+[[dangling-objects]]
 Examining dangling objects
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -1623,6 +1668,7 @@ $ git branch recovered-branch 7281251ddd
 ------------------------------------------------
 
 
+[[sharing-development]]
 Sharing development with others
 ===============================
 
@@ -1682,6 +1728,7 @@ $ git merge branch
 
 are roughly equivalent.  The former is actually very commonly used.
 
+[[submitting-patches]]
 Submitting patches to a project
 -------------------------------
 
@@ -1703,6 +1750,7 @@ use the gitlink:git-send-email[1] script to automate the process.
 Consult the mailing list for your project first to determine how they
 prefer such patches be handled.
 
+[[importing-patches]]
 Importing patches to a project
 ------------------------------
 
@@ -1898,6 +1946,7 @@ See the explanations of the remote.<name>.url, branch.<name>.remote,
 and remote.<name>.push options in gitlink:git-config[1] for
 details.
 
+[[setting-up-a-shared-repository]]
 Setting up a shared repository
 ------------------------------
 
@@ -1907,6 +1956,7 @@ all push to and pull from a single shared repository.  See
 link:cvs-migration.txt[git for CVS users] for instructions on how to
 set this up.
 
+[[setting-up-gitweb]]
 Allow web browsing of a repository
 ----------------------------------
 
@@ -1914,6 +1964,7 @@ The gitweb cgi script provides users an easy way to browse your
 project's files and history without having to install git; see the file
 gitweb/INSTALL in the git source tree for instructions on setting it up.
 
+[[sharing-development-examples]]
 Examples
 --------
 
@@ -1931,6 +1982,7 @@ cause git's merge machinery (for example) to do the wrong thing.
 However, there is a situation in which it can be useful to violate this
 assumption.
 
+[[patch-series]]
 Creating the perfect patch series
 ---------------------------------
 
@@ -1963,6 +2015,7 @@ We will introduce some tools that can help you do this, explain how to
 use them, and then explain some of the problems that can arise because
 you are rewriting history.
 
+[[using-git-rebase]]
 Keeping a patch series up to date using git-rebase
 --------------------------------------------------
 
@@ -2044,6 +2097,7 @@ return mywork to the state it had before you started the rebase:
 $ git rebase --abort
 -------------------------------------------------
 
+[[modifying-one-commit]]
 Modifying a single commit
 -------------------------
 
@@ -2089,6 +2143,7 @@ Note that the immutable nature of git history means that you haven't really
 "modified" existing commits; instead, you have replaced the old commits with
 new commits having new object names.
 
+[[reordering-patch-series]]
 Reordering or selecting from a patch series
 -------------------------------------------
 
@@ -2118,6 +2173,7 @@ $ git reset --hard origin
 Then modify, reorder, or eliminate patches as preferred before applying
 them again with gitlink:git-am[1].
 
+[[patch-series-tools]]
 Other tools
 -----------
 
@@ -2125,6 +2181,7 @@ There are numerous other tools, such as stgit, which exist for the
 purpose of maintaining a patch series.  These are outside of the scope of
 this manual.
 
+[[problems-with-rewriting-history]]
 Problems with rewriting history
 -------------------------------
 
@@ -2173,9 +2230,11 @@ branches into their own work.
 For true distributed development that supports proper merging,
 published branches should never be rewritten.
 
+[[advanced-branch-management]]
 Advanced branch management
 ==========================
 
+[[fetching-individual-branches]]
 Fetching individual branches
 ----------------------------
 
@@ -2204,7 +2263,7 @@ already have a branch named example-master, it will attempt to
 "fast-forward" to the commit given by example.com's master branch.  So
 next we explain what a fast-forward is:
 
-[[fast-forwards]]
+[[fast-forwards-2]]
 Understanding git history: fast-forwards
 ----------------------------------------
 
@@ -2242,6 +2301,7 @@ situation above this may mean losing the commits labeled "a" and "b",
 unless you've already created a reference of your own pointing to
 them.
 
+[[forcing-fetch]]
 Forcing git fetch to do non-fast-forward updates
 ------------------------------------------------
 
@@ -2256,6 +2316,7 @@ Note the addition of the "+" sign.  Be aware that commits that the
 old version of example/master pointed at may be lost, as we saw in
 the previous section.
 
+[[remote-branch-configuration]]
 Configuring remote branches
 ---------------------------
 
@@ -2329,6 +2390,7 @@ Git internals
 Git depends on two fundamental abstractions: the "object database", and
 the "current directory cache" aka "index".
 
+[[the-object-database]]
 The Object Database
 -------------------
 
@@ -2398,6 +2460,7 @@ to just verifying their superficial consistency through the hash).
 
 The object types in some more detail:
 
+[[blob-object]]
 Blob Object
 -----------
 
@@ -2419,6 +2482,7 @@ file is associated with in any way.
 A blob is typically created when gitlink:git-update-index[1]
 is run, and its data can be accessed by gitlink:git-cat-file[1].
 
+[[tree-object]]
 Tree Object
 -----------
 
@@ -2460,6 +2524,7 @@ A tree is created with gitlink:git-write-tree[1] and
 its data can be accessed by gitlink:git-ls-tree[1].
 Two trees can be compared with gitlink:git-diff-tree[1].
 
+[[commit-object]]
 Commit Object
 -------------
 
@@ -2486,6 +2551,7 @@ file manager.
 A commit is created with gitlink:git-commit-tree[1] and
 its data can be accessed by gitlink:git-cat-file[1].
 
+[[trust]]
 Trust
 -----
 
@@ -2515,6 +2581,7 @@ like GPG/PGP.
 
 To assist in this, git also provides the tag object...
 
+[[tag-object]]
 Tag Object
 ----------
 
@@ -2537,6 +2604,7 @@ and the signature can be verified by
 gitlink:git-verify-tag[1].
 
 
+[[the-index]]
 The "index" aka "Current Directory Cache"
 -----------------------------------------
 
@@ -2591,6 +2659,7 @@ been written back to the backing store.
 
 
 
+[[the-workflow]]
 The Workflow
 ------------
 
@@ -2600,6 +2669,7 @@ index), but most operations move data to and from the index file. Either
 from the database or from the working directory. Thus there are four
 main combinations: 
 
+[[working-directory-to-index]]
 working directory -> index
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -2633,6 +2703,7 @@ stat information. It will 'not' update the object status itself, and
 it will only update the fields that are used to quickly test whether
 an object still matches its old backing store object.
 
+[[index-to-object-database]]
 index -> object database
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -2648,6 +2719,7 @@ and it will return the name of the resulting top-level tree. You can
 use that tree to re-generate the index at any time by going in the
 other direction:
 
+[[object-database-to-index]]
 object database -> index
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -2664,6 +2736,7 @@ and your index file will now be equivalent to the tree that you saved
 earlier. However, that is only your 'index' file: your working
 directory contents have not been modified.
 
+[[index-to-working-directory]]
 index -> working directory
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -2693,6 +2766,7 @@ need to use the "-f" flag ('before' the "-a" flag or the filename) to
 Finally, there are a few odds and ends which are not purely moving
 from one representation to the other:
 
+[[tying-it-all-together]]
 Tying it all together
 ~~~~~~~~~~~~~~~~~~~~~
 
@@ -2768,6 +2842,7 @@ various pieces fit together.
 ------------
 
 
+[[examining-the-data]]
 Examining the data
 ------------------
 
@@ -2803,6 +2878,7 @@ $ git-cat-file commit HEAD
 
 to see what the top commit was.
 
+[[merging-multiple-trees]]
 Merging multiple trees
 ----------------------
 
@@ -2854,6 +2930,7 @@ index file, and you can just write the result out with
 `git-write-tree`.
 
 
+[[merging-multiple-trees-2]]
 Merging multiple trees, continued
 ---------------------------------
 
@@ -2924,6 +3001,7 @@ $ git-merge-index git-merge-one-file hello.c
 
 and that is what higher level `git merge -s resolve` is implemented with.
 
+[[pack-files]]
 How git stores objects efficiently: pack files
 ----------------------------------------------
 
@@ -2984,7 +3062,7 @@ objects will work exactly as they did before.
 The gitlink:git-gc[1] command performs packing, pruning, and more for
 you, so is normally the only high-level command you need.
 
-[[dangling-objects]]
+[[dangling-objects-2]]
 Dangling objects
 ----------------
 
@@ -3065,8 +3143,10 @@ confusing and scary messages, but it won't actually do anything bad. In
 contrast, running "git prune" while somebody is actively changing the 
 repository is a *BAD* idea).
 
+[[glossary]]
 include::glossary.txt[]
 
+[[todo]]
 Notes and todo list for this manual
 ===================================
 
-- 
1.5.1.1.98.gedb4f
