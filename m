Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED38920323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbdCVWTM (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:19:12 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33279 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbdCVWTK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:19:10 -0400
Received: by mail-wr0-f194.google.com with SMTP id 20so721449wrx.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZA+1XqbvyJbPgojOGiPIRInglGV4HUO4YLMWcZ2aMw=;
        b=odPHto1MjtgRGrhnDDSNUyLnFZXad2D4IgoCLVkCYlYtvhfCn1PbS0zdHWJZzIN72H
         VLRX/uhcHqC0iBRYm6bzHoT8q42F/LX+KwyHzw2H7s78fWJzz5Vk3587720vPQgkrzrY
         heLbUQq+Yy0SX/4MiK0Hr1pBPUZmue+v6aLvQuQDKpVWqb2DCeI6e5G39Av1dcEHBrKb
         78gP5WAvHV7R2L6/u670yCVTrFb0L/gLGtPRgwHhiSkByeCpI5Td7xBrbcMSGZobe6nQ
         pQ4s52KNH95B9ibGPUUnGp4HG0AR1MvrJiOJxJeQfbF80RreIwp3eAPeptQ1TLuREm8p
         ztbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZA+1XqbvyJbPgojOGiPIRInglGV4HUO4YLMWcZ2aMw=;
        b=q4Fj1APjoUEtrDR8ie9cco7txzI2v9vuDMqZPxTz0iAje3khjOYVs0Wf0g6joe9lf0
         n/t5BBRstfUL/kSQu1zckfv1A0G3BSGec40EEfHi9W7a2AuoOgK3lIvMbxq4nt1J5bYe
         cCrQBhTUgykwb3t89OqjD9BbK+KDNtEXLOYGLdipYTTcj+zz8Hw/6DCTpWdkE9MH4CPv
         ymd4vdMoh21fPVvY5oA9BPrwtnlfKVVghSTCuc7kLCQBHViAyFsiHM472zHNLsGxd9qY
         Id8uYtxndfqSn33j+67i2xc4oVuzQ5t7tl3LodfsAIfk/omLD62SO+jC4h9bGfIsHBB0
         TmdA==
X-Gm-Message-State: AFeK/H390jmy0xJngRtU1Nyct6snwTwNGHKqmYIRp9GbxEJBjwd5Cdgy1LxYK8dKdWwV5A==
X-Received: by 10.223.160.231 with SMTP id n36mr43012750wrn.167.1490221148066;
        Wed, 22 Mar 2017 15:19:08 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 190sm1916706wmk.17.2017.03.22.15.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2017 15:19:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] t/README: change "Inside <X> part" to "Inside the <X> part"
Date:   Wed, 22 Mar 2017 22:18:53 +0000
Message-Id: <20170322221854.10791-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170322221854.10791-1-avarab@gmail.com>
References: <20170322221854.10791-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the mention of "Inside the <script> part, the standard
output..." to use the definite article, which makes more sense in this
context.

This changes documentation I originally added back in commit
20873f45e7 ("t/README: Document the do's and don'ts of tests",
2010-07-02).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/README b/t/README
index a50290c789..89512e23d4 100644
--- a/t/README
+++ b/t/README
@@ -477,7 +477,7 @@ Don't:
 
 Keep in mind:
 
- - Inside <script> part, the standard output and standard error
+ - Inside the <script> part, the standard output and standard error
    streams are discarded, and the test harness only reports "ok" or
    "not ok" to the end user running the tests. Under --verbose, they
    are shown to help debugging the tests.
-- 
2.11.0

