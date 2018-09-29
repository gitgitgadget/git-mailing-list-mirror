Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 035EB1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 06:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeI2NSV (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 09:18:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40853 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeI2NSV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 09:18:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id r83-v6so7775527ljr.7
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 23:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=niiftlL+oA9yn99Wn9VLEsYdFpV4Xe6hONK7WkS9FSE=;
        b=uW5nCVGLBZXOS/ErI65iOG8wynG6rJ1ikcwsevMIiS6wh24H/mnxCcERSJzW7MT4Zu
         2SOLkMngXz6auqoshLfZc1db5YR4I+V9dGvJN+3LKMN6tRzbHJwn2xM3TYiklBvlYJee
         x8I6tY9gC3mN8KORAunErq+YLpNK4BoT2oq/YqKv2XZLSh4DrG1FTDwWhZVuQjHiWYI9
         fmMAujntwDM/3GyE2/4Bt2BNOMd2cU13LIcaKTjRgM8JlbSrlK0t9KBCkbtB5wCVa5f2
         O6+lOngWPpStmyA3xOCpSft+EsJrTplh0KWDNEQCfUoILeLUqNT63m/vCK8O4X+xDO67
         MziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=niiftlL+oA9yn99Wn9VLEsYdFpV4Xe6hONK7WkS9FSE=;
        b=IN919wda9Quhvlb+CgJHCTMQGUcJBbw3qfEBIEAKouXnTZwROVc/5Uq5J8H8OSbrJO
         Ni9QGjlV3Li0jFLu4XMqs2n+IcZAWkIxfW/9xgSQI0HK6XBS+FjgcKK9i3U4eywZkhBG
         QnmsJ6Ql27hiFlkSI8PyWeeUxtkTlGqOZ+swVFmp2ba95Ge4PQ8xwnvPN+rqOW3vlBTQ
         AvTGwiNShz0cpbn79RxZeymyq/ginsGO3bTm0OrX4wgzO5ZglDG8b+8WSWsPYtnZ7xRu
         Y3EusnH5as10gfmtyHCYR2y0hya6eg4ry5Za2P1RpfF8XxE47GIPLMuhadeXJNYSPh0K
         inHw==
X-Gm-Message-State: ABuFfogsAIGyUp6b8Wimo7gyfuo8ZtQCVlm4pwvAyLylv/a0VYnxkoNB
        lmFocnEVQUbGPyk87ISDkB4Lmz2L
X-Google-Smtp-Source: ACcGV60YoMuJJ333G8kvwfHK2KV5YfDkSqh45fH74WpePrbmZVwfFurGk1rOfuC5hSc9+zGklhxwGw==
X-Received: by 2002:a2e:9948:: with SMTP id r8-v6mr987499ljj.135.1538203864348;
        Fri, 28 Sep 2018 23:51:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a198-v6sm1407113lfa.22.2018.09.28.23.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 23:51:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        jeffhost@microsoft.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] config.txt: correct the note about uploadpack.packObjectsHook
Date:   Sat, 29 Sep 2018 08:50:56 +0200
Message-Id: <20180929065056.9960-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.341.g3acb95d729
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document for uploadpack.packObjectsHook is added in [1] and consists
of two paragraphs, the second one is quite important about where this
variable can stay.

When the paragraph about uploadpack.allowFilter is added in [2], it's
added in between the two paragraphs. This makes the "this is non-repo
level config" note incorrectly apply to allowFilter instead of
packObjectsHook. Move allowFilter paragraph down to fix this.

[1] 20b20a22f8 (upload-pack: provide a hook for running pack-objects -
    2016-05-18)

[2] 10ac85c785 (upload-pack: add object filtering for partial clone -
    2017-12-08)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ad0f4510c3..907b1d0cb9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3666,15 +3666,15 @@ uploadpack.packObjectsHook::
 	was run. I.e., `upload-pack` will feed input intended for
 	`pack-objects` to the hook, and expects a completed packfile on
 	stdout.
-
-uploadpack.allowFilter::
-	If this option is set, `upload-pack` will support partial
-	clone and partial fetch object filtering.
 +
 Note that this configuration variable is ignored if it is seen in the
 repository-level config (this is a safety measure against fetching from
 untrusted repositories).
 
+uploadpack.allowFilter::
+	If this option is set, `upload-pack` will support partial
+	clone and partial fetch object filtering.
+
 uploadpack.allowRefInWant::
 	If this option is set, `upload-pack` will support the `ref-in-want`
 	feature of the protocol version 2 `fetch` command.  This feature
-- 
2.19.0.341.g3acb95d729

