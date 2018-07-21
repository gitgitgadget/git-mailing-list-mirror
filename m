Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E3C1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeGUImF (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:42:05 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:42293 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeGUImE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:42:04 -0400
Received: by mail-lj1-f179.google.com with SMTP id f1-v6so11240400ljc.9
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/xOIJIIDGBlq5xs/EzwPalDke189TUid/tUbO0DvCc=;
        b=f6/UHHUqzGvIhSFnT74doxbVIXZR3s4hnOfqOO0xSztPkZ6Qm7Z15V2SVqB/dwN9BR
         ueHQy/0znxOnvjSYBjXeTalQYXbLTYQyCHHm9Z0Ip5e++ivbHOw9DiQBcXPUnYuHBRVn
         szUR92sh3w65ignAGSmFtslQglCV6M1m6iJRgSMe9TgZ/BKlKZ2I5/CHYlORcjgUz+dM
         EwKXbd5ZzO1u3yDTrRVbraLHmIluq2bEmTiZxlzmbPsaRR1drSt8024Nq67uB16zKEYg
         I1wCUtwZHwd+peKnIZGu7nN5Hpnn3HRfQqnqsGwuHowtIBNE9NFI+OB47eyVcXX0DwBC
         OJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/xOIJIIDGBlq5xs/EzwPalDke189TUid/tUbO0DvCc=;
        b=T0DctfjjnsOpLlOTYlZUyVlIl3+AboTrUKWuoeV/WXsgxGe1VRiDxD+ymRErrF2rAc
         SBl5tuFdzS1fryVdBznW48dSIPGITW0viohMeS+j15jyDGgMEeOSFmc48NqjHzFzU7DI
         UIIK/u/wqYRU+PnAviA8YdYclv01Irg4mhHOfa3zkcJDxvRlLKhWrv1K8NTXMnqQ7WrP
         sNVcF0GF0aPCFEvLnc5JF70iyzTU52+EFCmKrf7AWvaqBIH52q2eYuvyQTQ3GY7fdrgw
         dgahK2WYSIOlytFNRJ1dylNvuzgE76v7q7mdSlYXjOJawqFvJRSXf716KAR4KSDpFYVX
         Cdmg==
X-Gm-Message-State: AOUpUlEqrXaDmn5c55zClrT9Xml+pbVk/rS6fnqzvU2Vq0XZuu/m2LSy
        vfcH5dqaVf8cHFZ3YW4KJys1FPUo
X-Google-Smtp-Source: AAOMgpehWBFmCS2oO7nXp+cps1/0GLBD6xeAC9ePky9e3qNzWUUW+le1dmvX5bl1dX99M6i/4a+Gqw==
X-Received: by 2002:a2e:1004:: with SMTP id j4-v6mr3789457lje.2.1532159414722;
        Sat, 21 Jul 2018 00:50:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:50:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 18/23] refspec.c: mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:36 +0200
Message-Id: <20180721074941.14632-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180721074941.14632-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
 <20180721074941.14632-1-pclouds@gmail.com>
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
index c66351743b..f529092fd6 100644
--- a/refspec.c
+++ b/refspec.c
@@ -134,7 +134,7 @@ void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
 			      int fetch)
 {
 	if (!refspec_item_init(item, refspec, fetch))
-		die("invalid refspec '%s'", refspec);
+		die(_("invalid refspec '%s'"), refspec);
 }
 
 void refspec_item_clear(struct refspec_item *item)
-- 
2.18.0.656.gda699b98b3

