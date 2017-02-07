Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0151FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 13:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754235AbdBGNjC (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 08:39:02 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34657 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753307AbdBGNjC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 08:39:02 -0500
Received: by mail-pg0-f67.google.com with SMTP id v184so12180812pgv.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 05:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdQpRK10C3fd4/UKYAd3zQ6o4/l2Alw01FUoSjVu3nc=;
        b=pLLTj9ZnNvJwmitMtV/jI9tBkutrG93uzo130kHs/ESVC3RE+QRYk+xA9Y4YHvSq8h
         BZCa6In9xgyahcunvMisyonNyEF9ZL9J3GQDkij085mEN/6O6I3a4kA25LnmnIVHlzfa
         jPtlJZSYifai7Qxa0GtRzFksFmlBmMqXRkcOvT7fstCjCXWpcBx9Ny5+ONIWU5vHW3U6
         fllq/mt44VTHWuiQ6C8dd9OOBWKMy8Her4cTaeX6bwx1oh1ey4kdEdQsn+dfQRRfScTn
         m3qsJe+hGZyZqKhOE/6g1M4h0hl1+i00KNm9wZ89QBvRfTz/4U7buoLZWyuzraN9TR3p
         rhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdQpRK10C3fd4/UKYAd3zQ6o4/l2Alw01FUoSjVu3nc=;
        b=d5g80PTOSEp+Aqy54OEzzvP9YnAArM17sLtFcTxcNGl0N9hjaJgkbSJt9WHEIfC5R4
         aWV2UCA1gxQFv7CE6LJkGqvUNonPE0UfmvlY/1v8S9bcTWqCbbJSx3I3jLKQJxIowev/
         Q5m/GdKfJHOV568y/3kO3F3KkTD7IQ0lMoEU5i5JrUAPR61Ft07jlvnt/meLBk+ChhG/
         vFIx25EKxRizRdZhA/WhVCjrlqxcn5LjwhfviSheqI4IYEzo/7ysI67JcepePmjeU9hr
         JRgALujMKt3wKOiJgSEjxqhD2uQQ21RGZfkOjgasb3E446GvJjsNNnNZ6S4UOII8f0di
         pbig==
X-Gm-Message-State: AIkVDXKww65Fuk37HOEu0ZMVJdxEVh4TvAoQ9Jj/wyyabDvxChC0HSUWUrMQRYeyyyIwKw==
X-Received: by 10.84.224.199 with SMTP id k7mr26362249pln.25.1486474741480;
        Tue, 07 Feb 2017 05:39:01 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id n28sm11835310pgd.5.2017.02.07.05.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 05:39:00 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 07 Feb 2017 20:38:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] rev-list-options.txt: update --all about detached HEAD
Date:   Tue,  7 Feb 2017 20:38:49 +0700
Message-Id: <20170207133850.14056-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the document patch for f0298cf1c6 (revision walker: include a
detached HEAD in --all - 2009-01-16)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/rev-list-options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5da7cf5a8d..72212ac6ec 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -133,8 +133,8 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	for all following revision specifiers, up to the next `--not`.
 
 --all::
-	Pretend as if all the refs in `refs/` are listed on the
-	command line as '<commit>'.
+	Pretend as if all the refs in `refs/` (and HEAD if detached)
+	are listed on the command line as '<commit>'.
 
 --branches[=<pattern>]::
 	Pretend as if all the refs in `refs/heads` are listed
-- 
2.11.0.157.gd943d85

