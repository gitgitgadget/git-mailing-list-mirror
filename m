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
	by dcvr.yhbt.net (Postfix) with ESMTP id CFFEC1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbfKFPvc (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:51:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53207 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfKFPv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:51:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id c17so4090714wmk.2
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 07:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dRkvff0hxl+5T/aZHriidbvavaqv+86FG7Rim8rSqOA=;
        b=Cj8wtn447Tt8c2povuzh/Ya9tgY7Cxc7ttHnEpuycIXuaDhStzWxCoGE+yCDSkwY7A
         e0La9JXAxnEcnsDpBuHEeGEUZ9dSRUWrst+nGV0PvlgM7xHHT1KwBcZc9+9S4AwC3Olo
         0sP48C0+2R+snLWA4DBkLvtY1roc6zLQuSQ7WgEnl4vyXcNViQOM/Rhcpwm7YRVfh/Un
         Lud8x4AsfOSGtnY+ZxKLzwamTFa4bPTnlraTD8Rce+wTlBpZJG0O7iNFxovv0rjqIC9F
         L5v17YgiXivQlD4fd0cQrDgW0rye+E9xbG+I7EPfyQdJwqSfJXt9I6D4G0YGgHX+Wqld
         XmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dRkvff0hxl+5T/aZHriidbvavaqv+86FG7Rim8rSqOA=;
        b=Dhms/yptvgnEpLWOmXB/uiemGK9vur4uLCLxp/4/F3s3BpL7u5XN6iam9p7gQiJyjt
         P/76tCkrRkhra//ff6xphfB2Sap1kz5UDO7UB1U2QztHdCzbmLgxNIjgvFL8PAqM+izx
         SZ3IMdBdACdpmSwPBFF89/yRvS3Yyc0R5y7OpNcDp9qeO1Zs/ZKkrMIz0f48JbZeDhBQ
         A1BKsoV8ZRWc2b1/w1i8wfqNl23NRyFAUoSce47jrhJgnHCR2dT7VaRI/91X3rirgaN/
         AduDAXQs8XNh0o7S13CYMv0VOGL4EpziuvErrDQhako5Xj8JZuuuz9br6o2//WB63pIl
         xzMA==
X-Gm-Message-State: APjAAAWdi8fKHke8XPwyIzCOu47CFW+YWEkLUqOG8GRvMIDaBdYztfZn
        gTZisOwRuyPyEhvuJkW80KBp1Fdk
X-Google-Smtp-Source: APXvYqy9bSncUvkyt5Ht7sXwkwItlhjLE367wU7HWgszqqFX0F1s2DanSre/IWDfB9wMRiTCkb83VQ==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr3336476wmj.127.1573055482659;
        Wed, 06 Nov 2019 07:51:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x7sm47216429wrg.63.2019.11.06.07.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 07:51:22 -0800 (PST)
Message-Id: <d72d4f16b5f77df7cfb4379c9464b2a89cd703f8.1573055478.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 15:51:16 +0000
Subject: [PATCH v2 4/6] reset: support the `--pathspec-from-file` option
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
   `--patch`, even when <file> is not `stdin`. Such use case it not
   really expected. Also, it is harder to support in `git commit`, so
   I decided to make it incompatible in all places.
2) It is not allowed to pass pathspec in both args and file.

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-reset.txt    |  19 +++-
 builtin/reset.c                |  21 ++++-
 t/t7107-reset-pathspec-file.sh | 155 +++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 5 deletions(-)
 create mode 100755 t/t7107-reset-pathspec-file.sh

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index f2ccb1426c..d2cd0af6a4 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -9,20 +9,22 @@ SYNOPSIS
 --------
 [verse]
 'git reset' [-q] [<tree-ish>] [--] <pathspec>...
+'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]
 'git reset' (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
 'git reset' [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
 -----------
-In the first and second form, copy entries from `<tree-ish>` to the index.
-In the third form, set the current branch head (`HEAD`) to `<commit>`,
+In the first three forms, copy entries from `<tree-ish>` to the index.
+In the last form, set the current branch head (`HEAD`) to `<commit>`,
 optionally modifying index and working tree to match.
 The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
 The <pathspec> is used to limit the paths affected by the operation
 (see the entry for 'pathspec' in linkgit:gitglossary[7] for more details).
 
 'git reset' [-q] [<tree-ish>] [--] <pathspec>...::
-	This form resets the index entries for all `<pathspec>` to their
+'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]::
+	These forms reset the index entries matching pathspec to their
 	state at `<tree-ish>`.  (It does not affect the working tree or
 	the current branch.)
 +
@@ -103,6 +105,17 @@ OPTIONS
 	`reset.quiet` config option. `--quiet` and `--no-quiet` will
 	override the default behavior.
 
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
 
 EXAMPLES
 --------
diff --git a/builtin/reset.c b/builtin/reset.c
index 9291c0fd72..246bf9d737 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -31,6 +31,7 @@
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
 	N_("git reset [-q] [<tree-ish>] [--] <pathspec>..."),
+	N_("git reset [-q] [--pathspec-from-file [--pathspec-file-nul]] [<tree-ish>]"),
 	N_("git reset --patch [<tree-ish>] [--] [<pathspec>...]"),
 	NULL
 };
@@ -284,8 +285,8 @@ static int git_reset_config(const char *var, const char *value, void *cb)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
-	int patch_mode = 0, unborn;
-	const char *rev;
+	int patch_mode = 0, pathspec_file_nul = 0, unborn;
+	const char *rev, *pathspec_from_file = NULL;
 	struct object_id oid;
 	struct pathspec pathspec;
 	int intent_to_add = 0;
@@ -306,6 +307,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
+		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 		OPT_END()
 	};
 
@@ -316,6 +319,20 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
+	if (pathspec_from_file) {
+		if (patch_mode)
+			die(_("--pathspec-from-file is incompatible with --patch"));
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
 	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
new file mode 100755
index 0000000000..987cc77b7d
--- /dev/null
+++ b/t/t7107-reset-pathspec-file.sh
@@ -0,0 +1,155 @@
+#!/bin/sh
+
+test_description='reset --pathspec-from-file'
+
+. ./test-lib.sh
+
+test_tick
+
+test_expect_success setup '
+	echo A >fileA.t &&
+	echo B >fileB.t &&
+	echo C >fileC.t &&
+	echo D >fileD.t &&
+	git add . &&
+	git commit --include . -m "Commit" &&
+	git tag checkpoint
+'
+
+restore_checkpoint () {
+	git reset --hard checkpoint
+}
+
+verify_expect () {
+	git status --porcelain -- fileA.t fileB.t fileC.t fileD.t >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success '--pathspec-from-file from stdin' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	echo fileA.t | git reset --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success '--pathspec-from-file from file' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	echo fileA.t >list &&
+	git reset --pathspec-from-file=list &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'NUL delimiters' '
+	restore_checkpoint &&
+
+	git rm fileA.t fileB.t &&
+	printf "fileA.t\0fileB.t\0" | git reset --pathspec-from-file=- --pathspec-file-nul &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	 D fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'LF delimiters' '
+	restore_checkpoint &&
+
+	git rm fileA.t fileB.t &&
+	printf "fileA.t\nfileB.t\n" | git reset --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	 D fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'no trailing delimiter' '
+	restore_checkpoint &&
+
+	git rm fileA.t fileB.t &&
+	printf "fileA.t\nfileB.t" | git reset --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	 D fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'CRLF delimiters' '
+	restore_checkpoint &&
+
+	git rm fileA.t fileB.t &&
+	printf "fileA.t\r\nfileB.t\r\n" | git reset --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	 D fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'quotes' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	printf "\"file\\101.t\"" | git reset --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'quotes not compatible with --pathspec-file-nul' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	printf "\"file\\101.t\"" >list &&
+	# Note: "git reset" has not yet learned to fail on wrong pathspecs
+	git reset --pathspec-from-file=list --pathspec-file-nul &&
+	
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	EOF
+	test_must_fail verify_expect
+'
+
+test_expect_success '--pathspec-from-file is not compatible with --soft or --hard' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	echo fileA.t >list &&
+	test_must_fail git reset --soft --pathspec-from-file=list &&
+	test_must_fail git reset --hard --pathspec-from-file=list
+'
+
+test_expect_success 'only touches what was listed' '
+	restore_checkpoint &&
+
+	git rm fileA.t fileB.t fileC.t fileD.t &&
+	printf "fileB.t\nfileC.t\n" | git reset --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	D  fileA.t
+	 D fileB.t
+	 D fileC.t
+	D  fileD.t
+	EOF
+	verify_expect
+'
+
+test_done
-- 
gitgitgadget

