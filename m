Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B191F42D
	for <e@80x24.org>; Thu, 24 May 2018 19:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971298AbeEXT4a (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:56:30 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:38838 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968767AbeEXT42 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TBqfF/pgnuSALH7FbVi+b1nHCeMNaJI/zwRejre0PFo=; b=CPs5NMfEsk09x3D0evKtvkE9mo
        WYL2pX9QrAfu2tXTFzXaJwJFNc95yuCGXKpcn/PU8HAm9fJS3ltcm4QgzwNpjKOEw5Hzyi9XqAss1
        +sm4A1aG8NHKXEC/0kQ4HlgTjvsTrOdoclhLTn922uLCqViEgmKvIlPFkNn5KAvDRRoMQwdARFSdm
        G9KmObuXdYFr7awrOIVwU86eIiiywiXVtVYH43XO0X3yjJKIeIG2YyYwHQIFxnXgj+1krtXky59QA
        e+ePaDM/1kz0VDymcOf26fEW0LeBm7OuPjPQ0KuJi3842nTUdntVq2S+NyGR0gCmLNcnQQOWuVGsx
        75IETA9Q==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:46020 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fLwLZ-001Dya-6o
        for git@vger.kernel.org; Thu, 24 May 2018 15:56:26 -0400
Date:   Thu, 24 May 2018 15:54:43 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] Use proper syntax for replaceables in command docs
Message-ID: <alpine.LFD.2.21.1805241552080.6217@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The standard for command documentation synopses appears to be:

  [...] means optional
  <...> means replaceable
  [<...>] means both optional and replaceable

So fix a number of doc pages that use incorrect variations of the
above.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
index 05fd482b7..e44a83133 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -8,7 +8,7 @@ git-annotate - Annotate file lines with commit information
 SYNOPSIS
 --------
 [verse]
-'git annotate' [options] file [revision]
+'git annotate' [<options>] <file> [<revision>]

 DESCRIPTION
 -----------
diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index aa3b2bf2f..aff476e28 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -9,7 +9,7 @@ git-check-attr - Display gitattributes information
 SYNOPSIS
 --------
 [verse]
-'git check-attr' [-a | --all | attr...] [--] pathname...
+'git check-attr' [-a | --all | attr...] [--] <pathname>...
 'git check-attr' --stdin [-z] [-a | --all | attr...]

 DESCRIPTION
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 611754f10..006f3b9fa 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -9,8 +9,8 @@ git-check-ignore - Debug gitignore / exclude files
 SYNOPSIS
 --------
 [verse]
-'git check-ignore' [options] pathname...
-'git check-ignore' [options] --stdin
+'git check-ignore' [<options>] <paths>...
+'git check-ignore' [<options>] --stdin

 DESCRIPTION
 -----------
diff --git a/Documentation/git-check-mailmap.txt b/Documentation/git-check-mailmap.txt
index 39028ee1a..aa2055dbe 100644
--- a/Documentation/git-check-mailmap.txt
+++ b/Documentation/git-check-mailmap.txt
@@ -9,7 +9,7 @@ git-check-mailmap - Show canonical names and email addresses of contacts
 SYNOPSIS
 --------
 [verse]
-'git check-mailmap' [options] <contact>...
+'git check-mailmap' [<options>] <contact>...


 DESCRIPTION
diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 2b8582639..0216c18ef 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -8,7 +8,7 @@ git-credential-cache - Helper to temporarily store passwords in memory
 SYNOPSIS
 --------
 -----------------------------
-git config credential.helper 'cache [options]'
+git config credential.helper 'cache [<options>]'
 -----------------------------

 DESCRIPTION
diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 25fb963f4..693dd9d9d 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -8,7 +8,7 @@ git-credential-store - Helper to store credentials on disk
 SYNOPSIS
 --------
 -------------------
-git config credential.helper 'store [options]'
+git config credential.helper 'store [<options>]'
 -------------------

 DESCRIPTION
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 37b96c545..f98b7c6ed 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -22,7 +22,7 @@ cvspserver stream tcp nowait nobody /usr/bin/git-cvsserver git-cvsserver pserver
 Usage:

 [verse]
-'git-cvsserver' [options] [pserver|server] [<directory> ...]
+'git-cvsserver' [<options>] [pserver|server] [<directory> ...]

 OPTIONS
 -------
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 7c2c44270..b180f1fa5 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -9,11 +9,11 @@ git-diff - Show changes between commits, commit and working tree, etc
 SYNOPSIS
 --------
 [verse]
-'git diff' [options] [<commit>] [--] [<path>...]
-'git diff' [options] --cached [<commit>] [--] [<path>...]
-'git diff' [options] <commit> <commit> [--] [<path>...]
-'git diff' [options] <blob> <blob>
-'git diff' [options] --no-index [--] <path> <path>
+'git diff' [<options>] [<commit>] [--] [<path>...]
+'git diff' [<options>] --cached [<commit>] [--] [<path>...]
+'git diff' [<options>] <commit> <commit> [--] [<path>...]
+'git diff' [<options>] <blob> <blob>
+'git diff' [<options>] --no-index [--] <path> <path>

 DESCRIPTION
 -----------
@@ -21,7 +21,7 @@ Show changes between the working tree and the index or a tree, changes
 between the index and a tree, changes between two trees, changes between
 two blob objects, or changes between two files on disk.

-'git diff' [options] [--] [<path>...]::
+'git diff' [<options>] [--] [<path>...]::

 	This form is to view the changes you made relative to
 	the index (staging area for the next commit).  In other
@@ -29,7 +29,7 @@ two blob objects, or changes between two files on disk.
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].

-'git diff' [options] --no-index [--] <path> <path>::
+'git diff' [<options>] --no-index [--] <path> <path>::

 	This form is to compare the given two paths on the
 	filesystem.  You can omit the `--no-index` option when
@@ -38,7 +38,7 @@ two blob objects, or changes between two files on disk.
 	or when running the command outside a working tree
 	controlled by Git.

-'git diff' [options] --cached [<commit>] [--] [<path>...]::
+'git diff' [<options>] --cached [<commit>] [--] [<path>...]::

 	This form is to view the changes you staged for the next
 	commit relative to the named <commit>.  Typically you
@@ -48,7 +48,7 @@ two blob objects, or changes between two files on disk.
 	<commit> is not given, it shows all staged changes.
 	--staged is a synonym of --cached.

-'git diff' [options] <commit> [--] [<path>...]::
+'git diff' [<options>] <commit> [--] [<path>...]::

 	This form is to view the changes you have in your
 	working tree relative to the named <commit>.  You can
@@ -56,18 +56,18 @@ two blob objects, or changes between two files on disk.
 	branch name to compare with the tip of a different
 	branch.

-'git diff' [options] <commit> <commit> [--] [<path>...]::
+'git diff' [<options>] <commit> <commit> [--] [<path>...]::

 	This is to view the changes between two arbitrary
 	<commit>.

-'git diff' [options] <commit>..<commit> [--] [<path>...]::
+'git diff' [<options>] <commit>..<commit> [--] [<path>...]::

 	This is synonymous to the previous form.  If <commit> on
 	one side is omitted, it will have the same effect as
 	using HEAD instead.

-'git diff' [options] <commit>\...<commit> [--] [<path>...]::
+'git diff' [<options>] <commit>\...<commit> [--] [<path>...]::

 	This form is to view the changes on the branch containing
 	and up to the second <commit>, starting at a common ancestor
@@ -87,7 +87,7 @@ and the range notations ("<commit>..<commit>" and
 "<commit>\...<commit>") do not mean a range as defined in the
 "SPECIFYING RANGES" section in linkgit:gitrevisions[7].

-'git diff' [options] <blob> <blob>::
+'git diff' [<options>] <blob> <blob>::

 	This form is to view the differences between the raw
 	contents of two blob objects.
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 44098595d..ce954be53 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -9,7 +9,7 @@ git-fast-export - Git data exporter
 SYNOPSIS
 --------
 [verse]
-'git fast-export [options]' | 'git fast-import'
+'git fast-export [<options>]' | 'git fast-import'

 DESCRIPTION
 -----------
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index cdf696ff7..e81117d27 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -9,7 +9,7 @@ git-fast-import - Backend for fast Git data importers
 SYNOPSIS
 --------
 [verse]
-frontend | 'git fast-import' [options]
+frontend | 'git fast-import' [<options>]

 DESCRIPTION
 -----------
diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index ff446f15f..9111c47a1 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -8,8 +8,8 @@ git-interpret-trailers - add or parse structured information in commit messages
 SYNOPSIS
 --------
 [verse]
-'git interpret-trailers' [options] [(--trailer <token>[(=|:)<value>])...] [<file>...]
-'git interpret-trailers' [options] [--parse] [<file>...]
+'git interpret-trailers' [<options>] [(--trailer <token>[(=|:)<value>])...] [<file>...]
+'git interpret-trailers' [<options>] [--parse] [<file>...]

 DESCRIPTION
 -----------
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 4e0ad6fd8..118d9d86f 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -9,7 +9,7 @@ git-pull - Fetch from and integrate with another repository or a local branch
 SYNOPSIS
 --------
 [verse]
-'git pull' [options] [<repository> [<refspec>...]]
+'git pull' [<options>] [<repository> [<refspec>...]]


 DESCRIPTION
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index bd5ecff98..0e20a66e7 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,9 +8,9 @@ git-rebase - Reapply commits on top of another base tip
 SYNOPSIS
 --------
 [verse]
-'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
+'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
 	[<upstream> [<branch>]]
-'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
+'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
 'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --show-current-patch

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 95326b85f..e72d332b8 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -9,7 +9,7 @@ git-rev-parse - Pick out and massage parameters
 SYNOPSIS
 --------
 [verse]
-'git rev-parse' [ --option ] <args>...
+'git rev-parse' [<options>] <args>...

 DESCRIPTION
 -----------
@@ -360,7 +360,7 @@ Example

 ------------
 OPTS_SPEC="\
-some-command [options] <args>...
+some-command [<options>] <args>...

 some-command does foo and bar!
 --
@@ -385,7 +385,7 @@ When `"$@"` is `-h` or `--help` in the above example, the following
 usage text would be shown:

 ------------
-usage: some-command [options] <args>...
+usage: some-command [<options>] <args>...

     some-command does foo and bar!

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 464c15b94..4f3efde80 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -9,7 +9,7 @@ git-send-email - Send a collection of patches as emails
 SYNOPSIS
 --------
 [verse]
-'git send-email' [options] <file|directory|rev-list options>...
+'git send-email' [<options>] <file|directory|rev-list options>...
 'git send-email' --dump-aliases


diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 0e1695df3..fcf528c1b 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -9,7 +9,7 @@ git-show - Show various types of objects
 SYNOPSIS
 --------
 [verse]
-'git show' [options] [<object>...]
+'git show' [<options>] [<object>...]

 DESCRIPTION
 -----------
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index e9615951d..7ea24fc94 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -8,7 +8,7 @@ git-svn - Bidirectional operation between a Subversion repository and Git
 SYNOPSIS
 --------
 [verse]
-'git svn' <command> [options] [arguments]
+'git svn' <command> [<options>] [<arguments>]

 DESCRIPTION
 -----------
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index a4ec25b45..fd952a5ff 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -8,7 +8,7 @@ git-web--browse - Git helper script to launch a web browser
 SYNOPSIS
 --------
 [verse]
-'git web{litdd}browse' [OPTIONS] URL/FILE ...
+'git web{litdd}browse' [<options>] <url|file>...

 DESCRIPTION
 -----------
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 9f13266a6..592e06d83 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -110,8 +110,8 @@ couple of magic command-line options:
 +
 ---------------------------------------------
 $ git describe -h
-usage: git describe [options] <commit-ish>*
-   or: git describe [options] --dirty
+usage: git describe [<options>] <commit-ish>*
+   or: git describe [<options>] --dirty

     --contains            find the tag that comes after the commit
     --debug               debug search strategy on stderr
