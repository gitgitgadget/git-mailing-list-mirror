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
	by dcvr.yhbt.net (Postfix) with ESMTP id 94BEC1F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 21:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfKQVFR (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 16:05:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39439 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfKQVFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 16:05:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so16568529wmi.4
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 13:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C1HXWuLEZc5ovCTgL44tyjZQhFCyqayDKjSGiiKI3SE=;
        b=DHFuE3lkVyAcLyOE4F1mOlDnre3if9MIDgawuxlZGw4XVKJc8/93tOuyDQSHE09tNS
         v3kuWPzMCISBjEtiBYrpmQGWnCMvY/DNbXkmZcGGIizfW04OOBJVfrB5gwza4KN1xTXF
         SgVsvris3Ek/sw182wiTEia17thxoC4bkqNocktlQw4RzuU1XZNoqJ0V8EsXDr9nwrZo
         x/V+0tfr0W1vTHVJ+LZHoKm+MQczic3MqD/yEw8qQTRomWoVrKDpQjJFto+3+6trPKAf
         AePQ0f9t31hzsv6vAVLG5ebYUKOvipDU4Y+Xz2IEMnRO+OjU0+mqvMcAoI+ygRYNnRfT
         giyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C1HXWuLEZc5ovCTgL44tyjZQhFCyqayDKjSGiiKI3SE=;
        b=hXABNhWg1f8YgDLh0C7/ka38hPVl0tUkeBMCSu5f0XVTyyoVgKsxus8UtKPR6gLwZe
         0xjh38LzLte9bniJW3E7a+6tpIz18PgvoH8LoLCyfFGfJ+TNI9tyxCBmwTdNDo/BA1mE
         7g/4u0WmtAvoi2qbZWsL0DbDS+LLPHQkMO3n4ewd/0rqFqTx/sryk3myQfF2gjRdRH9i
         8tQ+3hmPR0YiBa8LLKR/YlmJ29sjwxpOZ1YufNI4z84NpKh7JOv+5gT4D2nRwu9dsWpm
         lmmDZwTpKK1n/YbNBvHzknZDuCKoHPWG4x4V84BR5XVoF7vKHAfCnGcZ+xv7djPa/PGP
         ZyYQ==
X-Gm-Message-State: APjAAAVzYTuBebk7A65H1RSRgZ0hi1ussLDiR6uIG599k9tI38OyNhzd
        Eiuih1EQlC0GEyn2EiCi1r7Dvyqx
X-Google-Smtp-Source: APXvYqz/dDrjnabcbdei1s/STzNbprr81ykCplcmaupIRuPa+Gl3k4NH+S+WE//6IeU7zNHUvvNlJw==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr24727544wmi.109.1574024713565;
        Sun, 17 Nov 2019 13:05:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm20243412wrm.7.2019.11.17.13.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 13:05:13 -0800 (PST)
Message-Id: <0e9e89fd8380f3f2a3b89ad02a05f87ea2251f1d.1574024701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
References: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
        <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 21:04:54 +0000
Subject: [PATCH v5 15/21] parse-options: add link to doc file in
 parse-options.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Add a link to Documentation/technical/api-parse-options.txt in parse-options.h
So the developers would know where to find more info about the API.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 parse-options.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/parse-options.h b/parse-options.h
index 38a33a087e..164ec566b0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -1,6 +1,10 @@
 #ifndef PARSE_OPTIONS_H
 #define PARSE_OPTIONS_H
 
+/**
+ * Refer to Documentation/technical/api-parse-options.txt for the API doc.
+ */
+
 enum parse_opt_type {
 	/* special types */
 	OPTION_END,
-- 
gitgitgadget

