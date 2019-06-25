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
	by dcvr.yhbt.net (Postfix) with ESMTP id A9A7F1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbfFYOtw (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33956 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbfFYOth (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so27593522edb.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dqJHfuKTPsOY8evakM7j8XeIh7DKWK6mb9bcnQXq+SE=;
        b=CePhjfu8TDCniWl23kgGFSym4T+r5Xh4s1Q8MnsZOEfBwdDVIn5RlD9wdFIc7MLCNU
         QoVTKXULT+jLCXssIoG2eiSHr6Zdc4J0lDB1rxsU9Ua0l0AWSn6lZTrZ5hIJ8MW2KgJz
         MacWyibsmCAXtyXhNBK7AsYAJU/kdvcEOPE0y66f2jWIZAo0aTNgmu/W1YG9m+5q7GsC
         XFI4iEb3aoX7EA8VK8FjgkEOQx6R6Jel2hUi5ksKlM6RSHgpGtaAOk77amCxnwwFsB+Y
         mChg04MMkhmetjcOyEZkazGuyI80p9D0VsmrbtMyaSCI/Vd5uUBtjDr9Yzw6G4peHNBf
         PouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dqJHfuKTPsOY8evakM7j8XeIh7DKWK6mb9bcnQXq+SE=;
        b=LjpydHVdeTh9WeRVbeuKy1yH9NWU+R/VmGXDO9jyrTlfMR77E6XK8Spi8TPmTQLfDD
         QtBz4tKNiI9E94XP+O2vHIlP4MrEzLrv/K3yKpyoChHh5NHfQlprmQIYOiAjceEC6BUL
         5jpDSRoIwKz9BnzNBqluol29jykfmVJ5WAn+d3IsnSsLAkLFSmAwSSB+rxD4IeW8Jt2l
         srejKmSo6LFH/74pIVpC9LdCAMB6FoVvKNk7V6F+8OzY5sNXButqCkMv75Z5xZU9zOkq
         GO9sKdKwcDYUXye+Rnh8E4TsedrK0dqDNxZrDOskXHEmHCX+X7AxANFsYdYbwZZ5u055
         qtnA==
X-Gm-Message-State: APjAAAWN8RieQB5nUAGTDV1dTwtNgXyUyLelT7CmNYQCoO88c2O0esFL
        uMB4xm4XnCAWm7Y8N5fmAAzzPoBy
X-Google-Smtp-Source: APXvYqwR9t7cXZlKbs5BZq4r4+lcExumR50ekb332D3tcw/UpaMIZcfVJluaakaiDeb6awOi0SLGNg==
X-Received: by 2002:a50:89a2:: with SMTP id g31mr138419090edg.93.1561474175682;
        Tue, 25 Jun 2019 07:49:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9sm4961777edd.53.2019.06.25.07.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:35 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:35 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:15 GMT
Message-Id: <99a2939cc2d4501d37e806de9273c8f9832b7849.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 09/20] msvc: define O_ACCMODE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

This constant is not defined in MSVC's headers.

In UCRT's fcntl.h, _O_RDONLY, _O_WRONLY and _O_RDWR are defined as 0, 1
and 2, respectively. Yes, that means that UCRT breaks with the tradition
that O_RDWR == O_RDONLY | O_WRONLY.

It is a perfectly legal way to define those constants, though, therefore
we need to take care of defining O_ACCMODE accordingly.

This is particularly important in order to keep our "open() can set
errno to EISDIR" emulation working: it tests that (flags & O_ACCMODE) is
not identical to O_RDONLY before going on to test specifically whether
the file for which open() reported EACCES is, in fact, a directory.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/msvc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/msvc.h b/compat/msvc.h
index 04b4750b87..d336d80670 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -19,6 +19,8 @@
 #undef ERROR
 
 typedef int sigset_t;
+/* open for reading, writing, or both (not in fcntl.h) */
+#define O_ACCMODE     (_O_RDONLY | _O_WRONLY | _O_RDWR)
 
 #include "compat/mingw.h"
 
-- 
gitgitgadget

