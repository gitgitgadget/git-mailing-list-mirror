Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30D4B1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfI3Jze (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:55:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54665 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbfI3Jzd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:55:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so12641198wmp.4
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vvWfyWe/pSI2Q4yl+6HpmxNLfmif9NwMsTGV9UJkH8c=;
        b=PNLWK3F8nFFefXV0ziNEOf3JKusEHvip67+Eox3slTI0gPZmk53b2tZZ3EvwyB5M76
         7eUbDpXviPfRQLBjS+5YE8YV2bqEOrDyQluuONeFNWVw2Phg9P4jidIZLB+8aWgOEPuq
         ioIFiz1LJOjKpjOWixqEIc5s3r+nJ5m+R2i5MQWjMFMY7Y12cuxZw2x0jo2h5sHkeURm
         hUg8eAjTq1ly/QVSRvS72LEPnkjBRqyVsc0d/r2LMqhYnc2RowOk2P65tfhw5D+ah8t+
         mC2KHo0whP1gOsgYAT5WY2AuqMu+OS/pJdWWP8+BXKku3cJL6HHgQ/B54ceqEvclHrdK
         fX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vvWfyWe/pSI2Q4yl+6HpmxNLfmif9NwMsTGV9UJkH8c=;
        b=mZzMmjcELF/Y4DgC4iUVcArMyymecAodZIC9KnyBQlEiW7sVINXSat+ydzg+U/mmj8
         O1hmQDJjLPHYvbKPdJnsbSxzztvQ6rxC0y1519K2dhj3aNrZdT72fsjRVW8x9DcTssWt
         wNtdyoboRCfMmHWpHyz8QtgsS9CegTRIdh+aB0eMIKBdZD9UIkPyJcexVsfo8Thm2Tfp
         RL5SkIu54q7zw+gqhbX0dmR5AuZIItf88SI7E9ZRuqDg1MRE84dWoqI0QV76FaPGwPiw
         MptfZJXzvPl4qbItLNsMJc++/bgrqeam81BMu1TkGYFMe3s2NYP/b2PZ0R3dh9GIkChG
         Z6hA==
X-Gm-Message-State: APjAAAWcJaoqO3zsRNO3e5RNzut31De/u1fpSQ/h6jDsBoMW4gF9hW8S
        weRMY0VIRdqErgp0O73ijaM3/FoY
X-Google-Smtp-Source: APXvYqwtUw3FPtY9rL8ZRMjrdiWWVE7713ajTH/EHl6P332EqXbf0iAkiViNs2a8fc4MPV8mWKRh1g==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr16144314wmj.21.1569837331598;
        Mon, 30 Sep 2019 02:55:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x2sm16154249wrn.81.2019.09.30.02.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:55:31 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:55:31 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:55:17 GMT
Message-Id: <4d0b38125a13d85963be5e524becf48271893e2b.1569837329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v2.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 01/13] push: do not pretend to return `int` from
 `die_push_simple()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This function is marked as `NORETURN`, and it indeed does not want to
return anything. So let's not declare it with the return type `int`.
This fixes the following warning when building with MSVC:

	C4646: function declared with 'noreturn' has non-void return type

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/push.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 021dd3b1e4..d216270d5f 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -143,8 +143,8 @@ static int push_url_of_remote(struct remote *remote, const char ***url_p)
 	return remote->url_nr;
 }
 
-static NORETURN int die_push_simple(struct branch *branch,
-				    struct remote *remote)
+static NORETURN void die_push_simple(struct branch *branch,
+				     struct remote *remote)
 {
 	/*
 	 * There's no point in using shorten_unambiguous_ref here,
-- 
gitgitgadget

