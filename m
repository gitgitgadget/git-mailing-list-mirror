Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8141320229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756240AbcJWJ1S (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33979 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbcJWJ1M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id d199so5245673wmd.1
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OAhH+msYB9RoGfY4uRsmvaRkAFKfbVNiHMwNNHcStbw=;
        b=TFdbPKeSeaFGtaDKDTS28Q7P2WOOR1wTPhduc5l/zBXytdn1S9ZFKV8wj85Ihj1dre
         wtnXvOZl44zQ4uyZnM7tfDXJS1VtR3xNYki6zSpVXThRKsiNC1CRUqmyZO4sDgzosyAF
         FeuiFyDG1LastY3A1w2x+DXc6cWhNBGlbHp50ldhzX3bGHgUtza9Rsfnw5V5B8a9Cl4Q
         /WzgE0ootcOdqjIKqaN9BFXKeAhtJeDAe9ho4hOMW6yHZ/ZNLfRl0iRjVAoiOI+yyGOl
         Mmn1leGWutQtKcxVgVY8R36h9jvBwqfUrYkekK0p+eTOTYfDFUwUaJBfWpdTlkF33ipL
         9nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OAhH+msYB9RoGfY4uRsmvaRkAFKfbVNiHMwNNHcStbw=;
        b=KyxbKGDH8daaZj31UOWnuTVKLj2GlKDvYrkX8ThwZDPrHejnXFAJf7qVyiNEluUkh0
         mzrCJNcAaud2ATptkNSIsq6Eu/AVGI7s33QRPzJ4DLmtXkSiCUcyeyEHW5n3n94+hi5D
         uZ7IKwKHfwkOgUnExl6zyggPuQSG4EFO7NNgrwpb8pZuodoS7Utf86jkmQfWmxSC6pal
         e7UEfLaFbK9UCqNX1vrlgW7PZ95hKpz7FFaJC99MtJdJYz3KDIx87+B+JGfg0C7Oiqmn
         B5Erzz7qIWaaTGul9G7Y8IdvNjJLwBezFz3+BLo0xNE5aYmNTG2dQ9HQRCuIUD+XPlQ1
         xO3w==
X-Gm-Message-State: ABUngvf+7MoVnvlsVF0pg/8xuCXH8206+pDf7f3QzMoX5IUJMmnAszEdglpvR21zl/Lp8g==
X-Received: by 10.194.176.201 with SMTP id ck9mr7062210wjc.199.1477214831046;
        Sun, 23 Oct 2016 02:27:11 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:10 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 01/19] split-index: s/eith/with/ typo fix
Date:   Sun, 23 Oct 2016 11:26:30 +0200
Message-Id: <20161023092648.12086-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 split-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/split-index.c b/split-index.c
index 35da553..615f4ca 100644
--- a/split-index.c
+++ b/split-index.c
@@ -187,7 +187,7 @@ void prepare_to_write_split_index(struct index_state *istate)
 		/* Go through istate->cache[] and mark CE_MATCHED to
 		 * entry with positive index. We'll go through
 		 * base->cache[] later to delete all entries in base
-		 * that are not marked eith either CE_MATCHED or
+		 * that are not marked with either CE_MATCHED or
 		 * CE_UPDATE_IN_BASE. If istate->cache[i] is a
 		 * duplicate, deduplicate it.
 		 */
-- 
2.10.1.462.g7e1e03a

