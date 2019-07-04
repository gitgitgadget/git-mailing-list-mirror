Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C4B1F461
	for <e@80x24.org>; Thu,  4 Jul 2019 22:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfGDWhA (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 18:37:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45505 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfGDWg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 18:36:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id a14so6561124edv.12
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S+15odrXhALJBc1LsmekKklTe/3YE7TfvcUPAAJ2orA=;
        b=WyTjdis6qWlklfvT85aGIrxuETHfO5R1uuCn2LlfVlucVZB4VedAn1I+4tbMzmlC88
         KCenuCK4wgNUZSdJSVmTa3tuTe0vwPugWAOnlAn+BtGD9E2blGg+gqhQNa8n1oerwsoz
         5mC0A/48fitqDoVSnik+ui2PL2CvVrnIkGZDkJjpZXtXQ3ylZUtsWsCmuRIQjav8jLeu
         hyXld2+rzr1qE3Zs2I7/pUl0i3LzYMtM+j3mjj0f/vXVqpF0tw5IeQVx8ruvuj0dKhAg
         Qh/DNL3hrKcUZ0XyMJgoC5QrkNA5SDE+rzO+Nw5Lhm4K8vtlCATkLBcpa4LT8NplBVR0
         4o5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S+15odrXhALJBc1LsmekKklTe/3YE7TfvcUPAAJ2orA=;
        b=pOyV7tXNrpB63HJ78KDPnco/QMO6U0vB7UE/Ak79kQZX2ndoOA53Ca+qO7B+yOHjcW
         c12hyH0Migh0WhMVUMoJ0l93DqedtahriXs9+OOSsdAEXl1v4ggoFq5zqiZwvMfrB7n8
         /4vYj9j2yrCn4t4/TJil3YIiRp5lxndDj/PnT34WhPYHT6j+ZeHxWwCdMJa0tVqCjSdQ
         0PISX/CAAWl0Yv9M9QZrIQbvuaY+rXk+FKIcVWYPBPzMQPHby08r/Uf+MzIm8dZZ8x3/
         hKcA7vUSdfYQ91mnZwsWyBwfybAJSsxeU8vSXnVmcNNwFlJ0F6XCxfUPkrKpO+AcixUp
         XEIg==
X-Gm-Message-State: APjAAAWXztA9YLnuNfz1GgZdjUJ75VaGx2i427FeW40CSgj4D4i5yHWz
        y0tB7gbr4uY1wnBHSM2+ICSGiVSm
X-Google-Smtp-Source: APXvYqzUCz/oxONySaByl63ByRoObG/ZLtfWD+GLnzxV5KyWH+uakL+XYdFe4EQ4Tyos2knMZCqGhA==
X-Received: by 2002:a17:906:7f0f:: with SMTP id d15mr532477ejr.39.1562279817833;
        Thu, 04 Jul 2019 15:36:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f36sm2051028ede.47.2019.07.04.15.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 15:36:57 -0700 (PDT)
Date:   Thu, 04 Jul 2019 15:36:57 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jul 2019 22:36:55 GMT
Message-Id: <15bd816ea576554beefe5b1d495e0ec2810a7d5b.1562279815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.283.git.gitgitgadget@gmail.com>
References: <pull.283.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: fix possible buffer overrun when calling
 `GetUserNameW()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 39a98e9b68b8 (mingw: get pw_name in UTF-8 format, 2019-06-27), this
developer missed the fact that the `GetUserNameW()` function takes the
number of characters as `len` parameter, not the number of bytes.

Reported-by: Beat Bolli <dev+git@drbeat.li>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index b8a62bf914..a0eb695653 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1952,7 +1952,7 @@ struct passwd *getpwuid(int uid)
 	if (initialized)
 		return p;
 
-	len = sizeof(buf);
+	len = ARRAY_SIZE(buf);
 	if (!GetUserNameW(buf, &len)) {
 		initialized = 1;
 		return NULL;
-- 
gitgitgadget
