Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E1FC201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbdBXUij (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:38:39 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36400 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdBXUic (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:38:32 -0500
Received: by mail-wr0-f195.google.com with SMTP id o22so2687139wro.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 12:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C7kY4GakoZTQRoZUg5OibUinrzdSaW0+n5G+nV+Onxw=;
        b=s8MM5TeFqyZgp+s5vFfeoBoo6mdq7HJI+N2tlaBzAKddvKcQQD03uMU+jk6xvI8EjL
         xaSN18ufElwWCfvUQJverUcP/5/8hJCLMsLzqgQ8ZicCAAf0iugQVwmBCh+sC3JnPEb6
         bHwG4jVnqlW3ePebLkeK7qC7MecWf2V14cvT5A5p9c7A0qd++D1WdL3mXEyhtwFVebck
         2yqXuZEC1Npxi5REekyJFZAxDJ5XWwyqAeTGidFxovxy3eKjJ6gw6tWzCMFQ1vwr0ouM
         PkZRoXHJXww0SS/wl9PBz7Nvku2Y+I9cBBG9EVDpdH2TVAbatZm3Q4cgvSGlV5io1Fku
         eWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C7kY4GakoZTQRoZUg5OibUinrzdSaW0+n5G+nV+Onxw=;
        b=a1yReizKtiWEagoHDxhwl0eowoV2NrrpE6WuopkKy/OSzt2SpQDHqeudGtFzy6F1tD
         UrGCWW+X1T8Y8mZOCekmVXmpONP/D3IfQe9uuBLNXU8bGHzKxZ8SB48kYvoWhbx6xiFX
         bQxiDUeXo3TkJMgLpkDza/Rb7L+wxO04xaqtm+/P1x/Xfi+Uro7hR/kqJM8AT9gSyJH5
         9eKSzdCFCrq49lrcf+eHSh0v0AcNUlf+dBKLA7KLNorAheEv/VqXbGoNhQ+rRuecpsBW
         7+s4VQPRlQDydhlxm/JIFhd1l8voW9YlPpfm2aylHRNVckqffQ9HqMzo4240Jk/wtlcv
         OIYw==
X-Gm-Message-State: AMke39njOBvvp4JMY9Ebm0xJIJln1pdU7qOnqXYuzUP++qerAvPBnwOGDf0hqGyKggtozA==
X-Received: by 10.223.136.168 with SMTP id f37mr4164647wrf.98.1487968710183;
        Fri, 24 Feb 2017 12:38:30 -0800 (PST)
Received: from arrakeen.fritz.box ([2001:a61:1087:f101:3062:f226:b4ec:5b6c])
        by smtp.gmail.com with ESMTPSA id j184sm3224550wmd.31.2017.02.24.12.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 12:38:29 -0800 (PST)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     gitster@pobox.com
Cc:     Andreas Heiduk <asheiduk@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2 2/2] Documentation: Link descriptions of -z to core.quotePath
Date:   Fri, 24 Feb 2017 21:37:56 +0100
Message-Id: <1487968676-6126-3-git-send-email-asheiduk@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1487968676-6126-1-git-send-email-asheiduk@gmail.com>
References: <3c801e54-28c7-52d0-6915-ee7aaf1d89c9@gmail.com>
 <1487968676-6126-1-git-send-email-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linking the description for pathname quoting to the configuration
variable "core.quotePath" removes inconstistent and incomplete
sections while also giving two hints how to deal with it: Either with
"-c core.quotePath=false" or with "-z".

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/diff-format.txt         |  7 ++++---
 Documentation/diff-generate-patch.txt |  7 +++----
 Documentation/diff-options.txt        |  7 +++----
 Documentation/git-apply.txt           |  7 +++----
 Documentation/git-commit.txt          |  9 ++++++---
 Documentation/git-ls-files.txt        | 10 ++++++----
 Documentation/git-ls-tree.txt         | 10 +++++++---
 Documentation/git-status.txt          |  7 +++----
 8 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index cf52626..706916c 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -78,9 +78,10 @@ Example:
 :100644 100644 5be4a4...... 000000...... M file.c
 ------------------------------------------------
 
-When `-z` option is not used, TAB, LF, and backslash characters
-in pathnames are represented as `\t`, `\n`, and `\\`,
-respectively.
+Without the `-z` option, pathnames with "unusual" characters are
+quoted as explained for the configuration variable `core.quotePath`
+(see linkgit:git-config[1]).  Using `-z` the filename is output
+verbatim and the line is terminated by a NUL byte.
 
 diff format for merges
 ----------------------
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index d2a7ff5..231105c 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -53,10 +53,9 @@ The index line includes the SHA-1 checksum before and after the change.
 The <mode> is included if the file mode does not change; otherwise,
 separate lines indicate the old and the new mode.
 
-3.  TAB, LF, double quote and backslash characters in pathnames
-    are represented as `\t`, `\n`, `\"` and `\\`, respectively.
-    If there is need for such substitution then the whole
-    pathname is put in double quotes.
+3.  Pathnames with "unusual" characters are quoted as explained for
+    the configuration variable `core.quotePath` (see
+    linkgit:git-config[1]).
 
 4.  All the `file1` files in the output refer to files before the
     commit, and all the `file2` files refer to files after the commit.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e6215c3..7c28e73 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -192,10 +192,9 @@ ifndef::git-log[]
 	given, do not munge pathnames and use NULs as output field terminators.
 endif::git-log[]
 +
-Without this option, each pathname output will have TAB, LF, double quotes,
-and backslash characters replaced with `\t`, `\n`, `\"`, and `\\`,
-respectively, and the pathname will be enclosed in double quotes if
-any of those replacements occurred.
+Without this option, pathnames with "unusual" characters are munged as
+explained for the configuration variable `core.quotePath` (see
+linkgit:git-config[1]).
 
 --name-only::
 	Show only names of changed files.
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 8ddb207..a7a001b 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -108,10 +108,9 @@ the information is read from the current index instead.
 	When `--numstat` has been given, do not munge pathnames,
 	but use a NUL-terminated machine-readable format.
 +
-Without this option, each pathname output will have TAB, LF, double quotes,
-and backslash characters replaced with `\t`, `\n`, `\"`, and `\\`,
-respectively, and the pathname will be enclosed in double quotes if
-any of those replacements occurred.
+Without this option, pathnames with "unusual" characters are munged as
+explained for the configuration variable `core.quotePath` (see
+linkgit:git-config[1]).
 
 -p<n>::
 	Remove <n> leading slashes from traditional diff paths. The
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 4f8f20a..25dcdcc 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -117,9 +117,12 @@ OPTIONS
 
 -z::
 --null::
-	When showing `short` or `porcelain` status output, terminate
-	entries in the status output with NUL, instead of LF. If no
-	format is given, implies the `--porcelain` output format.
+	When showing `short` or `porcelain` status output, print the
+	filename verbatim and terminate the entries with NUL, instead of LF.
+	If no format is given, implies the `--porcelain` output format.
+	Without the `-z` option, filenames with "unusual" characters are
+	quoted as explained for the configuration variable `core.quotePath`
+	(see linkgit:git-config[1]).
 
 -F <file>::
 --file=<file>::
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 446209e..1cab703 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -77,7 +77,8 @@ OPTIONS
 	succeed.
 
 -z::
-	\0 line termination on output.
+	\0 line termination on output and do not quote filenames.
+	See OUTPUT below for more information.
 
 -x <pattern>::
 --exclude=<pattern>::
@@ -196,9 +197,10 @@ the index records up to three such pairs; one from tree O in stage
 the user (or the porcelain) to see what should eventually be recorded at the
 path. (see linkgit:git-read-tree[1] for more information on state)
 
-When `-z` option is not used, TAB, LF, and backslash characters
-in pathnames are represented as `\t`, `\n`, and `\\`,
-respectively.
+Without the `-z` option, pathnames with "unusual" characters are
+quoted as explained for the configuration variable `core.quotePath`
+(see linkgit:git-config[1]).  Using `-z` the filename is output
+verbatim and the line is terminated by a NUL byte.
 
 
 Exclude Patterns
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index dbc91f9..9dee7be 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -53,7 +53,8 @@ OPTIONS
 	Show object size of blob (file) entries.
 
 -z::
-	\0 line termination on output.
+	\0 line termination on output and do not quote filenames.
+	See OUTPUT FORMAT below for more information.
 
 --name-only::
 --name-status::
@@ -82,8 +83,6 @@ Output Format
 -------------
         <mode> SP <type> SP <object> TAB <file>
 
-Unless the `-z` option is used, TAB, LF, and backslash characters
-in pathnames are represented as `\t`, `\n`, and `\\`, respectively.
 This output format is compatible with what `--index-info --stdin` of
 'git update-index' expects.
 
@@ -95,6 +94,11 @@ Object size identified by <object> is given in bytes, and right-justified
 with minimum width of 7 characters.  Object size is given only for blobs
 (file) entries; for other entries `-` character is used in place of size.
 
+Without the `-z` option, pathnames with "unusual" characters are
+quoted as explained for the configuration variable `core.quotePath`
+(see linkgit:git-config[1]).  Using `-z` the filename is output
+verbatim and the line is terminated by a NUL byte.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 725065e..ba87365 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -322,10 +322,9 @@ When the `-z` option is given, pathnames are printed as is and
 without any quoting and lines are terminated with a NUL (ASCII 0x00)
 byte.
 
-Otherwise, all pathnames will be "C-quoted" if they contain any tab,
-linefeed, double quote, or backslash characters. In C-quoting, these
-characters will be replaced with the corresponding C-style escape
-sequences and the resulting pathname will be double quoted.
+Without the `-z` option, pathnames with "unusual" characters are
+quoted as explained for the configuration variable `core.quotePath`
+(see linkgit:git-config[1]).
 
 
 CONFIGURATION
