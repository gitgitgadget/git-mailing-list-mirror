Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066AE208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 11:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeHHOJU (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 10:09:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35829 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbeHHOJU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 10:09:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so1037646pfh.2
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 04:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f7ieJMa/bdNRyZwsLtzrcejomMwmQDoyVfzakUT9zvw=;
        b=fQVbfBdSFAkgjRIoLfE3HV4Lo0kzWCfaq57Y8IBjANby6082FoBCnU7z/9GbPJ/ri8
         yPzdsgPl49gMRagqOL7JayJECUIclKkgFHrrWSHii8hjbXK+9iezvy1Do2k+ru/mL+sJ
         FlKZJw/ib5zVYhoNcANzR9t6drAE6E+GNLz4khXw2aVnN3+csW77B9t1xBLUQnGaackb
         a49L/8OR0+HXO7ArwoXRX8Xf2nVIpqA11L0XX3k0X4gBuZCI29JDmO77Sq3hXHTjy007
         +C/r6r/6wmzsg+MPOzY5AsSbUD02nrabh31UT0SlnQwF1pXrY4JLNwUZORQEVFSXANhD
         0J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f7ieJMa/bdNRyZwsLtzrcejomMwmQDoyVfzakUT9zvw=;
        b=NV7DfPu8IqVwWKYy9TeFK7jW0yg3T7B64sP3V8AEpnVH3sHJ8kqvSSCVS0SL5SWZ8k
         DGALRINXS+9FNdvyQlFezdtgy3M7L3odZOgmN0GVDcfNcTXUpXD1ZBNRxHglbnx1ClJT
         coY6Z+W+WAhaSptXnkmXPYgxBTVm4Dc6Bfh4FBSwEsbz87gYc4o2l9D7uFp3kTFOVYfQ
         oc1vLA6BcvBR684frm07pJ4uSBWptM/zTf7gNZe1ZlywRuQL3lUR3WztMGMHBwY9KUTX
         6HEqYSLNgW7XXVXuqCeu1LmOHrwAPjYrabPYe1hLYS7lujKY7/Gq+Ae7oPdhG2AyI+dp
         Z3Lg==
X-Gm-Message-State: AOUpUlF8DYupSDyfjzFZjMX9QoxokecKUHxSs1IOQEB2GUAMZlSyhxpX
        WJn6RYZwf9itvWA2W8sm+x8n88ZU
X-Google-Smtp-Source: AA+uWPxmDe6mBZQlkF9CKhYsJ++YXkoCOHS5ra9FMDxVRkvTw9KUONqXFCVouj3f/Q2Qq86+jQ1W5A==
X-Received: by 2002:a63:d20e:: with SMTP id a14-v6mr2281966pgg.226.1533728999457;
        Wed, 08 Aug 2018 04:49:59 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id h24-v6sm7522012pfk.113.2018.08.08.04.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 04:49:58 -0700 (PDT)
Date:   Wed, 08 Aug 2018 04:49:58 -0700 (PDT)
X-Google-Original-Date: Wed, 08 Aug 2018 11:49:54 GMT
Message-Id: <e0e7b6ae9da313637fcbd79a31e4b628b1ddb798.1533728995.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.16.git.gitgitgadget@gmail.com>
References: <pull.16.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] git-compat-util.h: fix typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The words "save" and "safe" are both very wonderful words, each with
their own set of meanings. Let's not confuse them with one another save
on occasion of a pun.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9a64998b2..a9dfa0be0 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -220,7 +220,7 @@
 #endif
 #ifdef NO_INTPTR_T
 /*
- * On I16LP32, ILP32 and LP64 "long" is the save bet, however
+ * On I16LP32, ILP32 and LP64 "long" is the safe bet, however
  * on LLP86, IL33LLP64 and P64 it needs to be "long long",
  * while on IP16 and IP16L32 it is "int" (resp. "short")
  * Size needs to match (or exceed) 'sizeof(void *)'.
-- 
gitgitgadget

