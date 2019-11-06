Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D78BE1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbfKFPv2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:51:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43403 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731931AbfKFPv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:51:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so26436419wra.10
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 07:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lPFpIHP8kKACgUUXfyeiF5OKzMMDfNtfeN8KJB0Lxz0=;
        b=eyxre4vZNxJD7yUIsSTZZT18ebGGHiV36zzC88SpQNLKuLeOE8KJzAyrStTJwGQZdH
         SVjhnvZdYfDfjljp5d9FYOLdn60tHedyhL/bf/W47wyvxaHj8GTkqXmY7HtDcEQcs3/L
         favt/HTlcmEG67Z5neGK6z+tlL1gzCILNd6LrGCveRMg0uzAombUUGe/Wpzzw7D31At3
         Zv3eR5KpcIdFEQMHY7SNIrKzh+ch4ieZFsh1gXfhFH3lsUAd9TkVaQfA/vxbOjbcNELT
         IsRdOSX0oqxqKCLtTw9DKaTereW/CIUSnC8Nd9e/3NRoBlc4iOq8YnmgxEynzTr+NQ2r
         8jTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lPFpIHP8kKACgUUXfyeiF5OKzMMDfNtfeN8KJB0Lxz0=;
        b=igU3Gbv1vZ3pLA+dCjq3D2/Zvxi6lJlxtz/1mgWeGdFe86QUaDeWInCkdzzUDI4ZpK
         XXUYR9/XtIxnB8EiT7hrlXvQp2PCrHLQnrxZ0uh8XWx9S92vQMjzD7uS7uE495etvbUV
         3IMzHEDT8DyRuS/QYQY6HGuvVI6YrwYI0qJf0B6GDnZRtVsR2M/8x2q+GGukS0NaWtCk
         JEjuF9SbuLHH4AnxJrdW2/B8FKVlOox4I69F4aFPFXJHognCdZWdvlMPkOfp5Uak4RR7
         76Zs7jMEH88jr0poOM4X+Ln139Lr/tgeFuydUsB4PXuD3R3+2gL5iWlMvMCqutwNSGM5
         8+ug==
X-Gm-Message-State: APjAAAVCmr60eofRW0+AoXJEGICj2XRxVWdIOj1QorFwwFph/w9u78R5
        /16F4aolY6h8bAiVEQti7NrHMcB6
X-Google-Smtp-Source: APXvYqz2JS+Xf0WJM22+Iq5AKp2P7Z+8xht7IO0ilDlRnGvPoHYNIRGWMesCWXDJmIPDtvYyO+dZJw==
X-Received: by 2002:adf:9323:: with SMTP id 32mr3334038wro.15.1573055483948;
        Wed, 06 Nov 2019 07:51:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm19409620wrp.49.2019.11.06.07.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 07:51:23 -0800 (PST)
Message-Id: <cb5fc9b14dbe81703a7fc61b56f5c68c4a49ebc2.1573055478.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 15:51:18 +0000
Subject: [PATCH v2 6/6] commit: support the --pathspec-from-file option
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
 Documentation/git-commit.txt    |  15 +++-
 builtin/commit.c                |  25 +++++-
 t/t7526-commit-pathspec-file.sh | 130 ++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 5 deletions(-)
 create mode 100755 t/t7526-commit-pathspec-file.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 915c212a0d..bbd53959bd 100644
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
@@ -277,6 +278,18 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 	the last commit without committing changes that have
 	already been staged. If used together with `--allow-empty`
 	paths are also not required, and an empty commit will be created.
+	
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
+	separated with NUL character and are not expected to be quoted.
 
 -u[<mode>]::
 --untracked-files[=<mode>]::
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
index 0000000000..4fdf206dd0
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
