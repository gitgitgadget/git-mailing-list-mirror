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
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B2B1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 15:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfFMP0L (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 11:26:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34390 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbfFMLtr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 07:49:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id s49so1005244edb.1
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wu3jazoDAlbauAyAM1ClYlJXGYiSgY5Y02gxCmNI9SI=;
        b=Zb6lMa3PJ+hUuWHJgdBwrMuVMZEoiXP0asmE4lFKq/uKBmZCp4f+on7fxz3pFObwjv
         gm6RMykq8jjbWzpwvNsU1bub8fztcyKqHkTuLmki3F7lF9rRfoYtMhz9FIFBDA4nYLxg
         21I7B91fp0CPLh+VHSCb5w/73Mv/CyDzaLQqveLrNu5YMaAvJwNUA4hZ/ipB92iHi26V
         EqHo2j043BBvuTX40iw9gTDR79yma5bIKhirDIw/UKbm/6AN74CCEAHxFEmi0fmDIfBr
         m2IGalpFqzplFHGKX6s33pFlDKLmH9A10I5A6EcNvsme8xUALbg8RQUZo2Ij5n4r+9BV
         cVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wu3jazoDAlbauAyAM1ClYlJXGYiSgY5Y02gxCmNI9SI=;
        b=C7JrilGaGHG9jA4GohiTg0YrqL6WMgLbyoevTB9KwYJNbR2ssYDJwjQ7rHzM0lFut4
         N2+u0f38soFMNIaPcoHvjGvBHXQ0Jz9PlvCLINhTJOD8Y4BSy9I1HtvzYwysPuZeIhby
         1oBrdZi6wvQBCUiNlDHR4jasZEZfnv6jqODkHEV3nPqK/XdWNQqsLT2x4b3HDraBIczn
         K1/J4hmU3Qyw495yYefAL/rzMw4BSIGzyCXzR9BqqXoX8HFihMZwGp0VMkzHuKVIc5W7
         LjL5ipiHDVIBCG0XzrIkDhpJMnPOQLwdkiK6CYMiR62sPVTAfZqR0c4pQHxgYxJQn7/C
         wWfg==
X-Gm-Message-State: APjAAAVnmXWVfBefCLwvplT4SuX5DH9Q84hMxNdKXhk1gShyBvpzCCpw
        XtdcrWSl7IWbT6a32Im/EKaAC6lw
X-Google-Smtp-Source: APXvYqzs5rKNaUtzJCRFfTACgyrjXW5hD54inRd3L2H4YCMVJpcPVvQp9oSJXtk1QAgjfNh4oR8QdQ==
X-Received: by 2002:a50:8b9c:: with SMTP id m28mr49662101edm.53.1560426585250;
        Thu, 13 Jun 2019 04:49:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c21sm509070ejk.79.2019.06.13.04.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 04:49:44 -0700 (PDT)
Date:   Thu, 13 Jun 2019 04:49:44 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Jun 2019 11:49:38 GMT
Message-Id: <fde98c32199a6570c721dbef7795e278b36224db.1560426581.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.265.git.gitgitgadget@gmail.com>
References: <pull.265.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/4] poll (mingw): allow compiling with GCC 8 and DEVELOPER=1
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

The return type of the `GetProcAddress()` function is `FARPROC` which
evaluates to `long long int (*)()`, i.e. it cannot be cast to the
correct function signature by GCC 8.

To work around that, we first cast to `void *` and go on with our merry
lives.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/poll/poll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 4459408c7d..8b07edb0fe 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -149,7 +149,7 @@ win32_compute_revents (HANDLE h, int *p_sought)
     case FILE_TYPE_PIPE:
       if (!once_only)
 	{
-	  NtQueryInformationFile = (PNtQueryInformationFile)
+	  NtQueryInformationFile = (PNtQueryInformationFile)(void (*)(void))
 	    GetProcAddress (GetModuleHandle ("ntdll.dll"),
 			    "NtQueryInformationFile");
 	  once_only = TRUE;
-- 
gitgitgadget

