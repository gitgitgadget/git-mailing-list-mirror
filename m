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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3129B1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 08:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfIZIaM (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 04:30:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37223 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfIZIaL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 04:30:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id w67so1037969lff.4
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vvWfyWe/pSI2Q4yl+6HpmxNLfmif9NwMsTGV9UJkH8c=;
        b=DJVeDjNNbS3aUO+qli+ywX6kRgjraedfZnR1jAVcWDZXwzkNUusWhkEIkE3l5tsvZ5
         o9Uo3bBW/UbE0KJYSspcc6HJHpzmFco0ntzEyW3uOXE65qBzcJuHPxeTLXIZghlgdxoO
         k6SBF7aHbcQ9BbV04xjcU9SpOK55ARPeJbVgkWXPJAxph6uab51fUb72VUFj2R9gLdCW
         JGOGkwehTg7sFy+wxpi7OOCz8qrmUOuHXBeGFok/q+GfIJh8Qiy63hFa4i8e3mAORCto
         xuU5B0DdKc651g6/iltw+EuMiAlaWomc6rGol3E0Kp6ALq9NBaY35wTMEx9S/0uiJhPE
         kaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vvWfyWe/pSI2Q4yl+6HpmxNLfmif9NwMsTGV9UJkH8c=;
        b=Lu23EUUXQs+gu85KHKv8KJFXarcZnZi8t0mZK0iSRSmWk+1Dvq1n10Zb+Bs19YW26Y
         KI+0KH3BtrvmCJr6puzpKikSU/RYpTrwJxBfFpc4pH3qXwh6Ta1JJqW1lzS95NUjQ8AE
         IDE4HaTZXG0FKaRc5+APsMKptLNeoFYRZU5ahSRdXKwZ2vkxiSsNQLXxxZ3AHbKU1Kq8
         P/89F1/K0eEBeb0Az9IDnNHvATC8eX7KfMz7/8uWruBIx/jHtxpPdLGacIuPvKHy5p/r
         LyFckOcakL8SRfd2kOwOSzo0xGJJZJTIYnXORMwGhejPfUARAF0NhMPu/aFZRI2DNuCl
         kH7w==
X-Gm-Message-State: APjAAAVL8T7o2J9sa4PArL/ZV1euFt/FrCcNVghodU8lsHoLfPJQWAtA
        dZqFy0k0CvjMy5c0mT0x1t7VygTb
X-Google-Smtp-Source: APXvYqzBIy+az3wp2qZ/FDtlpCkFFw4DbeE5B/DnMGJE52GCRI21QGv+IFMxjUWgfSzzb4vyPbn7Mw==
X-Received: by 2002:a19:f707:: with SMTP id z7mr1459373lfe.142.1569486610091;
        Thu, 26 Sep 2019 01:30:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3sm349911ljn.78.2019.09.26.01.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:30:09 -0700 (PDT)
Date:   Thu, 26 Sep 2019 01:30:09 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 08:29:54 GMT
Message-Id: <4d0b38125a13d85963be5e524becf48271893e2b.1569486607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 01/13] push: do not pretend to return `int` from
 `die_push_simple()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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

