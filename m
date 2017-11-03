Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51CAC20281
	for <e@80x24.org>; Fri,  3 Nov 2017 05:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbdKCFoP (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 01:44:15 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45305 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbdKCFoP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 01:44:15 -0400
Received: by mail-pg0-f67.google.com with SMTP id b192so1626355pga.2
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 22:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wkdKHw/E1YI1IRFdDDykzTQO1RZMHVbOrG+5HOEvPwM=;
        b=NbkCyZS3lM19HOWVrOmRvPQC+Mkm8898CHoXbBu1o/YJjJAtteGlQJejpgSeffb0LL
         2RzoiTF4lWfkHx97BeOpxF4Bdp4YxEchhGAmtiLL0YWwNOZnHjq5U7N2sN0Gq09yN3Pp
         DQGa3YOenY45b67yIFAvrhcfQ3/MN0CejNHP+1F3vNSdfECLw2FVYafk2dJ8o9Li0w58
         693weGaAVphXFaEtb484WlFS1KWIu0lh7ZBxg9WcpnQSDxz+SqIdlKOZqlTN4TUORFqY
         rRiXGne38uSBB9drhfQ0RQtAnuxjapCdmmNWiVvFkPJc/EziNAqU7F/LjJcdUyPU/xTY
         a/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wkdKHw/E1YI1IRFdDDykzTQO1RZMHVbOrG+5HOEvPwM=;
        b=DiynPn80uEbhdbg2949B3niaT6N7DofIW9rFFsRXVmin6FhVKpbKXMIA7oAGdnCd7n
         roSvli+WJICmXLNwVSBQrRCiCG6WSW+yqFPRvhaBlN4ln9H7ObPN38T5T4h6B21q3mXS
         fSd8oVnR86DgtarokVcwZL4zVBceHgB/VNEYeNOARX37JWbZMLaZhYK7Svb99QP4fmKp
         AVp9O/ZLIU3hckzqKd08iDHJ4mrIYXBUkJBLEVUdUYs7O4Y/s0IGT5zqbwHzJuX1jRtt
         Iv822bUh5Xw2U2HmxzMfpsCNIsgjVb9ekrC+bO3WAy2dUgYvjeeiT4s2pMu+4kesKfBK
         JIXw==
X-Gm-Message-State: AMCzsaVshrcE86TSoX4szaTZ32XkT3d55tpKsOQ/IWlPAvkUbtUHdgKj
        5rs357CrRgv289/kyhDNZwybo64S
X-Google-Smtp-Source: ABhQp+QB0BeYGKmTJTyF9Z8WIZDFZjnni+b2MdGlh1ZQPj679S1gS9ySGac69hU42J5OkANl4Qs55A==
X-Received: by 10.159.242.196 with SMTP id x4mr5521609plw.68.1509687854476;
        Thu, 02 Nov 2017 22:44:14 -0700 (PDT)
Received: from localhost.localdomain ([117.243.30.244])
        by smtp.gmail.com with ESMTPSA id g16sm9940841pfd.87.2017.11.02.22.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Nov 2017 22:44:13 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] mailmap: use Kaartic Sivaraam's new address
Date:   Fri,  3 Nov 2017 11:13:41 +0530
Message-Id: <20171103054341.15171-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.461.gf957c703b.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Map the old address to the new, hopefully more permanent one.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index ab85e0d16..2634baef2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -113,6 +113,7 @@ Junio C Hamano <gitster@pobox.com> <junio@pobox.com>
 Junio C Hamano <gitster@pobox.com> <junio@twinsun.com>
 Junio C Hamano <gitster@pobox.com> <junkio@cox.net>
 Junio C Hamano <gitster@pobox.com> <junkio@twinsun.com>
+Kaartic Sivaraam <kaartic.sivaraam@gmail.com> <kaarticsivaraam91196@gmail.com>
 Karl Wiberg <kha@treskal.com> Karl  Hasselström
 Karl Wiberg <kha@treskal.com> <kha@yoghurt.hemma.treskal.com>
 Karsten Blees <blees@dcon.de> <karsten.blees@dcon.de>
-- 
2.15.0.461.gf957c703b.dirty

