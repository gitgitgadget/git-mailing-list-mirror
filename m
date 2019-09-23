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
	by dcvr.yhbt.net (Postfix) with ESMTP id 888071F463
	for <e@80x24.org>; Mon, 23 Sep 2019 18:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfIWSfC (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 14:35:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33227 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfIWSfB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 14:35:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id i30so2727032pgl.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mGYUyRdlM+ndZ66evrjh2vHHd6b7OE70UcHC/IGIytw=;
        b=aQhtqJc/ldTR8CJSRNdO7cZo/tpWkxcJYu+09o3+1KBW6KgQsAhfKkutFBERy1WqYQ
         s1QXJiQOiX2mRUiYI5Bg2QjHxo0hra1WSClPRYS23Qh2oKbcp5D7r3Z+FAYkHCNYl3RZ
         CAL2zuAdCO0/gf2gEBpWpBj3pL/IaChmAF5bmtPhUZ3hncgFI0wJlMnZaMtekSI6e1Cc
         QZhZAq61kEVQG4x54swlmDyA9RM7kUL8cRoelIZD/7MATMRE93vLNfS+bLbIhOYoJjAj
         PRmBNOYRo7ySTdX7J92vDYCK91DxVBIxQRHBJABMaSquodAX6hnzLtMpSWjIvjXK1K0o
         vWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mGYUyRdlM+ndZ66evrjh2vHHd6b7OE70UcHC/IGIytw=;
        b=EccyW66bSg/iVnbOhFgqll+J4OzhMn2zzljgNJAVDrP5Ia+6ah1d8G5mPasnFnB02l
         NrLfp7fp5PfHXhMkrVU1rN//Kfxy12nl7tkrHLn6ZhJJKWtIjn1296lmyySufTPeXjQ4
         qS75C/DOcUpYxvuS00Wd8Vi2897jzdtIA3CGtSBoKvraj3HE6MxXo1kXpzTtNmNXnlez
         voHdFVZcyCQ7gHe7gm5CQ4MtvWDm9aujLz5sXqdi9xnCoTlFGk5y7j71dXB0hMxjpo3V
         Ihml2liTjaSJvYNUc5tx6qGmzLg9j+dsR+J94lr0XFKqYqTSo17mSOKgEpuq1aTegWqM
         ifJw==
X-Gm-Message-State: APjAAAVg8wILG9Ry2xRtk4Ucx+quVVvOJOjxbREe2roC5+l/G5qQMbGG
        XyPIEfd/8qhfNmqVzEwLcUtpK+xg
X-Google-Smtp-Source: APXvYqynFQOT9F9AENgjA0S92dE8k1UvJTdnoNBdF/h1tWgw1SE9t1EOvOVQn4+5umwjieeFUtlAQA==
X-Received: by 2002:a63:4755:: with SMTP id w21mr1313642pgk.122.1569263700114;
        Mon, 23 Sep 2019 11:35:00 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id q204sm12550634pfc.11.2019.09.23.11.34.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:34:59 -0700 (PDT)
Date:   Mon, 23 Sep 2019 11:34:58 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] promisor-remote.h: include missing header
Message-ID: <8ccbd81673dc83e3292e7b1227b5acf536bcd2b3.1569263631.git.liu.denton@gmail.com>
References: <cover.1569263631.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569263631.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we ran `make hdr-check`, we got the following warning message:

	promisor-remote.h:21:46: warning: declaration of 'struct repository' will not be visible outside of this function [-Wvisibility]
	extern int promisor_remote_get_direct(struct repository *repo,
						     ^
	1 warning generated.

This was caused by a missing reference to `struct repository`, which is
defined in "repository.h".

Include this missing header to fix this warning.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 promisor-remote.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/promisor-remote.h b/promisor-remote.h
index 8200dfc940..76e8d86c7c 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -1,6 +1,8 @@
 #ifndef PROMISOR_REMOTE_H
 #define PROMISOR_REMOTE_H
 
+#include "repository.h"
+
 struct object_id;
 
 /*
-- 
2.23.0.565.g1cc52d20df

