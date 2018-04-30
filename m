Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F83F215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754461AbeD3Pfv (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:35:51 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36649 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeD3Pft (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:35:49 -0400
Received: by mail-lf0-f43.google.com with SMTP id w8-v6so12724772lfe.3
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aaR8HcKj5Lui78Qcg1K0A2XqAnjZw+Hkw5aD4XXInI=;
        b=mPuFIqVdmF5SNayqJN3IIfcQPVlEpgxJRTnoIPh5sMSH0MpUv5lWnXazpx/02Ytuvg
         ojL6ptVzN/Z9SFFhToCfb4SgKGfPh+MKBavv5suel+09HItIQ4298AZlB9qxQh/R8wpB
         wBYR39iAaYmTszVTbivbaZUUffgRCronW7W1Xsh9YBa2XIzmAiAKADYEs3JW1WWnFjVW
         /Aq0xxnY8gl2BOnNuhCZjqm2xNvgdlT55grVook12i8nMq+nd4F1Xu5f8mgnb2kydftC
         Yv+1OVG0AGLD6cS5cMsPC3Nlt+uFFAqbzTGFY0gIKKNZLVq6As+1/YKv7rg458Ao0EtD
         j3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aaR8HcKj5Lui78Qcg1K0A2XqAnjZw+Hkw5aD4XXInI=;
        b=N/Nc41EiqT629RWSLRvlU0sv/A9RNRQelxaVrpMm5Dwmv6lh0HpU6qpMh3VgoNrRHx
         k1KajPSZdkgNidaT4J9O9OnKIy7C6+HZOtie4GaXADfrkKAkqLdvhXj2wPfWfHgni/8/
         KOieL06XbHK6qcLohJqHeiW/4BB5DAKtCwVb8jpKi04GeFBmz2Jztsx3ZkFTfKDwPn1s
         aTRjPst+l+/NHFyXmcxayxmHfRQZbj8De0fxDIALcJG4rwZWr+SwmbjkrLBqrunbliTS
         rGJ88Imy8qwXIuwZtXR2dNi2QMSEMz0bvKMs0A6HVxWyWYovIO/6gbsS0hGm6WGuH+7m
         /H+A==
X-Gm-Message-State: ALQs6tDFXvsf7POnEF/QQfmgwYude1xvpgIoO0dw66EWlT1nSP+RsG21
        HCiN70BOMHZugEeVNVe0pCSjYQ==
X-Google-Smtp-Source: AB8JxZqYD/goSVZ9qaVybAJf/Yjz5kvv72+dhOWp7F5M5oAZvGKcM71hIHT4cmdVZLXWY2SGVTCWzw==
X-Received: by 2002:a2e:9c90:: with SMTP id x16-v6mr5551612lji.13.1525102546108;
        Mon, 30 Apr 2018 08:35:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h5-v6sm1622989lfc.8.2018.04.30.08.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 08:35:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] doc: keep first level section header in upper case
Date:   Mon, 30 Apr 2018 17:35:33 +0200
Message-Id: <20180430153533.13119-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When formatted as a man page, 1st section header is always in upper
case even if we write it otherwise. Make all 1st section headers
uppercase to keep it close to the final output.

This does affect html since case is kept there, but I still think it's
a good idea to maintain a consistent style for 1st section headers.

Some sections perhaps should become second sections instead, where
case is kept, and for better organization. I will update if anyone has
suggestions about this.

While at there I also make some header more consistent (e.g. examples
vs example) and fix a couple minor things here and there.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-add.txt           |  4 ++--
 Documentation/git-apply.txt         |  4 ++--
 Documentation/git-branch.txt        |  4 ++--
 Documentation/git-bundle.txt        |  4 ++--
 Documentation/git-clone.txt         |  2 +-
 Documentation/git-cvsserver.txt     | 10 +++++-----
 Documentation/git-diff-index.txt    |  6 +++---
 Documentation/git-diff-tree.txt     |  2 +-
 Documentation/git-fast-export.txt   |  2 +-
 Documentation/git-fast-import.txt   | 22 +++++++++++-----------
 Documentation/git-filter-branch.txt |  6 +++---
 Documentation/git-fmt-merge-msg.txt |  4 ++--
 Documentation/git-gc.txt            |  4 ++--
 Documentation/git-grep.txt          |  2 +-
 Documentation/git-http-push.txt     |  2 +-
 Documentation/git-imap-send.txt     |  4 ++--
 Documentation/git-index-pack.txt    |  4 ++--
 Documentation/git-ls-files.txt      |  4 ++--
 Documentation/git-name-rev.txt      |  4 ++--
 Documentation/git-p4.txt            |  4 ++--
 Documentation/git-prune.txt         |  6 +++---
 Documentation/git-push.txt          |  4 ++--
 Documentation/git-read-tree.txt     |  4 ++--
 Documentation/git-receive-pack.txt  | 10 +++++-----
 Documentation/git-remote-ext.txt    | 12 ++++++------
 Documentation/git-remote.txt        |  2 +-
 Documentation/git-request-pull.txt  |  4 ++--
 Documentation/git-send-email.txt    |  4 ++--
 Documentation/git-send-pack.txt     |  2 +-
 Documentation/git-shell.txt         |  4 ++--
 Documentation/git-show-branch.txt   |  4 ++--
 Documentation/git-show-ref.txt      |  4 ++--
 Documentation/git-show.txt          |  2 +-
 Documentation/git-update-index.txt  | 20 ++++++++++----------
 Documentation/git-update-ref.txt    |  2 +-
 Documentation/git-var.txt           |  4 ++--
 Documentation/git-web--browse.txt   |  2 +-
 Documentation/gitattributes.txt     |  4 ++--
 38 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index d50fa339dc..45652fe4a6 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -193,7 +193,7 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	for command-line options).
 
 
-Configuration
+CONFIGURATION
 -------------
 
 The optional configuration variable `core.excludesFile` indicates a path to a
@@ -226,7 +226,7 @@ Because this example lets the shell expand the asterisk (i.e. you are
 listing the files explicitly), it does not consider
 `subdir/git-foo.sh`.
 
-Interactive mode
+INTERACTIVE MODE
 ----------------
 When the command enters the interactive mode, it shows the
 output of the 'status' subcommand, and then goes into its
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 4ebc3d3271..ad0888bfcb 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -240,7 +240,7 @@ When `git apply` is used as a "better GNU patch", the user can pass
 the `--unsafe-paths` option to override this safety check.  This option
 has no effect when `--index` or `--cached` is in use.
 
-Configuration
+CONFIGURATION
 -------------
 
 apply.ignoreWhitespace::
@@ -251,7 +251,7 @@ apply.whitespace::
 	When no `--whitespace` flag is given from the command
 	line, this configuration item is used as the default.
 
-Submodules
+SUBMODULES
 ----------
 If the patch contains any changes to submodules then 'git apply'
 treats these changes as follows.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index b3084c99c1..02eccbb931 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -287,7 +287,7 @@ CONFIGURATION
 `--list` is used or implied. The default is to use a pager.
 See linkgit:git-config[1].
 
-Examples
+EXAMPLES
 --------
 
 Start development from a known tag::
@@ -318,7 +318,7 @@ See linkgit:git-fetch[1].
 is currently checked out) does not have all commits from the test branch.
 
 
-Notes
+NOTES
 -----
 
 If you are creating a branch that you want to checkout immediately, it is
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 3a8120c3b3..7d6c9dcd17 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -92,8 +92,8 @@ It is okay to err on the side of caution, causing the bundle file
 to contain objects already in the destination, as these are ignored
 when unpacking at the destination.
 
-EXAMPLE
--------
+EXAMPLES
+--------
 
 Assume you want to transfer the history from a repository R1 on machine A
 to another repository R2 on machine B.
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 42ca7b5095..5a863f9a4c 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -273,7 +273,7 @@ or `--mirror` is given)
 :git-clone: 1
 include::urls.txt[]
 
-Examples
+EXAMPLES
 --------
 
 * Clone from upstream:
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index ba90066f10..37b96c5453 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -207,7 +207,7 @@ allowing access over SSH.
 ------
 
 [[dbbackend]]
-Database Backend
+DATABASE BACKEND
 ----------------
 
 'git-cvsserver' uses one database per Git head (i.e. CVS module) to
@@ -321,7 +321,7 @@ git-cvsserver, as described above.
 When these environment variables are set, the corresponding
 command-line arguments may not be used.
 
-Eclipse CVS Client Notes
+ECLIPSE CVS CLIENT NOTES
 ------------------------
 
 To get a checkout with the Eclipse CVS client:
@@ -346,7 +346,7 @@ offer. In that case CVS_SERVER is ignored, and you will have to replace
 the cvs utility on the server with 'git-cvsserver' or manipulate your `.bashrc`
 so that calling 'cvs' effectively calls 'git-cvsserver'.
 
-Clients known to work
+CLIENTS KNOWN TO WORK
 ---------------------
 
 - CVS 1.12.9 on Debian
@@ -354,7 +354,7 @@ Clients known to work
 - Eclipse 3.0, 3.1.2 on MacOSX (see Eclipse CVS Client Notes)
 - TortoiseCVS
 
-Operations supported
+OPERATIONS SUPPORTED
 --------------------
 
 All the operations required for normal use are supported, including
@@ -424,7 +424,7 @@ For best consistency with 'cvs', it is probably best to override the
 defaults by setting `gitcvs.usecrlfattr` to true,
 and `gitcvs.allBinary` to "guess".
 
-Dependencies
+DEPENDENCIES
 ------------
 'git-cvsserver' depends on DBD::SQLite.
 
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index b380677718..f4bd8155c0 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -37,14 +37,14 @@ include::diff-options.txt[]
 
 include::diff-format.txt[]
 
-Operating Modes
+OPERATING MODES
 ---------------
 You can choose whether you want to trust the index file entirely
 (using the `--cached` flag) or ask the diff logic to show any files
 that don't match the stat state as being "tentatively changed".  Both
 of these operations are very useful indeed.
 
-Cached Mode
+CACHED MODE
 -----------
 If `--cached` is specified, it allows you to ask:
 
@@ -77,7 +77,7 @@ So doing a `git diff-index --cached` is basically very useful when you are
 asking yourself "what have I already marked for being committed, and
 what's the difference to a previous tree".
 
-Non-cached Mode
+NON-CACHED MODE
 ---------------
 The "non-cached" mode takes a different approach, and is potentially
 the more useful of the two in that what it does can't be emulated with
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 7870e175b7..2319b2b192 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -116,7 +116,7 @@ include::pretty-options.txt[]
 include::pretty-formats.txt[]
 
 
-Limiting Output
+LIMITING OUTPUT
 ---------------
 If you're only interested in differences in a subset of files, for
 example some architecture-specific files, you might do:
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index ed57c684db..44098595dd 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -202,7 +202,7 @@ smaller output, and it is usually easy to quickly confirm that there is
 no private data in the stream.
 
 
-Limitations
+LIMITATIONS
 -----------
 
 Since 'git fast-import' cannot tag trees, you will not be
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 3d3d219e58..cdf696ff7f 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -139,7 +139,7 @@ Performance and Compression Tuning
 fastimport.unpackLimit::
 	See linkgit:git-config[1]
 
-Performance
+PERFORMANCE
 -----------
 The design of fast-import allows it to import large projects in a minimum
 amount of memory usage and processing time.  Assuming the frontend
@@ -155,7 +155,7 @@ faster if the source data is stored on a different drive than the
 destination Git repository (due to less IO contention).
 
 
-Development Cost
+DEVELOPMENT COST
 ----------------
 A typical frontend for fast-import tends to weigh in at approximately 200
 lines of Perl/Python/Ruby code.  Most developers have been able to
@@ -165,7 +165,7 @@ an ideal situation, given that most conversion tools are throw-away
 (use once, and never look back).
 
 
-Parallel Operation
+PARALLEL OPERATION
 ------------------
 Like 'git push' or 'git fetch', imports handled by fast-import are safe to
 run alongside parallel `git repack -a -d` or `git gc` invocations,
@@ -186,7 +186,7 @@ this only be used on an otherwise quiet repository.  Using --force
 is not necessary for an initial import into an empty repository.
 
 
-Technical Discussion
+TECHNICAL DISCUSSION
 --------------------
 fast-import tracks a set of branches in memory.  Any branch can be created
 or modified at any point during the import process by sending a
@@ -204,7 +204,7 @@ directory also allows fast-import to run very quickly, as it does not
 need to perform any costly file update operations when switching
 between branches.
 
-Input Format
+INPUT FORMAT
 ------------
 With the exception of raw file data (which Git does not interpret)
 the fast-import input format is text (ASCII) based.  This text based
@@ -1131,7 +1131,7 @@ If the `--done` command-line option or `feature done` command is
 in use, the `done` command is mandatory and marks the end of the
 stream.
 
-Responses To Commands
+RESPONSES TO COMMANDS
 ---------------------
 New objects written by fast-import are not available immediately.
 Most fast-import commands have no visible effect until the next
@@ -1160,7 +1160,7 @@ To avoid deadlock, such frontends must completely consume any
 pending output from `progress`, `ls`, `get-mark`, and `cat-blob` before
 performing writes to fast-import that might block.
 
-Crash Reports
+CRASH REPORTS
 -------------
 If fast-import is supplied invalid input it will terminate with a
 non-zero exit status and create a crash report in the top level of
@@ -1247,7 +1247,7 @@ An example crash:
 	END OF CRASH REPORT
 ====
 
-Tips and Tricks
+TIPS AND TRICKS
 ---------------
 The following tips and tricks have been collected from various
 users of fast-import, and are offered here as suggestions.
@@ -1349,7 +1349,7 @@ Your users will feel better knowing how much of the data stream
 has been processed.
 
 
-Packfile Optimization
+PACKFILE OPTIMIZATION
 ---------------------
 When packing a blob fast-import always attempts to deltify against the last
 blob written.  Unless specifically arranged for by the frontend,
@@ -1380,7 +1380,7 @@ to force recomputation of all deltas can significantly reduce the
 final packfile size (30-50% smaller can be quite typical).
 
 
-Memory Utilization
+MEMORY UTILIZATION
 ------------------
 There are a number of factors which affect how much memory fast-import
 requires to perform an import.  Like critical sections of core
@@ -1458,7 +1458,7 @@ and lazy loading of subtrees, allows fast-import to efficiently import
 projects with 2,000+ branches and 45,114+ files in a very limited
 memory footprint (less than 2.7 MiB per active branch).
 
-Signals
+SIGNALS
 -------
 Sending *SIGUSR1* to the 'git fast-import' process ends the current
 packfile early, simulating a `checkpoint` command.  The impatient
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index b634043183..aae0253379 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -230,7 +230,7 @@ rewrite, the exit status is `2`.  On any other error, the exit status may be
 any other non-zero value.
 
 
-Examples
+EXAMPLES
 --------
 
 Suppose you want to remove a file (containing confidential information
@@ -406,7 +406,7 @@ git filter-branch --index-filter \
 
 
 
-Checklist for Shrinking a Repository
+CHECKLIST FOR SHRINKING A REPOSITORY
 ------------------------------------
 
 git-filter-branch can be used to get rid of a subset of files,
@@ -445,7 +445,7 @@ warned.
   (or if your git-gc is not new enough to support arguments to
   `--prune`, use `git repack -ad; git prune` instead).
 
-Notes
+NOTES
 -----
 
 git-filter-branch allows you to make complex shell-scripted rewrites
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 44892c447e..423b6e033b 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -57,8 +57,8 @@ merge.summary::
 	Synonym to `merge.log`; this is deprecated and will be removed in
 	the future.
 
-EXAMPLE
--------
+EXAMPLES
+--------
 
 ---------
 $ git fetch origin master
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 3126e0dd00..b61fb5751f 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -84,7 +84,7 @@ be performed as well.
 	Force `git gc` to run even if there may be another `git gc`
 	instance running on this repository.
 
-Configuration
+CONFIGURATION
 -------------
 
 The optional configuration variable `gc.reflogExpire` can be
@@ -144,7 +144,7 @@ old a stale working tree should be before `git worktree prune` deletes
 it. Default is "3 months ago".
 
 
-Notes
+NOTES
 -----
 
 'git gc' tries very hard not to delete objects that are referenced
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 18b494731f..312409a607 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -293,7 +293,7 @@ providing this option will cause it to die.
 For more details about the <pathspec> syntax, see the 'pathspec' entry
 in linkgit:gitglossary[7].
 
-Examples
+EXAMPLES
 --------
 
 `git grep 'time_t' -- '*.[ch]'`::
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 2aceb6f26d..ea03a4eeb0 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -55,7 +55,7 @@ OPTIONS
 	The remote refs to update.
 
 
-Specifying the Refs
+SPECIFYING THE REFS
 -------------------
 
 A '<ref>' specification can be either a single pattern, or a pair
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 5d1e4c80cd..032613c420 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -136,8 +136,8 @@ Using direct mode with SSL:
 .........................
 
 
-EXAMPLE
--------
+EXAMPLES
+--------
 To submit patches using GMail's IMAP interface, first, edit your ~/.gitconfig
 to specify your account settings:
 
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 138edb47b6..d5b7560bfe 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -93,8 +93,8 @@ OPTIONS
 --max-input-size=<size>::
 	Die, if the pack is larger than <size>.
 
-Note
-----
+NOTES
+-----
 
 Once the index has been created, the list of object names is sorted
 and the SHA-1 hash of that list is printed to stdout. If --stdin was
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3ac3e3a77d..0f2cee7c26 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -183,7 +183,7 @@ followed by the  ("attr/<eolattr>").
 	Files to show. If no files are given all files which match the other
 	specified criteria are shown.
 
-Output
+OUTPUT
 ------
 'git ls-files' just outputs the filenames unless `--stage` is specified in
 which case it outputs:
@@ -208,7 +208,7 @@ quoted as explained for the configuration variable `core.quotePath`
 verbatim and the line is terminated by a NUL byte.
 
 
-Exclude Patterns
+EXCLUDE PATTERNS
 ----------------
 
 'git ls-files' can use a list of "exclude patterns" when
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index e8e68f528c..5cb0eb0855 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -61,8 +61,8 @@ OPTIONS
 --always::
 	Show uniquely abbreviated commit object as fallback.
 
-EXAMPLE
--------
+EXAMPLES
+--------
 
 Given a commit, find out where it is relative to the local refs. Say somebody
 wrote you about that fantastic commit 33db5f4d9027a10e477ccf054b2c1ab94f74c85a.
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index d8c8f11c9f..b0abe2cb07 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -29,8 +29,8 @@ Submit Git changes back to p4 using 'git p4 submit'.  The command
 the updated p4 remote branch.
 
 
-EXAMPLE
--------
+EXAMPLES
+--------
 * Clone a repository:
 +
 ------------
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index a37c0af931..03552dd86f 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -56,8 +56,8 @@ OPTIONS
 	reachable from any of our references, keep objects
 	reachable from listed <head>s.
 
-EXAMPLE
--------
+EXAMPLES
+--------
 
 To prune objects not used by your repository or another that
 borrows from your repository via its
@@ -67,7 +67,7 @@ borrows from your repository via its
 $ git prune $(cd ../another && git rev-parse --all)
 ------------
 
-Notes
+NOTES
 -----
 
 In most cases, users will not need to call 'git prune' directly, but
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 5b08302fc2..241c4ddbbe 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -423,7 +423,7 @@ reason::
 	refs, no explanation is needed. For a failed ref, the reason for
 	failure is described.
 
-Note about fast-forwards
+NOTE ABOUT FAST-FORWARDS
 ------------------------
 
 When an update changes a branch (or more in general, a ref) that used to
@@ -510,7 +510,7 @@ overwrite it. In other words, "git push --force" is a method reserved for
 a case where you do mean to lose history.
 
 
-Examples
+EXAMPLES
 --------
 
 `git push`::
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index f2a07d54d6..5c70bc2878 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -132,7 +132,7 @@ OPTIONS
 	The id of the tree object(s) to be read/merged.
 
 
-Merging
+MERGING
 -------
 If `-m` is specified, 'git read-tree' can perform 3 kinds of
 merge, a single tree merge if only 1 tree is given, a
@@ -382,7 +382,7 @@ middle of doing, and when your working tree is ready (i.e. you
 have finished your work-in-progress), attempt the merge again.
 
 
-Sparse checkout
+SPARSE CHECKOUT
 ---------------
 
 "Sparse checkout" allows populating the working directory sparsely.
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 86a4b32f0f..dedf97efbb 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -41,7 +41,7 @@ OPTIONS
 <directory>::
 	The repository to sync into.
 
-pre-receive Hook
+PRE-RECEIVE HOOK
 ----------------
 Before any ref is updated, if $GIT_DIR/hooks/pre-receive file exists
 and is executable, it will be invoked once with no parameters.  The
@@ -116,7 +116,7 @@ bail out if the update is not to be supported.
 
 See the notes on the quarantine environment below.
 
-update Hook
+UPDATE HOOK
 -----------
 Before each ref is updated, if $GIT_DIR/hooks/update file exists
 and is executable, it is invoked once per ref, with three parameters:
@@ -138,7 +138,7 @@ ensure the ref will actually be updated, it is only a prerequisite.
 As such it is not a good idea to send notices (e.g. email) from
 this hook.  Consider using the post-receive hook instead.
 
-post-receive Hook
+POST-RECEIVE HOOK
 -----------------
 After all refs were updated (or attempted to be updated), if any
 ref update was successful, and if $GIT_DIR/hooks/post-receive
@@ -198,7 +198,7 @@ after it was updated by 'git-receive-pack', but before the hook was able
 to evaluate it.  It is recommended that hooks rely on sha1-new
 rather than the current value of refname.
 
-post-update Hook
+POST-UPDATE HOOK
 ----------------
 After all other processing, if at least one ref was updated, and
 if $GIT_DIR/hooks/post-update file exists and is executable, then
@@ -216,7 +216,7 @@ if the repository is packed and is served via a dumb transport.
 	exec git update-server-info
 
 
-Quarantine Environment
+QUARANTINE ENVIRONMENT
 ----------------------
 
 When `receive-pack` takes in objects, they are placed into a temporary
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index b25d0b5996..3fc5d94336 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -55,14 +55,14 @@ some tunnel.
 	the vhost field in the git:// service request (to rest of the argument).
 	Default is not to send vhost in such request (if sent).
 
-ENVIRONMENT VARIABLES:
-----------------------
+ENVIRONMENT VARIABLES
+---------------------
 
 GIT_TRANSLOOP_DEBUG::
 	If set, prints debugging information about various reads/writes.
 
-ENVIRONMENT VARIABLES PASSED TO COMMAND:
-----------------------------------------
+ENVIRONMENT VARIABLES PASSED TO COMMAND
+---------------------------------------
 
 GIT_EXT_SERVICE::
 	Set to long name (git-upload-pack, etc...) of service helper needs
@@ -73,8 +73,8 @@ GIT_EXT_SERVICE_NOPREFIX::
 	to invoke.
 
 
-EXAMPLES:
----------
+EXAMPLES
+--------
 This remote helper is transparently used by Git when
 you use commands such as "git fetch <URL>", "git clone <URL>",
 , "git push <URL>" or "git remote add <nick> <URL>", where <URL>
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 4feddc0293..595948da53 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -203,7 +203,7 @@ The remote configuration is achieved using the `remote.origin.url` and
 `remote.origin.fetch` configuration variables.  (See
 linkgit:git-config[1]).
 
-Examples
+EXAMPLES
 --------
 
 * Add a new remote, fetch, and check out a branch from it
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index c32cb0bea1..4d4392d0f8 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -46,8 +46,8 @@ ref that is different from the ref you have locally, you can use the
 its remote name.
 
 
-EXAMPLE
--------
+EXAMPLES
+--------
 
 Imagine that you built your work on your `master` branch on top of
 the `v1.0` release, and want it to be integrated to the project.
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 60cf96f4c1..464c15b94f 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -458,8 +458,8 @@ sendemail.confirm::
 	one of 'always', 'never', 'cc', 'compose', or 'auto'. See `--confirm`
 	in the previous section for the meaning of these values.
 
-EXAMPLE
--------
+EXAMPLES
+--------
 Use gmail as the smtp server
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 To use 'git send-email' to send your patches through the GMail SMTP server,
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index f51c64939b..44fd146b91 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -99,7 +99,7 @@ be in a separate packet, and the list must end with a flush packet.
 	The remote refs to update.
 
 
-Specifying the Refs
+SPECIFYING THE REFS
 -------------------
 
 There are three ways to specify which refs to update on the
diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 54cf2560be..11361f33e9 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -62,8 +62,8 @@ permissions.
 If a `no-interactive-login` command exists, then it is run and the
 interactive shell is aborted.
 
-EXAMPLE
--------
+EXAMPLES
+--------
 
 To disable interactive logins, displaying a greeting instead:
 
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 7818e0f098..262db049d7 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -173,8 +173,8 @@ The "fixes" branch adds one commit "Introduce "reset type" flag to
 The current branch is "master".
 
 
-EXAMPLE
--------
+EXAMPLES
+--------
 
 If you keep your primary branches immediately under
 `refs/heads`, and topic branches in subdirectories of
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index c0aa871c9e..d28e6154c6 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -120,8 +120,8 @@ $ git show-ref --heads --hash
 ...
 -----------------------------------------------------------------------------
 
-EXAMPLE
--------
+EXAMPLES
+--------
 
 To show all references called "master", whether tags or heads or anything
 else, and regardless of how deep in the reference naming hierarchy they are,
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index e73ef54017..0e1695df35 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -77,7 +77,7 @@ EXAMPLES
 	Concatenates the contents of said Makefiles in the head
 	of the branch `master`.
 
-Discussion
+DISCUSSION
 ----------
 
 include::i18n.txt[]
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 3897a59ee9..4e8e762e68 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -228,7 +228,7 @@ will remove the intended effect of the option.
 	cleaner names.
 	The same applies to directories ending '/' and paths with '//'
 
-Using --refresh
+USING --REFRESH
 ---------------
 `--refresh` does not calculate a new sha1 file or bring the index
 up to date for mode/content changes. But what it *does* do is to
@@ -239,7 +239,7 @@ the stat entry is out of date.
 For example, you'd want to do this after doing a 'git read-tree', to link
 up the stat index details with the proper files.
 
-Using --cacheinfo or --info-only
+USING --CACHEINFO OR --INFO-ONLY
 --------------------------------
 `--cacheinfo` is used to register a file that is not in the
 current working directory.  This is useful for minimum-checkout
@@ -261,7 +261,7 @@ useful when the file is available, but you do not wish to update the
 object database.
 
 
-Using --index-info
+USING --INDEX-INFO
 ------------------
 
 `--index-info` is a more powerful mechanism that lets you feed
@@ -317,7 +317,7 @@ $ git ls-files -s
 ------------
 
 
-Using ``assume unchanged'' bit
+USING ``ASSUME UNCHANGED'' BIT
 ------------------------------
 
 Many operations in Git depend on your filesystem to have an
@@ -350,7 +350,7 @@ the index (use `git update-index --really-refresh` if you want
 to mark them as "assume unchanged").
 
 
-Examples
+EXAMPLES
 --------
 To update and refresh only the files already checked out:
 
@@ -387,7 +387,7 @@ M foo.c
 <9> now it checks with lstat(2) and finds it has been changed.
 
 
-Skip-worktree bit
+SKIP-WORKTREE BIT
 -----------------
 
 Skip-worktree bit can be defined in one (long) sentence: When reading
@@ -407,7 +407,7 @@ Although this bit looks similar to assume-unchanged bit, its goal is
 different from assume-unchanged bit's. Skip-worktree also takes
 precedence over assume-unchanged bit when both are set.
 
-Split index
+SPLIT INDEX
 -----------
 
 This mode is designed for repositories with very large indexes, and
@@ -432,7 +432,7 @@ To avoid deleting a shared index file that is still used, its
 modification time is updated to the current time everytime a new split
 index based on the shared index file is either created or read from.
 
-Untracked cache
+UNTRACKED CACHE
 ---------------
 
 This cache is meant to speed up commands that involve determining
@@ -490,7 +490,7 @@ As with the bug described above the solution is to one-off do a "git
 status" run with `core.untrackedCache=false` to flush out the leftover
 bad data.
 
-File System Monitor
+FILE SYSTEM MONITOR
 -------------------
 
 This feature is intended to speed up git operations for repos that have
@@ -518,7 +518,7 @@ file system monitor is added to or removed from the index the next time
 a command reads the index. When `--[no-]fsmonitor` are used, the file
 system monitor is immediately added to or removed from the index.
 
-Configuration
+CONFIGURATION
 -------------
 
 The command honors `core.filemode` configuration variable.  If
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 969bfab2ab..bc8fdfd469 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -120,7 +120,7 @@ modifications are performed.  Note that while each individual
 <ref> is updated or deleted atomically, a concurrent reader may
 still see a subset of the modifications.
 
-Logging Updates
+LOGGING UPDATES
 ---------------
 If config parameter "core.logAllRefUpdates" is true and the ref is one under
 "refs/heads/", "refs/remotes/", "refs/notes/", or the symbolic ref HEAD; or
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 44ff9541df..6072f936ab 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -23,14 +23,14 @@ OPTIONS
 	as well. (However, the configuration variables listing functionality
 	is deprecated in favor of `git config -l`.)
 
-EXAMPLE
+EXAMPLES
 --------
 	$ git var GIT_AUTHOR_IDENT
 	Eric W. Biederman <ebiederm@lnxi.com> 1121223278 -0600
 
 
 VARIABLES
-----------
+---------
 GIT_AUTHOR_IDENT::
     The author of a piece of code.
 
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 2d6b09a43c..a4ec25b450 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -84,7 +84,7 @@ variable exists then 'git web{litdd}browse' will treat the specified tool
 as a custom command and will use a shell eval to run the command with
 the URLs passed as arguments.
 
-Note about konqueror
+NOTE ABOUT KONQUEROR
 --------------------
 
 When 'konqueror' is specified by a command-line option or a
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 1094fe2b5b..ee95d8531d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1141,8 +1141,8 @@ to:
 ------------
 
 
-EXAMPLE
--------
+EXAMPLES
+--------
 
 If you have these three `gitattributes` file:
 
-- 
2.17.0.705.g3525833791

