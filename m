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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EFD11F454
	for <e@80x24.org>; Sun,  3 Nov 2019 03:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfKCDwB (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 23:52:01 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:35071 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfKCDwB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 23:52:01 -0400
Received: by mail-wm1-f54.google.com with SMTP id 8so5657214wmo.0
        for <git@vger.kernel.org>; Sat, 02 Nov 2019 20:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ETBmSAUfUQs5nKzKf1wMPXSWxbMfxL9Biudnu5vPY7I=;
        b=osVfPxcXc5ARqLb7JXR+5ClKWf5Z8ojR2UAdF1zSItBLIbo3EtMys4iwT9BcI53XIx
         i/AarlxlNUN/FuyadFOnhfNx9M0r8Dth88wMY2IGyTprzNxN2oVNuEy5BD2i+suRsUP2
         zD1DLc69T8gIv2ZaGh4dKU59oDjMN7I4O+DMXJtx72p2bSAHAH+Raz1ggDA5Zvu60rDN
         TJfcrqcH0UAsbIb/I3hGxKvl5tMByxhe3XQhePRI/OdmstoN7JcxuqG6VkeD4SiJyFjF
         //QTpqklP5zVwAHf2mpMYPGZvq1IhFl8dTJiYWuaJQ+hrIbTNzPserkfOlV/GMJoG4uz
         5rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ETBmSAUfUQs5nKzKf1wMPXSWxbMfxL9Biudnu5vPY7I=;
        b=WeTKkW1ZLBB9kcQ3dnMRLWwUwqwmpULrtY2fKicau5F9fe0n/GmkJyutfIktEedbRZ
         xoKOlahmQEO6p9PSeljHwKy5k5KSrS4hupD0jb7wg101yJ1PhoNGobTrbWDHTO1829Kn
         NZ/NYTb2P53S1eCqyLQ8OC18Y+ek3EBvmiH0N677gJCJLbBl6XD6vdmpKeF0SVh0JjPr
         jXd6Pz4hfkJXwFeINAgHIewH3eBCM86wnLFCbUethWGoCjVATD2fw2W1E0E2NaQBt74f
         1YgaUVacMW0Nbb/m0kYOTlCnSvsYFPhgZd6bv4K2vG3li2VBKaMeoS2fKBJZhqyHG6rq
         QwEA==
X-Gm-Message-State: APjAAAVFKNatC/IgGlDWg2jroX1Ou7T9sYk75tWDcPAJz8dby55oHWCD
        9KgK+0zB4/d5ONcwXQVyziebBIIO
X-Google-Smtp-Source: APXvYqzM01LhQ6ieKIbZXGidvjvFwQFAsiWTgLmzIPCnW/hdOHrmd+589XDjJ1V/WJjLl0Q/E/amqQ==
X-Received: by 2002:a1c:6a1a:: with SMTP id f26mr10586831wmc.19.1572753119103;
        Sat, 02 Nov 2019 20:51:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14sm17827313wre.27.2019.11.02.20.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 20:51:58 -0700 (PDT)
Message-Id: <58035fc61390d42bc97697de54d44f328f110acd.1572753114.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.442.git.1572753114.gitgitgadget@gmail.com>
References: <pull.442.git.1572753114.gitgitgadget@gmail.com>
From:   "Abimbola via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 03 Nov 2019 03:51:54 +0000
Subject: [PATCH 5/5] fix unproper comment in Makefile
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
index a632505ad9..41f0fcb78f 100644
--- a/Makefile
+++ b/Makefile
@@ -1033,7 +1033,6 @@ LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/am.o
-// BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
 BUILTIN_OBJS += builtin/bisect--helper.o
-- 
gitgitgadget
