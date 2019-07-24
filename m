Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900061F462
	for <e@80x24.org>; Wed, 24 Jul 2019 21:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfGXVPE (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 17:15:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50981 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfGXVPC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 17:15:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so43074675wml.0
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 14:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NKBJkbR+IfW7nt9hEjvH8dApvgeOBzH8HYWlRsdpoAY=;
        b=TgH0Pxit7EL9e+0kL/RUWsBNJ3rDd7Y/bCptl7wHbkvl8lspeUj3JZAkInzdkMmLdO
         Areobt/VpGazo/QiRgZ81bicF/4crO08one1WtBQz3HAhkJktreH7qI9cEtHe/Lrmijn
         XKXMlA+TWiLApc4p6pUVkXexB4hPrB2qS6XPClRSix8ZrqwkQbfdJNROwB9c3baY9QOs
         oKbzEzsV2p/r+/6hs0YsV+AqdtRMsR9EerzFGFd3Aqc919qOeUQdujWu2QN6mQdS5OfH
         IWiAtFabhiZVUnraDS2mXmc4IE2rWgH7HxyoqMPrFi/hjZQDqhpZygvCZetsbBHWND5N
         p9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NKBJkbR+IfW7nt9hEjvH8dApvgeOBzH8HYWlRsdpoAY=;
        b=rEcOjOacFeWTh68JaHZ6PjzrBjOGxNcbxlDppWllyFj8m0rgm3OBVuR1IAgBz3DJgk
         iHde9sE+jBluqCTIIU0RF6dvYgor5VKv9QY1000CIpFteH26l1P9xdh2mtKGolSKlj9/
         nMeA12MaXYmnFVNgMTNRUlb4N3OTkhkaX/dIJMScwOPoUpwe3MN506e5kYpUjEAahucH
         Nqa/by2E4rSyLJOjD5/N5oi8WklpSDZOUJf15E2vpJNHHgYOJWmiFP18S38ttqzueYt9
         SwJVe+lT1KhugmjipY8rLoXMoZ4BDc8uc+5f2wQqQDMCoy1IGJx7Xgw78iXNKDjrTs7r
         yMHA==
X-Gm-Message-State: APjAAAUbpGg4kjfprHoS0RFntX9RYl9a2KDEsb4iMOop3VNapMa3vNIR
        xFu/bUCpl+M4h7n9X7uIrQtO2Gxk
X-Google-Smtp-Source: APXvYqzfDPgMTQvWft9nJw4zFwmjdhGWYgBfecnHvy/Km2IWnpsCH48DenCxkAhRG8ba7dTDuy7Ydg==
X-Received: by 2002:a7b:cf0b:: with SMTP id l11mr79985607wmg.143.1564002900461;
        Wed, 24 Jul 2019 14:15:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm42690460wmf.27.2019.07.24.14.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 14:15:00 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:15:00 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Jul 2019 21:14:57 GMT
Message-Id: <bee82eb36f8dc1bd7d31d4db763d0d0e1b0a4b84.1564002897.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.293.git.gitgitgadget@gmail.com>
References: <pull.293.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] git: mark cmd_rebase as requiring a worktree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We skipped marking the "rebase" built-in as requiring a .git/ directory
and a worktree only to allow to spawn the scripted version of `git
rebase`.

Now that we no longer have that escape hatch, we can change that to the
canonical form.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 4 ----
 git.c            | 7 +------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 798b9ae2d7..b33ec9c7c0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1481,10 +1481,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
-	prefix = setup_git_directory();
-	trace_repo_setup(prefix);
-	setup_work_tree();
-
 	options.allow_empty_message = 1;
 	git_config(rebase_config, &options);
 
diff --git a/git.c b/git.c
index 1bf9c94550..1461e819c3 100644
--- a/git.c
+++ b/git.c
@@ -549,12 +549,7 @@ static struct cmd_struct commands[] = {
 	{ "push", cmd_push, RUN_SETUP },
 	{ "range-diff", cmd_range_diff, RUN_SETUP | USE_PAGER },
 	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
-	/*
-	 * NEEDSWORK: Until the rebase is independent and needs no redirection
-	 * to rebase shell script this is kept as is, then should be changed to
-	 * RUN_SETUP | NEED_WORK_TREE
-	 */
-	{ "rebase", cmd_rebase },
+	{ "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },
 	{ "rebase--interactive", cmd_rebase__interactive, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
-- 
gitgitgadget
