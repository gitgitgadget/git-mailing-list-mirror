Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C469D20960
	for <e@80x24.org>; Thu, 13 Apr 2017 16:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754191AbdDMQlX (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 12:41:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33154 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbdDMQlV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 12:41:21 -0400
Received: by mail-wr0-f194.google.com with SMTP id l28so9329783wre.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WvxDKH8sbNQ3X2Dd6lZTtzp9HbmjZQNdCPyZwEF7GdA=;
        b=itvMr0KYilIL9tJ0ytKPJk6ggJ9RtBI5NbtTLURVAiAMOtzNHH1yxDjmMNsW+RRGnu
         lEyclC6/2kn4/wfD5YAGdyjholnOKdUDNm2XfjcUSKyLzL9o+hYP6+lYcr+945CQaIYx
         5vlI9zunaerwc4RkKdf0vk8g+CsLDuYG1RZbc6eYTBNZZbnVafRlAlCTtl7JiBKl+v06
         DXikGClFW/1x+CNKWlb1c3BcHSVBL/n/ESu3qMpajl9hznn5NYJVmFK5NFGY6+yTV4vC
         EwSy5oL6KeqbuGw5q0JIPSD5yDu6P2QFjxrPWehgmUCuRBWwQAzNIIMf9FrtpdzHO/lq
         Zq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WvxDKH8sbNQ3X2Dd6lZTtzp9HbmjZQNdCPyZwEF7GdA=;
        b=K9xgt1a3OpyiQwLwSkigzNbQbI01tktfAjfHuaaYKIt/pNu4L1ACHdfTC7LXialwFt
         25xYPWDxwElly8991yiCXm4y7EAZ8Nf+87BRqCZ9RQA85TdWLMM7qoHsjZgYUojuwdlJ
         YP8AeVB1P8///QJ86NwHsgL70j3mYYCakprMea9GEyG9eALmMAj3gySauSIyVZxxpzBB
         nIsEIZhGS7S/jL1ec3c7Fz0/rGrf7Lk+EbTdeA1Ktmhecp1aj+SIADoTTiExZKOYOd79
         5xXjdonDfvV/Ukf2QRJ+4P5bL0mT9nEO1oozQ9K7qzQYMszET0pK6gd2gbCmlucB6eLN
         4fdw==
X-Gm-Message-State: AN3rC/4xL1Dne/CMpdlP0yZkaMW2w/6FUF+YcUMm6uxQS5UrgQyc+FxV
        CLjUVIrARGqExvvW
X-Received: by 10.223.155.134 with SMTP id d6mr3509959wrc.113.1492101674553;
        Thu, 13 Apr 2017 09:41:14 -0700 (PDT)
Received: from localhost (cable-94-139-14-18.cust.telecolumbus.net. [94.139.14.18])
        by smtp.gmail.com with ESMTPSA id t24sm2587841wra.44.2017.04.13.09.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Apr 2017 09:41:13 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] git-add--interactive.perl: add missing dot in a message
Date:   Thu, 13 Apr 2017 18:41:12 +0200
Message-Id: <20170413164112.19623-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One message appears twice in the translations and the only
difference is a dot at the end.  So add this dot to make
the messages being identical.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 git-add--interactive.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 77b4ed53a..709a5f6ce 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1040,7 +1040,7 @@ marked for unstaging."),
 marked for applying."),
 	checkout_index => N__(
 "If the patch applies cleanly, the edited hunk will immediately be
-marked for discarding"),
+marked for discarding."),
 	checkout_head => N__(
 "If the patch applies cleanly, the edited hunk will immediately be
 marked for discarding."),
-- 
2.12.2.762.g0e3151a22

