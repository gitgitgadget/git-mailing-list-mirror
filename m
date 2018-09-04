Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308311F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeIEC04 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:26:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46553 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeIEC04 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:26:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id t19-v6so2238369ply.13
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RD259SlPc27AS146R5KG6Kv3SVt00C/vmvw+CoeJEG8=;
        b=F8laqhzJrufMqV3K1g5LHcUHhDm4PYhTcju+ktU7rClDdNc0af5p3CKEsyT4vtvxej
         gdo8VsnlU/tCBbylTl/zTep4yDroDWMNy4ujPnLvORKNiT5/ry4QSqfwlA/Qqk31DNYT
         KwFPTNzP8Xy3I8O13gFoQ88GY1PJyddfLaztA5ZveCuXmnawHNsJfqU8Kmh0Km7kilE3
         6kUpiOlzCg0e+0UQfirwVcNUZhJg3EKab/dfFjMrUE7rM7AmjiqDPWGK5R4r2o5TS+kU
         eN0ZpIQZXHEGKYygZYtq41v7ndTyUdf5BpBnUT6ByulWLLykO+Vnrc2J1U54kP2NWIsB
         ptJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RD259SlPc27AS146R5KG6Kv3SVt00C/vmvw+CoeJEG8=;
        b=Ug09hRL8TkFW9oiSoNuNBWwRjcz7CmqRryCfh+FJLrTBCtjWS6On2TdA+CBwl+MxKk
         /0m+nxgGLOWRe4De0/mnT1uni3oNS/sX1IgX5r/ABK6xF5bW9eKGepXpY2MWL7S0aXYf
         6le9eafokUdUYtsaKeeDEzq0MHAiGjrYEAfXNpow18QslWxQ50nqIE+UZbktjn5Jh9wW
         ryLtbUb6zfxd6n0RomEqvIrH3I01hXNRbq16mNSjStD5aV/8Raqitbg7ECw/CS2hwezt
         6NzzpcDi8A9KF/dvjb4Vn1P3gKMOaPLrwobrOam0+Mdhf9RVTUR8UJdXYx5W7a7Bdtjv
         bF7w==
X-Gm-Message-State: APzg51AQnB4XdJh+krlPZAQBYV5Fd65FAj+/CTEijgkFATe8Tg2fNnf8
        GSWomRWgD86vMZTr6HHHEvSwXd5P
X-Google-Smtp-Source: ANB0VdZkynhC4H+u2bz9cUeNEKEcnbyuukCFWAuswlpyfTIjydNEjf7Poi4TrAkvaauFYkWoWUIg5g==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3-v6mr35526022plb.80.1536098391380;
        Tue, 04 Sep 2018 14:59:51 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id g25-v6sm7275pfd.23.2018.09.04.14.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:59:50 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:59:50 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:29 GMT
Message-Id: <1e2ce4b34efa234ebca0c008a3766bb9c998d466.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 02/18] builtin rebase: support --signoff
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

This commit adds support for `--signoff` which is used to add a
`Signed-off-by` trailer to all the rebased commits. The actual
handling is left to the rebase backends.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index fc9b5a8a60..a491481120 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -93,6 +93,7 @@ struct rebase_options {
 	} flags;
 	struct strbuf git_am_opt;
 	const char *action;
+	int signoff;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -168,6 +169,11 @@ static int read_basic_state(struct rebase_options *opts)
 	if (file_exists(state_dir_path("verbose", opts)))
 		opts->flags |= REBASE_VERBOSE;
 
+	if (file_exists(state_dir_path("signoff", opts))) {
+		opts->signoff = 1;
+		opts->flags |= REBASE_FORCE;
+	}
+
 	strbuf_release(&buf);
 
 	return 0;
@@ -249,6 +255,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 	if (opts->switch_to)
 		add_var(&script_snippet, "switch_to", opts->switch_to);
 	add_var(&script_snippet, "action", opts->action ? opts->action : "");
+	add_var(&script_snippet, "signoff", opts->signoff ? "--signoff" : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -513,6 +520,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{OPTION_NEGBIT, 'n', "no-stat", &options.flags, NULL,
 			N_("do not show diffstat of what changed upstream"),
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
+		OPT_BOOL(0, "signoff", &options.signoff,
+			 N_("add a Signed-off-by: line to each commit")),
 		OPT_BIT('f', "force-rebase", &options.flags,
 			N_("cherry-pick all commits, even if unchanged"),
 			REBASE_FORCE),
@@ -745,6 +754,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
+	if (options.signoff) {
+		if (options.type == REBASE_PRESERVE_MERGES)
+			die("cannot combine '--signoff' with "
+			    "'--preserve-merges'");
+		strbuf_addstr(&options.git_am_opt, " --signoff");
+		options.flags |= REBASE_FORCE;
+	}
+
 	if (!options.root) {
 		if (argc < 1)
 			die("TODO: handle @{upstream}");
-- 
gitgitgadget

