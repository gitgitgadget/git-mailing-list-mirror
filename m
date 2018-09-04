Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919861F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeIEByS (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:54:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33292 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEByS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:54:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id s7-v6so2303501pgc.0
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UFtibGe2SjNG8vtpOv9+xanEFBBHUrUO7/h4SC9lgjo=;
        b=dhG+hhsFY1IbUhaJ/4GJguPavXBaGO+t8/DK3Gn8CLKCcV+WUpWUvwEPRv1UUrYdUu
         D/wbH8Ok5KGwuHvdWRVamFEIdcPWGGWAGQpHN6xCPMPSx8VQ5tZ3shuV0Nj5sn4AwBOK
         rWMfNptfQefW7eaffEWG6bCnOWEew6IEoPIRJ12w3fTDXePEk2miQ7bJsTPhEXOOwnv1
         AzqIM+PWIOsntu0CLFkqlWZfONQ3e80kEQZYDadfRycsIeig5Oa/WUCYstF0lj+Gl32r
         khacLfx4dSEZmsOj/BxrRnPrcvD9n0hUuTOV2AhDGYrSlGHOAzQtiVZWxUaeJHIA0JOM
         RQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UFtibGe2SjNG8vtpOv9+xanEFBBHUrUO7/h4SC9lgjo=;
        b=PD9jX7oQoOkf+0uJdbGeb3KcvAv4URtwFhCJHf4Sk7fnVD7q8Jl0c2sdauK1qr91QT
         JW9+3uJjaJwSzhtrtPgxuSrRU8VrftgEdWxvJJc4hdeAX93aehQYBDW7V+AgSK8s/VXJ
         qSYhxJmuAghoQ0Y3D0DClAT7W6AIu6FXXxwfuY4uCWfwOE+BN7n+gOscbyEVBysKdg7P
         DMRe1dF6TJOGlZRBE1rCc/s96vJ2UNIM7ktrE3WDD6XQZYL4vv12Qwzid7SPgmgj2Xcm
         yMtj20u/sDmFazJX8icoCOfVjMxBNv1D7xjVir9GXBorcnBtEMLRnluOVfQgQJtegMN2
         M7kA==
X-Gm-Message-State: APzg51Dq+oNSoZPThLWoaqpT9fYPrwZkaXQK9WXPr6NPZRbaw5rXx0Se
        6k326Zr4/ik3B7dd4raqImVUahr/
X-Google-Smtp-Source: ANB0VdbY6nDEaJgTEz/aC4qW2xVglakr4vkpTXL7kk3N0tBBkey52zmHrgmM1OxNLL/IN16NNRoAUA==
X-Received: by 2002:a62:411a:: with SMTP id o26-v6mr37269007pfa.111.1536096441057;
        Tue, 04 Sep 2018 14:27:21 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id q80-v6sm31857180pfd.15.2018.09.04.14.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:27:20 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:27:20 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:27:03 GMT
Message-Id: <aab01f0b8e15db37bc17630b4298148aeacf41e2.1536096424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.32.v2.git.gitgitgadget@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <pull.32.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 10/11] builtin rebase: only store fully-qualified refs in
 `options.head_name`
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

When running a rebase on a detached HEAD, we currently store the string
"detached HEAD" in options.head_name. That is a faithful translation of
the shell script version, and we still kind of need it for the purposes of
the scripted backends.

It is poor style for C, though, where we would really only want a valid,
fully-qualified ref name as value, and NULL for detached HEADs, using
"detached HEAD" for display only. Make it so.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index d45f8f9008..afc75fe731 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -169,7 +169,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "upstream_name", opts->upstream_name);
 	add_var(&script_snippet, "upstream",
 				 oid_to_hex(&opts->upstream->object.oid));
-	add_var(&script_snippet, "head_name", opts->head_name);
+	add_var(&script_snippet, "head_name",
+		opts->head_name ? opts->head_name : "detached HEAD");
 	add_var(&script_snippet, "orig_head", oid_to_hex(&opts->orig_head));
 	add_var(&script_snippet, "onto", oid_to_hex(&opts->onto->object.oid));
 	add_var(&script_snippet, "onto_name", opts->onto_name);
@@ -251,6 +252,9 @@ static int reset_head(struct object_id *oid, const char *action,
 		*old_orig = NULL, oid_old_orig;
 	int ret = 0;
 
+	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
+		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
+
 	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
@@ -558,7 +562,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * branch_name -- branch/commit being rebased, or
 	 * 		  HEAD (already detached)
 	 * orig_head -- commit object name of tip of the branch before rebasing
-	 * head_name -- refs/heads/<that-branch> or "detached HEAD"
+	 * head_name -- refs/heads/<that-branch> or NULL (detached HEAD)
 	 */
 	if (argc > 0)
 		 die("TODO: handle switch_to");
@@ -575,7 +579,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				branch_name = options.head_name;
 
 		} else {
-			options.head_name = xstrdup("detached HEAD");
+			free(options.head_name);
+			options.head_name = NULL;
 			branch_name = "HEAD";
 		}
 		if (get_oid("HEAD", &options.orig_head))
-- 
gitgitgadget

