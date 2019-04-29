Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28C941F453
	for <e@80x24.org>; Mon, 29 Apr 2019 20:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfD2UOf (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 16:14:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41075 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbfD2UOY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 16:14:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so10290274edd.8
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=Y39lxs1+tGytldKfUDrOu28A/2/KraLOpfyeQMqv7kA=;
        b=t3gUGZm9RUizAwElr9naeT8hj7F/cq2wT5p2sWcWk9GGYT2TwJEwc3YyUT4TSlRgaI
         wMxqlOJ4N58OWe0O6PNeVhDlCHJa/Tyb8SZl33yPVAnEvPgQIRnAzNzq9I+hI7144eIc
         aKAiIcCNTQ9ouJ4uVk1CjIPTtBuGZSpEcKE8eW5zzQoRUoop0dRXLrk5mqhX8pFrF+rc
         9lp9sFbu5rUJA+jpNTVx90xjP+OQyXM/W2bNKyD5JdLLaPDUDY1aDFVJkX0GkXwkz4RP
         78FX1J9Rg4F0FXOfYiTKDETO7X4sljMRnKW9RcN8BUmvAh5W2Oposn1FElHiK+cJVjYv
         0ZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=Y39lxs1+tGytldKfUDrOu28A/2/KraLOpfyeQMqv7kA=;
        b=eU2ZwI7/qmKqdbwEGD91RXLaqRuWsXWOj4KU/eMe9uZiFylioKPmy5VXCOP97PqRw5
         AmxxoLDZS+q+U8A+9hbVoTbs54Ml0+qpCPZm1uwxQUrBUBgS15ctX26+5szJBFLXLuhv
         Y4DGi45cGuhjz1hITIfH/HtsWuKuIZ3yf3Tpcx+yeNepRxZIS9MUDo+kGkLvYdAVulQ2
         HcJi55hB5Lj7QbwrHxMszyUAWmSwtzCf7iGJ9nn/thW+y1Iq6rLGe3OtWix3MafYLzth
         PgSZY1wz+k88yqmE+6+rsWb6ybpR6kLYs4za3A9FOv9BE1z0oaYV5F51h3Um0sMkr2jF
         PLgw==
X-Gm-Message-State: APjAAAUyb2fTGtp2IzmDeJbvdPt9LYnbYf+WjfxlzEx3nT+Y092vJDsp
        VZPtMxBKF1dlpgT2tAAj5DBwWLeg
X-Google-Smtp-Source: APXvYqyRB1xCBeQ67yfa31TYuB+P0NyzvrZiRQCe8jXvmvortDeMHOmqVn7i+igdddCgi8UbiIREvA==
X-Received: by 2002:a50:b662:: with SMTP id c31mr6025289ede.252.1556568863094;
        Mon, 29 Apr 2019 13:14:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e21sm2066465ejk.86.2019.04.29.13.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:14:22 -0700 (PDT)
Date:   Mon, 29 Apr 2019 13:14:22 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 20:14:11 GMT
Message-Id: <18ce7953609f5d9d5165cb443138ebf7e3026795.1556568852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v5.git.gitgitgadget@gmail.com>
References: <pull.169.v4.git.gitgitgadget@gmail.com>
        <pull.169.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 11/11] trace2: fixup access problem on /etc/gitconfig in
 read_very_early_config
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach do_git_config_sequence() to optionally gently check for access to
the system config.  Use this option in read_very_early_config() when
initializing trace2.

In [1] SZEDER Gábor reported that my changes in [2] introduced a
regression when the user does not have permission to read the system
config.

This commit addresses that problem by optionally ignoring that error.

[1] https://public-inbox.org/git/285beb2b2d740ce20fdd8af1becf371ab39703db.1554995916.git.gitgitgadget@gmail.com/T/#m342e839289aec515523a98b5e34d7f42d3f1fd79
[2] https://public-inbox.org/git/285beb2b2d740ce20fdd8af1becf371ab39703db.1554995916.git.gitgitgadget@gmail.com/T/#m11b59c9228c698442f750ee8f9b10c629399ae48

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 config.c | 5 ++++-
 config.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index d7a08713a8..3f5ad9dc3c 100644
--- a/config.c
+++ b/config.c
@@ -1676,7 +1676,9 @@ static int do_git_config_sequence(const struct config_options *opts,
 		repo_config = NULL;
 
 	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
-	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
+	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK,
+						  opts->system_gently ?
+						  ACCESS_EACCES_OK : 0))
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
 					    data);
 
@@ -1807,6 +1809,7 @@ void read_very_early_config(config_fn_t cb, void *data)
 	opts.ignore_repo = 1;
 	opts.ignore_worktree = 1;
 	opts.ignore_cmdline = 1;
+	opts.system_gently = 1;
 
 	config_with_options(cb, data, NULL, &opts);
 }
diff --git a/config.h b/config.h
index 6a58d61d22..36bb23a9d9 100644
--- a/config.h
+++ b/config.h
@@ -58,6 +58,7 @@ struct config_options {
 	unsigned int ignore_repo : 1;
 	unsigned int ignore_worktree : 1;
 	unsigned int ignore_cmdline : 1;
+	unsigned int system_gently : 1;
 	const char *commondir;
 	const char *git_dir;
 	config_parser_event_fn_t event_fn;
-- 
gitgitgadget
