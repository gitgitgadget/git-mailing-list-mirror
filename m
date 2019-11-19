Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84BDE1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 16:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfKSQtI (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 11:49:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41154 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfKSQtD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 11:49:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id b18so23253253wrj.8
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 08:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2qJ2JnwHuR1ld5PUIj6mq6uqSoUsP0jupdV9js+upsU=;
        b=HrNQMZ2Nw50/+lhVSC+E1hfc5dTDkS+kqfkvBA3nObrPonI161hY8ZNI1x2+zxyscs
         CimZO5lTYEaXvaxs2/jTCX4w8GqKM84H1z/TFGBVy8B7k/2ziN+MahPwuLCnAHzit5ck
         KJqqCWBfWO0f3nHG+m1rR9yTNlFubVNbPg72qoRJZx0WTo/b/Ag5GX10xgcupDIfR0q9
         XkEaH6VpL407T7VZpJ7Rgc05Ls+9OJphpKVBt5uTe9EQ3aVRHAqiijrE3msmT0T5TR0t
         Fv7ODCqkDQ2PIrp7gi3Tjn9etd9nQNJsQM48CfOu7vlnFQOS9ycjY/NXejgp163FjLLi
         GMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2qJ2JnwHuR1ld5PUIj6mq6uqSoUsP0jupdV9js+upsU=;
        b=d0MRtJcglIRyVxYt8a27iuM8fg66gzJD7wOcaXebqwN906n8CPRNJBZesUtNBFODfh
         vcXH5pdsESuTXkuKTidZSixIr2j0SI1Cn6H+y3OmsSn+3Wv4c12FOED5R3zVofWS//eW
         qUV4xXJjZHHV/QoFpXkfoyRX6z30S8joE9clVhOAtsGY6EX2dL9ECTEagdVHk9+Nb4zY
         AkxaZGmT9Qp+/HaaiLcTWD2j3aPvQyY5i/uTLlqNSWrYmZWMdkHMGop1YwZRHXAsz/i3
         cdV/X9bGldaXMk5wSYOV7qpaKpCosb1ysRTE9im2m6fUW37twMT6gLtt/ebV355Anvoy
         QWRQ==
X-Gm-Message-State: APjAAAV/v85+0iNvjo5j2NfTrMwiGg9qs/grvM4ZoTdzL8oArtkxZ39v
        bTd17ml/sBHVcVgx5sia2HrXr+FbuJA=
X-Google-Smtp-Source: APXvYqw+M4+C29q2YhTG7F3eeEJPE2CxeWjZbWJkCKfIMozKRfQwAcvL61oefxmGA/pRwa9sC+XUAw==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr38481662wrm.366.1574182141462;
        Tue, 19 Nov 2019 08:49:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a206sm3811989wmf.15.2019.11.19.08.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:49:00 -0800 (PST)
Message-Id: <7e482120020faf403daf8fbd517fbf27cebe452c.1574182135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
References: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
        <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Nov 2019 16:48:55 +0000
Subject: [PATCH v3 6/6] commit: support the --pathspec-from-file option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Decisions taken for simplicity:
1) For now, `--pathspec-from-file` is declared incompatible with
   `--interactive/--patch`, even when <file> is not `stdin`. Such use
   case it not really expected. Also, it would require changes to
   `interactive_add()`.
2) It is not allowed to pass pathspec in both args and file.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-commit.txt    |  16 +++-
 builtin/commit.c                |  25 +++++-
 t/t7526-commit-pathspec-file.sh | 130 ++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 5 deletions(-)
 create mode 100755 t/t7526-commit-pathspec-file.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a0c44978ee..ced5a9beab 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
-	   [-i | -o] [-S[<keyid>]] [--] [<pathspec>...]
+	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
+	   [-S[<keyid>]] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -278,6 +279,19 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 	already been staged. If used together with `--allow-empty`
 	paths are also not required, and an empty commit will be created.
 
+--pathspec-from-file=<file>::
+	Pathspec is passed in `<file>` instead of commandline args. If
+	`<file>` is exactly `-` then standard input is used. Pathspec
+	elements are separated by LF or CR/LF. Pathspec elements can be
+	quoted as explained for the configuration variable `core.quotePath`
+	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
+	global `--literal-pathspecs`.
+
+--pathspec-file-nul::
+	Only meaningful with `--pathspec-from-file`. Pathspec elements are
+	separated with NUL character and all other characters are taken
+	literally (including newlines and quotes).
+
 -u[<mode>]::
 --untracked-files[=<mode>]::
 	Show untracked files.
diff --git a/builtin/commit.c b/builtin/commit.c
index e588bc6ad3..ed40729355 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -107,9 +107,9 @@ static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
-static int no_post_rewrite, allow_empty_message;
+static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
-static char *sign_commit;
+static char *sign_commit, *pathspec_from_file;
 
 /*
  * The default commit message cleanup mode will remove the lines
@@ -343,6 +343,23 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
 
+	if (pathspec_from_file) {
+		if (interactive)
+			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
+
+		if (pathspec.nr)
+			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+
+		parse_pathspec_file(&pathspec, 0,
+				    PATHSPEC_PREFER_FULL,
+				    prefix, pathspec_from_file, pathspec_file_nul);
+	} else if (pathspec_file_nul) {
+		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+	}
+
+	if (!pathspec.nr && (also || (only && !amend && !allow_empty)))
+		die(_("No paths with --include/--only does not make sense."));
+
 	if (read_cache_preload(&pathspec) < 0)
 		die(_("index file corrupt"));
 
@@ -1198,8 +1215,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (also + only + all + interactive > 1)
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
-	if (argc == 0 && (also || (only && !amend && !allow_empty)))
-		die(_("No paths with --include/--only does not make sense."));
 	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
 
 	handle_untracked_files_arg(s);
@@ -1535,6 +1550,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 		/* end commit contents options */
 
 		OPT_HIDDEN_BOOL(0, "allow-empty", &allow_empty,
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
new file mode 100755
index 0000000000..a06b683534
--- /dev/null
+++ b/t/t7526-commit-pathspec-file.sh
@@ -0,0 +1,130 @@
+#!/bin/sh
+
+test_description='commit --pathspec-from-file'
+
+. ./test-lib.sh
+
+test_tick
+
+test_expect_success setup '
+	test_commit file0 &&
+	git tag checkpoint &&
+
+	echo A >fileA.t &&
+	echo B >fileB.t &&
+	echo C >fileC.t &&
+	echo D >fileD.t &&
+	git add fileA.t fileB.t fileC.t fileD.t
+'
+
+restore_checkpoint () {
+	git reset --soft checkpoint
+}
+
+verify_expect () {
+	git diff-tree --no-commit-id --name-status -r HEAD >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success '--pathspec-from-file from stdin' '
+	restore_checkpoint &&
+
+	echo fileA.t | git commit --pathspec-from-file=- -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success '--pathspec-from-file from file' '
+	restore_checkpoint &&
+
+	echo fileA.t >list &&
+	git commit --pathspec-from-file=list -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'NUL delimiters' '
+	restore_checkpoint &&
+
+	printf "fileA.t\0fileB.t\0" | git commit --pathspec-from-file=- --pathspec-file-nul -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileA.t
+	A	fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'LF delimiters' '
+	restore_checkpoint &&
+
+	printf "fileA.t\nfileB.t\n" | git commit --pathspec-from-file=- -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileA.t
+	A	fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'no trailing delimiter' '
+	restore_checkpoint &&
+
+	printf "fileA.t\nfileB.t" | git commit --pathspec-from-file=- -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileA.t
+	A	fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'CRLF delimiters' '
+	restore_checkpoint &&
+
+	printf "fileA.t\r\nfileB.t\r\n" | git commit --pathspec-from-file=- -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileA.t
+	A	fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'quotes' '
+	restore_checkpoint &&
+
+	printf "\"file\\101.t\"" | git commit --pathspec-from-file=- -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileA.t
+	EOF
+	verify_expect expect
+'
+
+test_expect_success 'quotes not compatible with --pathspec-file-nul' '
+	restore_checkpoint &&
+
+	printf "\"file\\101.t\"" >list &&
+	test_must_fail git commit --pathspec-from-file=list --pathspec-file-nul -m "Commit"
+'
+
+test_expect_success 'only touches what was listed' '
+	restore_checkpoint &&
+
+	printf "fileB.t\nfileC.t\n" | git commit --pathspec-from-file=- -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileB.t
+	A	fileC.t
+	EOF
+	verify_expect
+'
+
+test_done
-- 
gitgitgadget
