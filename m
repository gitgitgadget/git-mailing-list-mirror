Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CACB61F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfA1Vry (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:47:54 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35857 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfA1Vrw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:47:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so14350693edb.3
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 13:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=717c7OdR6NBnQK3hRwJXlAkwGkauYy96P0xUlww47Sk=;
        b=WE7GCjhWvZeT9H6cflilOi+KbyJYaEjy8kMaFK2Ii8BoURRjzr8xSQhQDyXIO7YemP
         JOG2FHl1vZwm0gEEIUbKAoijahFi3ICf0IL2DDwUVVJo4HxwlLvQDXDtXVPCROZEi2pQ
         7xaAqQD28x0q1mpfFa7eJEnkHU6t4ZfOEufE090W8voV6bSzdB4uNnp43kWxOaweMpz6
         +XmIEiTvK1lBMWBMTdPic87WP5pOm+qhfgNq2EMm1bAf2UGrgMYNR1NDEhMltBx2OElb
         0ppxgrdwTl7iJWSCH5tQBu8pSAt33ucoN0KHXqIInH9X77nYVD/m5LIyAhsT+3WgRcK+
         FulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=717c7OdR6NBnQK3hRwJXlAkwGkauYy96P0xUlww47Sk=;
        b=rPVDptOzlkjpXduvEFciX77ykuAmRpgSqvc8Melyv/fA0j3T2UJ+XuHfSC68PjcbdA
         XM8CUqvnO3y3zJC4CX1cLl812WxgnOR6ZgqS1ifJbfhFuA+GkKb6vJ/KaSNtM2yKrx/d
         zPraXWsbJqYz2I43iPVT0gJ4j3S5rm7YA8pQeG3MhUPHqfYMtqqQ/XjTMQDsmcyeLs53
         JPCCloKoWus5EyC+rqS2KgkPb7x2ATx7plc1PGhwwqVDE/KKgyOd4AXKUJLV6Z9OJHf7
         NfbghO/VavzAQfuXTivsqW9LugZs39cctfH4Ok+uyzcMEakxKV2rFwh3JoYFuPKHcg8X
         2TEQ==
X-Gm-Message-State: AJcUukdAXaSgmDati/ps5sKPivlw/8bq6xD+MlNHpAS+d5SZX6/nfduu
        rVxQX+Yd7R76E7VgJYGEP+fva4G5
X-Google-Smtp-Source: ALg8bN70zYGc3t0mBfv9ReGjaJ8X65IZjUq+XaXPKOOnXUfeat2mJcThFGb6s7upCpkvPttis5Me4A==
X-Received: by 2002:a17:906:4ed8:: with SMTP id i24mr20493562ejv.180.1548712070238;
        Mon, 28 Jan 2019 13:47:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s5-v6sm7811615eji.25.2019.01.28.13.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:47:49 -0800 (PST)
Date:   Mon, 28 Jan 2019 13:47:49 -0800 (PST)
X-Google-Original-Date: Mon, 28 Jan 2019 21:47:36 GMT
Message-Id: <86feec03e2e222657c832870f2ff34290b4d870e.1548712060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v2.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
        <pull.108.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 11/14] trace2:data: add subverb to checkout command
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
index 6fadf412e8..8939ae99ed 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -262,6 +262,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	struct lock_file lock_file = LOCK_INIT;
 	int nr_checkouts = 0;
 
+	trace2_cmd_subverb(opts->patch_mode ? "patch" : "path");
+
 	if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 		die(_("'%s' cannot be used with updating paths"), "--track");
 
@@ -952,6 +954,9 @@ static int switch_branches(const struct checkout_opts *opts,
 	void *path_to_free;
 	struct object_id rev;
 	int flag, writeout_error = 0;
+
+	trace2_cmd_subverb("branch");
+
 	memset(&old_branch_info, 0, sizeof(old_branch_info));
 	old_branch_info.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
 	if (old_branch_info.path)
@@ -1189,6 +1194,8 @@ static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 	int status;
 	struct strbuf branch_ref = STRBUF_INIT;
 
+	trace2_cmd_subverb("unborn");
+
 	if (!opts->new_branch)
 		die(_("You are on a branch yet to be born"));
 	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
-- 
gitgitgadget

