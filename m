Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FB2A1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbfA3TvV (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:51:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42609 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733063AbfA3TvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:51:16 -0500
Received: by mail-ed1-f68.google.com with SMTP id y20so613935edw.9
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 11:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=717c7OdR6NBnQK3hRwJXlAkwGkauYy96P0xUlww47Sk=;
        b=bnFTlZOqPElS9G4NsIXCAynlCgdwsg69FR1XhD9JZe20T1BReuBNQq9M2IMajKHIvw
         /JxrBwWt+hCfyE9dbP5sz82KbZGlG6swvmPhcyKfnXP3G9uCtuCOE4mk8Y37ZjhnH7Hw
         9Xm92OANV5zr8D2OA/q6UQ8KbwsCAAFRHe5H15lUryupZq4baBtZWkDVUxitFSy2PIed
         8PICgSg92VuFxrq90izGafjqRRzL4rgi1j2PfrFv36y45NcEiIhV/Bs2nHUgZuGLCOSR
         82Qt7KAl6Ys1owKPniclVTbMAd8/e4EJgeHNlUlaVOShpgPdFpkAMqatjtvDGmMSWwx0
         y1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=717c7OdR6NBnQK3hRwJXlAkwGkauYy96P0xUlww47Sk=;
        b=btQU8GRiM5pUcAcVrX4/7hkpxPdEjnEC8mlqatxKCXPQseo+H8IbXzp5C3UpRrKKc4
         bis/vB1PrbDR/r/O1QtKpVnJPD/2Y+mP47pNDjUBbAJWbf09ai9JADim9fVX8emiV4U+
         4nO3RuvE5q+byrnlGL/98Em7cZvI+nsVYqcm8PlM3Cu3wCEw2rb5cw5y2GrIn24CFAT8
         2Y+s/z71P9YrVi7uhS5mfXqbOfytKr635KER4weoxeQVOqnTT8xAQB3gSmdRDrLKW3v/
         xUdoJzErqaXq2BpmimXg2noAdMaEyCSU40zd1NehIJYLCeGwCSKpohbnd9gCrjC2S+GF
         si/g==
X-Gm-Message-State: AJcUukdib8TEVBSIvMtV7/QgzKZq8SJ2fckHxDV9Pcr4J0UDF3QDCYWw
        RfPcs44E75NpL99+6HQEKvfgCOL9
X-Google-Smtp-Source: ALg8bN7h/WEDIwSNjAVsMRzHhhUzBDjosU5FKA3+LCh7IxZLOQ2k8iag2Ca3oJt+js0J4b2ate2OOg==
X-Received: by 2002:a17:906:6201:: with SMTP id s1mr28225705ejk.66.1548877874615;
        Wed, 30 Jan 2019 11:51:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm714032edy.49.2019.01.30.11.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:51:14 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:51:14 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 19:51:00 GMT
Message-Id: <33e431be8812732235b6d5555e2c589fc85a8223.1548877863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v3.git.gitgitgadget@gmail.com>
References: <pull.108.v2.git.gitgitgadget@gmail.com>
        <pull.108.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 11/14] trace2:data: add subverb to checkout command
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

