From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v3 4/6] Change 'git' to 'Git' whenever the whole system is
 referred to #3
Date: Mon, 21 Jan 2013 20:21:38 +0100 (CET)
Message-ID: <1667947659.632844.1358796098848.JavaMail.ngmail@webmail20.arcor-online.net>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net> <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net> <7vvcark1f2.fsf@alter.siamese.dyndns.org> <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: davvid@gmail.com, git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Mon Jan 21 20:22:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMwa-0006HS-UA
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071Ab3AUTVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 14:21:46 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:41745 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755704Ab3AUTVo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 14:21:44 -0500
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net [151.189.8.34])
	by mx.arcor.de (Postfix) with ESMTP id 4CC343058F;
	Mon, 21 Jan 2013 20:21:39 +0100 (CET)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id F0A8D10C007;
	Mon, 21 Jan 2013 20:21:38 +0100 (CET)
Received: from webmail20.arcor-online.net (webmail20.arcor-online.net [151.189.8.201])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id D26E2212423;
	Mon, 21 Jan 2013 20:21:38 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-13.arcor-online.net D26E2212423
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1358796098; bh=8ILtOas4K0g3F/sHdrg4ASUyMi8C3sjvtHSnNOmyCw4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=boBuZ+AvlO/OXKqWFpEfmyQ9UITlyQuajTy/ZRoKHKp9P3ZY7GQ8TN+YaMJaOhvxq
	 /3WC9rGFxQ3jJPCDoEsphhWoNXS0TMZ5Ha48RtJy5K5/wlwU2a3FntD4Jeya0ZJMOP
	 Ys6aK1djXM9dHgThM1Rk398ZQLymDv4J66TKApek=
Received: from [188.105.98.86] by webmail20.arcor-online.net (151.189.8.201) with HTTP (Arcor Webmail); Mon, 21 Jan 2013 20:21:38 +0100 (CET)
In-Reply-To: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.98.86
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214149>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 6a701dd..5d957c2 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -3,7 +3,7 @@ gitcore-tutorial(7)
 
 NAME
 ----
-gitcore-tutorial - A git core tutorial for developers
+gitcore-tutorial - A Git core tutorial for developers
 
 SYNOPSIS
 --------
@@ -12,17 +12,17 @@ git *
 DESCRIPTION
 -----------
 
-This tutorial explains how to use the "core" git commands to set up and
-work with a git repository.
+This tutorial explains how to use the "core" Git commands to set up and
+work with a Git repository.
 
-If you just need to use git as a revision control system you may prefer
+If you just need to use Git as a revision control system you may prefer
 to start with "A Tutorial Introduction to Git" (linkgit:gittutorial[7]) or
 link:user-manual.html[the Git User Manual].
 
 However, an understanding of these low-level tools can be helpful if
-you want to understand git's internals.
+you want to understand Git's internals.
 
-The core git is often called "plumbing", with the prettier user
+The core Git is often called "plumbing", with the prettier user
 interfaces on top of it called "porcelain". You may not want to use the
 plumbing directly very often, but it can be good to know what the
 plumbing does for when the porcelain isn't flushing.
@@ -40,19 +40,19 @@ Deeper technical details are often marked as Notes, which you can
 skip on your first reading.
 
 
-Creating a git repository
+Creating a Git repository
 -------------------------
 
-Creating a new git repository couldn't be easier: all git repositories start
+Creating a new Git repository couldn't be easier: all Git repositories start
 out empty, and the only thing you need to do is find yourself a
 subdirectory that you want to use as a working tree - either an empty
 one for a totally new project, or an existing working tree that you want
-to import into git.
+to import into Git.
 
 For our first example, we're going to start a totally new repository from
 scratch, with no pre-existing files, and we'll call it 'git-tutorial'.
 To start up, create a subdirectory for it, change into that
-subdirectory, and initialize the git infrastructure with 'git init':
+subdirectory, and initialize the Git infrastructure with 'git init':
 
 ------------------------------------------------
 $ mkdir git-tutorial
@@ -60,13 +60,13 @@ $ cd git-tutorial
 $ git init
 ------------------------------------------------
 
-to which git will reply
+to which Git will reply
 
 ----------------
 Initialized empty Git repository in .git/
 ----------------
 
-which is just git's way of saying that you haven't been doing anything
+which is just Git's way of saying that you haven't been doing anything
 strange, and that it will have created a local `.git` directory setup for
 your new project. You will now have a `.git` directory, and you can
 inspect that with 'ls'. For your new empty project, it should show you
@@ -102,7 +102,7 @@ start out expecting to work on the `master` branch.
 
 However, this is only a convention, and you can name your branches
 anything you want, and don't have to ever even 'have' a `master`
-branch. A number of the git tools will assume that `.git/HEAD` is
+branch. A number of the Git tools will assume that `.git/HEAD` is
 valid, though.
 
 [NOTE]
@@ -119,18 +119,18 @@ populating your tree.
 An advanced user may want to take a look at linkgit:gitrepository-layout[5]
 after finishing this tutorial.
 
-You have now created your first git repository. Of course, since it's
+You have now created your first Git repository. Of course, since it's
 empty, that's not very useful, so let's start populating it with data.
 
 
-Populating a git repository
+Populating a Git repository
 ---------------------------
 
 We'll keep this simple and stupid, so we'll start off with populating a
 few trivial files just to get a feel for it.
 
 Start off with just creating any random files that you want to maintain
-in your git repository. We'll start off with a few bad examples, just to
+in your Git repository. We'll start off with a few bad examples, just to
 get a feel for how this works:
 
 ------------------------------------------------
@@ -146,7 +146,7 @@ but to actually check in your hard work, you will have to go through two steps:
 
  - commit that index file as an object.
 
-The first step is trivial: when you want to tell git about any changes
+The first step is trivial: when you want to tell Git about any changes
 to your working tree, you use the 'git update-index' program. That
 program normally just takes a list of filenames you want to update, but
 to avoid trivial mistakes, it refuses to add new entries to the index
@@ -160,10 +160,10 @@ So to populate the index with the two files you just created, you can do
 $ git update-index --add hello example
 ------------------------------------------------
 
-and you have now told git to track those two files.
+and you have now told Git to track those two files.
 
 In fact, as you did that, if you now look into your object directory,
-you'll notice that git will have added two new objects to the object
+you'll notice that Git will have added two new objects to the object
 database. If you did exactly the steps above, you should now be able to do
 
 
@@ -189,7 +189,7 @@ $ git cat-file -t 557db03de997c86a4a028e1ebd3a1ceb225be238
 ----------------
 
 where the `-t` tells 'git cat-file' to tell you what the "type" of the
-object is. git will tell you that you have a "blob" object (i.e., just a
+object is. Git will tell you that you have a "blob" object (i.e., just a
 regular file), and you can see the contents with
 
 ----------------
@@ -214,28 +214,28 @@ Anyway, as we mentioned previously, you normally never actually take a
 look at the objects themselves, and typing long 40-character hex
 names is not something you'd normally want to do. The above digression
 was just to show that 'git update-index' did something magical, and
-actually saved away the contents of your files into the git object
+actually saved away the contents of your files into the Git object
 database.
 
 Updating the index did something else too: it created a `.git/index`
 file. This is the index that describes your current working tree, and
 something you should be very aware of. Again, you normally never worry
 about the index file itself, but you should be aware of the fact that
-you have not actually really "checked in" your files into git so far,
-you've only *told* git about them.
+you have not actually really "checked in" your files into Git so far,
+you've only *told* Git about them.
 
-However, since git knows about them, you can now start using some of the
-most basic git commands to manipulate the files or look at their status.
+However, since Git knows about them, you can now start using some of the
+most basic Git commands to manipulate the files or look at their status.
 
-In particular, let's not even check in the two files into git yet, we'll
+In particular, let's not even check in the two files into Git yet, we'll
 start off by adding another line to `hello` first:
 
 ------------------------------------------------
 $ echo "It's a new day for git" >>hello
 ------------------------------------------------
 
-and you can now, since you told git about the previous state of `hello`, ask
-git what has changed in the tree compared to your old index, using the
+and you can now, since you told Git about the previous state of `hello`, ask
+Git what has changed in the tree compared to your old index, using the
 'git diff-files' command:
 
 ------------
@@ -282,11 +282,11 @@ index 557db03..263414f 100644
 ------------
 
 
-Committing git state
+Committing Git state
 --------------------
 
-Now, we want to go to the next stage in git, which is to take the files
-that git knows about in the index, and commit them as a real tree. We do
+Now, we want to go to the next stage in Git, which is to take the files
+that Git knows about in the index, and commit them as a real tree. We do
 that in two phases: creating a 'tree' object, and committing that 'tree'
 object as a 'commit' object together with an explanation of what the
 tree was all about, along with information of how we came to that state.
@@ -296,7 +296,7 @@ There are no options or other input: `git write-tree` will take the
 current index state, and write an object that describes that whole
 index. In other words, we're now tying together all the different
 filenames with their contents (and their permissions), and we're
-creating the equivalent of a git "directory" object:
+creating the equivalent of a Git "directory" object:
 
 ------------------------------------------------
 $ git write-tree
@@ -415,9 +415,9 @@ regardless of whether the `--cached` flag is used or not. The `--cached`
 flag really only determines whether the file *contents* to be compared
 come from the working tree or not.
 
-This is not hard to understand, as soon as you realize that git simply
+This is not hard to understand, as soon as you realize that Git simply
 never knows (or cares) about files that it is not told about
-explicitly. git will never go *looking* for files to compare, it
+explicitly. Git will never go *looking* for files to compare, it
 expects you to tell it what the files are, and that's what the index
 is there for.
 ================
@@ -433,7 +433,7 @@ update the index cache:
 $ git update-index hello
 ------------------------------------------------
 
-(note how we didn't need the `--add` flag this time, since git knew
+(note how we didn't need the `--add` flag this time, since Git knew
 about the file already).
 
 Note what happens to the different 'git diff-{asterisk}' versions here.
@@ -464,7 +464,7 @@ this point (you can continue to edit things and update the index), you
 can just leave an empty message. Otherwise `git commit` will commit
 the change for you.
 
-You've now made your first real git commit. And if you're interested in
+You've now made your first real Git commit. And if you're interested in
 looking at what `git commit` really does, feel free to investigate:
 it's a few very simple shell scripts to generate the helpful (?) commit
 message headers, and a few one-liners that actually do the
@@ -535,7 +535,7 @@ all, but just show the actual commit message.
 In fact, together with the 'git rev-list' program (which generates a
 list of revisions), 'git diff-tree' ends up being a veritable fount of
 changes. A trivial (but very useful) script called 'git whatchanged' is
-included with git which does exactly this, and shows a log of recent
+included with Git which does exactly this, and shows a log of recent
 activities.
 
 To see the whole history of our pitiful little git-tutorial project, you
@@ -563,19 +563,19 @@ the log.showroot configuration variable to false. Having this, you
 can still show it for each command just adding the `--root` option,
 which is a flag for 'git diff-tree' accepted by both commands.
 
-With that, you should now be having some inkling of what git does, and
+With that, you should now be having some inkling of what Git does, and
 can explore on your own.
 
 [NOTE]
 Most likely, you are not directly using the core
-git Plumbing commands, but using Porcelain such as 'git add', `git-rm'
+Git Plumbing commands, but using Porcelain such as 'git add', `git-rm'
 and `git-commit'.
 
 
 Tagging a version
 -----------------
 
-In git, there are two kinds of tags, a "light" one, and an "annotated tag".
+In Git, there are two kinds of tags, a "light" one, and an "annotated tag".
 
 A "light" tag is technically nothing more than a branch, except we put
 it in the `.git/refs/tags/` subdirectory instead of calling it a `head`.
@@ -598,7 +598,7 @@ obviously be an empty diff, but if you continue to develop and commit
 stuff, you can use your tag as an "anchor-point" to see what has changed
 since you tagged it.
 
-An "annotated tag" is actually a real git object, and contains not only a
+An "annotated tag" is actually a real Git object, and contains not only a
 pointer to the state you want to tag, but also a small tag name and
 message, along with optionally a PGP signature that says that yes,
 you really did
@@ -623,17 +623,17 @@ name for the state at that point.
 Copying repositories
 --------------------
 
-git repositories are normally totally self-sufficient and relocatable.
+Git repositories are normally totally self-sufficient and relocatable.
 Unlike CVS, for example, there is no separate notion of
-"repository" and "working tree". A git repository normally *is* the
-working tree, with the local git information hidden in the `.git`
+"repository" and "working tree". A Git repository normally *is* the
+working tree, with the local Git information hidden in the `.git`
 subdirectory. There is nothing else. What you see is what you got.
 
 [NOTE]
-You can tell git to split the git internal information from
+You can tell Git to split the Git internal information from
 the directory that it tracks, but we'll ignore that for now: it's not
 how normal projects work, and it's really only meant for special uses.
-So the mental model of "the git information is always tied directly to
+So the mental model of "the Git information is always tied directly to
 the working tree that it describes" may not be technically 100%
 accurate, but it's a good model for all normal use.
 
@@ -649,13 +649,13 @@ $ rm -rf git-tutorial
 and it will be gone. There's no external repository, and there's no
 history outside the project you created.
 
- - if you want to move or duplicate a git repository, you can do so. There
+ - if you want to move or duplicate a Git repository, you can do so. There
    is 'git clone' command, but if all you want to do is just to
    create a copy of your repository (with all the full history that
    went along with it), you can do so with a regular
    `cp -a git-tutorial new-git-tutorial`.
 +
-Note that when you've moved or copied a git repository, your git index
+Note that when you've moved or copied a Git repository, your Git index
 file (which caches various information, notably some of the "stat"
 information for the files involved) will likely need to be refreshed.
 So after you do a `cp -a` to create a new copy, you'll want to do
@@ -667,7 +667,7 @@ $ git update-index --refresh
 in the new repository to make sure that the index file is up-to-date.
 
 Note that the second point is true even across machines. You can
-duplicate a remote git repository with *any* regular copy mechanism, be it
+duplicate a remote Git repository with *any* regular copy mechanism, be it
 'scp', 'rsync' or 'wget'.
 
 When copying a remote repository, you'll want to at a minimum update the
@@ -694,23 +694,23 @@ The above can also be written as simply
 $ git reset
 ----------------
 
-and in fact a lot of the common git command combinations can be scripted
+and in fact a lot of the common Git command combinations can be scripted
 with the `git xyz` interfaces.  You can learn things by just looking
 at what the various git scripts do.  For example, `git reset` used to be
 the above two lines implemented in 'git reset', but some things like
 'git status' and 'git commit' are slightly more complex scripts around
-the basic git commands.
+the basic Git commands.
 
 Many (most?) public remote repositories will not contain any of
 the checked out files or even an index file, and will *only* contain the
-actual core git files. Such a repository usually doesn't even have the
-`.git` subdirectory, but has all the git files directly in the
+actual core Git files. Such a repository usually doesn't even have the
+`.git` subdirectory, but has all the Git files directly in the
 repository.
 
-To create your own local live copy of such a "raw" git repository, you'd
+To create your own local live copy of such a "raw" Git repository, you'd
 first create your own subdirectory for the project, and then copy the
 raw repository contents into the `.git` directory. For example, to
-create your own copy of the git repository, you'd do the following
+create your own copy of the Git repository, you'd do the following
 
 ----------------
 $ mkdir my-git
@@ -725,7 +725,7 @@ $ git read-tree HEAD
 ----------------
 
 to populate the index. However, now you have populated the index, and
-you have all the git internal files, but you will notice that you don't
+you have all the Git internal files, but you will notice that you don't
 actually have any of the working tree files to work on. To get
 those, you'd check them out with
 
@@ -757,7 +757,7 @@ repository, and checked it out.
 Creating a new branch
 ---------------------
 
-Branches in git are really nothing more than pointers into the git
+Branches in Git are really nothing more than pointers into the Git
 object database from within the `.git/refs/` subdirectory, and as we
 already discussed, the `HEAD` branch is nothing but a symlink to one of
 these object pointers.
@@ -849,7 +849,7 @@ $ git commit -m "Some work." -i hello
 Here, we just added another line to `hello`, and we used a shorthand for
 doing both `git update-index hello` and `git commit` by just giving the
 filename directly to `git commit`, with an `-i` flag (it tells
-git to 'include' that file in addition to what you have done to
+Git to 'include' that file in addition to what you have done to
 the index file so far when making the commit).  The `-m` flag is to give the
 commit log message from the command line.
 
@@ -900,7 +900,7 @@ where the first argument is going to be used as the commit message if
 the merge can be resolved automatically.
 
 Now, in this case we've intentionally created a situation where the
-merge will need to be fixed up by hand, though, so git will do as much
+merge will need to be fixed up by hand, though, so Git will do as much
 of it as it can automatically (which in this case is just merge the `example`
 file, which had no differences in the `mybranch` branch), and say:
 
@@ -939,7 +939,7 @@ After you're done, start up `gitk --all` to see graphically what the
 history looks like. Notice that `mybranch` still exists, and you can
 switch to it, and continue to work with it if you want to. The
 `mybranch` branch will not contain the merge, but next time you merge it
-from the `master` branch, git will know how you merged it, so you'll not
+from the `master` branch, Git will know how you merged it, so you'll not
 have to do _that_ merge again.
 
 Another useful tool, especially if you do not always work in X-Window
@@ -1028,7 +1028,7 @@ Merging external work
 ---------------------
 
 It's usually much more common that you merge with somebody else than
-merging with your own branches, so it's worth pointing out that git
+merging with your own branches, so it's worth pointing out that Git
 makes that very easy too, and in fact, it's not that different from
 doing a 'git merge'. In fact, a remote merge ends up being nothing
 more than "fetch the work from a remote repository into a temporary tag"
@@ -1099,8 +1099,8 @@ necessary objects.  Because of this behavior, they are
 sometimes also called 'commit walkers'.
 +
 The 'commit walkers' are sometimes also called 'dumb
-transports', because they do not require any git aware smart
-server like git Native transport does.  Any stock HTTP server
+transports', because they do not require any Git aware smart
+server like Git Native transport does.  Any stock HTTP server
 that does not even support directory index would suffice.  But
 you must prepare your repository with 'git update-server-info'
 to help dumb transport downloaders.
@@ -1321,7 +1321,7 @@ update the public repository from it. This is often called
 
 [NOTE]
 This public repository could further be mirrored, and that is
-how git repositories at `kernel.org` are managed.
+how Git repositories at `kernel.org` are managed.
 
 Publishing the changes from your local (private) repository to
 your remote (public) repository requires a write privilege on
@@ -1340,7 +1340,7 @@ done only once.
 on the remote machine. The communication between the two over
 the network internally uses an SSH connection.
 
-Your private repository's git directory is usually `.git`, but
+Your private repository's Git directory is usually `.git`, but
 your public repository is often named after the project name,
 i.e. `<project>.git`. Let's create such a public repository for
 project `my-git`. After logging into the remote machine, create
@@ -1350,7 +1350,7 @@ an empty directory:
 $ mkdir my-git.git
 ------------
 
-Then, make that directory into a git repository by running
+Then, make that directory into a Git repository by running
 'git init', but this time, since its name is not the usual
 `.git`, we do things slightly differently:
 
@@ -1389,7 +1389,7 @@ This synchronizes your public repository to match the named
 branch head (i.e. `master` in this case) and objects reachable
 from them in your current repository.
 
-As a real example, this is how I update my public git
+As a real example, this is how I update my public Git
 repository. Kernel.org mirror network takes care of the
 propagation to other publicly visible machines:
 
@@ -1402,9 +1402,9 @@ Packing your repository
 -----------------------
 
 Earlier, we saw that one file under `.git/objects/??/` directory
-is stored for each git object you create. This representation
+is stored for each Git object you create. This representation
 is efficient to create atomically and safely, but
-not so convenient to transport over the network. Since git objects are
+not so convenient to transport over the network. Since Git objects are
 immutable once they are created, there is a way to optimize the
 storage by "packing them together". The command
 
@@ -1472,14 +1472,14 @@ repositories every once in a while.
 Working with Others
 -------------------
 
-Although git is a truly distributed system, it is often
+Although Git is a truly distributed system, it is often
 convenient to organize your project with an informal hierarchy
 of developers. Linux kernel development is run this way. There
 is a nice illustration (page 17, "Merges to Mainline") in
 link:http://www.xenotime.net/linux/mentor/linux-mentoring-2006.pdf[Randy Dunlap's presentation].
 
 It should be stressed that this hierarchy is purely *informal*.
-There is nothing fundamental in git that enforces the "chain of
+There is nothing fundamental in Git that enforces the "chain of
 patch flow" this hierarchy implies. You do not have to pull
 from only one remote repository.
 
@@ -1592,7 +1592,7 @@ Working with Others, Shared Repository Style
 
 If you are coming from CVS background, the style of cooperation
 suggested in the previous section may be new to you. You do not
-have to worry. git supports "shared public repository" style of
+have to worry. Git supports "shared public repository" style of
 cooperation you are probably more familiar with as well.
 
 See linkgit:gitcvs-migration[7] for the details.
@@ -1602,7 +1602,7 @@ Bundling your work together
 
 It is likely that you will be working on more than one thing at
 a time.  It is easy to manage those more-or-less independent tasks
-using branches with git.
+using branches with Git.
 
 We have already seen how branches work previously,
 with "fun and work" example using two branches.  The idea is the
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 7dfffc0..47576be 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -3,7 +3,7 @@ gitcredentials(7)
 
 NAME
 ----
-gitcredentials - providing usernames and passwords to git
+gitcredentials - providing usernames and passwords to Git
 
 SYNOPSIS
 --------
@@ -18,13 +18,13 @@ DESCRIPTION
 Git will sometimes need credentials from the user in order to perform
 operations; for example, it may need to ask for a username and password
 in order to access a remote repository over HTTP. This manual describes
-the mechanisms git uses to request these credentials, as well as some
+the mechanisms Git uses to request these credentials, as well as some
 features to avoid inputting these credentials repeatedly.
 
 REQUESTING CREDENTIALS
 ----------------------
 
-Without any credential helpers defined, git will try the following
+Without any credential helpers defined, Git will try the following
 strategies to ask the user for usernames and passwords:
 
 1. If the `GIT_ASKPASS` environment variable is set, the program
@@ -59,7 +59,7 @@ for a password. It is generally configured by adding this to your config:
 	username = me
 ---------------------------------------
 
-Credential helpers, on the other hand, are external programs from which git can
+Credential helpers, on the other hand, are external programs from which Git can
 request both usernames and passwords; they typically interface with secure
 storage provided by the OS or other programs.
 
@@ -79,7 +79,7 @@ store::
 You may also have third-party helpers installed; search for
 `credential-*` in the output of `git help -a`, and consult the
 documentation of individual helpers.  Once you have selected a helper,
-you can tell git to use it by putting its name into the
+you can tell Git to use it by putting its name into the
 credential.helper variable.
 
 1. Find a helper.
@@ -95,7 +95,7 @@ credential-foo
 $ git help credential-foo
 -------------------------------------------
 
-3. Tell git to use it.
+3. Tell Git to use it.
 +
 -------------------------------------------
 $ git config --global credential.helper foo
@@ -103,7 +103,7 @@ $ git config --global credential.helper foo
 
 If there are multiple instances of the `credential.helper` configuration
 variable, each helper will be tried in turn, and may provide a username,
-password, or nothing. Once git has acquired both a username and a
+password, or nothing. Once Git has acquired both a username and a
 password, no more helpers will be tried.
 
 
@@ -114,7 +114,7 @@ Git considers each credential to have a context defined by a URL. This context
 is used to look up context-specific configuration, and is passed to any
 helpers, which may use it as an index into secure storage.
 
-For instance, imagine we are accessing `https://example.com/foo.git`. When git
+For instance, imagine we are accessing `https://example.com/foo.git`. When Git
 looks into a config file to see if a section matches this context, it will
 consider the two a match if the context is a more-specific subset of the
 pattern in the config file. For example, if you have this in your config file:
@@ -133,10 +133,10 @@ context would not match:
 	username = foo
 --------------------------------------
 
-because the hostnames differ. Nor would it match `foo.example.com`; git
+because the hostnames differ. Nor would it match `foo.example.com`; Git
 compares hostnames exactly, without considering whether two hosts are part of
 the same domain. Likewise, a config entry for `http://example.com` would not
-match: git compares the protocols exactly.
+match: Git compares the protocols exactly.
 
 
 CONFIGURATION OPTIONS
@@ -164,7 +164,7 @@ username::
 
 useHttpPath::
 
-	By default, git does not consider the "path" component of an http URL
+	By default, Git does not consider the "path" component of an http URL
 	to be worth matching via external helpers. This means that a credential
 	stored for `https://example.com/foo.git` will also be used for
 	`https://example.com/bar.git`. If you do want to distinguish these
@@ -175,7 +175,7 @@ CUSTOM HELPERS
 --------------
 
 You can write your own custom helpers to interface with any system in
-which you keep credentials. See the documentation for git's
+which you keep credentials. See the documentation for Git's
 link:technical/api-credentials.html[credentials API] for details.
 
 GIT
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b9003fe..26babb3 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -3,7 +3,7 @@ githooks(5)
 
 NAME
 ----
-githooks - Hooks used by git
+githooks - Hooks used by Git
 
 SYNOPSIS
 --------
@@ -108,7 +108,7 @@ it is not suppressed by the `--no-verify` option.  A non-zero exit
 means a failure of the hook and aborts the commit.  It should not
 be used as replacement for pre-commit hook.
 
-The sample `prepare-commit-msg` hook that comes with git comments
+The sample `prepare-commit-msg` hook that comes with Git comments
 out the `Conflicts:` part of a merge's commit message.
 
 commit-msg
@@ -275,7 +275,7 @@ for the user.
 
 The default 'post-receive' hook is empty, but there is
 a sample script `post-receive-email` provided in the `contrib/hooks`
-directory in git distribution, which implements sending commit
+directory in Git distribution, which implements sending commit
 emails.
 
 [[post-update]]
@@ -303,7 +303,7 @@ them.
 When enabled, the default 'post-update' hook runs
 'git update-server-info' to keep the information used by dumb
 transports (e.g., HTTP) up-to-date.  If you are publishing
-a git repository that is accessible via HTTP, you should
+a Git repository that is accessible via HTTP, you should
 probably enable this hook.
 
 Both standard output and standard error output are forwarded to
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 91a6438..bc7a046 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -13,12 +13,12 @@ DESCRIPTION
 -----------
 
 A `gitignore` file specifies intentionally untracked files that
-git should ignore.
-Files already tracked by git are not affected; see the NOTES
+Git should ignore.
+Files already tracked by Git are not affected; see the NOTES
 below for details.
 
 Each line in a `gitignore` file specifies a pattern.
-When deciding whether to ignore a path, git normally checks
+When deciding whether to ignore a path, Git normally checks
 `gitignore` patterns from multiple sources, with the following
 order of precedence, from highest to lowest (within one level of
 precedence, the last matching pattern decides the outcome):
@@ -53,17 +53,17 @@ be used.
    the repository but are specific to one user's workflow) should go into
    the `$GIT_DIR/info/exclude` file.
 
- * Patterns which a user wants git to
+ * Patterns which a user wants Git to
    ignore in all situations (e.g., backup or temporary files generated by
    the user's editor of choice) generally go into a file specified by
    `core.excludesfile` in the user's `~/.gitconfig`. Its default value is
    $XDG_CONFIG_HOME/git/ignore. If $XDG_CONFIG_HOME is either not set or
    empty, $HOME/.config/git/ignore is used instead.
 
-The underlying git plumbing tools, such as
+The underlying Git plumbing tools, such as
 'git ls-files' and 'git read-tree', read
 `gitignore` patterns specified by command-line options, or from
-files specified by command-line options.  Higher-level git
+files specified by command-line options.  Higher-level Git
 tools, such as 'git status' and 'git add',
 use patterns from the sources specified above.
 
@@ -89,15 +89,15 @@ PATTERN FORMAT
    a match with a directory.  In other words, `foo/` will match a
    directory `foo` and paths underneath it, but will not match a
    regular file or a symbolic link `foo` (this is consistent
-   with the way how pathspec works in general in git).
+   with the way how pathspec works in general in Git).
 
- - If the pattern does not contain a slash '/', git treats it as
+ - If the pattern does not contain a slash '/', Git treats it as
    a shell glob pattern and checks for a match against the
    pathname relative to the location of the `.gitignore` file
    (relative to the toplevel of the work tree if not from a
    `.gitignore` file).
 
- - Otherwise, git treats the pattern as a shell glob suitable
+ - Otherwise, Git treats the pattern as a shell glob suitable
    for consumption by fnmatch(3) with the FNM_PATHNAME flag:
    wildcards in the pattern will not match a / in the pathname.
    For example, "Documentation/{asterisk}.html" matches
@@ -131,7 +131,7 @@ NOTES
 -----
 
 The purpose of gitignore files is to ensure that certain files
-not tracked by git remain untracked.
+not tracked by Git remain untracked.
 
 To ignore uncommitted changes in a file that is already tracked,
 use 'git update-index {litdd}assume-unchanged'.
@@ -179,7 +179,7 @@ Another example:
     $ echo '!/vmlinux*' >arch/foo/kernel/.gitignore
 --------------------------------------------------------------
 
-The second .gitignore prevents git from ignoring
+The second .gitignore prevents Git from ignoring
 `arch/foo/kernel/vmlinux.lds.S`.
 
 SEE ALSO
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index a17a354..c17e760 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -3,7 +3,7 @@ gitk(1)
 
 NAME
 ----
-gitk - The git repository browser
+gitk - The Git repository browser
 
 SYNOPSIS
 --------
@@ -18,7 +18,7 @@ the files in the trees of each revision.
 
 Historically, gitk was the first repository browser. It's written in tcl/tk
 and started off in a separate repository but was later merged into the main
-git repository.
+Git repository.
 
 OPTIONS
 -------
@@ -108,10 +108,10 @@ SEE ALSO
 
 'gitview(1)'::
 	A repository browser written in Python using Gtk. It's based on
-	'bzrk(1)' and distributed in the contrib area of the git repository.
+	'bzrk(1)' and distributed in the contrib area of the Git repository.
 
 'tig(1)'::
-	A minimal repository browser and git tool output highlighter written
+	A minimal repository browser and Git tool output highlighter written
 	in C using Ncurses.
 
 GIT
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 52d7ae4..6a1ca4a 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -13,7 +13,7 @@ $GIT_WORK_DIR/.gitmodules
 DESCRIPTION
 -----------
 
-The `.gitmodules` file, located in the top-level directory of a git
+The `.gitmodules` file, located in the top-level directory of a Git
 working tree, is a text file with a syntax matching the requirements
 of linkgit:git-config[1].
 
@@ -24,7 +24,7 @@ option of 'git submodule add'. Each submodule section also contains the
 following required keys:
 
 submodule.<name>.path::
-	Defines the path, relative to the top-level directory of the git
+	Defines the path, relative to the top-level directory of the Git
 	working tree, where the submodule is expected to be checked out.
 	The path name must not end with a `/`. All submodule paths must
 	be unique within the .gitmodules file.
diff --git a/Documentation/gitnamespaces.txt b/Documentation/gitnamespaces.txt
index c6713cf..7685e36 100644
--- a/Documentation/gitnamespaces.txt
+++ b/Documentation/gitnamespaces.txt
@@ -29,7 +29,7 @@ prevent duplication between new objects added to the repositories
 without ongoing maintenance, while namespaces do.
 
 To specify a namespace, set the `GIT_NAMESPACE` environment variable to
-the namespace.  For each ref namespace, git stores the corresponding
+the namespace.  For each ref namespace, Git stores the corresponding
 refs in a directory under `refs/namespaces/`.  For example,
 `GIT_NAMESPACE=foo` will store refs under `refs/namespaces/foo/`.  You
 can also specify namespaces via the `--namespace` option to
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 9f62886..5f8d545 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -12,12 +12,12 @@ $GIT_DIR/*
 DESCRIPTION
 -----------
 
-You may find these things in your git repository (`.git`
+You may find these things in your Git repository (`.git`
 directory for a repository associated with your working tree, or
 `<project>.git` directory for a public 'bare' repository. It is
 also possible to have a working tree where `.git` is a plain
 ASCII file containing `gitdir: <path>`, i.e. the path to the
-real git repository).
+real Git repository).
 
 objects::
 	Object store associated with this repository.  Usually
@@ -108,7 +108,7 @@ HEAD::
 	A symref (see glossary) to the `refs/heads/` namespace
 	describing the currently active branch.  It does not mean
 	much if the repository is not associated with any working tree
-	(i.e. a 'bare' repository), but a valid git repository
+	(i.e. a 'bare' repository), but a valid Git repository
 	*must* have the HEAD file; some porcelains may use it to
 	guess the designated "default" branch of the repository
 	(usually 'master').  It is legal if the named branch
@@ -131,7 +131,7 @@ branches::
 	and not likely to be found in modern repositories.
 
 hooks::
-	Hooks are customization scripts used by various git
+	Hooks are customization scripts used by various Git
 	commands.  A handful of sample hooks are installed when
 	'git init' is run, but all of them are disabled by
 	default.  To enable, the `.sample` suffix has to be
@@ -169,7 +169,7 @@ info/exclude::
 	This file, by convention among Porcelains, stores the
 	exclude pattern list. `.gitignore` is the per-directory
 	ignore file.  'git status', 'git add', 'git rm' and
-	'git clean' look at it but the core git commands do not look
+	'git clean' look at it but the core Git commands do not look
 	at it.  See also: linkgit:gitignore[5].
 
 remotes::
diff --git a/Documentation/gitrevisions.txt b/Documentation/gitrevisions.txt
index fc4789f..c0ed6d1 100644
--- a/Documentation/gitrevisions.txt
+++ b/Documentation/gitrevisions.txt
@@ -3,7 +3,7 @@ gitrevisions(7)
 
 NAME
 ----
-gitrevisions - specifying revisions and ranges for git
+gitrevisions - specifying revisions and ranges for Git
 
 SYNOPSIS
 --------
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index e00a4d2..94c906e 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -3,7 +3,7 @@ gittutorial-2(7)
 
 NAME
 ----
-gittutorial-2 - A tutorial introduction to git: part two
+gittutorial-2 - A tutorial introduction to Git: part two
 
 SYNOPSIS
 --------
@@ -16,11 +16,11 @@ DESCRIPTION
 You should work through linkgit:gittutorial[7] before reading this tutorial.
 
 The goal of this tutorial is to introduce two fundamental pieces of
-git's architecture--the object database and the index file--and to
+Git's architecture--the object database and the index file--and to
 provide the reader with everything necessary to understand the rest
-of the git documentation.
+of the Git documentation.
 
-The git object database
+The Git object database
 -----------------------
 
 Let's start a new project and create a small amount of history:
@@ -42,14 +42,14 @@ $ git commit -a -m "add emphasis"
  1 file changed, 1 insertion(+), 1 deletion(-)
 ------------------------------------------------
 
-What are the 7 digits of hex that git responded to the commit with?
+What are the 7 digits of hex that Git responded to the commit with?
 
 We saw in part one of the tutorial that commits have names like this.
-It turns out that every object in the git history is stored under
+It turns out that every object in the Git history is stored under
 a 40-digit hex name.  That name is the SHA1 hash of the object's
-contents; among other things, this ensures that git will never store
+contents; among other things, this ensures that Git will never store
 the same data twice (since identical data is given an identical SHA1
-name), and that the contents of a git object will never change (since
+name), and that the contents of a Git object will never change (since
 that would change the object's name as well). The 7 char hex strings
 here are simply the abbreviation of such 40 character long strings.
 Abbreviations can be used everywhere where the 40 character strings
@@ -60,7 +60,7 @@ following the example above generates a different SHA1 hash than
 the one shown above because the commit object records the time when
 it was created and the name of the person performing the commit.
 
-We can ask git about this particular object with the `cat-file`
+We can ask Git about this particular object with the `cat-file`
 command. Don't copy the 40 hex digits from this example but use those
 from your own version. Note that you can shorten it to only a few
 characters to save yourself typing all 40 hex digits:
@@ -102,11 +102,11 @@ $ git cat-file blob 3b18e512
 hello world
 ------------------------------------------------
 
-Note that this is the old file data; so the object that git named in
+Note that this is the old file data; so the object that Git named in
 its response to the initial tree was a tree with a snapshot of the
 directory state that was recorded by the first commit.
 
-All of these objects are stored under their SHA1 names inside the git
+All of these objects are stored under their SHA1 names inside the Git
 directory:
 
 ------------------------------------------------
@@ -191,7 +191,7 @@ Besides blobs, trees, and commits, the only remaining type of object
 is a "tag", which we won't discuss here; refer to linkgit:git-tag[1]
 for details.
 
-So now we know how git uses the object database to represent a
+So now we know how Git uses the object database to represent a
 project's history:
 
   * "commit" objects refer to "tree" objects representing the
@@ -403,21 +403,21 @@ What next?
 
 At this point you should know everything necessary to read the man
 pages for any of the git commands; one good place to start would be
-with the commands mentioned in link:everyday.html[Everyday git].  You
+with the commands mentioned in link:everyday.html[Everyday Git].  You
 should be able to find any unknown jargon in linkgit:gitglossary[7].
 
 The link:user-manual.html[Git User's Manual] provides a more
-comprehensive introduction to git.
+comprehensive introduction to Git.
 
 linkgit:gitcvs-migration[7] explains how to
-import a CVS repository into git, and shows how to use git in a
+import a CVS repository into Git, and shows how to use Git in a
 CVS-like way.
 
-For some interesting examples of git use, see the
+For some interesting examples of Git use, see the
 link:howto-index.html[howtos].
 
-For git developers, linkgit:gitcore-tutorial[7] goes
-into detail on the lower-level git mechanisms involved in, for
+For Git developers, linkgit:gitcore-tutorial[7] goes
+into detail on the lower-level Git mechanisms involved in, for
 example, creating a new commit.
 
 SEE ALSO
@@ -427,7 +427,7 @@ linkgit:gitcvs-migration[7],
 linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
 linkgit:git-help[1],
-link:everyday.html[Everyday git],
+link:everyday.html[Everyday Git],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 9dd45c4..6091988 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -3,7 +3,7 @@ gittutorial(7)
 
 NAME
 ----
-gittutorial - A tutorial introduction to git (for version 1.5.1 or newer)
+gittutorial - A tutorial introduction to Git (for version 1.5.1 or newer)
 
 SYNOPSIS
 --------
@@ -13,10 +13,10 @@ git *
 DESCRIPTION
 -----------
 
-This tutorial explains how to import a new project into git, make
+This tutorial explains how to import a new project into Git, make
 changes to it, and share changes with other developers.
 
-If you are instead primarily interested in using git to fetch a project,
+If you are instead primarily interested in using Git to fetch a project,
 for example, to test the latest version, you may prefer to start with
 the first two chapters of link:user-manual.html[The Git User's Manual].
 
@@ -36,7 +36,7 @@ $ git help log
 With the latter, you can use the manual viewer of your choice; see
 linkgit:git-help[1] for more information.
 
-It is a good idea to introduce yourself to git with your name and
+It is a good idea to introduce yourself to Git with your name and
 public email address before doing any operation.  The easiest
 way to do so is:
 
@@ -50,7 +50,7 @@ Importing a new project
 -----------------------
 
 Assume you have a tarball project.tar.gz with your initial work.  You
-can place it under git revision control as follows.
+can place it under Git revision control as follows.
 
 ------------------------------------------------
 $ tar xzf project.tar.gz
@@ -67,14 +67,14 @@ Initialized empty Git repository in .git/
 You've now initialized the working directory--you may notice a new
 directory created, named ".git".
 
-Next, tell git to take a snapshot of the contents of all files under the
+Next, tell Git to take a snapshot of the contents of all files under the
 current directory (note the '.'), with 'git add':
 
 ------------------------------------------------
 $ git add .
 ------------------------------------------------
 
-This snapshot is now stored in a temporary staging area which git calls
+This snapshot is now stored in a temporary staging area which Git calls
 the "index".  You can permanently store the contents of the index in the
 repository with 'git commit':
 
@@ -83,7 +83,7 @@ $ git commit
 ------------------------------------------------
 
 This will prompt you for a commit message.  You've now stored the first
-version of your project in git.
+version of your project in Git.
 
 Making changes
 --------------
@@ -141,7 +141,7 @@ begin the commit message with a single short (less than 50 character)
 line summarizing the change, followed by a blank line and then a more
 thorough description. The text up to the first blank line in a commit
 message is treated as the commit title, and that title is used
-throughout git.  For example, linkgit:git-format-patch[1] turns a
+throughout Git.  For example, linkgit:git-format-patch[1] turns a
 commit into email, and it uses the title on the Subject line and the
 rest of the commit in the body.
 
@@ -180,7 +180,7 @@ $ git log --stat --summary
 Managing branches
 -----------------
 
-A single git repository can maintain multiple branches of
+A single Git repository can maintain multiple branches of
 development.  To create a new branch named "experimental", use
 
 ------------------------------------------------
@@ -276,10 +276,10 @@ $ git branch -D crazy-idea
 Branches are cheap and easy, so this is a good way to try something
 out.
 
-Using git for collaboration
+Using Git for collaboration
 ---------------------------
 
-Suppose that Alice has started a new project with a git repository in
+Suppose that Alice has started a new project with a Git repository in
 /home/alice/project, and that Bob, who has a home directory on the
 same machine, wants to contribute.
 
@@ -320,7 +320,7 @@ Note that in general, Alice would want her local changes committed before
 initiating this "pull".  If Bob's work conflicts with what Alice did since
 their histories forked, Alice will use her working tree and the index to
 resolve conflicts, and existing local changes will interfere with the
-conflict resolution process (git will still perform the fetch but will
+conflict resolution process (Git will still perform the fetch but will
 refuse to merge --- Alice will have to get rid of her local changes in
 some way and pull again when this happens).
 
@@ -422,7 +422,7 @@ bob$ git pull
 -------------------------------------
 
 Note that he doesn't need to give the path to Alice's repository;
-when Bob cloned Alice's repository, git stored the location of her
+when Bob cloned Alice's repository, Git stored the location of her
 repository in the repository configuration, and that location is
 used for pulls:
 
@@ -450,7 +450,7 @@ perform clones and pulls using the ssh protocol:
 bob$ git clone alice.org:/home/alice/project myrepo
 -------------------------------------
 
-Alternatively, git has a native protocol, or can use rsync or http;
+Alternatively, Git has a native protocol, or can use rsync or http;
 see linkgit:git-pull[1] for details.
 
 Git can also be used in a CVS-like mode, with a central repository
@@ -462,7 +462,7 @@ Exploring history
 
 Git history is represented as a series of interrelated commits.  We
 have already seen that the 'git log' command can list those commits.
-Note that first line of each git log entry also gives a name for the
+Note that first line of each Git log entry also gives a name for the
 commit:
 
 -------------------------------------
@@ -518,7 +518,7 @@ share this name with other people (for example, to identify a release
 version), you should create a "tag" object, and perhaps sign it; see
 linkgit:git-tag[1] for details.
 
-Any git command that needs to know a commit can take any of these
+Any Git command that needs to know a commit can take any of these
 names.  For example:
 
 -------------------------------------
@@ -554,9 +554,9 @@ files it manages in your current directory.  So
 $ git grep "hello"
 -------------------------------------
 
-is a quick way to search just the files that are tracked by git.
+is a quick way to search just the files that are tracked by Git.
 
-Many git commands also take sets of commits, which can be specified
+Many Git commands also take sets of commits, which can be specified
 in a number of ways.  Here are some examples with 'git log':
 
 -------------------------------------
@@ -592,7 +592,7 @@ then merged back together, the order in which 'git log' presents
 those commits is meaningless.
 
 Most projects with multiple contributors (such as the Linux kernel,
-or git itself) have frequent merges, and 'gitk' does a better job of
+or Git itself) have frequent merges, and 'gitk' does a better job of
 visualizing their history.  For example,
 
 -------------------------------------
@@ -623,7 +623,7 @@ Next Steps
 
 This tutorial should be enough to perform basic distributed revision
 control for your projects.  However, to fully understand the depth
-and power of git you need to understand two simple ideas on which it
+and power of Git you need to understand two simple ideas on which it
 is based:
 
   * The object database is the rather elegant system used to
@@ -636,7 +636,7 @@ is based:
 
 Part two of this tutorial explains the object
 database, the index file, and a few other odds and ends that you'll
-need to make the most of git. You can find it at linkgit:gittutorial-2[7].
+need to make the most of Git. You can find it at linkgit:gittutorial-2[7].
 
 If you don't want to continue with that right away, a few other
 digressions that may be interesting at this point are:
@@ -668,7 +668,7 @@ linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
 linkgit:git-help[1],
 linkgit:gitworkflows[7],
-link:everyday.html[Everyday git],
+link:everyday.html[Everyday Git],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 4947455..eb63631 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -3,7 +3,7 @@ gitweb.conf(5)
 
 NAME
 ----
-gitweb.conf - Gitweb (git web interface) configuration file
+gitweb.conf - Gitweb (Git web interface) configuration file
 
 SYNOPSIS
 --------
@@ -79,7 +79,7 @@ stops declaring it.
 You can include other configuration file using read_config_file()
 subroutine.  For example, one might want to put gitweb configuration
 related to access control for viewing repositories via Gitolite (one
-of git repository management tools) in a separate file, e.g. in
+of Git repository management tools) in a separate file, e.g. in
 '/etc/gitweb-gitolite.conf'.  To include it, put
 
 --------------------------------------------------
@@ -111,7 +111,7 @@ and installing gitweb.
 Location of repositories
 ~~~~~~~~~~~~~~~~~~~~~~~~
 The configuration variables described below control how gitweb finds
-git repositories, and how repositories are displayed and accessed.
+Git repositories, and how repositories are displayed and accessed.
 
 See also "Repositories" and later subsections in linkgit:gitweb[1] manpage.
 
@@ -159,7 +159,7 @@ will fall back to scanning the `$projectroot` directory for repositories.
 
 $project_maxdepth::
 	If `$projects_list` variable is unset, gitweb will recursively
-	scan filesystem for git repositories.  The `$project_maxdepth`
+	scan filesystem for Git repositories.  The `$project_maxdepth`
 	is used to limit traversing depth, relative to `$projectroot`
 	(starting point); it means that directories which are further
 	from `$projectroot` than `$project_maxdepth` will be skipped.
@@ -200,7 +200,7 @@ our $export_ok = "git-daemon-export-ok";
 +
 If not set (default), it means that this feature is disabled.
 +
-See also more involved example in "Controlling access to git repositories"
+See also more involved example in "Controlling access to Git repositories"
 subsection on linkgit:gitweb[1] manpage.
 
 $strict_export::
@@ -222,18 +222,18 @@ The values of these variables are paths on the filesystem.
 
 $GIT::
 	Core git executable to use.  By default set to `$GIT_BINDIR/git`, which
-	in turn is by default set to `$(bindir)/git`.  If you use git installed
+	in turn is by default set to `$(bindir)/git`.  If you use Git installed
 	from a binary package, you should usually set this to "/usr/bin/git".
 	This can just be "git" if your web server has a sensible PATH; from
 	security point of view it is better to use absolute path to git binary.
-	If you have multiple git versions installed it can be used to choose
+	If you have multiple Git versions installed it can be used to choose
 	which one to use.  Must be (correctly) set for gitweb to be able to
 	work.
 
 $mimetypes_file::
 	File to use for (filename extension based) guessing of MIME types before
 	trying '/etc/mime.types'.  *NOTE* that this path, if relative, is taken
-	as relative to the current git repository, not to CGI script.  If unset,
+	as relative to the current Git repository, not to CGI script.  If unset,
 	only '/etc/mime.types' is used (if present on filesystem).  If no mimetypes
 	file is found, mimetype guessing based on extension of file is disabled.
 	Unset by default.
@@ -343,8 +343,8 @@ $logo_url::
 $logo_label::
 	URI and label (title) for the Git logo link (or your site logo,
 	if you chose to use different logo image). By default, these both
-	refer to git homepage, http://git-scm.com[]; in the past, they pointed
-	to git documentation at http://www.kernel.org[].
+	refer to Git homepage, http://git-scm.com[]; in the past, they pointed
+	to Git documentation at http://www.kernel.org[].
 
 
 Changing gitweb's look
@@ -436,7 +436,7 @@ $fallback_encoding::
 	detection.
 +
 *Note* that rename and especially copy detection can be quite
-CPU-intensive.  Note also that non git tools can have problems with
+CPU-intensive.  Note also that non Git tools can have problems with
 patches generated with options mentioned above, especially when they
 involve file copies (\'-C') or criss-cross renames (\'-B').
 
@@ -451,7 +451,7 @@ looks does contain variables configuring administrative side of gitweb
 affects how "summary" pages look like, or load limiting).
 
 @git_base_url_list::
-	List of git base URLs.  These URLs are used to generate URLs
+	List of Git base URLs.  These URLs are used to generate URLs
 	describing from where to fetch a project, which are shown on
 	project summary page.  The full fetch URL is "`$git_base_url/$project`",
 	for each element of this list. You can set up multiple base URLs
@@ -616,7 +616,7 @@ override::
 	(or enabled/disabled) on a per-repository basis.
 +
 Usually given "<feature>" is configurable via the `gitweb.<feature>`
-config variable in the per-repository git configuration file.
+config variable in the per-repository Git configuration file.
 +
 *Note* that no feature is overriddable by default.
 
@@ -782,7 +782,7 @@ filesystem (i.e. "$projectroot/$project"), `%h` to the current hash
 (\'hb' gitweb parameter); `%%` expands to \'%'.
 +
 For example, at the time this page was written, the http://repo.or.cz[]
-git hosting site set it to the following to enable graphical log
+Git hosting site set it to the following to enable graphical log
 (using the third party tool *git-browser*):
 +
 ----------------------------------------------------------------------
@@ -796,10 +796,10 @@ This adds a link titled "graphiclog" after the "summary" link, leading to
 Project specific override is not supported.
 
 timed::
-	Enable displaying how much time and how many git commands it took to
+	Enable displaying how much time and how many Git commands it took to
 	generate and display each page in the page footer (at the bottom of
 	page).  For example the footer might contain: "This page took 6.53325
-	seconds and 13 git commands to generate."  Disabled by default.
+	seconds and 13 Git commands to generate."  Disabled by default.
 +
 Project specific override is not supported.
 
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index d364c3a..40969f1 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -7,14 +7,14 @@ gitweb - Git web interface (web frontend to Git repositories)
 
 SYNOPSIS
 --------
-To get started with gitweb, run linkgit:git-instaweb[1] from a git repository.
+To get started with gitweb, run linkgit:git-instaweb[1] from a Git repository.
 This would configure and start your web server, and run web browser pointing to
 gitweb.
 
 
 DESCRIPTION
 -----------
-Gitweb provides a web interface to git repositories.  Its features include:
+Gitweb provides a web interface to Git repositories.  Its features include:
 
 * Viewing multiple Git repositories with common root.
 * Browsing every revision of the repository.
@@ -54,9 +54,9 @@ our $projectroot = '/path/to/parent/directory';
 The default value for `$projectroot` is '/pub/git'.  You can change it during
 building gitweb via `GITWEB_PROJECTROOT` build configuration variable.
 
-By default all git repositories under `$projectroot` are visible and available
+By default all Git repositories under `$projectroot` are visible and available
 to gitweb.  The list of projects is generated by default by scanning the
-`$projectroot` directory for git repositories (for object databases to be
+`$projectroot` directory for Git repositories (for object databases to be
 more exact; gitweb is not interested in a working area, and is best suited
 to showing "bare" repositories).
 
@@ -111,7 +111,7 @@ foo/bar.git   O+W+Ner+<owner@example.org>
 
 
 By default this file controls only which projects are *visible* on projects
-list page (note that entries that do not point to correctly recognized git
+list page (note that entries that do not point to correctly recognized Git
 repositories won't be displayed by gitweb).  Even if a project is not
 visible on projects list page, you can view it nevertheless by hand-crafting
 a gitweb URL.  By setting `$strict_export` configuration variable (see
@@ -151,9 +151,9 @@ as projects list file, which means that you can set `$projects_list` to its
 filename.
 
 
-Controlling access to git repositories
+Controlling access to Git repositories
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-By default all git repositories under `$projectroot` are visible and
+By default all Git repositories under `$projectroot` are visible and
 available to gitweb.  You can however configure how gitweb controls access
 to repositories.
 
@@ -206,7 +206,7 @@ $export_auth_hook = sub {
 Per-repository gitweb configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 You can configure individual repositories shown in gitweb by creating file
-in the 'GIT_DIR' of git repository, or by setting some repo configuration
+in the 'GIT_DIR' of Git repository, or by setting some repo configuration
 variable (in 'GIT_DIR/config', see linkgit:git-config[1]).
 
 You can use the following files in repository:
@@ -584,7 +584,7 @@ $projectroot = $ENV{'GITWEB_PROJECTROOT'} || "/pub/git";
 referenced by `$per_request_config`;
 
 These configurations enable two things. First, each unix user (`<user>`) of
-the server will be able to browse through gitweb git repositories found in
+the server will be able to browse through gitweb Git repositories found in
 '~/public_git/' with the following url:
 
   http://git.example.org/~<user>/
@@ -673,7 +673,7 @@ The additional AliasMatch makes it so that
 
   http://git.example.com/project.git
 
-will give raw access to the project's git dir (so that the project can be
+will give raw access to the project's Git dir (so that the project can be
 cloned), while
 
   http://git.example.com/project
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index e2e7d65..f16c414 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -3,7 +3,7 @@ gitworkflows(7)
 
 NAME
 ----
-gitworkflows - An overview of recommended workflows with git
+gitworkflows - An overview of recommended workflows with Git
 
 SYNOPSIS
 --------
@@ -245,7 +245,7 @@ tag to the tip of 'master' indicating the release version:
 `git tag -s -m "Git X.Y.Z" vX.Y.Z master`
 =====================================
 
-You need to push the new tag to a public git server (see
+You need to push the new tag to a public Git server (see
 "DISTRIBUTED WORKFLOWS" below). This makes the tag available to
 others tracking your project. The push could also trigger a
 post-update hook to perform release-related items such as building
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 7c28aef..7c15bc0 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -7,7 +7,7 @@
 	A bare repository is normally an appropriately
 	named <<def_directory,directory>> with a `.git` suffix that does not
 	have a locally checked-out copy of any of the files under
-	revision control. That is, all of the `git`
+	revision control. That is, all of the Git
 	administrative and control files that would normally be present in the
 	hidden `.git` sub-directory are directly present in the
 	`repository.git` directory instead,
@@ -22,7 +22,7 @@
 	<<def_commit,commit>> on a branch is referred to as the tip of
 	that branch.  The tip of the branch is referenced by a branch
 	<<def_head,head>>, which moves forward as additional development
-	is done on the branch.  A single git
+	is done on the branch.  A single Git
 	<<def_repository,repository>> can track an arbitrary number of
 	branches, but your <<def_working_tree,working tree>> is
 	associated with just one of them (the "current" or "checked out"
@@ -37,9 +37,9 @@
 	<<def_commit,commit>> could be one of its <<def_parent,parents>>).
 
 [[def_changeset]]changeset::
-	BitKeeper/cvsps speak for "<<def_commit,commit>>". Since git does not
+	BitKeeper/cvsps speak for "<<def_commit,commit>>". Since Git does not
 	store changes, but states, it really does not make sense to use the term
-	"changesets" with git.
+	"changesets" with Git.
 
 [[def_checkout]]checkout::
 	The action of updating all or part of the
@@ -64,14 +64,14 @@
 
 [[def_commit]]commit::
 	As a noun: A single point in the
-	git history; the entire history of a project is represented as a
+	Git history; the entire history of a project is represented as a
 	set of interrelated commits.  The word "commit" is often
-	used by git in the same places other revision control systems
+	used by Git in the same places other revision control systems
 	use the words "revision" or "version".  Also used as a short
 	hand for <<def_commit_object,commit object>>.
 +
 As a verb: The action of storing a new snapshot of the project's
-state in the git history, by creating a new commit representing the current
+state in the Git history, by creating a new commit representing the current
 state of the <<def_index,index>> and advancing <<def_HEAD,HEAD>>
 to point at the new commit.
 
@@ -82,8 +82,8 @@ to point at the new commit.
 	to the top <<def_directory,directory>> of the stored
 	revision.
 
-[[def_core_git]]core git::
-	Fundamental data structures and utilities of git. Exposes only limited
+[[def_core_git]]core Git::
+	Fundamental data structures and utilities of Git. Exposes only limited
 	source code management tools.
 
 [[def_DAG]]DAG::
@@ -100,7 +100,7 @@ to point at the new commit.
 
 [[def_detached_HEAD]]detached HEAD::
 	Normally the <<def_HEAD,HEAD>> stores the name of a
-	<<def_branch,branch>>.  However, git also allows you to <<def_checkout,check out>>
+	<<def_branch,branch>>.  However, Git also allows you to <<def_checkout,check out>>
 	an arbitrary <<def_commit,commit>> that isn't necessarily the tip of any
 	particular branch.  In this case HEAD is said to be "detached".
 
@@ -142,22 +142,22 @@ to point at the new commit.
 	and to get them, too.  See also linkgit:git-fetch[1].
 
 [[def_file_system]]file system::
-	Linus Torvalds originally designed git to be a user space file system,
+	Linus Torvalds originally designed Git to be a user space file system,
 	i.e. the infrastructure to hold files and directories. That ensured the
-	efficiency and speed of git.
+	efficiency and speed of Git.
 
-[[def_git_archive]]git archive::
+[[def_git_archive]]Git archive::
 	Synonym for <<def_repository,repository>> (for arch people).
 
 [[def_grafts]]grafts::
 	Grafts enables two otherwise different lines of development to be joined
 	together by recording fake ancestry information for commits. This way
-	you can make git pretend the set of <<def_parent,parents>> a <<def_commit,commit>> has
+	you can make Git pretend the set of <<def_parent,parents>> a <<def_commit,commit>> has
 	is different from what was recorded when the commit was
 	created. Configured via the `.git/info/grafts` file.
 
 [[def_hash]]hash::
-	In git's context, synonym to <<def_object_name,object name>>.
+	In Git's context, synonym to <<def_object_name,object name>>.
 
 [[def_head]]head::
 	A <<def_ref,named reference>> to the <<def_commit,commit>> at the tip of a
@@ -177,14 +177,14 @@ to point at the new commit.
 	A synonym for <<def_head,head>>.
 
 [[def_hook]]hook::
-	During the normal execution of several git commands, call-outs are made
+	During the normal execution of several Git commands, call-outs are made
 	to optional scripts that allow a developer to add functionality or
 	checking. Typically, the hooks allow for a command to be pre-verified
 	and potentially aborted, and allow for a post-notification after the
 	operation is done. The hook scripts are found in the
 	`$GIT_DIR/hooks/` directory, and are enabled by simply
 	removing the `.sample` suffix from the filename. In earlier versions
-	of git you had to make them executable.
+	of Git you had to make them executable.
 
 [[def_index]]index::
 	A collection of files with stat information, whose contents are stored
@@ -201,7 +201,7 @@ to point at the new commit.
 
 [[def_master]]master::
 	The default development <<def_branch,branch>>. Whenever you
-	create a git <<def_repository,repository>>, a branch named
+	create a Git <<def_repository,repository>>, a branch named
 	"master" is created, and becomes the active branch. In most
 	cases, this contains the local development, though that is
 	purely by convention and is not required.
@@ -228,7 +228,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 "merge".
 
 [[def_object]]object::
-	The unit of storage in git. It is uniquely identified by the
+	The unit of storage in Git. It is uniquely identified by the
 	<<def_SHA1,SHA1>> of its contents. Consequently, an
 	object can not be changed.
 
@@ -323,7 +323,7 @@ top `/`;;
 +
 Currently only the slash `/` is recognized as the "magic signature",
 but it is envisioned that we will support more types of magic in later
-versions of git.
+versions of Git.
 +
 A pathspec with only a colon means "there is no pathspec". This form
 should not be combined with other pathspec.
@@ -341,12 +341,12 @@ should not be combined with other pathspec.
 	particular line of text. See linkgit:git-diff[1].
 
 [[def_plumbing]]plumbing::
-	Cute name for <<def_core_git,core git>>.
+	Cute name for <<def_core_git,core Git>>.
 
 [[def_porcelain]]porcelain::
 	Cute name for programs and program suites depending on
-	<<def_core_git,core git>>, presenting a high level access to
-	core git. Porcelains expose more of a <<def_SCM,SCM>>
+	<<def_core_git,core Git>>, presenting a high level access to
+	core Git. Porcelains expose more of a <<def_SCM,SCM>>
 	interface than the <<def_plumbing,plumbing>>.
 
 [[def_pull]]pull::
@@ -406,7 +406,7 @@ should not be combined with other pathspec.
 	linkgit:git-push[1].
 
 [[def_remote_tracking_branch]]remote-tracking branch::
-	A regular git <<def_branch,branch>> that is used to follow changes from
+	A regular Git <<def_branch,branch>> that is used to follow changes from
 	another <<def_repository,repository>>. A remote-tracking
 	branch should not contain direct modifications or have local commits
 	made to it. A remote-tracking branch can usually be
@@ -443,7 +443,7 @@ should not be combined with other pathspec.
 [[def_shallow_repository]]shallow repository::
 	A shallow <<def_repository,repository>> has an incomplete
 	history some of whose <<def_commit,commits>> have <<def_parent,parents>> cauterized away (in other
-	words, git is told to pretend that these commits do not have the
+	words, Git is told to pretend that these commits do not have the
 	parents, even though they are recorded in the <<def_commit_object,commit
 	object>>). This is sometimes useful when you are interested only in the
 	recent history of a project even though the real history recorded in the
@@ -464,9 +464,9 @@ should not be combined with other pathspec.
 	object of an arbitrary type (typically a tag points to either a
 	<<def_tag_object,tag>> or a <<def_commit_object,commit object>>).
 	In contrast to a <<def_head,head>>, a tag is not updated by
-	the `commit` command. A git tag has nothing to do with a Lisp
+	the `commit` command. A Git tag has nothing to do with a Lisp
 	tag (which would be called an <<def_object_type,object type>>
-	in git's context). A tag is most typically used to mark a particular
+	in Git's context). A tag is most typically used to mark a particular
 	point in the commit ancestry <<def_chain,chain>>.
 
 [[def_tag_object]]tag object::
@@ -476,7 +476,7 @@ should not be combined with other pathspec.
 	signature, in which case it is called a "signed tag object".
 
 [[def_topic_branch]]topic branch::
-	A regular git <<def_branch,branch>> that is used by a developer to
+	A regular Git <<def_branch,branch>> that is used by a developer to
 	identify a conceptual line of development. Since branches are very easy
 	and inexpensive, it is often desirable to have several small branches
 	that each contain very well defined concepts or small incremental yet
diff --git a/Documentation/howto-index.sh b/Documentation/howto-index.sh
index 8e82e52..a234086 100755
--- a/Documentation/howto-index.sh
+++ b/Documentation/howto-index.sh
@@ -5,7 +5,7 @@ Git Howto Index
 ===============
 
 Here is a collection of mailing list postings made by various
-people describing how they use git in their workflow.
+people describing how they use Git in their workflow.
 
 EOF
 
diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index ea6e4a5..8671573 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -1,7 +1,7 @@
 From: Junio C Hamano <gitster@pobox.com>
 Date: Wed, 21 Nov 2007 16:32:55 -0800
 Subject: Addendum to "MaintNotes"
-Abstract: Imagine that git development is racing along as usual, when our friendly
+Abstract: Imagine that Git development is racing along as usual, when our friendly
  neighborhood maintainer is struck down by a wayward bus. Out of the
  hordes of suckers (loyal developers), you have been tricked (chosen) to
  step up as the new maintainer. This howto will show you "how to" do it.
@@ -10,7 +10,7 @@ Content-type: text/asciidoc
 How to maintain Git
 ===================
 
-The maintainer's git time is spent on three activities.
+The maintainer's Git time is spent on three activities.
 
  - Communication (60%)
 
@@ -77,7 +77,7 @@ The policy.
    are found before new topics are merged to 'master'.
 
 
-A typical git day for the maintainer implements the above policy
+A typical Git day for the maintainer implements the above policy
 by doing the following:
 
  - Scan mailing list and #git channel log.  Respond with review
diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/new-command.txt
index 36502f6..2abc3a0 100644
--- a/Documentation/howto/new-command.txt
+++ b/Documentation/howto/new-command.txt
@@ -1,25 +1,25 @@
 From: Eric S. Raymond <esr@thyrsus.com>
 Abstract: This is how-to documentation for people who want to add extension
- commands to git.  It should be read alongside api-builtin.txt.
+ commands to Git.  It should be read alongside api-builtin.txt.
 Content-type: text/asciidoc
 
 How to integrate new subcommands
 ================================
 
 This is how-to documentation for people who want to add extension
-commands to git.  It should be read alongside api-builtin.txt.
+commands to Git.  It should be read alongside api-builtin.txt.
 
 Runtime environment
 -------------------
 
-git subcommands are standalone executables that live in the git exec
+Git subcommands are standalone executables that live in the Git exec
 path, normally /usr/lib/git-core.  The git executable itself is a
 thin wrapper that knows where the subcommands live, and runs them by
 passing command-line arguments to them.
 
-(If "git foo" is not found in the git exec path, the wrapper
+(If "git foo" is not found in the Git exec path, the wrapper
 will look in the rest of your $PATH for it.  Thus, it's possible
-to write local git extensions that don't live in system space.)
+to write local Git extensions that don't live in system space.)
 
 Implementation languages
 ------------------------
@@ -30,13 +30,13 @@ Perl.
 While we strongly encourage coding in portable C for portability,
 these specific scripting languages are also acceptable.  We won't
 accept more without a very strong technical case, as we don't want
-to broaden the git suite's required dependencies.  Import utilities,
+to broaden the Git suite's required dependencies.  Import utilities,
 surgical tools, remote helpers and other code at the edges of the
-git suite are more lenient and we allow Python (and even Tcl/tk),
+Git suite are more lenient and we allow Python (and even Tcl/tk),
 but they should not be used for core functions.
 
 This may change in the future.  Especially Python is not allowed in
-core because we need better Python integration in the git Windows
+core because we need better Python integration in the Git Windows
 installer before we can be confident people in that environment
 won't experience an unacceptably large loss of capability.
 
@@ -54,7 +54,7 @@ functions available to built-in commands written in C.
 What every extension command needs
 ----------------------------------
 
-You must have a man page, written in asciidoc (this is what git help
+You must have a man page, written in asciidoc (this is what Git help
 followed by your subcommand name will display).  Be aware that there is
 a local asciidoc configuration and macros which you should use.  It's
 often helpful to start by cloning an existing page and replacing the
@@ -74,7 +74,7 @@ Integrating a command
 ---------------------
 
 Here are the things you need to do when you want to merge a new
-subcommand into the git tree.
+subcommand into the Git tree.
 
 1. Don't forget to sign off your patch!
 
diff --git a/Documentation/howto/rebuild-from-update-hook.txt b/Documentation/howto/rebuild-from-update-hook.txt
index 00c1b45..25378f6 100644
--- a/Documentation/howto/rebuild-from-update-hook.txt
+++ b/Documentation/howto/rebuild-from-update-hook.txt
@@ -3,7 +3,7 @@ Message-ID: <7vy86o6usx.fsf@assigned-by-dhcp.cox.net>
 From: Junio C Hamano <gitster@pobox.com>
 Date: Fri, 26 Aug 2005 18:19:10 -0700
 Abstract: In this how-to article, JC talks about how he
- uses the post-update hook to automate git documentation page
+ uses the post-update hook to automate Git documentation page
  shown at http://www.kernel.org/pub/software/scm/git/docs/.
 Content-type: text/asciidoc
 
@@ -15,11 +15,11 @@ are built from Documentation/ directory of the git.git project
 and needed to be kept up-to-date.  The www.kernel.org/ servers
 are mirrored and I was told that the origin of the mirror is on
 the machine $some.kernel.org, on which I was given an account
-when I took over git maintainership from Linus.
+when I took over Git maintainership from Linus.
 
 The directories relevant to this how-to are these two:
 
-    /pub/scm/git/git.git/	The public git repository.
+    /pub/scm/git/git.git/	The public Git repository.
     /pub/software/scm/git/docs/	The HTML documentation page.
 
 So I made a repository to generate the documentation under my
@@ -46,7 +46,7 @@ script:
     EOF
 
 Initially I used to run this by hand whenever I push into the
-public git repository.  Then I did a cron job that ran twice a
+public Git repository.  Then I did a cron job that ran twice a
 day.  The current round uses the post-update hook mechanism,
 like this:
 
diff --git a/Documentation/howto/recover-corrupted-blob-object.txt b/Documentation/howto/recover-corrupted-blob-object.txt
index 7484735..6d362ce 100644
--- a/Documentation/howto/recover-corrupted-blob-object.txt
+++ b/Documentation/howto/recover-corrupted-blob-object.txt
@@ -20,7 +20,7 @@ itself doesn't actually tell you anything, in order to fix a corrupt
 object you basically have to find the "original source" for it.
 
 The easiest way to do that is almost always to have backups, and find the
-same object somewhere else. Backups really are a good idea, and git makes
+same object somewhere else. Backups really are a good idea, and Git makes
 it pretty easy (if nothing else, just clone the repository somewhere else,
 and make sure that you do *not* use a hard-linked clone, and preferably
 not the same disk/machine).
@@ -134,7 +134,7 @@ and your repository is good again!
 	git log --raw --all
 
 and just looked for the sha of the missing object (4b9458b..) in that
-whole thing. It's up to you - git does *have* a lot of information, it is
+whole thing. It's up to you - Git does *have* a lot of information, it is
 just missing one particular blob version.
 
 Trying to recreate trees and especially commits is *much* harder. So you
diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.txt
index 8a68548..075418e 100644
--- a/Documentation/howto/revert-a-faulty-merge.txt
+++ b/Documentation/howto/revert-a-faulty-merge.txt
@@ -164,7 +164,7 @@ merged. So it's debugging hell, because now you don't have lots of small
 changes that you can try to pinpoint which _part_ of it changes.
 
 But does it all work? Sure it does. You can revert a merge, and from a
-purely technical angle, git did it very naturally and had no real
+purely technical angle, Git did it very naturally and had no real
 troubles. It just considered it a change from "state before merge" to
 "state after merge", and that was it. Nothing complicated, nothing odd,
 nothing really dangerous. Git will do it without even thinking about it.
diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index e49d785..7f4943e 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -1,9 +1,9 @@
 From: Rutger Nijlunsing <rutger@nospam.com>
-Subject: Setting up a git repository which can be pushed into and pulled from over HTTP(S).
+Subject: Setting up a Git repository which can be pushed into and pulled from over HTTP(S).
 Date: Thu, 10 Aug 2006 22:00:26 +0200
 Content-type: text/asciidoc
 
-How to setup git server over http
+How to setup Git server over http
 =================================
 
 Since Apache is one of those packages people like to compile
@@ -44,9 +44,9 @@ What's needed:
 
 - have permissions to chown a directory
 
-- have git installed on the client, and
+- have Git installed on the client, and
 
-- either have git installed on the server or have a webdav client on
+- either have Git installed on the server or have a webdav client on
   the client.
 
 In effect, this means you're going to be root, or that you're using a
@@ -57,7 +57,7 @@ Step 1: setup a bare Git repository
 -----------------------------------
 
 At the time of writing, git-http-push cannot remotely create a Git
-repository. So we have to do that at the server side with git. Another
+repository. So we have to do that at the server side with Git. Another
 option is to generate an empty bare repository at the client and copy
 it to the server with a WebDAV client (which is the only option if Git
 is not installed on the server).
@@ -189,7 +189,7 @@ http://<servername>/my-new-repo.git [x] Open as webfolder -> login .
 Step 3: setup the client
 ------------------------
 
-Make sure that you have HTTP support, i.e. your git was built with
+Make sure that you have HTTP support, i.e. your Git was built with
 libcurl (version more recent than 7.10). The command 'git http-push' with
 no argument should display a usage message.
 
@@ -268,7 +268,7 @@ Reading /usr/local/apache2/logs/error_log is often helpful.
 
   On Debian: Read /var/log/apache2/error.log instead.
 
-If you access HTTPS locations, git may fail verifying the SSL
+If you access HTTPS locations, Git may fail verifying the SSL
 certificate (this is return code 60). Setting http.sslVerify=false can
 help diagnosing the problem, but removes security checks.
 
diff --git a/Documentation/howto/use-git-daemon.txt b/Documentation/howto/use-git-daemon.txt
index 23cdf35..7af2e52 100644
--- a/Documentation/howto/use-git-daemon.txt
+++ b/Documentation/howto/use-git-daemon.txt
@@ -4,7 +4,7 @@ How to use git-daemon
 =====================
 
 Git can be run in inetd mode and in stand alone mode. But all you want is
-let a coworker pull from you, and therefore need to set up a git server
+let a coworker pull from you, and therefore need to set up a Git server
 real quick, right?
 
 Note that git-daemon is not really chatty at the moment, especially when
diff --git a/Documentation/howto/using-signed-tag-in-pull-request.txt b/Documentation/howto/using-signed-tag-in-pull-request.txt
index 00f693b..bbf040e 100644
--- a/Documentation/howto/using-signed-tag-in-pull-request.txt
+++ b/Documentation/howto/using-signed-tag-in-pull-request.txt
@@ -23,7 +23,7 @@ Earlier, a typical pull request may have started like this:
 
    Froboz 3.2 (2011-09-30 14:20:57 -0700)
 
- are available in the git repository at:
+ are available in the Git repository at:
 
    example.com:/git/froboz.git for-xyzzy
 ------------
@@ -107,7 +107,7 @@ The resulting msg.txt file begins like so:
 
    Froboz 3.2 (2011-09-30 14:20:57 -0700)
 
- are available in the git repository at:
+ are available in the Git repository at:
 
    example.com:/git/froboz.git tags/frotz-for-xyzzy
 
diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index 625d315..e9a1d5d 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -1,9 +1,9 @@
-At the core level, git is character encoding agnostic.
+At the core level, Git is character encoding agnostic.
 
  - The pathnames recorded in the index and in the tree objects
    are treated as uninterpreted sequences of non-NUL bytes.
    What readdir(2) returns are what are recorded and compared
-   with the data git keeps track of, which in turn are expected
+   with the data Git keeps track of, which in turn are expected
    to be what lstat(2) and creat(2) accepts.  There is no such
    thing as pathname encoding translation.
 
@@ -15,9 +15,9 @@ At the core level, git is character encoding agnostic.
    bytes.
 
 Although we encourage that the commit log messages are encoded
-in UTF-8, both the core and git Porcelain are designed not to
+in UTF-8, both the core and Git Porcelain are designed not to
 force UTF-8 on projects.  If all participants of a particular
-project find it more convenient to use legacy encodings, git
+project find it more convenient to use legacy encodings, Git
 does not forbid it.  However, there are a few things to keep in
 mind.
 
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 9bb4956..897329b 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -17,10 +17,10 @@ merge.defaultToUpstream::
 	these tracking branches are merged.
 
 merge.ff::
-	By default, git does not create an extra merge commit when merging
+	By default, Git does not create an extra merge commit when merging
 	a commit that is a descendant of the current commit. Instead, the
 	tip of the current branch is fast-forwarded. When set to `false`,
-	this variable tells git to create an extra merge commit in such
+	this variable tells Git to create an extra merge commit in such
 	a case (equivalent to giving the `--no-ff` option from the command
 	line). When set to `only`, only such fast-forward merges are
 	allowed (equivalent to giving the `--ff-only` option from the
@@ -38,10 +38,10 @@ merge.renameLimit::
 	diff.renameLimit.
 
 merge.renormalize::
-	Tell git that canonical representation of files in the
+	Tell Git that canonical representation of files in the
 	repository has changed over time (e.g. earlier commits record
 	text files with CRLF line endings, but recent ones use LF line
-	endings).  In such a repository, git can convert the data
+	endings).  In such a repository, Git can convert the data
 	recorded in commits to a canonical form before performing a
 	merge to reduce unnecessary conflicts.  For more information,
 	see section "Merging branches with differing checkin/checkout
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 1ec14a0..3bdbf5e 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -649,7 +649,7 @@ together.
 Object Traversal
 ~~~~~~~~~~~~~~~~
 
-These options are mostly targeted for packing of git repositories.
+These options are mostly targeted for packing of Git repositories.
 
 --objects::
 
@@ -717,7 +717,7 @@ format, often found in E-mail messages.
 +
 `--date=short` shows only date but not time, in `YYYY-MM-DD` format.
 +
-`--date=raw` shows the date in the internal raw git format `%s %z` format.
+`--date=raw` shows the date in the internal raw Git format `%s %z` format.
 +
 `--date=default` shows timestamps in the original timezone
 (either committer's or author's).
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 991fcd8..678d175 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -23,7 +23,7 @@ blobs contained in a commit.
   A symbolic ref name.  E.g. 'master' typically means the commit
   object referenced by 'refs/heads/master'.  If you
   happen to have both 'heads/master' and 'tags/master', you can
-  explicitly say 'heads/master' to tell git which one you mean.
+  explicitly say 'heads/master' to tell Git which one you mean.
   When ambiguous, a '<refname>' is disambiguated by taking the
   first match in the following rules:
 
-- 
1.8.0.msysgit.0


---
Thomas
