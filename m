Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2871F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 12:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbeKMWgZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 17:36:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44087 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732895AbeKMWgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 17:36:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id w3-v6so5624028pgs.11
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 04:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sjAxl2p/ZnhvxEKYrcl9SbFcQdgo0WJYkU6s1RoGglE=;
        b=dtqMGg2LkJ7vIu1nHR2W2Y1FKIHYThKbxVnz8Hfwml8xdxmtbNs2yTbydq5rjoGkb6
         COxyb2+H/CVvvvTJBFK1cGt4GFoknN1JHbB/4TTpS9C7V5L47lqX7KSqt5fnXeOlBGZF
         a3QC7TuIwqOJlH3Ufi7jPrSQadoyGACKEok+qMoYc+h5m+J7QvUnTR/8qXSFOYhiiQmN
         ZZ1vJcgdRpl49NYtcPecb/ivdEOg+YfzcVzBagYTP8F+W5HFeHcE2BxkgS+/vqptfQng
         LiJsxvqKJCWRvK+XGTA4xL46oCVYd013PMjV0nrn11axtmvXli7RPVz471sUBQsqCbbv
         5zvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sjAxl2p/ZnhvxEKYrcl9SbFcQdgo0WJYkU6s1RoGglE=;
        b=ZZElowQAalf+CKQTJWsKlS9kaUuSTrY+of18SIYHfNKQ71brb0kWQQkK2C7Z5orQWl
         xeVVO07qXaPYgRkMkmxq8cvPUpYzFAa2fQSNkDIhOAoWa/rAlsmfcb2rdGl0lKqNDXY6
         m5CsKlvnW83VzQdEjGheVNcQ8YPSgv5CrZoUfHtf76dI5yJQPvBysgQf9U+9xHUP1Slm
         r8DpsvxmMyDcQ/V/701nXuVOQ+11974oJbEbcUhSFfD2v8PNkEC7RMHJoi3kiIHGlwU4
         ZpIxkPQMWITv0AAlSEPaqxnhL8OoXs9jEfcvEJzOT6zbsgOHhHm7ER/KcpYgfDOu5+Wk
         wXKQ==
X-Gm-Message-State: AGRZ1gJbHSApNFpwEaI/BdFEEk7fS7Th1REXtUsev/Ayx5RsaZC9hqN2
        Tg7udRbKL8r3a2CcqXzqfF+w740I
X-Google-Smtp-Source: AJdET5cpe1Y515kuZ6UnrOuTFmYL2jmwHER3wlhhnvof8697EcdKH85z6PDBy7MH8IKu+AjxiDZ7Og==
X-Received: by 2002:a62:4105:: with SMTP id o5-v6mr4881337pfa.85.1542112706979;
        Tue, 13 Nov 2018 04:38:26 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id p11sm12350542pgn.60.2018.11.13.04.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 04:38:26 -0800 (PST)
Date:   Tue, 13 Nov 2018 04:38:26 -0800 (PST)
X-Google-Original-Date: Tue, 13 Nov 2018 12:38:22 GMT
Message-Id: <dc36a450680b1854abbb9bb06180001ce68c3f3b.1542112703.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.76.git.gitgitgadget@gmail.com>
References: <pull.76.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] rebase: really just passthru the `git am` options
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
