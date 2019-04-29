Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADBA11F453
	for <e@80x24.org>; Mon, 29 Apr 2019 21:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfD2V5C (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 17:57:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34090 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbfD2V47 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 17:56:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id a6so10553641edv.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 14:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=zjtl1qclrDtVCF9j0VxvqBg/3kvhEV7o9wRud+DHZ00=;
        b=Q8Do3fapggJc7EBvrFKFWY4hNBlXFKbD8YJgPv89G2Gs1wwUdVzfAKDrKjJkhokO8B
         Dk30W8FZpcxQkHUgmKF1aYIES0KpI/ksm9MVlDVzSJ09oG3u+KliQPmhoNmMurClPifR
         bWBUesBwFZBnFbH6qB+O/trUTDwzerJ0/qVewVrXBxAac1ga4C21ArVOgKJyODfAbGNg
         I0JBMcCOu0EOqDN2G1jjL9xkPhN+/D827VXcxzR2DfeDlOxcoX8a98BtIiuvodvfLNOO
         Y/lpMHEU7aN/mw/XNxyXGrEH6EAlneiaweYRE2OWyojNQkVdaGWv2f8ksFm7K+sz1wFn
         jQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=zjtl1qclrDtVCF9j0VxvqBg/3kvhEV7o9wRud+DHZ00=;
        b=Zib3kfoBOrsJDsg7ZM+3qWZvDmOFu9t9Rv8dCwei/o0C5mi90GXjXLqhyLazQomXBL
         2L37tUyUqZh9i2uM6sTbO4HM8gvPIMg03SreyMSeA0Jp2USiMLOC+A/qXnoUSg1uwNnp
         dnwoX+ag0ck0O/S2+1FfePRRTalOb/wy4U5k27JEYPHFP6I6xLgCuVdQa4d/f4Av8CEA
         CBfVNt4zTTfiC5nn+GSOdnn596DWmOqpEKlw8dMalloYRM0ePZsW6p8uLsqV/KIgYhfr
         xllBvcYnG4fC9deJrGKg6sVUog4z/tq2ld7LP+Lny8pxCMgDw8Y1h0moPXlKWbP/0Fta
         ToRg==
X-Gm-Message-State: APjAAAV6vs1TkIS0No3nUEee3JY5ptH233rFdxJVVbOTCYygD9ow9LHU
        11l2WaH16YLq+E+Ei38X1OBuS6sr
X-Google-Smtp-Source: APXvYqz8C9B0RbLWY4iJCx56nP63CGLnNhdNRs9DOzpqkFhbpLubM69nK1HQJAShxYpUQiUgqRGYZg==
X-Received: by 2002:a50:896a:: with SMTP id f39mr13206865edf.293.1556575017846;
        Mon, 29 Apr 2019 14:56:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r18sm1810253ejh.92.2019.04.29.14.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 14:56:57 -0700 (PDT)
Date:   Mon, 29 Apr 2019 14:56:57 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 21:56:54 GMT
Message-Id: <e6acdba58659d6176a03037aeb63b0ba84e126ff.1556575015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.134.git.gitgitgadget@gmail.com>
References: <pull.134.git.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C4=B0smail=20D=C3=B6nmez?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] mingw: do not let ld strip relocations
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C4=B0smail=20D=C3=B6nmez?= <ismail@i10z.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C4=B0smail=20D=C3=B6nmez?= <ismail@i10z.com>

This is the first step for enabling ASLR (Address Space Layout
Randomization) support. We want to enable ASLR for better protection
against exploiting security holes in Git: it makes it harder to attack
software by making code addresses unpredictable.

The problem fixed by this commit is that `ld.exe` seems to be stripping
relocations which in turn will break ASLR support. We just make sure
it's not stripping the main executable entry.

Signed-off-by: İsmail Dönmez <ismail@i10z.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index b37fa8424c..e7c7d14e5f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -573,10 +573,12 @@ else
 		ifeq (MINGW32,$(MSYSTEM))
 			prefix = /mingw32
 			HOST_CPU = i686
+			BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup
 		endif
 		ifeq (MINGW64,$(MSYSTEM))
 			prefix = /mingw64
 			HOST_CPU = x86_64
+			BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
 		else
 			COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 			BASIC_LDFLAGS += -Wl,--large-address-aware
-- 
gitgitgadget

