Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4D0209FD
	for <e@80x24.org>; Mon,  5 Jun 2017 10:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbdFEKyn (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 06:54:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33397 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdFEKyn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 06:54:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id x3so1966320wme.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WijqeHvXgXpAfhKRIpgvEW53W1ttuaaYDlhS0w9Q9xo=;
        b=Zv071OsUIYqsjvTttWOZtX/7X72ylSxqPPLQmLNGDL1kDsjPmkX75U2ZveGEYxrhUI
         yvX00X6v8L7U8H9HRtwK8YkOtFlI2vGBpjyCAZhi4rU4u43zRltmlEQ+31A4Ee6jxvHF
         OTiaDpPUDU9wc0Qnc303Ya1NCRVUjPQ7btFZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WijqeHvXgXpAfhKRIpgvEW53W1ttuaaYDlhS0w9Q9xo=;
        b=ee2XBNmfEGnijhQHctXO5HHztvQSLoE4bme6ZQDE/Lc3jutFfAiI97/suldMRTW8z0
         RCjL3o+zg7lJfiQRj5DWyTB648QCDXAL9EKKOjBJeMb5MEdoTWiht+/gYG0l/6uu+yCx
         TwWk7ZBH42o2yP3a/JcGEfNOnIMUi7V22SgkpVqRifXSyiql011YPk9+Sd6ZZwdtuK6G
         sNDbn5WJAxCwdY3XlLUygIp5gnf9/Yar3kGeoW4707om+zFJbGLUXFKx7bUq5fhbMzoq
         5iLk+YE2iwKh5+syxRVLPv07EObPQ+Se9YiiGoHRwZfkf1k2Mk02dy7c0fzPawPuXMNZ
         KX7g==
X-Gm-Message-State: AODbwcBlNgK5LhEiTK/rR2uZKwbrDiQdxNWMN+lJbZV636g0HufZ08PG
        014B0MjpbctvBnsRWrUEEw==
X-Received: by 10.28.99.7 with SMTP id x7mr7273731wmb.39.1496660081378;
        Mon, 05 Jun 2017 03:54:41 -0700 (PDT)
Received: from PC5175.ad.datcon.co.uk ([2620:104:4001:73:9c60:500:54fe:f32e])
        by smtp.gmail.com with ESMTPSA id l190sm13393946wmb.18.2017.06.05.03.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jun 2017 03:54:40 -0700 (PDT)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Genz?= <liebundartig@freenet.de>
Subject: [PATCH] docs: suggest "Helped-by" rather than "Thanks-to"
Date:   Mon,  5 Jun 2017 11:53:41 +0100
Message-Id: <20170605105341.35096-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The SubmittingPatches doc suggests adding "tags" in the style of
"Signed-off-by" to commit messages, and suggests some in common usage.
However, based on usage on the Git mailing list (and in particular,
Junio C Hamano's email to René Genz on 23 April), the suggested
"Thanks-to" is not common usage, and should instead be "Helped-by".

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 558d465b6..2de42b3fa 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -319,7 +319,7 @@ If you like, you can put extra tags at the end:
    and found it to have the desired effect.
 
 You can also create your own tag or use one that's in common usage
-such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
+such as "Helped-by:", "Based-on-patch-by:", or "Mentored-by:".
 
 ------------------------------------------------
 Subsystems with dedicated maintainers
-- 
2.12.3

