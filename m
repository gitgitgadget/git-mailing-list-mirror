Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D32F1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfBFRQJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:16:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37967 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbfBFRQF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:16:05 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so6542856ede.5
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jvgohm/bki+d8IckhuMJC3Yx/07SLfOhsR5w/P1dvGI=;
        b=XQAeHkFrpWTD+75Ws8/cdTy8fwX30kdsukxYTDNyLzv6hDEaVzHFwp282Ft3WyLxb+
         oKKB9RNIVpVGGM5FCyMGb21AdN4Lb9A195X/UXn3Q4lM29qYDL0dVHoyAzlGUg28g0j+
         IwIGOsGqwecgL/3yeUJEks/a2v99Y5wUzJKsqY1FhsusvoWNr68kLVQg6n9a5kPal0Ps
         xetV7SW/MmR55K4hmh9sG1aTry5OaMGz+Nr1SyRz0Y8KJzc7k1FJc2xCpCAw5AaOsWwN
         oSUFSJomy3zC7yAOb60uwnh9OO4Mi4j2NCbltizJ5dHXrqSdXrAb1GteBmidDE1AMGRb
         2N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jvgohm/bki+d8IckhuMJC3Yx/07SLfOhsR5w/P1dvGI=;
        b=luvRQxAluDMsKxz5sGDqVlriS+Ofcr+9zL8yNq3lgz7glz8pN9LCXXVSCdo8XXVfYY
         6DIWGxTUmKNzHhcZbQTZa1B+USMHFbuM1Yc9ekHIYWKw6k61EkWrmF15lza3KUIEFvyD
         8VG9tmnLMik9V3ZAvoXcSs4w9F8ghzHtHU3qnQXH7DCnvzn5EzAkq1UwFNAGO5GwiIcL
         WEOI+AZtKWEyYliNDAAk/d0eXsV/3EBEph+zaroC6sVa6W69iAIyUAffjwdcHlIhWTRY
         plAIIoAdWDvg5szaseN3JfblARBEGZGRHrnF6La2xnt7h3PkXKkU9RIgJEgXKLP3Z6ks
         uYQw==
X-Gm-Message-State: AHQUAuZtoCATbZ9cEEnw3L9XyOvoGajH7WoaOP27FTuF3DnLUowJqd0r
        6a/MH94h9qBnw+7re1QIf9EM3VCr
X-Google-Smtp-Source: AHgI3Ib+0krLyUs9Y4B9xnQJO2+HvtoRixIQzUyRrqwPze4QVvzGjIzwzTubBpXO5Txskb1gvRQGZw==
X-Received: by 2002:a17:906:6447:: with SMTP id l7mr2417839ejn.156.1549473362949;
        Wed, 06 Feb 2019 09:16:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m20sm3653529ejs.68.2019.02.06.09.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:16:02 -0800 (PST)
Date:   Wed, 06 Feb 2019 09:16:02 -0800 (PST)
X-Google-Original-Date: Wed, 06 Feb 2019 17:15:46 GMT
Message-Id: <0191283fffe37f78ac9b7e056b41cbd4f90f2a0b.1549473350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v6.git.gitgitgadget@gmail.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
        <pull.108.v6.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 11/15] trace2:data: add subverb to checkout command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/checkout.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6fadf412e8..f911c88bb4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -262,6 +262,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	struct lock_file lock_file = LOCK_INIT;
 	int nr_checkouts = 0;
 
+	trace2_cmd_mode(opts->patch_mode ? "patch" : "path");
+
 	if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 		die(_("'%s' cannot be used with updating paths"), "--track");
 
@@ -952,6 +954,9 @@ static int switch_branches(const struct checkout_opts *opts,
 	void *path_to_free;
 	struct object_id rev;
 	int flag, writeout_error = 0;
+
+	trace2_cmd_mode("branch");
+
 	memset(&old_branch_info, 0, sizeof(old_branch_info));
 	old_branch_info.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
 	if (old_branch_info.path)
@@ -1189,6 +1194,8 @@ static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 	int status;
 	struct strbuf branch_ref = STRBUF_INIT;
 
+	trace2_cmd_mode("unborn");
+
 	if (!opts->new_branch)
 		die(_("You are on a branch yet to be born"));
 	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
-- 
gitgitgadget

