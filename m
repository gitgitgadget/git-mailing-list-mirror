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
	by dcvr.yhbt.net (Postfix) with ESMTP id 275C61F462
	for <e@80x24.org>; Tue, 18 Jun 2019 20:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfFRUZb (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 16:25:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37582 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfFRUZa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 16:25:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so23606233eds.4
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zwS2nMSbEsRZS5n1FJuk8U8t4YllwgX+MGjEmy+UsA8=;
        b=TnWguPE2qpae42ERaSmj4nNtyJHVekG4e8ZDxFpBFiYxsmoXVNC/xPKQYbj7ycJMzc
         ub50wAGdY91/qEhDSmdZJNYFhYFsgS/KkWA52CYuRkKZRHIFO0atNe+f4iDYT0QIHiGb
         zWzwfpC2j7NRMOiGgCvzHHTeU+cIuTsAB3gzK5Q1lkvCd+A3JH1CannYuDBsPoXIBQXH
         JKP1nO9WuXzzLMPdbQe4rc9Ep60u5s+O43Kmop2z1CFgqUUVYIFrgtXE3RKuvQVTSkYf
         nRPml8TzSFPfLMurD361mtSAc6lXz8Je1aO8mr7MrAjhAlPlLhVp7PPP+qAsd+GEy9Yu
         PWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zwS2nMSbEsRZS5n1FJuk8U8t4YllwgX+MGjEmy+UsA8=;
        b=KZlsM/QFmeg6Vrn8m2LmddzZH4zWX18GL0vkv1gBJRnxjrZ5YgdBeVI9Q4ZmA3YEMM
         rHSGXSed6oKZrkkVGAZ0P3ezyMFYQAGORb+fawjryHVFsTD9rgc3rTEGjpnTi4bFa6E6
         J4Bns6eejC096GCdvUfxL26NPrGfzWvaX9TmfMw+yeOpdj5zS5fjKg0oiabFHEShSaBp
         uf426RoyAdDhamtehUgQZFj8ZmHEdPFj9HaVqEjyPD2DiY9Z99t2lbUWCWtPYPZ2Lft/
         NDS12Lud7/biOY64CFx1hcIMmHRBqwSVLy1icrYmV2dbvKvT7Jqk5BYr2l+HGP+SsfLP
         exfg==
X-Gm-Message-State: APjAAAXVB8GPhaViMZTYkggIyo75P22t/5N2xLEuI4o4Ss/suJi1gENG
        1cwXYuqSVk3KogvYtEQS+tOD6dUG
X-Google-Smtp-Source: APXvYqzn4Re0WSeAISrLhqL5GUXbIFMRWFAI4pNqiTgL7dthDPPaPIubRtafPBb978RhHxYIaBrSOA==
X-Received: by 2002:a50:9822:: with SMTP id g31mr98670599edb.175.1560889528411;
        Tue, 18 Jun 2019 13:25:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y18sm2919973ejh.84.2019.06.18.13.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 13:25:28 -0700 (PDT)
Date:   Tue, 18 Jun 2019 13:25:28 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 20:25:24 GMT
Message-Id: <c9479caf4c6aa099bd49ddb4153051f449feab4c.1560889525.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.273.git.gitgitgadget@gmail.com>
References: <pull.273.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] pull: add --[no-]show-forced-updates passthrough
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     git@jeffhostetler, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git fetch' command can avoid calculating forced updates, so
allow users of 'git pull' to provide that option. This is particularly
necessary when the advice to use '--no-show-forced-updates' is given
at the end of the command.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/pull.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 9dd32a115b..f1eaf6e6ed 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -128,6 +128,7 @@ static char *opt_update_shallow;
 static char *opt_refmap;
 static char *opt_ipv4;
 static char *opt_ipv6;
+static int opt_show_forced_updates = -1;
 
 static struct option pull_options[] = {
 	/* Shared options */
@@ -240,6 +241,8 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU('6',  "ipv6", &opt_ipv6, NULL,
 		N_("use IPv6 addresses only"),
 		PARSE_OPT_NOARG),
+	OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
+		 N_("check for forced-updates on all updated branches")),
 
 	OPT_END()
 };
@@ -549,6 +552,10 @@ static int run_fetch(const char *repo, const char **refspecs)
 		argv_array_push(&args, opt_ipv4);
 	if (opt_ipv6)
 		argv_array_push(&args, opt_ipv6);
+	if (opt_show_forced_updates > 0)
+		argv_array_push(&args, "--show-forced-updates");
+	else if (opt_show_forced_updates == 0)
+		argv_array_push(&args, "--no-show-forced-updates");
 
 	if (repo) {
 		argv_array_push(&args, repo);
-- 
gitgitgadget
