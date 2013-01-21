From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v3 1/6] Change old system name 'GIT' to 'Git'
Date: Mon, 21 Jan 2013 20:16:20 +0100 (CET)
Message-ID: <1335904329.632749.1358795780375.JavaMail.ngmail@webmail20.arcor-online.net>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net> <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net> <7vvcark1f2.fsf@alter.siamese.dyndns.org> <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: davvid@gmail.com, git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Mon Jan 21 20:16:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMrO-0003R5-2b
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab3AUTQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 14:16:23 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:33463 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751670Ab3AUTQX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 14:16:23 -0500
Received: from mail-in-20-z2.arcor-online.net (mail-in-20-z2.arcor-online.net [151.189.8.85])
	by mx.arcor.de (Postfix) with ESMTP id BA3F55A0BA;
	Mon, 21 Jan 2013 20:16:21 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-20-z2.arcor-online.net (Postfix) with ESMTP id B4D67834015;
	Mon, 21 Jan 2013 20:16:21 +0100 (CET)
Received: from webmail20.arcor-online.net (webmail20.arcor-online.net [151.189.8.201])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id AD48E30324;
	Mon, 21 Jan 2013 20:16:20 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-02.arcor-online.net AD48E30324
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1358795781; bh=hFvSWZYoAB1SuKKTpBwkY8H/kEjEfiMJsIMJtICLSpY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=mVA6u2pGPf6eQt0bfUdrDSFQjXWLRVKStJT5fhfYd43w/rdpEnZvu7XB2+qb5J/JV
	 IgwhreFBpWvcWDPSPbKWcyVVTanXdDQVnwMs7K6hkesjtlFCKz8iFzwhKr3FXaSZ0N
	 DFw/P0/w+UAiq/iYL9yGs8plGiEP41uocc/dYGcs=
Received: from [188.105.98.86] by webmail20.arcor-online.net (151.189.8.201) with HTTP (Arcor Webmail); Mon, 21 Jan 2013 20:16:20 +0100 (CET)
In-Reply-To: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.98.86
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214146>

Git changed its 'official' system name from 'GIT' to 'Git' in v1.6.5.3
(as can be seen in the corresponding release note where 'GIT' was
changed to 'Git' in the header line). So change every occurrence
of 'GIT" in the documention to 'Git'.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/asciidoc.conf                         |  2 +-
 Documentation/everyday.txt                          |  4 ++--
 Documentation/git-clone.txt                         |  2 +-
 Documentation/git-cvsexportcommit.txt               |  2 +-
 Documentation/git-cvsserver.txt                     |  8 ++++----
 Documentation/git-daemon.txt                        |  4 ++--
 Documentation/git-mv.txt                            |  2 +-
 Documentation/git-send-email.txt                    |  2 +-
 Documentation/git-tools.txt                         | 14 +++++++-------
 Documentation/git-update-ref.txt                    |  2 +-
 Documentation/git.txt                               |  2 +-
 Documentation/gitcore-tutorial.txt                  |  4 ++--
 Documentation/gitglossary.txt                       |  2 +-
 Documentation/gittutorial.txt                       |  2 +-
 Documentation/gitweb.txt                            |  2 +-
 Documentation/gitworkflows.txt                      |  2 +-
 Documentation/glossary-content.txt                  |  2 +-
 Documentation/howto-index.sh                        |  2 +-
 Documentation/howto/rebase-from-internal-branch.txt |  6 +++---
 Documentation/howto/revert-branch-rebase.txt        |  4 ++--
 Documentation/howto/setup-git-server-over-http.txt  |  4 ++--
 Documentation/technical/api-index-skel.txt          |  4 ++--
 Documentation/technical/index-format.txt            |  6 +++---
 Documentation/technical/pack-format.txt             |  4 ++--
 Documentation/user-manual.txt                       |  4 ++--
 25 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 1273a85..2c16c53 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -4,7 +4,7 @@
 #
 # Note, {0} is the manpage section, while {target} is the command.
 #
-# Show GIT link as: <command>(<section>); if section is defined, else just show
+# Show Git link as: <command>(<section>); if section is defined, else just show
 # the command.
 
 [macros]
diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 048337b..6acfd33 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -1,4 +1,4 @@
-Everyday GIT With 20 Commands Or So
+Everyday Git With 20 Commands Or So
 ===================================
 
 <<Individual Developer (Standalone)>> commands are essential for
@@ -229,7 +229,7 @@ commands in addition to the ones needed by participants.
 Examples
 ~~~~~~~~
 
-My typical GIT day.::
+My typical Git day.::
 +
 ------------
 $ git status <1>
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 7fefdb0..597048b 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -125,7 +125,7 @@ objects from the source repository into a pack in the cloned repository.
 	No checkout of HEAD is performed after the clone is complete.
 
 --bare::
-	Make a 'bare' GIT repository.  That is, instead of
+	Make a 'bare' Git repository.  That is, instead of
 	creating `<directory>` and placing the administrative
 	files in `<directory>/.git`, make the `<directory>`
 	itself the `$GIT_DIR`. This obviously implies the `-n`
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 7f79cec..a671e22 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Exports a commit from GIT to a CVS checkout, making it easier
+Exports a commit from Git to a CVS checkout, making it easier
 to merge patches from a git repository into a CVS repository.
 
 Specify the name of a CVS checkout using the -w switch or execute it
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 88d814a..36d069b 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -72,9 +72,9 @@ plugin. Most functionality works fine with both of these clients.
 LIMITATIONS
 -----------
 
-CVS clients cannot tag, branch or perform GIT merges.
+CVS clients cannot tag, branch or perform Git merges.
 
-'git-cvsserver' maps GIT branches to CVS modules. This is very different
+'git-cvsserver' maps Git branches to CVS modules. This is very different
 from what most CVS users would expect since in CVS modules usually represent
 one or more directories.
 
@@ -130,7 +130,7 @@ Then provide your password via the pserver method, for example:
 ------
    cvs -d:pserver:someuser:somepassword <at> server/path/repo.git co <HEAD_name>
 ------
-No special setup is needed for SSH access, other than having GIT tools
+No special setup is needed for SSH access, other than having Git tools
 in the PATH. If you have clients that do not accept the CVS_SERVER
 environment variable, you can rename 'git-cvsserver' to `cvs`.
 
@@ -197,7 +197,7 @@ allowing access over SSH.
    shell is bash, .bashrc may be a reasonable alternative.
 
 5. Clients should now be able to check out the project. Use the CVS 'module'
-   name to indicate what GIT 'head' you want to check out.  This also sets the
+   name to indicate what Git 'head' you want to check out.  This also sets the
    name of your newly checked-out directory, unless you tell it otherwise with
    `-d <dir_name>`.  For example, this checks out 'master' branch to the
    `project-master` directory:
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 7e5098a..80de4f6 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -51,7 +51,7 @@ OPTIONS
 
 --base-path=<path>::
 	Remap all the path requests as relative to the given path.
-	This is sort of "GIT root" - if you run 'git daemon' with
+	This is sort of "Git root" - if you run 'git daemon' with
 	'--base-path=/srv/git' on example.com, then if you later try to pull
 	'git://example.com/hello.git', 'git daemon' will interpret the path
 	as '/srv/git/hello.git'.
@@ -73,7 +73,7 @@ OPTIONS
 	whitelist.
 
 --export-all::
-	Allow pulling from all directories that look like GIT repositories
+	Allow pulling from all directories that look like Git repositories
 	(have the 'objects' and 'refs' subdirectories), even if they
 	do not have the 'git-daemon-export-ok' file.
 
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index e3c8448..bcb79c9 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -34,7 +34,7 @@ OPTIONS
 -k::
         Skip move or rename actions which would lead to an error
 	condition. An error happens when a source is neither existing nor
-        controlled by GIT, or when it would overwrite an existing
+        controlled by Git, or when it would overwrite an existing
         file unless '-f' is given.
 -n::
 --dry-run::
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index eeb561c..44a1f7c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -67,7 +67,7 @@ The --cc option must be repeated for each user you want on the cc list.
 When '--compose' is used, git send-email will use the From, Subject, and
 In-Reply-To headers specified in the message. If the body of the message
 (what you type after the headers and a blank line) only contains blank
-(or GIT: prefixed) lines the summary won't be sent, but From, Subject,
+(or Git: prefixed) lines the summary won't be sent, but From, Subject,
 and In-Reply-To headers will be used unless they are removed.
 +
 Missing From or In-Reply-To headers will be prompted for.
diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index a96403c..2f51b83 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -19,24 +19,24 @@ Alternative/Augmentative Porcelains
 
    Cogito is a version control system layered on top of the git tree history
    storage system. It aims at seamless user interface and ease of use,
-   providing generally smoother user experience than the "raw" Core GIT
+   providing generally smoother user experience than the "raw" Core Git
    itself and indeed many other version control systems.
 
    Cogito is no longer maintained as most of its functionality
-   is now in core GIT.
+   is now in core Git.
 
 
    - *pg* (http://www.spearce.org/category/projects/scm/pg/)
 
-   pg is a shell script wrapper around GIT to help the user manage a set of
+   pg is a shell script wrapper around Git to help the user manage a set of
    patches to files. pg is somewhat like quilt or StGIT, but it does have a
    slightly different feature set.
 
 
    - *StGit* (http://www.procode.org/stgit/)
 
-   Stacked GIT provides a quilt-like patch management functionality in the
-   GIT environment. You can easily manage your patches in the scope of GIT
+   Stacked Git provides a quilt-like patch management functionality in the
+   Git environment. You can easily manage your patches in the scope of Git
    until they get merged upstream.
 
 
@@ -45,7 +45,7 @@ History Viewers
 
    - *gitk* (shipped with git-core)
 
-   gitk is a simple Tk GUI for browsing history of GIT repositories easily.
+   gitk is a simple Tk GUI for browsing history of Git repositories easily.
 
 
    - *gitview*  (contrib/)
@@ -55,7 +55,7 @@ History Viewers
 
    - *gitweb* (shipped with git-core)
 
-   GITweb provides full-fledged web interface for GIT repositories.
+   Gitweb provides full-fledged web interface for Git repositories.
 
 
    - *qgit* (http://digilander.libero.it/mcostalba/)
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index d377a35..0df13ff 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -73,7 +73,7 @@ in ref value.  Log lines are formatted as:
 Where "oldsha1" is the 40 character hexadecimal value previously
 stored in <ref>, "newsha1" is the 40 character hexadecimal value of
 <newvalue> and "committer" is the committer's name, email address
-and date in the standard GIT committer ident format.
+and date in the standard Git committer ident format.
 
 Optionally with -m:
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 555250d..1aac71e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -890,7 +890,7 @@ See also the link:howto-index.html[howto] documents for some useful
 examples.
 
 The internals are documented in the
-link:technical/api-index.html[GIT API documentation].
+link:technical/api-index.html[Git API documentation].
 
 Users migrating from CVS may also want to
 read linkgit:gitcvs-migration[7].
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 5325c5a..6a701dd 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -16,8 +16,8 @@ This tutorial explains how to use the "core" git commands to set up and
 work with a git repository.
 
 If you just need to use git as a revision control system you may prefer
-to start with "A Tutorial Introduction to GIT" (linkgit:gittutorial[7]) or
-link:user-manual.html[the GIT User Manual].
+to start with "A Tutorial Introduction to Git" (linkgit:gittutorial[7]) or
+link:user-manual.html[the Git User Manual].
 
 However, an understanding of these low-level tools can be helpful if
 you want to understand git's internals.
diff --git a/Documentation/gitglossary.txt b/Documentation/gitglossary.txt
index d77a45a..6d7b195 100644
--- a/Documentation/gitglossary.txt
+++ b/Documentation/gitglossary.txt
@@ -3,7 +3,7 @@ gitglossary(7)
 
 NAME
 ----
-gitglossary - A GIT Glossary
+gitglossary - A Git Glossary
 
 SYNOPSIS
 --------
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index f1cb6f3..9dd45c4 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -656,7 +656,7 @@ digressions that may be interesting at this point are:
   * linkgit:gitworkflows[7]: Gives an overview of recommended
     workflows.
 
-  * link:everyday.html[Everyday GIT with 20 Commands Or So]
+  * link:everyday.html[Everyday Git with 20 Commands Or So]
 
   * linkgit:gitcvs-migration[7]: Git for CVS users.
 
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 168e8bf..d364c3a 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -504,7 +504,7 @@ repositories, you can configure Apache like this:
 
 The above configuration expects your public repositories to live under
 '/pub/git' and will serve them as `http://git.domain.org/dir-under-pub-git`,
-both as cloneable GIT URL and as browseable gitweb interface.  If you then
+both as cloneable Git URL and as browseable gitweb interface.  If you then
 start your linkgit:git-daemon[1] with `--base-path=/pub/git --export-all`
 then you can even use the `git://` URL with exactly the same path.
 
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 8b8c6ae..e2e7d65 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -242,7 +242,7 @@ tag to the tip of 'master' indicating the release version:
 .Release tagging
 [caption="Recipe: "]
 =====================================
-`git tag -s -m "GIT X.Y.Z" vX.Y.Z master`
+`git tag -s -m "Git X.Y.Z" vX.Y.Z master`
 =====================================
 
 You need to push the new tag to a public git server (see
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index f928b57..7c28aef 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -52,7 +52,7 @@
 [[def_cherry-picking]]cherry-picking::
 	In <<def_SCM,SCM>> jargon, "cherry pick" means to choose a subset of
 	changes out of a series of changes (typically commits) and record them
-	as a new series of changes on top of a different codebase. In GIT, this is
+	as a new series of changes on top of a different codebase. In Git, this is
 	performed by the "git cherry-pick" command to extract the change introduced
 	by an existing <<def_commit,commit>> and to record it based on the tip
 	of the current <<def_branch,branch>> as a new commit.
diff --git a/Documentation/howto-index.sh b/Documentation/howto-index.sh
index 34aa30c..8e82e52 100755
--- a/Documentation/howto-index.sh
+++ b/Documentation/howto-index.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 cat <<\EOF
-GIT Howto Index
+Git Howto Index
 ===============
 
 Here is a collection of mailing list postings made by various
diff --git a/Documentation/howto/rebase-from-internal-branch.txt b/Documentation/howto/rebase-from-internal-branch.txt
index 4627ee4..19ab604 100644
--- a/Documentation/howto/rebase-from-internal-branch.txt
+++ b/Documentation/howto/rebase-from-internal-branch.txt
@@ -4,7 +4,7 @@ Cc:	Petr Baudis <pasky@suse.cz>, Linus Torvalds <torvalds@osdl.org>
 Subject: Re: sending changesets from the middle of a git tree
 Date:	Sun, 14 Aug 2005 18:37:39 -0700
 Abstract: In this article, JC talks about how he rebases the
- public "pu" branch using the core GIT tools when he updates
+ public "pu" branch using the core Git tools when he updates
  the "master" branch, and how "rebase" works.  Also discussed
  is how this applies to individual developers who sends patches
  upstream.
@@ -31,7 +31,7 @@ up.  With its basing philosophical ancestry on quilt, this is
 the kind of task StGIT is designed to do.
 
 I just have done a simpler one, this time using only the core
-GIT tools.
+Git tools.
 
 I had a handful of commits that were ahead of master in pu, and I
 wanted to add some documentation bypassing my usual habit of
@@ -96,7 +96,7 @@ you ran fsck-cache, which is normal.  After testing "pu", you
 can run "git prune" to get rid of those original three commits.
 
 While I am talking about "git rebase", I should talk about how
-to do cherrypicking using only the core GIT tools.
+to do cherrypicking using only the core Git tools.
 
 Let's go back to the earlier picture, with different labels.
 
diff --git a/Documentation/howto/revert-branch-rebase.txt b/Documentation/howto/revert-branch-rebase.txt
index a59ced8..84dd839 100644
--- a/Documentation/howto/revert-branch-rebase.txt
+++ b/Documentation/howto/revert-branch-rebase.txt
@@ -12,10 +12,10 @@ How to revert an existing commit
 ================================
 
 One of the changes I pulled into the 'master' branch turns out to
-break building GIT with GCC 2.95.  While they were well intentioned
+break building Git with GCC 2.95.  While they were well intentioned
 portability fixes, keeping things working with gcc-2.95 was also
 important.  Here is what I did to revert the change in the 'master'
-branch and to adjust the 'pu' branch, using core GIT tools and
+branch and to adjust the 'pu' branch, using core Git tools and
 barebone Porcelain.
 
 First, prepare a throw-away branch in case I screw things up.
diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index a695f01..e49d785 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -53,10 +53,10 @@ In effect, this means you're going to be root, or that you're using a
 preconfigured WebDAV server.
 
 
-Step 1: setup a bare GIT repository
+Step 1: setup a bare Git repository
 -----------------------------------
 
-At the time of writing, git-http-push cannot remotely create a GIT
+At the time of writing, git-http-push cannot remotely create a Git
 repository. So we have to do that at the server side with git. Another
 option is to generate an empty bare repository at the client and copy
 it to the server with a WebDAV client (which is the only option if Git
diff --git a/Documentation/technical/api-index-skel.txt b/Documentation/technical/api-index-skel.txt
index 730cfac..eda8c19 100644
--- a/Documentation/technical/api-index-skel.txt
+++ b/Documentation/technical/api-index-skel.txt
@@ -1,7 +1,7 @@
-GIT API Documents
+Git API Documents
 =================
 
-GIT has grown a set of internal API over time.  This collection
+Git has grown a set of internal API over time.  This collection
 documents them.
 
 ////////////////////////////////////////////////////////////////
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 7324154..6a05ee2 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -1,4 +1,4 @@
-GIT index format
+Git index format
 ================
 
 == The git index file has the following format
@@ -21,9 +21,9 @@ GIT index format
    - Extensions
 
      Extensions are identified by signature. Optional extensions can
-     be ignored if GIT does not understand them.
+     be ignored if Git does not understand them.
 
-     GIT currently supports cached tree and resolve undo extensions.
+     Git currently supports cached tree and resolve undo extensions.
 
      4-byte extension signature. If the first byte is 'A'..'Z' the
      extension is optional and can be ignored.
diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index a7871fb..e7d07bc 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -1,4 +1,4 @@
-GIT pack format
+Git pack format
 ===============
 
 == pack-*.pack files have the following format:
@@ -9,7 +9,7 @@ GIT pack format
          The signature is: {'P', 'A', 'C', 'K'}
 
      4-byte version number (network byte order):
-         GIT currently accepts version number 2 or 3 but
+         Git currently accepts version number 2 or 3 but
          generates version 2 only.
 
      4-byte number of objects contained in the pack (network byte order)
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1b377dc..c93e1a8 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2299,7 +2299,7 @@ Here are some of the scripts that simplify all this even further.
 
 -------------------------------------------------
 ==== update script ====
-# Update a branch in my GIT tree.  If the branch to be updated
+# Update a branch in my Git tree.  If the branch to be updated
 # is origin, then pull from kernel.org.  Otherwise merge
 # origin/master branch into test|release branch
 
@@ -2357,7 +2357,7 @@ esac
 
 -------------------------------------------------
 ==== status script ====
-# report on status of my ia64 GIT tree
+# report on status of my ia64 Git tree
 
 gb=$(tput setab 2)
 rb=$(tput setab 1)
-- 
1.8.0.msysgit.0


---
Thomas
