Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF274201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 21:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751071AbdKLVDW (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 16:03:22 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:55759 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdKLVDV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 16:03:21 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:58832 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eDzPV-0005KS-3C
        for git@vger.kernel.org; Sun, 12 Nov 2017 16:03:21 -0500
Date:   Sun, 12 Nov 2017 16:02:56 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] doc: Remove explanation of "--" from several man pages
Message-ID: <alpine.LFD.2.21.1711121600170.7904@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no value in individual man pages explaining the purpose of
the "--" separator.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  unless every man page explains that option, it's pointless to have
just *some* man pages explaining it, so might as well remove it from
all of them.

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index b700beaff..69d625285 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -180,11 +180,6 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	bit is only changed in the index, the files on disk are left
 	unchanged.

-\--::
-	This option can be used to separate command-line options from
-	the list of files, (useful when filenames might be mistaken
-	for command-line options).
-

 Configuration
 -------------
diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index aa3b2bf2f..0ae2523e0 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -36,10 +36,6 @@ OPTIONS
 	If `--stdin` is also given, input paths are separated
 	with a NUL character instead of a linefeed character.

-\--::
-	Interpret all preceding arguments as attributes and all following
-	arguments as path names.
-
 If none of `--stdin`, `--all`, or `--` is used, the first argument
 will be treated as an attribute and the rest of the arguments as
 pathnames.
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 4d33e7be0..11ee76e7d 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -68,9 +68,6 @@ OPTIONS
 	Only meaningful with `--stdin`; paths are separated with
 	NUL character instead of LF.

-\--::
-	Do not interpret any more arguments as options.
-
 The order of the flags used to matter, but not anymore.

 Just doing `git checkout-index` does nothing. You probably meant
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 8c74a2ca0..cd9f362d1 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -334,9 +334,6 @@ changes to tracked files.
 	Countermand `commit.gpgSign` configuration variable that is
 	set to force each and every commit to be signed.

-\--::
-	Do not interpret any more arguments as options.
-
 <file>...::
 	When files are given on the command line, the command
 	commits the contents of the named files, without
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 18b494731..bac0b789c 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -282,10 +282,6 @@ providing this option will cause it to die.
 	Instead of searching tracked files in the working tree, search
 	blobs in the given trees.

-\--::
-	Signals the end of options; the rest of the parameters
-	are <pathspec> limiters.
-
 <pathspec>...::
 	If given, limit the search to paths matching at least one pattern.
 	Both leading paths match and glob(7) patterns are supported.
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index d153c17e0..93ebb020c 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -171,9 +171,6 @@ Both the <eolinfo> in the index ("i/<eolinfo>")
 and in the working tree ("w/<eolinfo>") are shown for regular files,
 followed by the  ("attr/<eolattr>").

-\--::
-	Do not interpret any more arguments as options.
-
 <file>::
 	Files to show. If no files are given all files which match the other
 	specified criteria are shown.
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 02676fb39..51f884c7e 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -20,9 +20,6 @@ files are passed as arguments 5, 6 and 7.

 OPTIONS
 -------
-\--::
-	Do not interpret any more arguments as options.
-
 -a::
 	Run merge against all files in the index that need merging.

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 7a493c80f..39caa247a 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -42,9 +42,6 @@ OPTIONS
 --verbose::
 	Report all removed objects.

-\--::
-	Do not interpret any more arguments as options.
-
 --expire <time>::
 	Only expire loose objects older than <time>.

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index b5c46223c..67ea38e46 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -50,11 +50,6 @@ OPTIONS
         Allow recursive removal when a leading directory name is
         given.

-\--::
-	This option can be used to separate command-line options from
-	the list of files, (useful when filenames might be mistaken
-	for command-line options).
-
 --cached::
 	Use this option to unstage and remove paths only from the index.
 	Working tree files, whether modified or not, will be
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 75c7dd9de..3ff5b3460 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -201,9 +201,6 @@ will remove the intended effect of the option.
 	`--untracked-cache` used to imply `--test-untracked-cache` but
 	this option would enable the extension unconditionally.

-\--::
-	Do not interpret any more arguments as options.
-
 <file>::
 	Files to act on.
 	Note that files beginning with '.' are discarded. This includes
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index 61ca6d04c..b546c2192 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -33,9 +33,6 @@ OPTIONS
 	Do not verify the pack contents; only show the histogram of delta
 	chain length.  With `--verbose`, list of objects is also shown.

-\--::
-	Do not interpret any more arguments as options.
-
 OUTPUT FORMAT
 -------------
 When specifying the -v option the format used is:

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
