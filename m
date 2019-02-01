Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 667A61F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbfBAR7L (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:59:11 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38715 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731515AbfBAR7K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:59:10 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so6151924ede.5
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jvgohm/bki+d8IckhuMJC3Yx/07SLfOhsR5w/P1dvGI=;
        b=KsHjoAdRraqYih2LejkwywQWDEU7+QzQP/neGKJPYncSGl/OCyC1JonHKviKV5zYUK
         fL4FN47uoyyC96iOa1vGV5UTsfBskT0r/makyRyKqQKwKQMEE5jFMrJR9Pgf8FokqIYy
         9dlShMm8b5i8D/K8S3lVZ9L5Fg0X6cxsU+0k0N9Ur4tUC4CCkzLlNUMVqwyOSRhnq/zf
         yFoBnbvbKwS+hOylM+JTyI88nMTiJl4dMFpQZIi1o3HQDXLscy40nrWcQz5gIxNvksor
         VTBwhdyrP2YFJu2cNE1kJFMZYZyfH9T1MccZ2EvHMh72YbOk/9u8CNc1vSSV/sT/0k6n
         2jPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jvgohm/bki+d8IckhuMJC3Yx/07SLfOhsR5w/P1dvGI=;
        b=pUZ31dJaq4eWo22BmVFU4KMYVR5/W2Mc7+N8gGTS++QJQ227YOOkGFg3xy1RMi1WPH
         +xN6foWsRItZYZ1hCNqXq6Kt+0lidTsjbqDV41CMAjLDYsC58weCntbox3sNDBCVQW8X
         Zest82L9WenoplG1Hficueq6sPWaqt9J2JFpHPY2bL/a/2l4G6iApOMGI+rlMbyVf4uo
         38/NdDixc5/eh2uXyh4hOkxhZHRQHXMLyWcRSXBxvaULlQPeF8aTyBplNAYHqVGREctm
         8mHrp4EYpZHDo10flWbBFtJTqETfv2UeZuA8PuFf2l074lVFcm1HZGz9fE6wOW/i8sCO
         Gy9w==
X-Gm-Message-State: AJcUukeDgS6F1xrWBv/Y4Pug2CCN+NyLP+tvP5ZeyJy4YUP5X6fcvy2J
        R0LHwCCDH0bn9bZIwjChTZuAw6qQ
X-Google-Smtp-Source: ALg8bN5v1yX08ZpgkNRfnFQLPN4u1k8TTBd/Vv9mT3+ezoPYCJL2ywJIoD1A6EUWbIuCWPJygHtEKg==
X-Received: by 2002:a50:fc07:: with SMTP id i7mr39900072edr.153.1549043948628;
        Fri, 01 Feb 2019 09:59:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g21sm2186899edc.63.2019.02.01.09.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:59:08 -0800 (PST)
Date:   Fri, 01 Feb 2019 09:59:08 -0800 (PST)
X-Google-Original-Date: Fri, 01 Feb 2019 17:58:52 GMT
Message-Id: <6a82426a83328cf30f6eec436bb365119dee078c.1549043937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v5.git.gitgitgadget@gmail.com>
References: <pull.108.v4.git.gitgitgadget@gmail.com>
        <pull.108.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 11/15] trace2:data: add subverb to checkout command
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

