Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D4DB1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 16:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeKOC3Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 21:29:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40815 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeKOC3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 21:29:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22-v6so2570453pls.7
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 08:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sjAxl2p/ZnhvxEKYrcl9SbFcQdgo0WJYkU6s1RoGglE=;
        b=knm6ze7PRQC+E4h4mXKnnHO/8oNNP4dxYjDeCUXmZHnXBfQcduIwfno3OBCp+HroPO
         EUKpguDs7Nyhzz1KFO8Hek4yBahvvMWwjerz0PHL5U0eN1y7m/nqNAyiEARzBRsi3Xsp
         HVT0otgyz4KTxWZ3WMjsDL809UYcI1iVCdudY/3ndRcwmgXxL2LJ4fHHcyY2w/JCaG2K
         fe1pblgqcaXWMA28/zglBHY7ZqvsunhJOkSWAALeZ+Qe0grbw09e1E5ZYlgpoC7dCkjp
         voUWSlgOnq30wjwufwRZJPZElXZDgM7HmdWyrqKL2NOWfkYV4uXyTEGlIUBub8Qxl+kR
         gZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sjAxl2p/ZnhvxEKYrcl9SbFcQdgo0WJYkU6s1RoGglE=;
        b=RPo5abpw3Z0uEMfdYBbIA5TxkjgoSvFoR56YB+d8Iqid89Uz/P3uWFW5mUFnIqxMFj
         wxm9PSkOY+UEKoUb9HP8wIhUoKKiMcn5nf/UsqgG8/LuZUGEs0UJDanDVTPcG7t66RAm
         C6wCPHJVVMdhbl+cIUeB0cuvveT4Mfc36n5RUcN76SCyeYzr7mzuGtc7OhWY07AzEz8e
         3cHX4NVws8Wk+osQyHHw2zLtCuMd5uqlSaXOExA6dUxPZv1SdOiqthY+mJ2dLR2KQD7r
         GD+vYsV4mKaY2N6Fh/KXaWxzv9TAu4f71jzhw5lE22gpGTl0wmjo9iE9Z8sMyg0YbDdA
         Oqag==
X-Gm-Message-State: AGRZ1gJ/M5f7eCXs9lNSvLYi2rch7eyFKTsiFCDx5Gtf/X9ETGdTcbJt
        dcClg4gIuCh+/dXxhH2QWu6e1n45
X-Google-Smtp-Source: AJdET5ePxwATZExTsfQrH6GapcpzaE9ydIO5F08FLqn37C7k/bH9/s13ipWieXa/YfCp+r9LvIt2Gg==
X-Received: by 2002:a17:902:1e3:: with SMTP id b90-v6mr2532302plb.117.1542212730728;
        Wed, 14 Nov 2018 08:25:30 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id k14sm25663556pgs.52.2018.11.14.08.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:25:29 -0800 (PST)
Date:   Wed, 14 Nov 2018 08:25:29 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 16:25:24 GMT
Message-Id: <dc36a450680b1854abbb9bb06180001ce68c3f3b.1542212726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.76.v2.git.gitgitgadget@gmail.com>
References: <pull.76.git.gitgitgadget@gmail.com>
        <pull.76.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/2] rebase: really just passthru the `git am` options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Currently, we parse the options intended for `git am` as if we wanted to
handle them in `git rebase`, and then reconstruct them painstakingly to
define the `git_am_opt` variable.

However, there is a much better way (that I was unaware of, at the time
when I mentored Pratik to implement these options): OPT_PASSTHRU_ARGV.
It is intended for exactly this use case, where command-line options
want to be parsed into a separate `argv_array`.

Let's use this feature.

Incidentally, this also allows us to address a bug discovered by Phillip
Wood, where the built-in rebase failed to understand that the `-C`
option takes an optional argument.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 98 +++++++++++++++++-------------------------------
 1 file changed, 35 insertions(+), 63 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0ee06aa363..96ffa80b71 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -87,7 +87,7 @@ struct rebase_options {
 		REBASE_FORCE = 1<<3,
 		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
 	} flags;
-	struct strbuf git_am_opt;
+	struct argv_array git_am_opts;
 	const char *action;
 	int signoff;
 	int allow_rerere_autoupdate;
@@ -339,7 +339,7 @@ N_("Resolve all conflicts manually, mark them as resolved with\n"
 static int run_specific_rebase(struct rebase_options *opts)
 {
 	const char *argv[] = { NULL, NULL };
-	struct strbuf script_snippet = STRBUF_INIT;
+	struct strbuf script_snippet = STRBUF_INIT, buf = STRBUF_INIT;
 	int status;
 	const char *backend, *backend_func;
 
@@ -433,7 +433,9 @@ static int run_specific_rebase(struct rebase_options *opts)
 		oid_to_hex(&opts->restrict_revision->object.oid) : NULL);
 	add_var(&script_snippet, "GIT_QUIET",
 		opts->flags & REBASE_NO_QUIET ? "" : "t");
-	add_var(&script_snippet, "git_am_opt", opts->git_am_opt.buf);
+	sq_quote_argv_pretty(&buf, opts->git_am_opts.argv);
+	add_var(&script_snippet, "git_am_opt", buf.buf);
+	strbuf_release(&buf);
 	add_var(&script_snippet, "verbose",
 		opts->flags & REBASE_VERBOSE ? "t" : "");
 	add_var(&script_snippet, "diffstat",
@@ -756,7 +758,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct rebase_options options = {
 		.type = REBASE_UNSPECIFIED,
 		.flags = REBASE_NO_QUIET,
-		.git_am_opt = STRBUF_INIT,
+		.git_am_opts = ARGV_ARRAY_INIT,
 		.allow_rerere_autoupdate  = -1,
 		.allow_empty_message = 1,
 		.git_format_patch_opt = STRBUF_INIT,
@@ -777,12 +779,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ACTION_EDIT_TODO,
 		ACTION_SHOW_CURRENT_PATCH,
 	} action = NO_ACTION;
-	int committer_date_is_author_date = 0;
-	int ignore_date = 0;
-	int ignore_whitespace = 0;
 	const char *gpg_sign = NULL;
-	int opt_c = -1;
-	struct string_list whitespace = STRING_LIST_INIT_NODUP;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
 	int fork_point = -1;
@@ -804,15 +801,20 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{OPTION_NEGBIT, 'n', "no-stat", &options.flags, NULL,
 			N_("do not show diffstat of what changed upstream"),
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
-		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
-			 N_("passed to 'git apply'")),
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
-		OPT_BOOL(0, "committer-date-is-author-date",
-			 &committer_date_is_author_date,
-			 N_("passed to 'git am'")),
-		OPT_BOOL(0, "ignore-date", &ignore_date,
-			 N_("passed to 'git am'")),
+		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
+				  NULL, N_("passed to 'git am'"),
+				  PARSE_OPT_NOARG),
+		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
+				  &options.git_am_opts, NULL,
+				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
+		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
+				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
+		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
+				  N_("passed to 'git apply'"), 0),
+		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
+				  N_("action"), N_("passed to 'git apply'"), 0),
 		OPT_BIT('f', "force-rebase", &options.flags,
 			N_("cherry-pick all commits, even if unchanged"),
 			REBASE_FORCE),
@@ -856,10 +858,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
 			N_("GPG-sign commits"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-		OPT_STRING_LIST(0, "whitespace", &whitespace,
-				N_("whitespace"), N_("passed to 'git apply'")),
-		OPT_SET_INT('C', NULL, &opt_c, N_("passed to 'git apply'"),
-			    REBASE_AM),
 		OPT_BOOL(0, "autostash", &options.autostash,
 			 N_("automatically stash/stash pop before and after")),
 		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
@@ -884,6 +882,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 N_("rebase all reachable commits up to the root(s)")),
 		OPT_END(),
 	};
+	int i;
 
 	/*
 	 * NEEDSWORK: Once the builtin rebase has been tested enough
@@ -1064,22 +1063,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		    state_dir_base, cmd_live_rebase, buf.buf);
 	}
 
-	if (!(options.flags & REBASE_NO_QUIET))
-		strbuf_addstr(&options.git_am_opt, " -q");
-
-	if (committer_date_is_author_date) {
-		strbuf_addstr(&options.git_am_opt,
-			      " --committer-date-is-author-date");
-		options.flags |= REBASE_FORCE;
+	for (i = 0; i < options.git_am_opts.argc; i++) {
+		const char *option = options.git_am_opts.argv[i];
+		if (!strcmp(option, "--committer-date-is-author-date") ||
+		    !strcmp(option, "--ignore-date") ||
+		    !strcmp(option, "--whitespace=fix") ||
+		    !strcmp(option, "--whitespace=strip"))
+			options.flags |= REBASE_FORCE;
 	}
 
-	if (ignore_whitespace)
-		strbuf_addstr(&options.git_am_opt, " --ignore-whitespace");
-
-	if (ignore_date) {
-		strbuf_addstr(&options.git_am_opt, " --ignore-date");
-		options.flags |= REBASE_FORCE;
-	}
+	if (!(options.flags & REBASE_NO_QUIET))
+		argv_array_push(&options.git_am_opts, "-q");
 
 	if (options.keep_empty)
 		imply_interactive(&options, "--keep-empty");
@@ -1089,23 +1083,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
 	}
 
-	if (opt_c >= 0)
-		strbuf_addf(&options.git_am_opt, " -C%d", opt_c);
-
-	if (whitespace.nr) {
-		int i;
-
-		for (i = 0; i < whitespace.nr; i++) {
-			const char *item = whitespace.items[i].string;
-
-			strbuf_addf(&options.git_am_opt, " --whitespace=%s",
-				    item);
-
-			if ((!strcmp(item, "fix")) || (!strcmp(item, "strip")))
-				options.flags |= REBASE_FORCE;
-		}
-	}
-
 	if (exec.nr) {
 		int i;
 
@@ -1181,23 +1158,18 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	if (options.git_am_opt.len) {
-		const char *p;
-
+	if (options.git_am_opts.argc) {
 		/* all am options except -q are compatible only with --am */
-		strbuf_reset(&buf);
-		strbuf_addbuf(&buf, &options.git_am_opt);
-		strbuf_addch(&buf, ' ');
-		while ((p = strstr(buf.buf, " -q ")))
-			strbuf_splice(&buf, p - buf.buf, 4, " ", 1);
-		strbuf_trim(&buf);
+		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
+			if (strcmp(options.git_am_opts.argv[i], "-q"))
+				break;
 
-		if (is_interactive(&options) && buf.len)
+		if (is_interactive(&options) && i >= 0)
 			die(_("error: cannot combine interactive options "
 			      "(--interactive, --exec, --rebase-merges, "
 			      "--preserve-merges, --keep-empty, --root + "
 			      "--onto) with am options (%s)"), buf.buf);
-		if (options.type == REBASE_MERGE && buf.len)
+		if (options.type == REBASE_MERGE && i >= 0)
 			die(_("error: cannot combine merge options (--merge, "
 			      "--strategy, --strategy-option) with am options "
 			      "(%s)"), buf.buf);
@@ -1207,7 +1179,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (options.type == REBASE_PRESERVE_MERGES)
 			die("cannot combine '--signoff' with "
 			    "'--preserve-merges'");
-		strbuf_addstr(&options.git_am_opt, " --signoff");
+		argv_array_push(&options.git_am_opts, "--signoff");
 		options.flags |= REBASE_FORCE;
 	}
 
-- 
gitgitgadget

