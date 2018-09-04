Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ACC11F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeIEC1R (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:27:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39571 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeIEC1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:27:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so2357110pff.6
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 15:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s+Ny1KrIwjkuGSLuErfXFRJb3ZGpYIoPqmiQfDzz5wg=;
        b=jCsVrmqvnMWZ71F2LK05Jg2VToVhka2vPAnUv2E5Qtv/Tp48ybEVuh0NVlnICr3ruD
         4KcDYns8XtTybmkfaE5t7vjagYgH8kE0g4W/bKNdCVQYmsY/1I0+C0eXJkkFuyisqziH
         yCw1HP18r6ElbbLLn0Tm8yoE1KU5KN/tsLt74dI6O5p1Z8o6d1ilVWOhEtstE96vyKgg
         zZhLW9A43AJ7FX9LZTU0XagAlAf2cLGDcNPxMSd7QBnuduUVDTPFp7SOS/4mkbeA3VF2
         WNAMsBLuREUW/KfZA5AS6Q+z+2YN4FQ9yv1mF96TZGdolXdzwYQqbOUVGK0xTMTa1dUK
         s0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s+Ny1KrIwjkuGSLuErfXFRJb3ZGpYIoPqmiQfDzz5wg=;
        b=o6VVGXg6ulNTnz5Jjsogg9Sg4Rn3U83X7MG33/kDc+Q4XPOVJVqiqMSgVhY32qtgvu
         g1P0Fp/pMOPAWKZ71JYE0ZZ3m98QY3rrS5VigYV1ciGvlvAjd8TiBTHK8HMBEO1NXpc6
         SfbWjC7PcBL/MzARAX41f+RW2fkn9q0vBbB108r3BxbggOMcFsybNfHrutIrWEt4LZjs
         2uq/idjojoqVpo/hI6ix+fCGHyDQJDsj4Olx0iqXkwLmKnNJZLAKP8zfEl0N9VWQsyID
         cQNRg0gpdkJcTIxAaKnZ8PClNQBhd71WqcQBQ/jaG8qhlomP55cyRz/DaaJ3oMJGwYw5
         ntIA==
X-Gm-Message-State: APzg51BQFitgbkPABpS7JYil6/u82cGB1g1qrDaK/qbDTopWoTOLTWO0
        FXMVPwXDA2Y9939paz5CW0Ao5kjl
X-Google-Smtp-Source: ANB0VdZJa8G7GPpBUGSao2Vyg2hCNlUa71y6UfUHM62EjQrzrE8sWnvsbIAgISNZ7/G3g8pzweFvFA==
X-Received: by 2002:a62:c8d2:: with SMTP id i79-v6mr36752914pfk.35.1536098412124;
        Tue, 04 Sep 2018 15:00:12 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id v7-v6sm34007587pgh.57.2018.09.04.15.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 15:00:11 -0700 (PDT)
Date:   Tue, 04 Sep 2018 15:00:11 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:44 GMT
Message-Id: <10dc87d4ff20a68ccbab904dfbffbd7bf8c7dc35.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 17/18] builtin rebase: add support for custom merge
 strategies
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

When running a rebase in non-am mode, it uses the recursive merge to
cherry-pick the commits, and the rebase command allows to configure
the merge strategy to be used in this operation.

This commit adds that support to the builtin rebase.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6c101e1260..847c7daf1c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -96,6 +96,7 @@ struct rebase_options {
 	char *cmd;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
+	char *strategy, *strategy_opts;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -217,6 +218,22 @@ static int read_basic_state(struct rebase_options *opts)
 		opts->gpg_sign_opt = xstrdup(buf.buf);
 	}
 
+	if (file_exists(state_dir_path("strategy", opts))) {
+		strbuf_reset(&buf);
+		if (read_one(state_dir_path("strategy", opts), &buf))
+			return -1;
+		free(opts->strategy);
+		opts->strategy = xstrdup(buf.buf);
+	}
+
+	if (file_exists(state_dir_path("strategy_opts", opts))) {
+		strbuf_reset(&buf);
+		if (read_one(state_dir_path("strategy_opts", opts), &buf))
+			return -1;
+		free(opts->strategy_opts);
+		opts->strategy_opts = xstrdup(buf.buf);
+	}
+
 	strbuf_release(&buf);
 
 	return 0;
@@ -356,6 +373,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 		opts->rebase_merges ? "t" : "");
 	add_var(&script_snippet, "rebase_cousins",
 		opts->rebase_cousins ? "t" : "");
+	add_var(&script_snippet, "strategy", opts->strategy);
+	add_var(&script_snippet, "strategy_opts", opts->strategy_opts);
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -633,6 +652,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
 	int fork_point = -1;
+	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -717,6 +737,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
 		OPT_BOOL(0, "fork-point", &fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
+		OPT_STRING('s', "strategy", &options.strategy,
+			   N_("strategy"), N_("use the given merge strategy")),
+		OPT_STRING_LIST('X', "strategy-option", &strategy_options,
+				N_("option"),
+				N_("pass the argument through to the merge "
+				   "strategy")),
 		OPT_END(),
 	};
 
@@ -963,6 +989,37 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		imply_interactive(&options, "--rebase-merges");
 	}
 
+	if (strategy_options.nr) {
+		int i;
+
+		if (!options.strategy)
+			options.strategy = "recursive";
+
+		strbuf_reset(&buf);
+		for (i = 0; i < strategy_options.nr; i++)
+			strbuf_addf(&buf, " --%s",
+				    strategy_options.items[i].string);
+		options.strategy_opts = xstrdup(buf.buf);
+	}
+
+	if (options.strategy) {
+		options.strategy = xstrdup(options.strategy);
+		switch (options.type) {
+		case REBASE_AM:
+			die(_("--strategy requires --merge or --interactive"));
+		case REBASE_MERGE:
+		case REBASE_INTERACTIVE:
+		case REBASE_PRESERVE_MERGES:
+			/* compatible */
+			break;
+		case REBASE_UNSPECIFIED:
+			options.type = REBASE_MERGE;
+			break;
+		default:
+			BUG("unhandled rebase type (%d)", options.type);
+		}
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
gitgitgadget

