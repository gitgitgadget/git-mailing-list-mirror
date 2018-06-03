Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88ADB1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeFCQfM (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:35:12 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39794 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeFCQfC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:35:02 -0400
Received: by mail-lf0-f65.google.com with SMTP id t134-v6so21557920lff.6
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLOh/wA7DbDmPEMUjGov+44s/xCdBivmJSlueG9rEno=;
        b=tGvqw5lhaReH63CyR9iBbibW58rPdZ6S3C8Ob3ADLszfcg/+9rX+5b2A+UuZsJGJ0r
         N1VfKQpe3zXv2+mZ033gW6XrGXlNt4qOCTiNAaUeUglMcxk3HKjz8rlfUKcEouoZN+33
         2jGvHsMduol2grHWVTLhzcO9pyaMqClnszXYbdnG3EOxbrvWCX7macxPfP8K/xV93hsW
         EwxNblIt3T4FTcrY28a997RqdlhYR9doBirCp35wRuXrUqdY99S3XNK4sbyzhmjMY+r2
         AAvcq8nPmxBYEgtKmq0WxQ2WUEmmWSMp/aXCPTgRogVg/druY62V0eI/dMySuaSRd3Y1
         4VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLOh/wA7DbDmPEMUjGov+44s/xCdBivmJSlueG9rEno=;
        b=EeuJyohcBlou/6dWBGPuqIv0Z7GGpT9u2LjvKzvWaetxU1Trl5rZcgtal9+RuTaaVO
         f4jbjphNheauz/IiEeBmPZhbM+eyZHLM2qI7ym4SiUwLGVa3/ZeN9QvY61earbVGRN4n
         bUkfzghOWIVluYnsdhAuuvAKcjucWlerFjDC0VQdOHUoiPRewwKZEAS/iL6vWENgi6GV
         I4IhTiCvGv0e6K3RVGgt3Kr9C3DncLV+KCGLZ2W5fAi2hXe+wEzCcDkVSKxpF3J/2vWh
         OXvNcF3a6t5wNuKrZ21ANfmaf1zkPlSsgSO7nYp0QCjd2eEztjEIMsB3+MErTtCXxm65
         uHoQ==
X-Gm-Message-State: ALKqPwcF6/9rqEYqaXzZCwRdIUJEDYH2JCL4e6/ZBiugvBoXraa5c1oE
        7eYqe676gcliwdd7z3TBHSDjyg==
X-Google-Smtp-Source: ADUXVKIAT7qEZD4xSuPUQ9KOyfEk/qswlUIrFXaKDnsMSBOWR4Faa/3sRpJguhyg+7OkZ4ptRCK9KQ==
X-Received: by 2002:a2e:7113:: with SMTP id m19-v6mr13635323ljc.44.1528043700802;
        Sun, 03 Jun 2018 09:35:00 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:35:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 18/23] refspec.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:34:15 +0200
Message-Id: <20180603163420.13702-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180603163420.13702-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
 <20180603163420.13702-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refspec.c b/refspec.c
index 6e1efd4d60..1266e509c2 100644
--- a/refspec.c
+++ b/refspec.c
@@ -127,7 +127,7 @@ void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch
 	memset(item, 0, sizeof(*item));
 
 	if (!parse_refspec(item, refspec, fetch))
-		die("invalid refspec '%s'", refspec);
+		die(_("invalid refspec '%s'"), refspec);
 }
 
 void refspec_item_clear(struct refspec_item *item)
-- 
2.18.0.rc0.333.g22e6ee6cdf

