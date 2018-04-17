Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA3751F404
	for <e@80x24.org>; Tue, 17 Apr 2018 21:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeDQVgh (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 17:36:37 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42260 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbeDQVgf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 17:36:35 -0400
Received: by mail-wr0-f196.google.com with SMTP id s18so39359376wrg.9
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mTFoQLTcBguxtxGBZPJDzvSVAQGFGQMML/G6FTARLbA=;
        b=DCedEX4HD1qVhKelpRerOhGuDNkyPbluLf5llJ1cPvbGpr3D1hGh1JbJrQAaVdg1Sa
         MbnzYOUkWyrYtg0DrQmRogYhXiv7xfyOsoiA/VWBTOzDS/VKRggAZv/CtISLK2pS+vG4
         SVgIxq4VePEq4RjWFvShR5irq7suEcbg6rgKeSBOZMJmOyKaJPxaDSqrKTNNX73b3unA
         lvbca/KtVvNWeew81JEBDMJLz7SUQ7DF4gHa6HbMUv3MLHxkUzA3ou4KQbeZzIyQF9NM
         ezgs2a5S6p/5R/AQAT3V203UzCtjH962lyz7eG7CPlb/uv3NcleRy7rE6LSFnpIeO1vJ
         /51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mTFoQLTcBguxtxGBZPJDzvSVAQGFGQMML/G6FTARLbA=;
        b=LR3ojibRohNm3KKAIJ0SClTbTpOrshFT8EO59G1/U4oK1UhRQ1rH9E9jdHjWTSee8t
         KBKDUIZ87wmFVTKmRXakZmfFltQrT0bRDzfsqYsOte1pM4t1C8NUOcTAPpLAMY3mdG6X
         PnViW/xX0RNwGFKhJKD3WBGXuoksXthRCfyt8MsLX4K5de2IHbx0j0ed77TM5J/FSiW8
         gKEtMwmzdsyzSOWK1hCHrCoh/PGfUrUOjHYQ5sJIbcp2mJYcOe2voENqvF1FH/gZxxXZ
         Wfj725e8hchNkED1r2tSpskmQWckKAYy/D6OwHq489FxwR8D0jdsoM2bL7b6H4Q6Zifa
         w/JQ==
X-Gm-Message-State: ALQs6tA3t+ckw6X2BFQj5j2glp+1DZls7flVe7qo6oSD/WYx9xg0TP6P
        o5VgT+uHKf5SlJYtTtLw8nMGKw==
X-Google-Smtp-Source: AIpwx4+PUv9VtN7fdAqqsYD9NbLtWQLMPaVyiGgZaHeFDf3R6poT3YY3wwPygMjKYLw+MmyGXONVLw==
X-Received: by 10.223.153.45 with SMTP id x42mr2858312wrb.145.1524000994172;
        Tue, 17 Apr 2018 14:36:34 -0700 (PDT)
Received: from localhost.localdomain (x4db1b530.dyn.telefonica.de. [77.177.181.48])
        by smtp.gmail.com with ESMTPSA id k30sm12715372wrf.1.2018.04.17.14.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Apr 2018 14:36:33 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] docs/git-gc: fix minor rendering issue
Date:   Tue, 17 Apr 2018 23:36:28 +0200
Message-Id: <20180417213628.29265-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An unwanted single quote character in the paragraph documenting the
'gc.aggressiveWindow' config variable prevented the name of that
config variable from being rendered correctly, ever since that piece
of docs was added in 0d7566a5ba (Add --aggressive option to 'git gc',
2007-05-09).

Remove that single quote.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/git-gc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 3126e0dd00..7c8a2edd48 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -129,7 +129,7 @@ The optional configuration variable `gc.aggressiveWindow` controls how
 much time is spent optimizing the delta compression of the objects in
 the repository when the --aggressive option is specified.  The larger
 the value, the more time is spent optimizing the delta compression.  See
-the documentation for the --window' option in linkgit:git-repack[1] for
+the documentation for the --window option in linkgit:git-repack[1] for
 more details.  This defaults to 250.
 
 Similarly, the optional configuration variable `gc.aggressiveDepth`
-- 
2.17.0.366.gbe216a3084

