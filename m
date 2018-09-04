Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8211F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeIEByL (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:54:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40049 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEByL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:54:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17-v6so2215297plp.7
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E0pEqUPLoCmVf7Vy4bdssKf5rw/6CVrzrX/vvBj+DLU=;
        b=a0POyT33XLxDcAJKLlk0oJTiWz6+8nT5WP8d91HCYDHR6Wo/jsUOA86zu0/9RwxFxx
         AO4w1Q0quQ1qky0HlmCbhlAe8KtYe8pC7pvCfU5xfUlMcZJFcgB+rr5JUNnj8law4OqA
         X8e5Z1fJvm2Ylj4O3B1hzeTQqCtbVDaXOBJ85KWzhGqpIabpAe1zfwtIY+otGFAK1Ond
         1O8Qgk9cxTFEvu4t+G4DfZdz23ZDXzw9cvGCKPBcRFChNEh4xETDjhQdVEVIai0OKtvm
         eV8P8AylVHNn1KBQPW8vBrcaN4W+0CnWyj47vRR2SFfnVCDGDm/1WOsxRtDzIZFuV4F5
         wgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E0pEqUPLoCmVf7Vy4bdssKf5rw/6CVrzrX/vvBj+DLU=;
        b=XVD8shdl95eHUUlCS0DoKvwXuvBGaQ60Y6Z+cA9msF+DF3N1ChbqEZwlvEaOLm8X5x
         cxaRfSz634jAVv1D1C8itjjH40PG3jp80s4CbuPcQ6h84vmI23f4TmxbotRd88lux9hI
         6Blc916Gwbleng00M1D3QtvimLawuSH+InAEHMiat6NT78e9ajZSOpLLvPxosJTBMth5
         97bbXw/YLxSQpSxxj+hTvLzLHcR3/AfyDmze9JZ/KHxd3QQ5ehHGPWGTLG0I+ZXBCghT
         973OjdW0pS7ptBgIs+b8HoBD2Xi+W53FZGzVKRTeuzpR5Ko5eqwhKZIpOzZ+v14P6wwy
         krKw==
X-Gm-Message-State: APzg51AhtXWcJAK1Hy9qJm2VuCTDlEjccs/niTc+V3dkDo3ndysfFYBL
        QJSVOhG96F1cUNNgeyJrVQYC1iY/
X-Google-Smtp-Source: ANB0VdZLVicBvPZskloMe6EVAVrOjqDVEfyZL42MN9WHXXvrjm0sNYjE+lBcj/J4fpS0rDI6j/oW/w==
X-Received: by 2002:a17:902:42e2:: with SMTP id h89-v6mr34744052pld.69.1536096434220;
        Tue, 04 Sep 2018 14:27:14 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id h85-v6sm37091196pfk.71.2018.09.04.14.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:27:13 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:27:13 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:26:58 GMT
Message-Id: <ce1e1f266a8ec6c31576dfe871b1482015159af0.1536096424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.32.v2.git.gitgitgadget@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <pull.32.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 05/11] builtin rebase: support the `verbose` and `diffstat`
 options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pratik Karki <predatoramigo@gmail.com>

This commit introduces support for the `-v` and `--stat` options of
rebase.

The --stat option can also be configured via the Git config setting
rebase.stat. To support this, we also add a custom rebase_config()
function in this commit that will be used instead of (and falls back to
calling) git_default_config().

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 19fa4d3fc4..2d3f1d65fb 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -18,6 +18,7 @@
 #include "lockfile.h"
 #include "parse-options.h"
 #include "commit.h"
+#include "diff.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
@@ -81,6 +82,8 @@ struct rebase_options {
 	int dont_finish_rebase;
 	enum {
 		REBASE_NO_QUIET = 1<<0,
+		REBASE_VERBOSE = 1<<1,
+		REBASE_DIFFSTAT = 1<<2,
 	} flags;
 	struct strbuf git_am_opt;
 };
@@ -166,6 +169,10 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "GIT_QUIET",
 		opts->flags & REBASE_NO_QUIET ? "" : "t");
 	add_var(&script_snippet, "git_am_opt", opts->git_am_opt.buf);
+	add_var(&script_snippet, "verbose",
+		opts->flags & REBASE_VERBOSE ? "t" : "");
+	add_var(&script_snippet, "diffstat",
+		opts->flags & REBASE_DIFFSTAT ? "t" : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -311,6 +318,21 @@ static int reset_head(struct object_id *oid, const char *action,
 	return ret;
 }
 
+static int rebase_config(const char *var, const char *value, void *data)
+{
+	struct rebase_options *opts = data;
+
+	if (!strcmp(var, "rebase.stat")) {
+		if (git_config_bool(var, value))
+			opts->flags |= REBASE_DIFFSTAT;
+		else
+			opts->flags &= !REBASE_DIFFSTAT;
+		return 0;
+	}
+
+	return git_default_config(var, value, data);
+}
+
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = {
@@ -332,7 +354,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 N_("allow pre-rebase hook to run")),
 		OPT_NEGBIT('q', "quiet", &options.flags,
 			   N_("be quiet. implies --no-stat"),
-			   REBASE_NO_QUIET),
+			   REBASE_NO_QUIET| REBASE_VERBOSE | REBASE_DIFFSTAT),
+		OPT_BIT('v', "verbose", &options.flags,
+			N_("display a diffstat of what changed upstream"),
+			REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
+		{OPTION_NEGBIT, 'n', "no-stat", &options.flags, NULL,
+			N_("do not show diffstat of what changed upstream"),
+			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_END(),
 	};
 
@@ -360,7 +388,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	trace_repo_setup(prefix);
 	setup_work_tree();
 
-	git_config(git_default_config, NULL);
+	git_config(rebase_config, &options);
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
@@ -456,6 +485,33 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			argc ? argv[0] : NULL, NULL))
 		die(_("The pre-rebase hook refused to rebase."));
 
+	if (options.flags & REBASE_DIFFSTAT) {
+		struct diff_options opts;
+
+		if (options.flags & REBASE_VERBOSE)
+			printf(_("Changes from %s to %s:\n"),
+				oid_to_hex(&merge_base),
+				oid_to_hex(&options.onto->object.oid));
+
+		/* We want color (if set), but no pager */
+		diff_setup(&opts);
+		opts.stat_width = -1; /* use full terminal width */
+		opts.stat_graph_width = -1; /* respect statGraphWidth config */
+		opts.output_format |=
+			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
+		opts.detect_rename = DIFF_DETECT_RENAME;
+		diff_setup_done(&opts);
+		diff_tree_oid(&merge_base, &options.onto->object.oid,
+			      "", &opts);
+		diffcore_std(&opts);
+		diff_flush(&opts);
+	}
+
+	/* Detach HEAD and reset the tree */
+	if (options.flags & REBASE_NO_QUIET)
+		printf(_("First, rewinding head to replay your work on top of "
+			 "it...\n"));
+
 	strbuf_addf(&msg, "rebase: checkout %s", options.onto_name);
 	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1))
 		die(_("Could not detach HEAD"));
-- 
gitgitgadget

