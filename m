Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EECD20248
	for <e@80x24.org>; Fri, 22 Feb 2019 22:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfBVWZK (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 17:25:10 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:39911 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBVWZI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 17:25:08 -0500
Received: by mail-ed1-f43.google.com with SMTP id p27so3097994edc.6
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 14:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XtCymizwj1XYxWnQ5U84tXVndJDCA7G0G1rzgs0ilLU=;
        b=q4wCCC1MuaytB4bcLAlE2Z4PigOAZZ6GROhtxPpzIY+Vn2MUYTzPpkSxl0e2TYuiSV
         KpomoDAtp9hv3FRDrmrDCBmXDyfW+YIsZ6tykx0xnDRU60T82qMwnE/Xg1IrBJSEKzuZ
         6Az4TbMkton5R4ZfS622rNRyHikQq7R8i5dKOQn0UVA4u+hwfQ/R0Sym/2kiwNqx+TT1
         Jd2DurR4PvJo7cdYS0VFKhEcUZra1gPzFVXBOkUWXYYAwJVwUP9Puramfppv4EW3MgBp
         B7tT8F8T4w/juD9CkbE+aLZ3lAkzABH9+5L/ZTSz1RQDypCkwQmOmTzRkJFNseSOPLs7
         3hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XtCymizwj1XYxWnQ5U84tXVndJDCA7G0G1rzgs0ilLU=;
        b=oDRhEcT7XN40nZxmVS3GHtTzI7zCJlV6mKBScscXZ1VXqLW1vU62Av5vuSW/ycBjsK
         nFHmTm3EssIPVD/oxoGjKQOu9vOHvugs5pzzU97dnUijE+rYD+sd1RohASpYkwWJzriQ
         6iFrayZpD1jxJmQvZkAVO+Wz/Zto+YePddQP0O8tMFqj+1vWFIQ1p2Sxi1Vn+yHD9HYA
         a/TJqSscXwzJhZR4jlnxCH6V1+R8O5+A06uvSRCxIGwCs2HK7XMpd/OXRrdXNoQy/CKX
         P0YnQQH7u3hmbWxQfqUjE6GMeZnDkqTFVOPfp2ZQ9LG7QnEHO8fqfZU2vV7Vi08xqQrw
         gJYQ==
X-Gm-Message-State: AHQUAub71ZRXXcBsl+dX/Qqwtwk0r1T4m8CaJ554UDGIOL4T7MQU7h35
        IkDKoeG9I54sCHuOjVypv2x1K0Lu
X-Google-Smtp-Source: AHgI3IbkouqAyxnBmcmNnLKIcXXraYNGfwFl6VTPBjl/f9MDBtWREjczRzcPAqIcu3cmvhG/71W7ZQ==
X-Received: by 2002:a05:6402:6d7:: with SMTP id n23mr4948112edy.233.1550874306903;
        Fri, 22 Feb 2019 14:25:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h44sm702718edh.34.2019.02.22.14.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:25:06 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:25:06 -0800 (PST)
X-Google-Original-Date: Fri, 22 Feb 2019 22:24:51 GMT
Message-Id: <18659d61da6aaa0df834f0547b6363c98c0a58b8.1550874298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v7.git.gitgitgadget@gmail.com>
References: <pull.108.v6.git.gitgitgadget@gmail.com>
        <pull.108.v7.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v7 08/15] trace2:data: add trace2 hook classification
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

Classify certain child processes as hooks.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/am.c           | 1 +
 builtin/receive-pack.c | 4 ++++
 builtin/worktree.c     | 1 +
 sequencer.c            | 2 ++
 transport.c            | 1 +
 5 files changed, 9 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 95370313b6..a81e61c1bc 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -468,6 +468,7 @@ static int run_post_rewrite_hook(const struct am_state *state)
 
 	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
 	cp.stdout_to_stderr = 1;
+	cp.trace2_hook_name = "post-rewrite";
 
 	ret = run_command(&cp);
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 33187bd8e9..6eef8575b9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -694,6 +694,8 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	proc.argv = argv;
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
+	proc.trace2_hook_name = hook_name;
+
 	if (feed_state->push_options) {
 		int i;
 		for (i = 0; i < feed_state->push_options->nr; i++)
@@ -807,6 +809,7 @@ static int run_update_hook(struct command *cmd)
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
 	proc.argv = argv;
+	proc.trace2_hook_name = "update";
 
 	code = start_command(&proc);
 	if (code)
@@ -1190,6 +1193,7 @@ static void run_update_post_hook(struct command *commands)
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
+	proc.trace2_hook_name = "post-update";
 
 	if (!start_command(&proc)) {
 		if (use_sideband)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3f9907fcc9..6cc094a453 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -402,6 +402,7 @@ static int add_worktree(const char *path, const char *refname,
 			cp.dir = path;
 			cp.env = env;
 			cp.argv = NULL;
+			cp.trace2_hook_name = "post-checkout";
 			argv_array_pushl(&cp.args, absolute_path(hook),
 					 oid_to_hex(&null_oid),
 					 oid_to_hex(&commit->object.oid),
diff --git a/sequencer.c b/sequencer.c
index 213815dbfc..c1e36196a1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1103,6 +1103,7 @@ static int run_rewrite_hook(const struct object_id *oldoid,
 	proc.argv = argv;
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
+	proc.trace2_hook_name = "post-rewrite";
 
 	code = start_command(&proc);
 	if (code)
@@ -3784,6 +3785,7 @@ static int pick_commits(struct repository *r,
 				hook.in = open(rebase_path_rewritten_list(),
 					O_RDONLY);
 				hook.stdout_to_stderr = 1;
+				hook.trace2_hook_name = "post-rewrite";
 				argv_array_push(&hook.args, post_rewrite_hook);
 				argv_array_push(&hook.args, "rebase");
 				/* we don't care if this hook failed */
diff --git a/transport.c b/transport.c
index 99678153c1..ed5a733c4a 100644
--- a/transport.c
+++ b/transport.c
@@ -1061,6 +1061,7 @@ static int run_pre_push_hook(struct transport *transport,
 
 	proc.argv = argv;
 	proc.in = -1;
+	proc.trace2_hook_name = "pre-push";
 
 	if (start_command(&proc)) {
 		finish_command(&proc);
-- 
gitgitgadget

