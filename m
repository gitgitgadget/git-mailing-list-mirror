Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0151F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfG2UI3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54078 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbfG2UIS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so54990721wmj.3
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T5sC/K2nocoacN82eqyh9pXAZYpl+oGpqVWb7MKvpJg=;
        b=mEOX/H938fS9zpuoIRCo1vf2NEO7XkoJ96a6ZIyux5IH0pKsBN18/Jqx9SJxaWD2By
         Ggu20DYPHUExnrRUG/1PFahUB0KBT8sLIdtdZxatiW+TaM1vOZFzkQZEeD3ZW6by4Iwy
         RIPu8G9MqM+tsO3pXtTKM0BXXn8OcPzyQkdSPPZosS2hd+hnOEAZFGtph1FzXGKwQauj
         YAyCvVpGEXOuATMIyj8bPejDzcNtrIj0Qm79cHgCmiLgojZ762ovBcfReaBa0FNilQda
         wD720PbfMCmOLDZFtPsX8mpbPlMOZWR6Y6cxfYDC6+0dr1A0Egnk1HqKg7yUDB9yu46s
         u4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T5sC/K2nocoacN82eqyh9pXAZYpl+oGpqVWb7MKvpJg=;
        b=aVZ1ACmPYXNFolcXVRA1OBDlOEi5m3zHjv02+ivUyNDZt3wN3i0F3hbkZ77kgoclLj
         NWPX4NOQLNK7FUWlTpWUS0SsoAadeLIq1D5PKlFmd58Ya+q1OotReyUPwBCQ0Qh8dOSE
         h/ENUOjgAIN0Um6hFJRrvKC31y/Bn9dzmkqsJ9pLXIN2A+glLMZSGroksHufbpQxeHfI
         drKMOmPPc+EBGQsNaiBQI6QX9eFTxQid89LIyNmkU4Sq/Lf2a5f5NhSDSdPwiAUMsQQU
         tI9LigWRkG38lBJeG605aVzsuGrIPDxm/1hzvtUN9mTN8FtvXhxoytFVaDdMX5STPdiA
         0dPA==
X-Gm-Message-State: APjAAAU7o68VVwzKTDta8dxRLmOJrXJeBDOfO5jhuBK989U8SeZxNdYq
        6QFnCYMF06FNRov2gsYhPVUe7+Wn
X-Google-Smtp-Source: APXvYqxExHdYc7hEznxAl227aykFa+HPBUbn69uxmp/y/MFfxRsNV+geduG9XhJEo1c7r4z1rM6Rxg==
X-Received: by 2002:a1c:e109:: with SMTP id y9mr65068008wmg.35.1564430896369;
        Mon, 29 Jul 2019 13:08:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm42556958wmi.38.2019.07.29.13.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:16 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:16 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:58 GMT
Message-Id: <a81cc2cccef71fbcc73b72c3a26fba4097ced5f4.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 22/23] bin-wrappers: append `.exe` to target paths if
 necessary
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

When compiling with Visual Studio, the projects' names are identical to
the executables modulo the extensions. Read: there will exist both a
directory called `git` as well as an executable called `git.exe` in the
end. Which means that the bin-wrappers *need* to target the `.exe` files
lest they try to execute directories.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 98a0588416..3716dadc08 100644
--- a/Makefile
+++ b/Makefile
@@ -2717,7 +2717,7 @@ bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))|' < $< > $@ && \
+	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
 	chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
-- 
gitgitgadget

