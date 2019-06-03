Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC54D1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 20:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfFCUSa (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 16:18:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35195 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfFCUS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 16:18:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id p26so28652316edr.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 13:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5/B5/z/z9v1fVD0ZfdgAc+gdmEH5R30ot33lXTKNB5A=;
        b=GcBGaEhL5vk4X3CoKv1Kurr4nb5necNUtcO+LAT7YodLaeoMSORlnZv+YJl0AjbMfP
         U2oda4IdZNgr6pWrE64XXiIqPelYlbIzT5y2wARG4R7IzIwv1KjlHmGQfd1CW/3VppVR
         /iN03K6JQAAAPjnT+6c4bINm8veeC//wxRA5/8o4OQsXWSS2UjigFtc5z8RSvzl5rHHs
         mSbJYa52JV+cRj0PQUPzkLh07qndrL4nbiG9H31i2ZvG6aOoTLpdovNz6kHErgrtHAKj
         dMNKBji77WBoJJdDslI9bvz9cUuThmGSoVPJpZUVFLNLpcJ90QFCzyBCjR7Eb7YuVzsx
         pIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5/B5/z/z9v1fVD0ZfdgAc+gdmEH5R30ot33lXTKNB5A=;
        b=Sic6m5S7jCdh4ybavPtuisAAfuQP2KnwWm7dA/NWyoLkokenrfdyHyZ1d/zKzLGLyz
         nrCVF2ZyeLLJF6Qrw47RMKckEgzGztJU/T99/MAm5V12qjY3IHQD+DMQiR7vcFqMlIpv
         L6bNQVJ6A8kx5Gd8E/p3ZUq53R8s6GQ59+P336/NMeLPzyzxWAavQ5REJ+HRfuD79Q1S
         kAspkd9WmwwJGPvAXlRMrNyLuZ8XaaOjlmSWespYa2pMgKgIyf7a2UFpN3/znx6X5P6t
         L4HGocsEdJ1xCnElV6NBbsQG9+kE+QKrgquTJr9NdeQ46BpfUjWHxRUsEuVJUkbishIF
         kEaw==
X-Gm-Message-State: APjAAAVHtTV50jb6ky1s/+bDEDG2jp1s8eccCANzDMUfsuOsGCvwNcRJ
        mySaTGA6sH6+9YRyFw5C87M5MB66
X-Google-Smtp-Source: APXvYqzGKOZyQItAq1cHzlbSm67rd/gLYK50EXAzqIOyamVbaCNfNRxG7RRQ5Hbvt/Tma80B5TB9LQ==
X-Received: by 2002:a17:906:1e0a:: with SMTP id g10mr25869288ejj.127.1559593106290;
        Mon, 03 Jun 2019 13:18:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm426835edb.64.2019.06.03.13.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:18:25 -0700 (PDT)
Date:   Mon, 03 Jun 2019 13:18:25 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 20:18:16 GMT
Message-Id: <637aebc8ac1b90a3c7eed859c5d2c054f637a4b6.1559593097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 10/11] pull: add --[no-]show-forced-updates passthrough to
 fetch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

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

