Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6F5120282
	for <e@80x24.org>; Wed, 14 Jun 2017 15:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbdFNPMk (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 11:12:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36475 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbdFNPMh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 11:12:37 -0400
Received: by mail-wr0-f195.google.com with SMTP id 77so817917wrb.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kJ76d9sZB8O8Ngv5MQHpQWEjxPN+zPWnWwdmD0Ss9rY=;
        b=dxpa66Q0Lww6Ygm9273mm3tJNe5KPe5IL9fXoxPhI17kyAtLhitqEi4ZxQahEsPHGE
         nv2rF6mWYghXRGDR6/gUi7qdphTFv60kvH2tU7/xnN2SfGqs2mfi0F/lSt6CbrjsMC9p
         Sl0IZD565LfT92SOtyof6kpiFNpEhOaI8N55bPZHtDvKL5Ai3g6ukBvfsvchQW9Hwqqq
         gvbgF1VyS03BHdLoFg7ccy5V7Q3Zr/VQYnQF0t/lrtJif9fm3os0reZutDK0UMJwcuQX
         dUzZbr9fNPoYqhOL6khM8/p4A53FdYUzYqTMxWhbTVhZrK7QSAkXRW91Sg9Ycxsfm/oX
         YZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kJ76d9sZB8O8Ngv5MQHpQWEjxPN+zPWnWwdmD0Ss9rY=;
        b=UnGWGFS/PtVLRXfD0e+aOrgy1xio/j2xtkDz0OngKCJCvzeCU7stAj7mqExFSCTZ11
         SXzQYsglZI9xLSWTShsNRN3DhQkp9bT180+wGjdVnPI8iduOXjI3Zmqo9eSsOK7V8DxU
         IwPrBwSTiFnRQ9aaA937CN6UmsSNnvgEEjkjtlEyxGn10rRwn8XbiCCkGKarx5qmrx9l
         miy+Sxuo0/SOB1CWquuDTV6jIpHaSiv4y0Ya1qEj8i0SBE0LMfbU2VKzhelrhjXTM7Sp
         KoCcD0rvHxTbGW+p2ZpIXjTP5b+VVna761GJlNABI7v99JD8F6L8sFw+OZmTnKscJyp7
         9S6Q==
X-Gm-Message-State: AKS2vOwWn/tNKwcYsxmzEbSCfM1oR62Nit8DmE2E5yD/ksyzQG2GGmvJ
        alIdr1Jh7rec7ism
X-Received: by 10.223.135.181 with SMTP id b50mr407049wrb.170.1497453156052;
        Wed, 14 Jun 2017 08:12:36 -0700 (PDT)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id 64sm254710wmn.20.2017.06.14.08.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 08:12:35 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] sub-process: fix comment about api-sub-process.txt
Date:   Wed, 14 Jun 2017 17:12:25 +0200
Message-Id: <20170614151225.31055-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.453.g04e95ab038
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 sub-process.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sub-process.h b/sub-process.h
index 7d451e1cde..d9a45cd359 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -7,7 +7,7 @@
 
 /*
  * Generic implementation of background process infrastructure.
- * See Documentation/technical/api-background-process.txt.
+ * See: Documentation/technical/api-sub-process.txt
  */
 
  /* data structures */
-- 
2.13.1.453.g04e95ab038

