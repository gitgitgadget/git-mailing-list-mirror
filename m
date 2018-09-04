Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BBF81F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeIEC1N (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:27:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38667 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbeIEC1M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:27:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id t84-v6so477204pgb.5
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 15:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Kx24EvdLUy4tgIErdw7oVf8YIkhTvBB0zWRqw5XvDKU=;
        b=pyPsQ4bp5zyDhRYSsRoV2Nvd0cxwfG1l61IvZXMbPYTGScPKxo7e4b+VL2eLMKMSuT
         PhY09stvdiMgjhU/oW5w/yYiRNV7ReuqE/SrT+IhMlxDVpomlOQMX4+xUep+XzypLSXr
         TcuFIV+3lCQkfNEKvXAk161/3spT/lAjQAyIowR1N3VePpKEhH2iJqI5lEKTl2TRpuk/
         g/96OQUUgWLlqJTQjVi7HNLcIcoPVC4mEN0e4KENUDK0cID6CZ/0PjemB0f2KFMTZJTC
         2BQG3FHkkJc/TQqTbZvJr4ka6W2bk3qm1sF6c7VG+YSCrJk/fg2FQN67ztUZznIuWUfP
         HaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Kx24EvdLUy4tgIErdw7oVf8YIkhTvBB0zWRqw5XvDKU=;
        b=TsCKouKCg7CCvk0LVzkIb8CvNM1gXaRCuYyLM6AkORU/TT09Hp6h+akV+HAjm6bc+9
         uYUMzVaPw940WDhan1IHJE6EzVY2HqJPyPkr3CVoKl7Baxag+1rClc0lwfrkGfY/6a57
         HfqHJ669qHoqozsdvpu+X2ZD8unT5FduE/zjpXaw2IzrqGx+ffQ/jb0QTjTfWqmJNFXJ
         YiYYtsBPBeaKPPcvrimdI6dSopjudrS16K99gEO7I0mLSZOnJ31tZn1vahG94jRtdlgq
         uVOKz9Pw5mAAQNTUE6Tr3a0f8shXY1K+C6aOvXOVSWueA6X+61xJU64t79Avq2me20db
         0maQ==
X-Gm-Message-State: APzg51AxDzFhgUDvYY9X8RbdPI6/JWZ/S8jh03F3QoymHQyf8J8CDYKT
        7Trxjgyjqi2bUsz1H5gw2ju/jUbJ
X-Google-Smtp-Source: ANB0Vdaar8srOuMxVJGafY5K5x1QXk1wohwq5M7e7bKYogo8Ilost8OF3tUYdwa7HWqN6bajyacNiw==
X-Received: by 2002:a63:e914:: with SMTP id i20-v6mr33224961pgh.10.1536098407907;
        Tue, 04 Sep 2018 15:00:07 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id v8-v6sm28202206pff.120.2018.09.04.15.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 15:00:07 -0700 (PDT)
Date:   Tue, 04 Sep 2018 15:00:07 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:41 GMT
Message-Id: <1bebcde41cf42d74278ad520d60255ebd0bbe8c5.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 14/18] builtin rebase: support
 --rebase-merges[=[no-]rebase-cousins]
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

The mode to rebase non-linear branches is now supported by the builtin
rebase, too.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 3e37603da4..bcacffda33 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -95,6 +95,7 @@ struct rebase_options {
 	int autostash;
 	char *cmd;
 	int allow_empty_message;
+	int rebase_merges, rebase_cousins;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -351,6 +352,10 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "cmd", opts->cmd);
 	add_var(&script_snippet, "allow_empty_message",
 		opts->allow_empty_message ?  "--allow-empty-message" : "");
+	add_var(&script_snippet, "rebase_merges",
+		opts->rebase_merges ? "t" : "");
+	add_var(&script_snippet, "rebase_cousins",
+		opts->rebase_cousins ? "t" : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -626,6 +631,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int opt_c = -1;
 	struct string_list whitespace = STRING_LIST_INIT_NODUP;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
+	const char *rebase_merges = NULL;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -704,6 +710,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "allow-empty-message",
 			 &options.allow_empty_message,
 			 N_("allow rebasing commits with empty messages")),
+		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
+			N_("mode"),
+			N_("try to rebase merges instead of skipping them"),
+			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
 		OPT_END(),
 	};
 
@@ -939,6 +949,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.cmd = xstrdup(buf.buf);
 	}
 
+	if (rebase_merges) {
+		if (!*rebase_merges)
+			; /* default mode; do nothing */
+		else if (!strcmp("rebase-cousins", rebase_merges))
+			options.rebase_cousins = 1;
+		else if (strcmp("no-rebase-cousins", rebase_merges))
+			die(_("Unknown mode: %s"), rebase_merges);
+		options.rebase_merges = 1;
+		imply_interactive(&options, "--rebase-merges");
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
gitgitgadget

