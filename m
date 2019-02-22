Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D18820248
	for <e@80x24.org>; Fri, 22 Feb 2019 22:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfBVWZM (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 17:25:12 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40415 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfBVWZL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 17:25:11 -0500
Received: by mail-ed1-f66.google.com with SMTP id 10so3089644eds.7
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 14:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jvgohm/bki+d8IckhuMJC3Yx/07SLfOhsR5w/P1dvGI=;
        b=OV+q/8FyKZgvKJgn1ZjLLe6YIvxvDRZN4nbvzf+94hAh6baxemPUxpY+TtG9sgFDrf
         mevOCx1Lv/LDkNsm55yMqYIomhLbX27GviuaeWc70byWkS0FODwZx8FMohvlF1frRXgI
         IOUlKC6yY1heXStla/Fa880f2eYlspt2Nf7qQTGG6sd+tALZHSvBysCLR7nbudEObXtv
         cLuhEOwbjya8Q0Sb+tkfo+zpIQaaX0VZN2IvJ1RgrEIMvtw3kAye+mA3zYw1dacWjpVY
         XtRFbsskimyibjc01hxJElTwze9tpuJzbnKH4oB12kEEkwXMtZhjrZzzKnKnS547FrpM
         /3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jvgohm/bki+d8IckhuMJC3Yx/07SLfOhsR5w/P1dvGI=;
        b=DFq19FMLefTJBWOjGvbXXUftp3VSzonXrWcdpfzjnpJK1r0zs7nEiHOW16yxbngco+
         fwmyFZGE5Jh0JwDOR1fRiT2AHgAHVeLP1s2IPRMmPtK4TNhVcvEEKKWlzK7oUWzo6Nrv
         13A1Z/1ZNlxYOZsWdokJN6kYZ8Djslpn4YDYbZOqD7s3C6j2I13wCjXV4utkox16xDYX
         Owfr7nzVgHIi8d3yS/AAkDEqI7uatC5Q9dO7WuqDDH9Ao4TYwrzMrIJCbaUGvkrxJrx/
         OuBhwLJCQb8kpKe7Ae/SENfQGFObfNx+vfTHBbU0KuoFrynfQL43vDsZR3b8VmVvEQtt
         V+KA==
X-Gm-Message-State: AHQUAuYpDLWv2UISJttlH4syfNP8XsBTO/KMIpvOu+tABvgLCh9+zvVV
        t1ZZZpICBr16nN+VYkxWalDCjvLY
X-Google-Smtp-Source: AHgI3IZU0R3YwMd+kpBdom9RXN+tgnXADj0POx5ervJYzy/GHF9WTJZI29q7lOEmZqMya6xfA0EbVg==
X-Received: by 2002:a50:a55d:: with SMTP id z29mr4985675edb.269.1550874309292;
        Fri, 22 Feb 2019 14:25:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm676275edy.80.2019.02.22.14.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:25:08 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:25:08 -0800 (PST)
X-Google-Original-Date: Fri, 22 Feb 2019 22:24:54 GMT
Message-Id: <2a5aa3a8dc7e580938a72b28f322421f9b1d861e.1550874298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v7.git.gitgitgadget@gmail.com>
References: <pull.108.v6.git.gitgitgadget@gmail.com>
        <pull.108.v7.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v7 11/15] trace2:data: add subverb to checkout command
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

