Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A781E20282
	for <e@80x24.org>; Mon, 22 May 2017 21:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762631AbdEVVAS (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 17:00:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34768 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762611AbdEVVAO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 17:00:14 -0400
Received: by mail-wr0-f195.google.com with SMTP id 6so8175229wrb.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UCywItiq07anihyDbNtwxAippfSb6MDFD/PSkg533gM=;
        b=GrcqVmOkO9Jmj1ZQ71ER1UHRdPZ4NX8GH/5JtSX6UyZ8dTY+IyC29/wH1YEtckNFci
         qmgWjyMVwWJkOw/WsB84oCgUAd7qIu+HRHMjxF0W6e/y/+BYVEuZ8wr3sKoR/6uRLyH+
         EnTpYRe2cK82k05sGJwnWaLXm+G3HyW98ablfd4gKqxUw7D2hgV/d1Afv2G92iU2pBZp
         yYMASS5meAVPYyXagjFTM7c8wCwIEpo5AzT5Odp9Ahxs6WlhzfCLiVEJsjVPxLwcl1PX
         jcIzof4Eqm7NV5/+kNpzwC9RUMVIqfJ1eZYA5sWXfhJLhvWmRA15CgUmEOhee/Bb/RT+
         O6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UCywItiq07anihyDbNtwxAippfSb6MDFD/PSkg533gM=;
        b=Zu1jLlwsuREBs0CAKXJrKVuysPoFMKl6fyttLNy/p1sO4mG3U/X9zomBO/dzdDME5d
         H2absmBG1zfuByGr+SgRTIhQpCzdRpjJls9+nxyIktmeOa+Y5AKz13cGykf//89OVbrm
         uSaO89lzfBLEnKiE50tVewnDC3b3DMGCNMOqPuKmuZSKkC7dzm1jpvmCBDlYTRfyHcy4
         T+PYDzl7sJRV6PmmTgLsbgWxxpOpu4cbogZpvFe4x+ZP/+raRxVl5pwzMUwwtaKP0LT9
         w/P4Fh/DAXjdjgXy2M3sTEjZDg4gpToYE1DFNX48CTHAxjDuHe5XSRZQZctZ0fRR5CuB
         3gTg==
X-Gm-Message-State: AODbwcCKGScNyjKPb48pFRKiA4I0sQNfkjGPOLug2TZZWs8cd5gGtJtS
        tdcamX/NgbcI+w==
X-Received: by 10.223.135.130 with SMTP id b2mr12324040wrb.48.1495486813551;
        Mon, 22 May 2017 14:00:13 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3439:1100:e402:251d:acbb:6317])
        by smtp.gmail.com with ESMTPSA id n99sm14403579wrb.62.2017.05.22.14.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 May 2017 14:00:12 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH] Documentation: Fix formatting typo in pretty-formats.txt
Date:   Mon, 22 May 2017 22:59:58 +0200
Message-Id: <20170522205958.10962-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A missing space messed up formatting of the `%(trailers)` format.
---
 Documentation/pretty-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 47b286b33..38040e95b 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -199,7 +199,7 @@ endif::git-rev-list[]
   than given and there are spaces on its left, use those spaces
 - '%><(<N>)', '%><|(<N>)': similar to '% <(<N>)', '%<|(<N>)'
   respectively, but padding both sides (i.e. the text is centered)
--%(trailers): display the trailers of the body as interpreted by
+- %(trailers): display the trailers of the body as interpreted by
   linkgit:git-interpret-trailers[1]
 
 NOTE: Some placeholders may depend on other options given to the
-- 
2.13.0

