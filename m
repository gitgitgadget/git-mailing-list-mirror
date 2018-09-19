Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86781F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbeISWR2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 18:17:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43032 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeISWR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 18:17:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id x24-v6so5694956lfe.10
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bC6niSNhGguqXWpJHqMWdpQS5guHe3iz13LeF6GxBq0=;
        b=HSm8IHEDk+PE3hpxcCBNOWn5cxHCRbwoELHIpDcDOQsLA5Wyjv6JinCOOewZu+nftW
         8sEXi1tDyjj57FtnIiArNN8HRcop7VgM065HsJA3s5FJ8flQBzvjJQDyYbJbGDUgiOa7
         Ktaxx9ZHlQNF5Z/u7siXLeM7qsL3UQUM+YBqhKBG5y6hteDzXtFT6eikNlz25qswsrxd
         VPhDSVtN5ieTE4OJVFpV6kifM4OyWFSAMeW93HCs5iLbmjYQEC6JWHy7WI8jPMCzHRqr
         W1p73HDqiG+BfaeRezmeFePEsYRSvA1GUlj28S23aaedh1IjxgTMEFLOFs4BWCRlwREn
         2tUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bC6niSNhGguqXWpJHqMWdpQS5guHe3iz13LeF6GxBq0=;
        b=bqW5J79gl2PZGFg/2pZlOFa0k4SSXeI9GnvE2Vyk6c6H5sQlBv3ugjJTr6NoUwUCfj
         4JQto7YkWEdrSif2Aoxbc+QecmNNOwi9RjJZSN+07rYz6DwdyVXtheRYhR6ZzRIKZR3m
         h+O5geqYfJSHvLOcHOrOMyUsnwzOMQR5hZeFhNzO4bPF+KQakSL0m2t2bmVcIITol6Wt
         0ydkae59b5n58LIwieM76yUrpyqIYlBS+1OLFGvZZb7+mhjtNGOiL+3EKr4VgbJ7T2uh
         mZoaT2HTbLf4jBkCeEaLiXN8w3ghzmaJN7/r5FVwGzJqErOojlz/oDNuTjCyKRnebfVp
         /40A==
X-Gm-Message-State: APzg51AzjI4KYGwcb8gYpYHc7R/YdwiB6FlYPo/MQqO3LgwJjF4ZzwLN
        ecX7qGSy/XlIhguOb0RpJRJhYk0X
X-Google-Smtp-Source: ANB0VdZDQLZqMmNHNWj5NfiM0WCxSdxL8eGJ+5dZaOCSbqyHhOv+hpLrmjGoIc1Kxsth9OZWXcqtLg==
X-Received: by 2002:a19:e48a:: with SMTP id x10-v6mr15672601lfi.132.1537375124267;
        Wed, 19 Sep 2018 09:38:44 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id d13-v6sm1144261lfi.74.2018.09.19.09.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 09:38:43 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/2] git-config.txt: fix 'see: above' note
Date:   Wed, 19 Sep 2018 18:38:19 +0200
Message-Id: <377b7cfa36c3b23150005f7faec02bbc4a325bd7.1537375024.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.216.g2d3b1c576c
In-Reply-To: <e81bbd0e714221aac47b387e7d1e1572af32aa8f.1537375024.git.martin.agren@gmail.com>
References: <e81bbd0e714221aac47b387e7d1e1572af32aa8f.1537375024.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than saying "(see: above)", drop the colon. Also drop the comma
before this note.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 9d8cea72dd..5e87d82933 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -188,8 +188,8 @@ Valid `<type>`'s include:
 --bool-or-int::
 --path::
 --expiry-date::
-  Historical options for selecting a type specifier. Prefer instead `--type`,
-  (see: above).
+  Historical options for selecting a type specifier. Prefer instead `--type`
+  (see above).
 
 --no-type::
   Un-sets the previously set type specifier (if one was previously set). This
-- 
2.19.0.216.g2d3b1c576c

