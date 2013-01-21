From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v3 5/6] Change 'git' to 'Git' whenever the whole system is
 referred to #4
Date: Mon, 21 Jan 2013 20:22:52 +0100 (CET)
Message-ID: <1199035912.632874.1358796172804.JavaMail.ngmail@webmail20.arcor-online.net>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net> <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net> <7vvcark1f2.fsf@alter.siamese.dyndns.org> <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: davvid@gmail.com, git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Mon Jan 21 20:23:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMxl-0006su-G6
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756182Ab3AUTW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 14:22:57 -0500
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:50819 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756048Ab3AUTWz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 14:22:55 -0500
Received: from mail-in-20-z2.arcor-online.net (mail-in-20-z2.arcor-online.net [151.189.8.85])
	by mx.arcor.de (Postfix) with ESMTP id DDB6E2D68CC;
	Mon, 21 Jan 2013 20:22:53 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-20-z2.arcor-online.net (Postfix) with ESMTP id D7DF8834010;
	Mon, 21 Jan 2013 20:22:53 +0100 (CET)
Received: from webmail20.arcor-online.net (webmail20.arcor-online.net [151.189.8.201])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 1352C3050D;
	Mon, 21 Jan 2013 20:22:53 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-02.arcor-online.net 1352C3050D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1358796173; bh=MPn9QnOgk3zNyBTHxhIYqau8GCfHzX6EIXuGvK6uo1U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=uR+rJAvh6M8X0nhaIyFLwLkFhcoZqbYVZbpRrDzp2G/6rqQlZ1B1Zhj1hXn/URuCp
	 R8KDlw6otfGS8u0m5W/TveGBh5Wo55bbXTJx/fkkW4Ki2SNt+CbfOGuBM3tShU4t6o
	 7w2zMRZq/8QLfhNxc9+RdbGMcRQj4ZrcIl9a3Whc=
Received: from [188.105.98.86] by webmail20.arcor-online.net (151.189.8.201) with HTTP (Arcor Webmail); Mon, 21 Jan 2013 20:22:52 +0100 (CET)
In-Reply-To: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.98.86
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214151>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---

diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index aeb0cdc..2934ac2 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -19,7 +19,7 @@ important than any other.  However, you can emulate the CVS model by
 designating a single shared repository which people can synchronize with;
 this document explains how to do that.
 
-Some basic familiarity with git is required. Having gone through
+Some basic familiarity with Git is required. Having gone through
 linkgit:gittutorial[7] and
 linkgit:gitglossary[7] should be sufficient.
 
@@ -81,7 +81,7 @@ other than `master`.
 Setting Up a Shared Repository
 ------------------------------
 
-We assume you have already created a git repository for your project,
+We assume you have already created a Git repository for your project,
 possibly created from scratch or from a tarball (see
 linkgit:gittutorial[7]), or imported from an already existing CVS
 repository (see the next section).
@@ -101,7 +101,7 @@ Next, give every team member read/write access to this repository.  One
 easy way to do this is to give all the team members ssh access to the
 machine where the repository is hosted.  If you don't want to give them a
 full shell on the machine, there is a restricted shell which only allows
-users to do git pushes and pulls; see linkgit:git-shell[1].
+users to do Git pushes and pulls; see linkgit:git-shell[1].
 
 Put all the committers in the same group, and make the repository
 writable by that group:
@@ -125,7 +125,7 @@ of the project you are interested in and run linkgit:git-cvsimport[1]:
 $ git cvsimport -C <destination> <module>
 -------------------------------------------
 
-This puts a git archive of the named CVS module in the directory
+This puts a Git archive of the named CVS module in the directory
 <destination>, which will be created if necessary.
 
 The import checks out from CVS every revision of every file.  Reportedly
@@ -133,8 +133,8 @@ cvsimport can average some twenty revisions per second, so for a
 medium-sized project this should not take more than a couple of minutes.
 Larger projects or remote repositories may take longer.
 
-The main trunk is stored in the git branch named `origin`, and additional
-CVS branches are stored in git branches with the same names.  The most
+The main trunk is stored in the Git branch named `origin`, and additional
+CVS branches are stored in Git branches with the same names.  The most
 recent version of the main trunk is also left checked out on the `master`
 branch, so you can start adding your own changes right away.
 
@@ -160,10 +160,10 @@ You can enforce finer grained permissions using update hooks.  See
 link:howto/update-hook-example.txt[Controlling access to branches using
 update hooks].
 
-Providing CVS Access to a git Repository
+Providing CVS Access to a Git Repository
 ----------------------------------------
 
-It is also possible to provide true CVS access to a git repository, so
+It is also possible to provide true CVS access to a Git repository, so
 that developers can still use CVS; see linkgit:git-cvsserver[1] for
 details.
 
@@ -171,8 +171,8 @@ Alternative Development Models
 ------------------------------
 
 CVS users are accustomed to giving a group of developers commit access to
-a common repository.  As we've seen, this is also possible with git.
-However, the distributed nature of git allows other development models,
+a common repository.  As we've seen, this is also possible with Git.
+However, the distributed nature of Git allows other development models,
 and you may want to first consider whether one of them might be a better
 fit for your project.
 
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index daf1782..4ed71c7 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -254,7 +254,7 @@ pattern.  Filepairs that match a glob pattern on an earlier line
 in the file are output before ones that match a later line, and
 filepairs that do not match any glob pattern are output last.
 
-As an example, a typical orderfile for the core git probably
+As an example, a typical orderfile for the core Git probably
 would look like this:
 
 ------------------------------------------------
diff --git a/Documentation/gitglossary.txt b/Documentation/gitglossary.txt
index 6d7b195..e52de7d 100644
--- a/Documentation/gitglossary.txt
+++ b/Documentation/gitglossary.txt
@@ -19,7 +19,7 @@ SEE ALSO
 linkgit:gittutorial[7],
 linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
-link:everyday.html[Everyday git],
+link:everyday.html[Everyday Git],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/technical/api-builtin.txt b/Documentation/technical/api-builtin.txt
index b0cafe8..2d27ff1 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -23,7 +23,7 @@ where options is the bitwise-or of:
 
 `RUN_SETUP`::
 
-	Make sure there is a git directory to work on, and if there is a
+	Make sure there is a Git directory to work on, and if there is a
 	work tree, chdir to the top of it if the command was invoked
 	in a subdirectory.  If there is no work tree, no chdir() is
 	done.
diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index edf8dfb..230b3a0 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -1,7 +1,7 @@
 config API
 ==========
 
-The config API gives callers a way to access git configuration files
+The config API gives callers a way to access Git configuration files
 (and files which have the same syntax). See linkgit:git-config[1] for a
 discussion of the config file syntax.
 
@@ -12,7 +12,7 @@ Config files are parsed linearly, and each variable found is passed to a
 caller-provided callback function. The callback function is responsible
 for any actions to be taken on the config option, and is free to ignore
 some options. It is not uncommon for the configuration to be parsed
-several times during the run of a git program, with different callbacks
+several times during the run of a Git program, with different callbacks
 picking out different variables useful to themselves.
 
 A config callback function takes three parameters:
@@ -36,7 +36,7 @@ Basic Config Querying
 ---------------------
 
 Most programs will simply want to look up variables in all config files
-that git knows about, using the normal precedence rules. To do this,
+that Git knows about, using the normal precedence rules. To do this,
 call `git_config` with a callback function and void data pointer.
 
 `git_config` will read all config sources in order of increasing
@@ -49,7 +49,7 @@ value is left at the end).
 
 The `git_config_with_options` function lets the caller examine config
 while adjusting some of the default behavior of `git_config`. It should
-almost never be used by "regular" git code that is looking up
+almost never be used by "regular" Git code that is looking up
 configuration variables. It is intended for advanced callers like
 `git-config`, which are intentionally tweaking the normal config-lookup
 process. It takes two extra parameters:
@@ -66,7 +66,7 @@ Regular `git_config` defaults to `1`.
 There is a special version of `git_config` called `git_config_early`.
 This version takes an additional parameter to specify the repository
 config, instead of having it looked up via `git_path`. This is useful
-early in a git program before the repository has been found. Unless
+early in a Git program before the repository has been found. Unless
 you're working with early setup code, you probably don't want to use
 this.
 
diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 5977b58..f0c39e1 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -7,9 +7,9 @@ world can take many forms, in this document the word "credential" always
 refers to a username and password pair).
 
 This document describes two interfaces: the C API that the credential
-subsystem provides to the rest of git, and the protocol that git uses to
+subsystem provides to the rest of Git, and the protocol that Git uses to
 communicate with system-specific "credential helpers". If you are
-writing git code that wants to look up or prompt for credentials, see
+writing Git code that wants to look up or prompt for credentials, see
 the section "C API" below. If you want to write your own helper, see
 the section on "Credential Helpers" below.
 
@@ -31,7 +31,7 @@ Typical setup
 +-----------------------+
 ------------
 
-The git code (typically a remote-helper) will call the C API to obtain
+The Git code (typically a remote-helper) will call the C API to obtain
 credential data like a login/password pair (credential_fill). The
 API will itself call a remote helper (e.g. "git credential-cache" or
 "git credential-store") that may retrieve credential data from a
@@ -42,7 +42,7 @@ contacting the server, and does the actual authentication.
 C API
 -----
 
-The credential C API is meant to be called by git code which needs to
+The credential C API is meant to be called by Git code which needs to
 acquire or store a credential. It is centered around an object
 representing a single credential and provides three basic operations:
 fill (acquire credentials by calling helpers and/or prompting the user),
@@ -177,14 +177,14 @@ int foo_login(struct foo_connection *f)
 Credential Helpers
 ------------------
 
-Credential helpers are programs executed by git to fetch or save
+Credential helpers are programs executed by Git to fetch or save
 credentials from and to long-term storage (where "long-term" is simply
-longer than a single git process; e.g., credentials may be stored
+longer than a single Git process; e.g., credentials may be stored
 in-memory for a few minutes, or indefinitely on disk).
 
 Each helper is specified by a single string in the configuration
 variable `credential.helper` (and others, see linkgit:git-config[1]).
-The string is transformed by git into a command to be executed using
+The string is transformed by Git into a command to be executed using
 these rules:
 
   1. If the helper string begins with "!", it is considered a shell
@@ -248,7 +248,7 @@ FORMAT` in linkgit:git-credential[7] for a detailed specification).
 For a `get` operation, the helper should produce a list of attributes
 on stdout in the same format. A helper is free to produce a subset, or
 even no values at all if it has nothing useful to provide. Any provided
-attributes will overwrite those already known about by git.
+attributes will overwrite those already known about by Git.
 
 For a `store` or `erase` operation, the helper's output is ignored.
 If it fails to perform the requested operation, it may complain to
diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index 944fc39..fa2c5d5 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -39,7 +39,7 @@ The notable options are:
 
 `DIR_NO_GITLINKS`:::
 
-	If set, recurse into a directory that looks like a git
+	If set, recurse into a directory that looks like a Git
 	directory.  Otherwise it is shown as a directory.
 
 The result of the enumeration is left in these fields:
diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 3062389..32ddc1c 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -1,7 +1,7 @@
 parse-options API
 =================
 
-The parse-options API is used to parse and massage options in git
+The parse-options API is used to parse and massage options in Git
 and to provide a usage help with consistent look.
 
 Basics
diff --git a/Documentation/technical/api-remote.txt b/Documentation/technical/api-remote.txt
index c54b17d..2819d3a 100644
--- a/Documentation/technical/api-remote.txt
+++ b/Documentation/technical/api-remote.txt
@@ -3,7 +3,7 @@ Remotes configuration API
 
 The API in remote.h gives access to the configuration related to
 remotes. It handles all three configuration mechanisms historically
-and currently used by git, and presents the information in a uniform
+and currently used by Git, and presents the information in a uniform
 fashion. Note that the code also handles plain URLs without any
 configuration, giving them just the default information.
 
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 6a05ee2..27c716b 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -1,7 +1,7 @@
 Git index format
 ================
 
-== The git index file has the following format
+== The Git index file has the following format
 
   All binary numbers are in network byte order. Version 2 is described
   here unless stated otherwise.
diff --git a/Documentation/technical/pack-heuristics.txt b/Documentation/technical/pack-heuristics.txt
index 103eb5d..67772f1 100644
--- a/Documentation/technical/pack-heuristics.txt
+++ b/Documentation/technical/pack-heuristics.txt
@@ -5,11 +5,11 @@
 
                   Where do I go
                to learn the details
-	    of git's packing heuristics?
+	    of Git's packing heuristics?
 
 Be careful what you ask!
 
-Followers of the git, please open the git IRC Log and turn to
+Followers of the Git, please open the Git IRC Log and turn to
 February 10, 2006.
 
 It's a rare occasion, and we are joined by the King Git Himself,
@@ -19,7 +19,7 @@ and seeks enlightenment.  Others are present, but silent.
 Let's listen in!
 
     <njs`> Oh, here's a really stupid question -- where do I go to
-        learn the details of git's packing heuristics?  google avails
+        learn the details of Git's packing heuristics?  google avails
         me not, reading the source didn't help a lot, and wading
         through the whole mailing list seems less efficient than any
         of that.
@@ -37,7 +37,7 @@ Ah!  Modesty after all.
 
     <linus> njs, I don't think the docs exist. That's something where
 	 I don't think anybody else than me even really got involved.
-	 Most of the rest of git others have been busy with (especially
+	 Most of the rest of Git others have been busy with (especially
 	 Junio), but packing nobody touched after I did it.
 
 It's cryptic, yet vague.  Linus in style for sure.  Wise men
@@ -57,7 +57,7 @@ Bait...
 
 And switch.  That ought to do it!
 
-    <linus> Remember: git really doesn't follow files. So what it does is
+    <linus> Remember: Git really doesn't follow files. So what it does is
         - generate a list of all objects
         - sort the list according to magic heuristics
         - walk the list, using a sliding window, seeing if an object
@@ -382,7 +382,7 @@ The 'net never forgets, so that should be good until the end of time.
     <njs`> (if only it happened more...)
 
     <linus> Anyway, the pack-file could easily be denser still, but
-        because it's used both for streaming (the git protocol) and
+        because it's used both for streaming (the Git protocol) and
         for on-disk, it has a few pessimizations.
 
 Actually, it is a made-up word. But it is a made-up word being
@@ -432,12 +432,12 @@ Gasp!  OK, saved.  That's a fair Engineering trade off.  Close call!
 In fact, Linus reflects on some Basic Engineering Fundamentals,
 design options, etc.
 
-    <linus> More importantly, they allow git to still _conceptually_
+    <linus> More importantly, they allow Git to still _conceptually_
         never deal with deltas at all, and be a "whole object" store.
 
         Which has some problems (we discussed bad huge-file
-        behaviour on the git lists the other day), but it does mean
-        that the basic git concepts are really really simple and
+        behaviour on the Git lists the other day), but it does mean
+        that the basic Git concepts are really really simple and
         straightforward.
 
         It's all been quite stable.
@@ -461,6 +461,6 @@ Nuff said.
     <njs`> :-)
 
     <njs`> appreciate the infodump, I really was failing to find the
-        details on git packs :-)
+        details on Git packs :-)
 
 And now you know the rest of the story.
diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
index 53aa0c8..6dc82ca 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -1,21 +1,21 @@
-Use of index and Racy git problem
+Use of index and Racy Git problem
 =================================
 
 Background
 ----------
 
-The index is one of the most important data structures in git.
+The index is one of the most important data structures in Git.
 It represents a virtual working tree state by recording list of
 paths and their object names and serves as a staging area to
 write out the next tree object to be committed.  The state is
 "virtual" in the sense that it does not necessarily have to, and
 often does not, match the files in the working tree.
 
-There are cases git needs to examine the differences between the
+There are cases Git needs to examine the differences between the
 virtual working tree state in the index and the files in the
 working tree.  The most obvious case is when the user asks `git
 diff` (or its low level implementation, `git diff-files`) or
-`git-ls-files --modified`.  In addition, git internally checks
+`git-ls-files --modified`.  In addition, Git internally checks
 if the files in the working tree are different from what are
 recorded in the index to avoid stomping on local changes in them
 during patch application, switching branches, and merging.
@@ -24,16 +24,16 @@ In order to speed up this comparison between the files in the
 working tree and the index entries, the index entries record the
 information obtained from the filesystem via `lstat(2)` system
 call when they were last updated.  When checking if they differ,
-git first runs `lstat(2)` on the files and compares the result
+Git first runs `lstat(2)` on the files and compares the result
 with this information (this is what was originally done by the
 `ce_match_stat()` function, but the current code does it in
 `ce_match_stat_basic()` function).  If some of these "cached
-stat information" fields do not match, git can tell that the
+stat information" fields do not match, Git can tell that the
 files are modified without even looking at their contents.
 
 Note: not all members in `struct stat` obtained via `lstat(2)`
 are used for this comparison.  For example, `st_atime` obviously
-is not useful.  Currently, git compares the file type (regular
+is not useful.  Currently, Git compares the file type (regular
 files vs symbolic links) and executable bits (only for regular
 files) from `st_mode` member, `st_mtime` and `st_ctime`
 timestamps, `st_uid`, `st_gid`, `st_ino`, and `st_size` members.
@@ -49,7 +49,7 @@ of git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
 ([PATCH] Sync in core time granuality with filesystems,
 2005-01-04).
 
-Racy git
+Racy Git
 --------
 
 There is one slight problem with the optimization based on the
@@ -67,13 +67,13 @@ timestamp does not change, after this sequence, the cached stat
 information the index entry records still exactly match what you
 would see in the filesystem, even though the file `foo` is now
 different.
-This way, git can incorrectly think files in the working tree
+This way, Git can incorrectly think files in the working tree
 are unmodified even though they actually are.  This is called
-the "racy git" problem (discovered by Pasky), and the entries
+the "racy Git" problem (discovered by Pasky), and the entries
 that appear clean when they may not be because of this problem
 are called "racily clean".
 
-To avoid this problem, git does two things:
+To avoid this problem, Git does two things:
 
 . When the cached stat information says the file has not been
   modified, and the `st_mtime` is the same as (or newer than)
@@ -116,7 +116,7 @@ timestamp comparison check done with the former logic anymore.
 The latter makes sure that the cached stat information for `foo`
 would never match with the file in the working tree, so later
 checks by `ce_match_stat_basic()` would report that the index entry
-does not match the file and git does not have to fall back on more
+does not match the file and Git does not have to fall back on more
 expensive `ce_modified_check_fs()`.
 
 
@@ -159,7 +159,7 @@ of the cached stat information.
 Avoiding runtime penalty
 ------------------------
 
-In order to avoid the above runtime penalty, post 1.4.2 git used
+In order to avoid the above runtime penalty, post 1.4.2 Git used
 to have a code that made sure the index file
 got timestamp newer than the youngest files in the index when
 there are many young files with the same timestamp as the
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index 00f7e79..282758e 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -6,7 +6,7 @@ REMOTES[[REMOTES]]
 The name of one of the following can be used instead
 of a URL as `<repository>` argument:
 
-* a remote in the git configuration file: `$GIT_DIR/config`,
+* a remote in the Git configuration file: `$GIT_DIR/config`,
 * a file in the `$GIT_DIR/remotes` directory, or
 * a file in the `$GIT_DIR/branches` directory.
 
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 1d15ee7..a2cf68b 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -46,7 +46,7 @@ These two syntaxes are mostly equivalent, except the former implies
 --local option.
 endif::git-clone[]
 
-When git doesn't know how to handle a certain transport protocol, it
+When Git doesn't know how to handle a certain transport protocol, it
 attempts to use the 'remote-<transport>' remote helper, if one
 exists. To explicitly request a remote helper, the following syntax
 may be used:
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index c93e1a8..dda262a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -5,7 +5,7 @@ ______________________________________________
 Git is a fast distributed revision control system.
 
 This manual is designed to be readable by someone with basic UNIX
-command-line skills, but no previous knowledge of git.
+command-line skills, but no previous knowledge of Git.
 
 <<repositories-and-branches>> and <<exploring-git-history>> explain how
 to fetch and study a project using git--read these chapters to learn how
@@ -34,7 +34,7 @@ $ git help clone
 With the latter, you can use the manual viewer of your choice; see
 linkgit:git-help[1] for more information.
 
-See also <<git-quick-start>> for a brief overview of git commands,
+See also <<git-quick-start>> for a brief overview of Git commands,
 without any explanation.
 
 Finally, see <<todo>> for ways that you can help make this manual more
@@ -46,10 +46,10 @@ Repositories and Branches
 =========================
 
 [[how-to-get-a-git-repository]]
-How to get a git repository
+How to get a Git repository
 ---------------------------
 
-It will be useful to have a git repository to experiment with as you
+It will be useful to have a Git repository to experiment with as you
 read this manual.
 
 The best way to get one is by using the linkgit:git-clone[1] command to
@@ -57,7 +57,7 @@ download a copy of an existing repository.  If you don't already have a
 project in mind, here are some interesting examples:
 
 ------------------------------------------------
-	# git itself (approx. 10MB download):
+	# Git itself (approx. 10MB download):
 $ git clone git://git.kernel.org/pub/scm/git/git.git
 	# the Linux kernel (approx. 150MB download):
 $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
@@ -79,7 +79,7 @@ How to check out a different version of a project
 
 Git is best thought of as a tool for storing the history of a collection
 of files.  It stores the history as a compressed collection of
-interrelated snapshots of the project's contents.  In git each such
+interrelated snapshots of the project's contents.  In Git each such
 version is called a <<def_commit,commit>>.
 
 Those snapshots aren't necessarily all arranged in a single line from
@@ -87,7 +87,7 @@ oldest to newest; instead, work may simultaneously proceed along
 parallel lines of development, called <<def_branch,branches>>, which may
 merge and diverge.
 
-A single git repository can track development on multiple branches.  It
+A single Git repository can track development on multiple branches.  It
 does this by keeping a list of <<def_head,heads>> which reference the
 latest commit on each branch; the linkgit:git-branch[1] command shows
 you the list of branch heads:
@@ -198,7 +198,7 @@ has that commit at all).  Since the object name is computed as a hash over the
 contents of the commit, you are guaranteed that the commit can never change
 without its name also changing.
 
-In fact, in <<git-concepts>> we shall see that everything stored in git
+In fact, in <<git-concepts>> we shall see that everything stored in Git
 history, including file data and directory contents, is stored in an object
 with a name that is a hash of its contents.
 
@@ -211,7 +211,7 @@ parent commit which shows what happened before this commit.
 Following the chain of parents will eventually take you back to the
 beginning of the project.
 
-However, the commits do not form a simple list; git allows lines of
+However, the commits do not form a simple list; Git allows lines of
 development to diverge and then reconverge, and the point where two
 lines of development reconverge is called a "merge".  The commit
 representing a merge can therefore have more than one parent, with
@@ -219,8 +219,8 @@ each parent representing the most recent commit on one of the lines
 of development leading to that point.
 
 The best way to see how this works is using the linkgit:gitk[1]
-command; running gitk now on a git repository and looking for merge
-commits will help understand how the git organizes history.
+command; running gitk now on a Git repository and looking for merge
+commits will help understand how the Git organizes history.
 
 In the following, we say that commit X is "reachable" from commit Y
 if commit X is an ancestor of commit Y.  Equivalently, you could say
@@ -231,7 +231,7 @@ leading from commit Y to commit X.
 Understanding history: History diagrams
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-We will sometimes represent git history using diagrams like the one
+We will sometimes represent Git history using diagrams like the one
 below.  Commits are shown as "o", and the links between them with
 lines drawn with - / and \.  Time goes left to right:
 
@@ -285,7 +285,7 @@ git branch -D <branch>::
 	even if the branch points to a commit not reachable
 	from the current branch, you may know that that commit
 	is still reachable from some other branch or tag.  In that
-	case it is safe to use this command to force git to delete
+	case it is safe to use this command to force Git to delete
 	the branch.
 git checkout <branch>::
 	make the current branch <branch>, updating the working
@@ -295,7 +295,7 @@ git checkout -b <new> <start-point>::
 	check it out.
 
 The special symbol "HEAD" can always be used to refer to the current
-branch.  In fact, git uses a file named "HEAD" in the .git directory to
+branch.  In fact, Git uses a file named "HEAD" in the .git directory to
 remember which branch is current:
 
 ------------------------------------------------
@@ -377,7 +377,7 @@ $ git checkout -b my-todo-copy origin/todo
 You can also check out "origin/todo" directly to examine it or
 write a one-off patch.  See <<detached-head,detached head>>.
 
-Note that the name "origin" is just the name that git uses by default
+Note that the name "origin" is just the name that Git uses by default
 to refer to the repository that you cloned from.
 
 [[how-git-stores-references]]
@@ -405,7 +405,7 @@ As another useful shortcut, the "HEAD" of a repository can be referred
 to just using the name of that repository.  So, for example, "origin"
 is usually a shortcut for the HEAD branch in the repository "origin".
 
-For the complete list of paths which git checks for references, and
+For the complete list of paths which Git checks for references, and
 the order it uses to decide which to choose when there are multiple
 references with the same shorthand name, see the "SPECIFYING
 REVISIONS" section of linkgit:gitrevisions[7].
@@ -449,7 +449,7 @@ origin/master
 If you run "git fetch <remote>" later, the remote-tracking branches for the
 named <remote> will be updated.
 
-If you examine the file .git/config, you will see that git has added
+If you examine the file .git/config, you will see that Git has added
 a new stanza:
 
 -------------------------------------------------
@@ -461,13 +461,13 @@ $ cat .git/config
 ...
 -------------------------------------------------
 
-This is what causes git to track the remote's branches; you may modify
+This is what causes Git to track the remote's branches; you may modify
 or delete these configuration options by editing .git/config with a
 text editor.  (See the "CONFIGURATION FILE" section of
 linkgit:git-config[1] for details.)
 
 [[exploring-git-history]]
-Exploring git history
+Exploring Git history
 =====================
 
 Git is best thought of as a tool for storing the history of a
@@ -499,7 +499,7 @@ Bisecting: 3537 revisions left to test after this
 [65934a9a028b88e83e2b0f8b36618fe503349f8e] BLOCK: Make USB storage depend on SCSI rather than selecting it [try #6]
 -------------------------------------------------
 
-If you run "git branch" at this point, you'll see that git has
+If you run "git branch" at this point, you'll see that Git has
 temporarily moved you in "(no branch)". HEAD is now detached from any
 branch and points directly to a commit (with commit id 65934...) that
 is reachable from "master" but not from v2.6.18. Compile and test it,
@@ -511,7 +511,7 @@ Bisecting: 1769 revisions left to test after this
 [7eff82c8b1511017ae605f0c99ac275a7e21b867] i2c-core: Drop useless bitmaskings
 -------------------------------------------------
 
-checks out an older version.  Continue like this, telling git at each
+checks out an older version.  Continue like this, telling Git at each
 stage whether the version it gives you is good or bad, and notice
 that the number of revisions left to test is cut approximately in
 half each time.
@@ -549,14 +549,14 @@ then test, run "bisect good" or "bisect bad" as appropriate, and
 continue.
 
 Instead of "git bisect visualize" and then "git reset --hard
-fb47ddb2db...", you might just want to tell git that you want to skip
+fb47ddb2db...", you might just want to tell Git that you want to skip
 the current commit:
 
 -------------------------------------------------
 $ git bisect skip
 -------------------------------------------------
 
-In this case, though, git may not eventually be able to tell the first
+In this case, though, Git may not eventually be able to tell the first
 bad one between some first skipped commits and a later bad commit.
 
 There are also ways to automate the bisecting process if you have a
@@ -685,7 +685,7 @@ See the "--pretty" option in the linkgit:git-log[1] man page for more
 display options.
 
 Note that git log starts with the most recent commit and works
-backwards through the parents; however, since git history can contain
+backwards through the parents; however, since Git history can contain
 multiple independent lines of development, the particular order that
 commits are listed in may be somewhat arbitrary.
 
@@ -732,7 +732,7 @@ $ git show v2.5:fs/locks.c
 -------------------------------------------------
 
 Before the colon may be anything that names a commit, and after it
-may be any path to a file tracked by git.
+may be any path to a file tracked by Git.
 
 [[history-examples]]
 Examples
@@ -984,14 +984,14 @@ student.  The linkgit:git-log[1], linkgit:git-diff-tree[1], and
 linkgit:git-hash-object[1] man pages may prove helpful.
 
 [[Developing-With-git]]
-Developing with git
+Developing with Git
 ===================
 
 [[telling-git-your-name]]
-Telling git your name
+Telling Git your name
 ---------------------
 
-Before creating any commits, you should introduce yourself to git.  The
+Before creating any commits, you should introduce yourself to Git.  The
 easiest way to do so is to make sure the following lines appear in a
 file named .gitconfig in your home directory:
 
@@ -1035,13 +1035,13 @@ Creating a new commit takes three steps:
 
 	1. Making some changes to the working directory using your
 	   favorite editor.
-	2. Telling git about your changes.
-	3. Creating the commit using the content you told git about
+	2. Telling Git about your changes.
+	3. Creating the commit using the content you told Git about
 	   in step 2.
 
 In practice, you can interleave and repeat steps 1 and 2 as many
 times as you want: in order to keep track of what you want committed
-at step 3, git maintains a snapshot of the tree's contents in a
+at step 3, Git maintains a snapshot of the tree's contents in a
 special staging area called "the index."
 
 At the beginning, the content of the index will be identical to
@@ -1094,7 +1094,7 @@ When you're ready, just run
 $ git commit
 -------------------------------------------------
 
-and git will prompt you for a commit message and then create the new
+and Git will prompt you for a commit message and then create the new
 commit.  Check to make sure it looks like what you expected with
 
 -------------------------------------------------
@@ -1138,7 +1138,7 @@ with a single short (less than 50 character) line summarizing the
 change, followed by a blank line and then a more thorough
 description.  The text up to the first blank line in a commit
 message is treated as the commit title, and that title is used
-throughout git.  For example, linkgit:git-format-patch[1] turns a
+throughout Git.  For example, linkgit:git-format-patch[1] turns a
 commit into email, and it uses the title on the Subject line and the
 rest of the commit in the body.
 
@@ -1147,15 +1147,15 @@ rest of the commit in the body.
 Ignoring files
 --------------
 
-A project will often generate files that you do 'not' want to track with git.
+A project will often generate files that you do 'not' want to track with Git.
 This typically includes files generated by a build process or temporary
-backup files made by your editor. Of course, 'not' tracking files with git
+backup files made by your editor. Of course, 'not' tracking files with Git
 is just a matter of 'not' calling `git add` on them. But it quickly becomes
 annoying to have these untracked files lying around; e.g. they make
 `git add .` practically useless, and they keep showing up in the output of
 `git status`.
 
-You can tell git to ignore certain files by creating a file called .gitignore
+You can tell Git to ignore certain files by creating a file called .gitignore
 in the top level of your working directory, with contents such as:
 
 -------------------------------------------------
@@ -1181,7 +1181,7 @@ for other users who clone your repository.
 If you wish the exclude patterns to affect only certain repositories
 (instead of every repository for a given project), you may instead put
 them in a file in your repository named .git/info/exclude, or in any file
-specified by the `core.excludesfile` configuration variable.  Some git
+specified by the `core.excludesfile` configuration variable.  Some Git
 commands can also take exclude patterns directly on the command line.
 See linkgit:gitignore[5] for the details.
 
@@ -1227,7 +1227,7 @@ Automatic merge failed; fix conflicts and then commit the result.
 
 Conflict markers are left in the problematic files, and after
 you resolve the conflicts manually, you can update the index
-with the contents and run git commit, as you normally would when
+with the contents and run Git commit, as you normally would when
 creating a new file.
 
 If you examine the resulting commit using gitk, you will see that it
@@ -1238,7 +1238,7 @@ one to the top of the other branch.
 Resolving a merge
 -----------------
 
-When a merge isn't resolved automatically, git leaves the index and
+When a merge isn't resolved automatically, Git leaves the index and
 the working tree in a special state that gives you all the
 information you need to help resolve the merge.
 
@@ -1274,14 +1274,14 @@ some information about the merge.  Normally you can just use this
 default message unchanged, but you may add additional commentary of
 your own if desired.
 
-The above is all you need to know to resolve a simple merge.  But git
+The above is all you need to know to resolve a simple merge.  But Git
 also provides more information to help resolve conflicts:
 
 [[conflict-resolution]]
 Getting conflict-resolution help during a merge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-All of the changes that git was able to merge automatically are
+All of the changes that Git was able to merge automatically are
 already added to the index file, so linkgit:git-diff[1] shows only
 the conflicts.  It uses an unusual syntax:
 
@@ -1413,7 +1413,7 @@ parents, one pointing at each of the two lines of development that
 were merged.
 
 However, if the current branch is a descendant of the other--so every
-commit present in the one is already contained in the other--then git
+commit present in the one is already contained in the other--then Git
 just performs a "fast-forward"; the head of the current branch is moved
 forward to point at the head of the merged-in branch, without any new
 commits being created.
@@ -1464,7 +1464,7 @@ You can also revert an earlier change, for example, the next-to-last:
 $ git revert HEAD^
 -------------------------------------------------
 
-In this case git will attempt to undo the old change while leaving
+In this case Git will attempt to undo the old change while leaving
 intact any changes made since then.  If more recent changes overlap
 with the changes to be reverted, then you will be asked to fix
 conflicts manually, just as in the case of <<resolving-a-merge,
@@ -1561,7 +1561,7 @@ $ git stash pop
 Ensuring good performance
 -------------------------
 
-On large repositories, git depends on compression to keep the history
+On large repositories, Git depends on compression to keep the history
 information from taking up too much space on disk or in memory.
 
 This compression is not performed automatically.  Therefore you
@@ -1618,7 +1618,7 @@ Say you modify a branch with +linkgit:git-reset[1] \--hard+, and then
 realize that the branch was the only reference you had to that point in
 history.
 
-Fortunately, git also keeps a log, called a "reflog", of all the
+Fortunately, Git also keeps a log, called a "reflog", of all the
 previous values of each branch.  So in this case you can still find the
 old history using, for example,
 
@@ -1627,7 +1627,7 @@ $ git log master@{1}
 -------------------------------------------------
 
 This lists the commits reachable from the previous version of the
-"master" branch head.  This syntax can be used with any git command
+"master" branch head.  This syntax can be used with any Git command
 that accepts a commit, not just with git log.  Some other examples:
 
 -------------------------------------------------
@@ -1653,7 +1653,7 @@ pruned.  See linkgit:git-reflog[1] and linkgit:git-gc[1] to learn
 how to control this pruning, and see the "SPECIFYING REVISIONS"
 section of linkgit:gitrevisions[7] for details.
 
-Note that the reflog history is very different from normal git history.
+Note that the reflog history is very different from normal Git history.
 While normal history is shared by every repository that works on the
 same project, the reflog history is not shared: it tells you only about
 how the branches in your local repository have changed over time.
@@ -1816,7 +1816,7 @@ $ git am -3 patches.mbox
 Git will apply each patch in order; if any conflicts are found, it
 will stop, and you can fix the conflicts as described in
 "<<resolving-a-merge,Resolving a merge>>".  (The "-3" option tells
-git to perform a merge; if you would prefer it just to abort and
+Git to perform a merge; if you would prefer it just to abort and
 leave your tree and index untouched, you may omit that option.)
 
 Once the index is updated with the results of the conflict
@@ -1826,7 +1826,7 @@ resolution, instead of creating a new commit, just run
 $ git am --resolved
 -------------------------------------------------
 
-and git will create the commit for you and continue applying the
+and Git will create the commit for you and continue applying the
 remaining patches from the mailbox.
 
 The final result will be a series of commits, one for each patch in
@@ -1834,7 +1834,7 @@ the original mailbox, with authorship and commit log message each
 taken from the message containing each patch.
 
 [[public-repositories]]
-Public git repositories
+Public Git repositories
 -----------------------
 
 Another way to submit changes to a project is to tell the maintainer
@@ -1909,7 +1909,7 @@ public repository.  You can use scp, rsync, or whatever is most
 convenient.
 
 [[exporting-via-git]]
-Exporting a git repository via the git protocol
+Exporting a Git repository via the Git protocol
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This is the preferred method.
@@ -1922,7 +1922,7 @@ repository>>", below.
 
 Otherwise, all you need to do is start linkgit:git-daemon[1]; it will
 listen on port 9418.  By default, it will allow access to any directory
-that looks like a git directory and contains the magic file
+that looks like a Git directory and contains the magic file
 git-daemon-export-ok.  Passing some directory paths as `git daemon`
 arguments will further restrict the exports to those paths.
 
@@ -1931,13 +1931,13 @@ linkgit:git-daemon[1] man page for details.  (See especially the
 examples section.)
 
 [[exporting-via-http]]
-Exporting a git repository via http
+Exporting a Git repository via http
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The git protocol gives better performance and reliability, but on a
+The Git protocol gives better performance and reliability, but on a
 host with a web server set up, http exports may be simpler to set up.
 
-All you need to do is place the newly created bare git repository in
+All you need to do is place the newly created bare Git repository in
 a directory that is exported by the web server, and make some
 adjustments to give web clients some extra information they need:
 
@@ -2073,9 +2073,9 @@ all push to and pull from a single shared repository.  See
 linkgit:gitcvs-migration[7] for instructions on how to
 set this up.
 
-However, while there is nothing wrong with git's support for shared
+However, while there is nothing wrong with Git's support for shared
 repositories, this mode of operation is not generally recommended,
-simply because the mode of collaboration that git supports--by
+simply because the mode of collaboration that Git supports--by
 exchanging patches and pulling from public repositories--has so many
 advantages over the central shared repository:
 
@@ -2099,8 +2099,8 @@ Allowing web browsing of a repository
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The gitweb cgi script provides users an easy way to browse your
-project's files and history without having to install git; see the file
-gitweb/INSTALL in the git source tree for instructions on setting it up.
+project's files and history without having to install Git; see the file
+gitweb/INSTALL in the Git source tree for instructions on setting it up.
 
 [[sharing-development-examples]]
 Examples
@@ -2110,7 +2110,7 @@ Examples
 Maintaining topic branches for a Linux subsystem maintainer
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-This describes how Tony Luck uses git in his role as maintainer of the
+This describes how Tony Luck uses Git in his role as maintainer of the
 IA64 architecture for the Linux kernel.
 
 He uses two public branches:
@@ -2160,7 +2160,7 @@ $ git checkout release && git pull
 
 Important note!  If you have any local changes in these branches, then
 this merge will create a commit object in the history (with no local
-changes git will simply do a "fast-forward" merge).  Many people dislike
+changes Git will simply do a "fast-forward" merge).  Many people dislike
 the "noise" that this creates in the Linux history, so you should avoid
 doing this capriciously in the "release" branch, as these noisy commits
 will become part of the permanent history when you ask Linus to pull
@@ -2413,7 +2413,7 @@ Rewriting history and maintaining patch series
 
 Normally commits are only added to a project, never taken away or
 replaced.  Git is designed with this assumption, and violating it will
-cause git's merge machinery (for example) to do the wrong thing.
+cause Git's merge machinery (for example) to do the wrong thing.
 
 However, there is a situation in which it can be useful to violate this
 assumption.
@@ -2524,7 +2524,7 @@ running `git commit`, just run
 $ git rebase --continue
 -------------------------------------------------
 
-and git will continue applying the rest of the patches.
+and Git will continue applying the rest of the patches.
 
 At any point you may use the `--abort` option to abort this process and
 return mywork to the state it had before you started the rebase:
@@ -2577,7 +2577,7 @@ then clean up with
 $ git tag -d bad
 -------------------------------------------------
 
-Note that the immutable nature of git history means that you haven't really
+Note that the immutable nature of Git history means that you haven't really
 "modified" existing commits; instead, you have replaced the old commits with
 new commits having new object names.
 
@@ -2658,7 +2658,7 @@ Git has no way of knowing that the new head is an updated version of
 the old head; it treats this situation exactly the same as it would if
 two developers had independently done the work on the old and new heads
 in parallel.  At this point, if someone attempts to merge the new head
-in to their branch, git will attempt to merge together the two (old and
+in to their branch, Git will attempt to merge together the two (old and
 new) lines of development, instead of trying to replace the old by the
 new.  The results are likely to be unexpected.
 
@@ -2731,7 +2731,7 @@ linear history:
 Bisecting between Z and D* would hit a single culprit commit Y*,
 and understanding why Y* was broken would probably be easier.
 
-Partly for this reason, many experienced git users, even when
+Partly for this reason, many experienced Git users, even when
 working on an otherwise merge-heavy project, keep the history
 linear by rebasing against the latest upstream version before
 publishing.
@@ -2752,8 +2752,8 @@ arbitrary name:
 $ git fetch origin todo:my-todo-work
 -------------------------------------------------
 
-The first argument, "origin", just tells git to fetch from the
-repository you originally cloned from.  The second argument tells git
+The first argument, "origin", just tells Git to fetch from the
+repository you originally cloned from.  The second argument tells Git
 to fetch the branch named "todo" from the remote repository, and to
 store it locally under the name refs/heads/my-todo-work.
 
@@ -2801,7 +2801,7 @@ resulting in a situation like:
 
 In this case, "git fetch" will fail, and print out a warning.
 
-In that case, you can still force git to update to the new head, as
+In that case, you can still force Git to update to the new head, as
 described in the following section.  However, note that in the
 situation above this may mean losing the commits labeled "a" and "b",
 unless you've already created a reference of your own pointing to
@@ -2834,7 +2834,7 @@ Configuring remote-tracking branches
 
 We saw above that "origin" is just a shortcut to refer to the
 repository that you originally cloned from.  This information is
-stored in git configuration variables, which you can see using
+stored in Git configuration variables, which you can see using
 linkgit:git-config[1]:
 
 -------------------------------------------------
@@ -2900,7 +2900,7 @@ Git concepts
 
 Git is built on a small number of simple but powerful ideas.  While it
 is possible to get things done without understanding them, you will find
-git much more intuitive if you do.
+Git much more intuitive if you do.
 
 We start with the most important, the  <<def_object_database,object
 database>> and the <<def_index,index>>.
@@ -2994,7 +2994,7 @@ As you can see, a commit is defined by:
 Note that a commit does not itself contain any information about what
 actually changed; all changes are calculated by comparing the contents
 of the tree referred to by this commit with the trees associated with
-its parents.  In particular, git does not attempt to record file renames
+its parents.  In particular, Git does not attempt to record file renames
 explicitly, though it can identify cases where the existence of the same
 file data at changing paths suggests a rename.  (See, for example, the
 -M option to linkgit:git-diff[1]).
@@ -3033,14 +3033,14 @@ another tree, representing the contents of a subdirectory.  Since trees
 and blobs, like all other objects, are named by the SHA-1 hash of their
 contents, two trees have the same SHA-1 name if and only if their
 contents (including, recursively, the contents of all subdirectories)
-are identical.  This allows git to quickly determine the differences
+are identical.  This allows Git to quickly determine the differences
 between two related tree objects, since it can ignore any entries with
 identical object names.
 
 (Note: in the presence of submodules, trees may also have commits as
 entries.  See <<submodules>> for documentation.)
 
-Note that the files all have mode 644 or 755: git actually only pays
+Note that the files all have mode 644 or 755: Git actually only pays
 attention to the executable bit.
 
 [[blob-object]]
@@ -3101,7 +3101,7 @@ sending out a single email that tells the people the name (SHA-1 hash)
 of the top commit, and digitally sign that email using something
 like GPG/PGP.
 
-To assist in this, git also provides the tag object...
+To assist in this, Git also provides the tag object...
 
 [[tag-object]]
 Tag Object
@@ -3134,7 +3134,7 @@ objects.  (Note that linkgit:git-tag[1] can also be used to create
 references whose names begin with "refs/tags/").
 
 [[pack-files]]
-How git stores objects efficiently: pack files
+How Git stores objects efficiently: pack files
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Newly created objects are initially created in a file named after the
@@ -3152,7 +3152,7 @@ The first number is the number of objects which are kept in
 individual files.  The second is the amount of space taken up by
 those "loose" objects.
 
-You can save space and make git faster by moving these loose objects in
+You can save space and make Git faster by moving these loose objects in
 to a "pack file", which stores a group of objects in an efficient
 compressed format; the details of how pack files are formatted can be
 found in link:technical/pack-format.txt[technical/pack-format.txt].
@@ -3285,12 +3285,12 @@ repository is a *BAD* idea).
 Recovering from repository corruption
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-By design, git treats data trusted to it with caution.  However, even in
-the absence of bugs in git itself, it is still possible that hardware or
+By design, Git treats data trusted to it with caution.  However, even in
+the absence of bugs in Git itself, it is still possible that hardware or
 operating system errors could corrupt data.
 
 The first defense against such problems is backups.  You can back up a
-git directory using clone, or just using cp, tar, or any other backup
+Git directory using clone, or just using cp, tar, or any other backup
 mechanism.
 
 As a last resort, you can search for the corrupted objects and attempt
@@ -3396,7 +3396,7 @@ $ git log --raw --all
 ------------------------------------------------
 
 and just looked for the sha of the missing object (4b9458b..) in that
-whole thing. It's up to you - git does *have* a lot of information, it is
+whole thing. It's up to you - Git does *have* a lot of information, it is
 just missing one particular blob version.
 
 [[the-index]]
@@ -3438,7 +3438,7 @@ It does this by storing some additional data for each entry (such as
 the last modified time).  This data is not displayed above, and is not
 stored in the created tree object, but it can be used to determine
 quickly which files in the working directory differ from what was
-stored in the index, and thus save git from having to read all of the
+stored in the index, and thus save Git from having to read all of the
 data from such files to look for changes.
 
 3. It can efficiently represent information about merge conflicts
@@ -3669,7 +3669,7 @@ Did you forget to 'git add'?
 Unable to checkout '261dfac35cb99d380eb966e102c1197139f7fa24' in submodule path 'a'
 -------------------------------------------------
 
-In older git versions it could be easily forgotten to commit new or modified
+In older Git versions it could be easily forgotten to commit new or modified
 files in a submodule, which silently leads to similar problems as not pushing
 the submodule changes. Starting with git 1.7.0 both "git status" and "git diff"
 in the superproject show submodules as modified when they contain new or
@@ -3714,12 +3714,12 @@ NOTE: The changes are still visible in the submodule's reflog.
 This is not the case if you did not commit your changes.
 
 [[low-level-operations]]
-Low-level git operations
+Low-level Git operations
 ========================
 
 Many of the higher-level commands were originally implemented as shell
-scripts using a smaller core of low-level git commands.  These can still
-be useful when doing unusual things with git, or just as a way to
+scripts using a smaller core of low-level Git commands.  These can still
+be useful when doing unusual things with Git, or just as a way to
 understand its inner workings.
 
 [[object-manipulation]]
@@ -3750,7 +3750,7 @@ between the working tree, the index, and the object database.  Git
 provides low-level operations which perform each of these steps
 individually.
 
-Generally, all "git" operations work on the index file. Some operations
+Generally, all Git operations work on the index file. Some operations
 work *purely* on the index file (showing the current state of the
 index), but most operations move data between the index file and either
 the database or the working directory. Thus there are four main
@@ -3773,7 +3773,7 @@ but to avoid common mistakes with filename globbing etc, the command
 will not normally add totally new entries or remove old entries,
 i.e. it will normally just update existing cache entries.
 
-To tell git that yes, you really do realize that certain files no
+To tell Git that yes, you really do realize that certain files no
 longer exist, or that new files should be added, you
 should use the `--remove` and `--add` flags respectively.
 
@@ -3887,7 +3887,7 @@ redirection from a pipe or file, or by just typing it at the tty).
 
 `git commit-tree` will return the name of the object that represents
 that commit, and you should save it away for later use. Normally,
-you'd commit a new `HEAD` state, and while git doesn't care where you
+you'd commit a new `HEAD` state, and while Git doesn't care where you
 save the note about that state, in practice we tend to just write the
 result to the file pointed at by `.git/HEAD`, so that we can always see
 what the last committed state was.
@@ -4044,7 +4044,7 @@ $ git ls-files --unmerged
 
 Each line of the `git ls-files --unmerged` output begins with
 the blob mode bits, blob SHA-1, 'stage number', and the
-filename.  The 'stage number' is git's way to say which tree it
+filename.  The 'stage number' is Git's way to say which tree it
 came from: stage 1 corresponds to the `$orig` tree, stage 2 to
 the `HEAD` tree, and stage 3 to the `$target` tree.
 
@@ -4056,7 +4056,7 @@ obviously the final outcome is what is in `HEAD`.  What the
 above example shows is that file `hello.c` was changed from
 `$orig` to `HEAD` and `$orig` to `$target` in a different way.
 You could resolve this by running your favorite 3-way merge
-program, e.g.  `diff3`, `merge`, or git's own merge-file, on
+program, e.g.  `diff3`, `merge`, or Git's own merge-file, on
 the blob objects from these three stages yourself, like this:
 
 ------------------------------------------------
@@ -4068,7 +4068,7 @@ $ git merge-file hello.c~2 hello.c~1 hello.c~3
 
 This would leave the merge result in `hello.c~2` file, along
 with conflict markers if there are conflicts.  After verifying
-the merge result makes sense, you can tell git what the final
+the merge result makes sense, you can tell Git what the final
 merge result for this file is by:
 
 -------------------------------------------------
@@ -4077,11 +4077,11 @@ $ git update-index hello.c
 -------------------------------------------------
 
 When a path is in the "unmerged" state, running `git update-index` for
-that path tells git to mark the path resolved.
+that path tells Git to mark the path resolved.
 
-The above is the description of a git merge at the lowest level,
+The above is the description of a Git merge at the lowest level,
 to help you understand what conceptually happens under the hood.
-In practice, nobody, not even git itself, runs `git cat-file` three times
+In practice, nobody, not even Git itself, runs `git cat-file` three times
 for this.  There is a `git merge-index` program that extracts the
 stages to temporary files and calls a "merge" script on it:
 
@@ -4092,11 +4092,11 @@ $ git merge-index git-merge-one-file hello.c
 and that is what higher level `git merge -s resolve` is implemented with.
 
 [[hacking-git]]
-Hacking git
+Hacking Git
 ===========
 
-This chapter covers internal details of the git implementation which
-probably only git developers need to understand.
+This chapter covers internal details of the Git implementation which
+probably only Git developers need to understand.
 
 [[object-details]]
 Object storage format
@@ -4114,7 +4114,7 @@ about the data in the object.  It's worth noting that the SHA-1 hash
 that is used to name the object is the hash of the original data
 plus this header, so `sha1sum` 'file' does not match the object name
 for 'file'.
-(Historical note: in the dawn of the age of git the hash
+(Historical note: in the dawn of the age of Git the hash
 was the SHA-1 of the 'compressed' object.)
 
 As a result, the general consistency of an object can always be tested
@@ -4144,7 +4144,7 @@ A good place to start is with the contents of the initial commit, with:
 $ git checkout e83c5163
 ----------------------------------------------------
 
-The initial revision lays the foundation for almost everything git has
+The initial revision lays the foundation for almost everything Git has
 today, but is small enough to read in one sitting.
 
 Note that terminology has changed since that revision.  For example, the
@@ -4298,7 +4298,7 @@ Now, for the meat:
 This is how you read a blob (actually, not only a blob, but any type of
 object).  To know how the function `read_object_with_reference()` actually
 works, find the source code for it (something like `git grep
-read_object_with | grep ":[a-z]"` in the git repository), and read
+read_object_with | grep ":[a-z]"` in the Git repository), and read
 the source.
 
 To find out how the result can be used, just read on in `cmd_cat_file()`:
@@ -4479,7 +4479,7 @@ $ git bisect bad		# if this revision is bad.
 Making changes
 --------------
 
-Make sure git knows who to blame:
+Make sure Git knows who to blame:
 
 ------------------------------------------------
 $ cat >>~/.gitconfig <<\EOF
@@ -4529,7 +4529,7 @@ $ git format-patch origin..HEAD # format a patch for each commit
 $ git am mbox # import patches from the mailbox "mbox"
 -----------------------------------------------
 
-Fetch a branch in a different git repository, then merge into the
+Fetch a branch in a different Git repository, then merge into the
 current branch:
 
 -----------------------------------------------
@@ -4590,7 +4590,7 @@ The basic requirements:
 
 - It must be readable in order, from beginning to end, by someone
   intelligent with a basic grasp of the UNIX command line, but without
-  any special knowledge of git.  If necessary, any other prerequisites
+  any special knowledge of Git.  If necessary, any other prerequisites
   should be specifically mentioned as they arise.
 - Whenever possible, section headings should clearly describe the task
   they explain how to do, in language that requires no more knowledge
-- 
1.8.0.msysgit.0


---
Thomas
