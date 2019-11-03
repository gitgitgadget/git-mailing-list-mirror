Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 186201F454
	for <e@80x24.org>; Sun,  3 Nov 2019 03:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfKCDv7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 23:51:59 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35522 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfKCDv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 23:51:58 -0400
Received: by mail-wr1-f44.google.com with SMTP id l10so13379313wrb.2
        for <git@vger.kernel.org>; Sat, 02 Nov 2019 20:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hMK9qvzpwMIG4S20Z09fQtl5UvggXcHVBwZDOKPqWVQ=;
        b=aGRw1tu9yh4WcHCIQ0M4SR0tFNcflWoA/W8a71z2TxHt+QuV8fYNo5l/69IBh+ubsP
         vPXqUVUW42IeLOHKPwAKVPwL8UKqVM1mJtuaB6NJcAdX7Sjxq8rftYx3EUVdZELV5GHb
         IasK0rhjkNSwI4AMURjOsVLoOk6xvxvidNmIcimButOTM5QmeNk5ncaUYGXVlTSLDKUJ
         eGlmJW7LrbUK5nBGwjaz49D+quHaZi/sXdi4EsEx+m08ChU2DiYC8jLvixYsCCMwe1Tg
         4btkMnOPyACVCaR9cVTYyeIbAjrq331UKDHv4QMjmN7aU+EkjtlGyRoj3t7e6fV9B3Vp
         ZT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hMK9qvzpwMIG4S20Z09fQtl5UvggXcHVBwZDOKPqWVQ=;
        b=I4YQlRQDls+g7cYVwN3CvTBNlz43Jib4D2Xb9uKy2iiNdygHldkW8ZuNe1EInzSb8p
         xtarwfVsdQOlmAdIFtzJNMUISg/pFAKgxdZrPAkH6F2gccyFtqMb3E0Cd1eXb8FAX7Dg
         7r9Km1pEQCQvnmyxmQHmYe7/ZReXpSDy6oSzVsacKLr6Cq0mKCgMIv/nFyc1DiUe9Cp+
         hwdk0rdupu83U6IHS1VDV+q/0WfLLj6qV9uGG9kDsej4KSmd0JhzavVIQeEfpXPp2u19
         xxockWnFMC9ACRBiNWKIEF+0V9FaOirgVM9n2RTZfgI5Z7dH1nz4VpqawLdC0r1gH9I6
         zcHg==
X-Gm-Message-State: APjAAAXuEbRX2cZCtjMHss/T0y+bBH33gab48LOipMa2oT+yVoUZ1PsO
        226QrxnySj+5gE3X3ENo823w6euz
X-Google-Smtp-Source: APXvYqw16viThpGmDW+QmoblSOeaMgZbACDqJozjw2g9lvwrnewkijTZ6hkOCVw78KRKzQx7ARcArw==
X-Received: by 2002:adf:f489:: with SMTP id l9mr14334403wro.337.1572753117157;
        Sat, 02 Nov 2019 20:51:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm13393039wrw.10.2019.11.02.20.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 20:51:56 -0700 (PDT)
Message-Id: <595e8bae9ebc783c3be8174f15937255fafbbed7.1572753114.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.442.git.1572753114.gitgitgadget@gmail.com>
References: <pull.442.git.1572753114.gitgitgadget@gmail.com>
From:   "Abimbola via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 03 Nov 2019 03:51:51 +0000
Subject: [PATCH 2/5] edit the makefile
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Abimbola Olaitan <craftwordltd@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abimbola <craftwordltd@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abimbola <craftwordltd@gmail.com>

Signed-off-by: Abimbola <craftwordltd@gmail.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 58b92af54b..41f0fcb78f 100644
--- a/Makefile
+++ b/Makefile
@@ -1033,7 +1033,6 @@ LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/am.o
-BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
 BUILTIN_OBJS += builtin/bisect--helper.o
-- 
gitgitgadget

