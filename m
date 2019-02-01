Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6ACF1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbfBAR7J (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:59:09 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:34926 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbfBAR7I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:59:08 -0500
Received: by mail-ed1-f46.google.com with SMTP id x30so6172453edx.2
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XtCymizwj1XYxWnQ5U84tXVndJDCA7G0G1rzgs0ilLU=;
        b=EIUsLjxGOVplaZ9NpxX6KbSrHErnQaUuU6BtbeqT2b8HlDy5lRwwMpUWgO+hHwZyQ+
         bZn7o9teZk2/EZRGgfm9dmVX078niDBqWulraOwo2/xQnmhS/FqFzPfx3FibHEzJhesO
         PKpUlfti5gB6dAkeNKiyYjxSY+R8RlhHsK3OaN6RQ2Nb83de+C4+QWGpr4e6uWx5WX62
         KJDUUZwh+kuzBPTk1y+3+xQq/mfcdAFJjVmIkj5tqV9JlmfKjqD1d5jZOxV+2hjpc2Tk
         LizzwgczkiseN7mVS/gvXkbHQzoYq4DioamDZw7jkvLPsfXmBhJoLnHg7KeKbTd3tR+8
         C2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XtCymizwj1XYxWnQ5U84tXVndJDCA7G0G1rzgs0ilLU=;
        b=uQ+ntH/sF6eQeSDGnHO2u7VR6mNDqrv7H/5vxnO/e3sjdcUYFpFifCpWS2gS7jfmcz
         noR3m3bvoLoWUVoYBo7wFzjI2lg3ZVzyv7tj3b9GvZsmHEWTpvUima6o/BP7M5UoAurd
         ed4VNOZJYVV0y4hWkQYYtkY3SrxLAriT5UEaL80CC1epbCZRYxjfG36Up5fzF6tVenWW
         6FKxrH/ZzQRUTOuM5pUtarnmzZQ76ATDciMH6cy3vkFFCnd9ZIRh1EdKF9KqlrrwYwlE
         967s9SB6+Z/RoILcwo1za+CmR/I8iY8jPOPoi1nkW6y37nbtmKcfRCBNyjAoP0vNzt9K
         8N/g==
X-Gm-Message-State: AHQUAuYV0J02i5j0njpq5S3v/QHcNzx9uk1EDyPZMF1k406usIaUkvd9
        W1Q2uU8jatZegDB0Npt4CYcP+oXf
X-Google-Smtp-Source: AHgI3IbzpN0BAiWtHmlTQ/zOVAlVQAkSuCXFznIU5XKCH8VS+vHvLWsycGDBQEsDKNwPZMbIwCp9Aw==
X-Received: by 2002:a17:906:1191:: with SMTP id n17mr15121019eja.47.1549043945909;
        Fri, 01 Feb 2019 09:59:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f35sm2137230edd.80.2019.02.01.09.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:59:05 -0800 (PST)
Date:   Fri, 01 Feb 2019 09:59:05 -0800 (PST)
X-Google-Original-Date: Fri, 01 Feb 2019 17:58:49 GMT
Message-Id: <c2c1ea5ce35bef92770d6c46b850f3fbc607da67.1549043936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v5.git.gitgitgadget@gmail.com>
References: <pull.108.v4.git.gitgitgadget@gmail.com>
        <pull.108.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 08/15] trace2:data: add trace2 hook classification
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

