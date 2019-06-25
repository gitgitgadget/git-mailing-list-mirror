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
	by dcvr.yhbt.net (Postfix) with ESMTP id AF4611F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbfFYOtn (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:43 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:35055 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbfFYOtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:40 -0400
Received: by mail-ed1-f41.google.com with SMTP id w20so19944700edd.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hZNUWoDxtPYSagWWQfRxxLc7WIBwG+NKxJpRjBW0xjo=;
        b=tPJxJmAoSgZ9RiPGdrwRKkg89fWBXGDZdn6uyGcmPjEuPMMBfG9KoSwPHTwXQ2+6x1
         0p/1jNj0CZUt95vK3sap6llN7LGXcbVE/IPZcfhdyQIxdpg0SeIGT+BfqeSq8LGtXPo0
         xVjuY9kXYJ9ZhuqZjhytIKMiNzwWS1RpyJsgGXzcJfpsuU5GbbzWkqLsSikTKIQoqZF6
         5xNIYpwTyol1gQzt9H+dhhDV6djYYi7EFtfxo8PP98xt7VtsMd4eeJnWetYnpV2TDUey
         aJ1gE70ax4kv5BgSwTEJhbv10e+uqFUBN4uYsQD9yCvXOFrLzgr3tRoBKSAD39YPRCvG
         3Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hZNUWoDxtPYSagWWQfRxxLc7WIBwG+NKxJpRjBW0xjo=;
        b=mcb1LA0vMYI5p8SotT1QLZdFF3ZPjC2PngME/YUpCETJkGMo1pacUxf/M9IpcDBDDo
         ynfL2zRNcrlvw21Q98A+e5j7IEnlh//wdVvxRn9tjLWAd53O1Suy+pqni/ea9bHU7cj6
         on3zagardcPNKjQM75Vnbe0hrilgPjPKIqFG9ZfJYxUxCP0q6tE1X7hrvTmlPUoY58qd
         9ueyyOMitLnYmaEYotm9ko7Iz/0LciXfv1PHTZMHAe4nvUqI8l6yjOju203sv82lobFP
         s4DWVU2e8qwee/IrijwSHg7RCg9bEBv/TusR5ALtXLCVrSQ4FMRvXelClstdIKeytEe7
         Ztkw==
X-Gm-Message-State: APjAAAW/ASjs/q/GQ35xUk8dXC5FEwI2G3m8dsGO2+4Nl37TbxTkL0ox
        Fn51H21FplLNr5+0uxBMlOXB4kPD
X-Google-Smtp-Source: APXvYqxr5GBKVdlokuaDIrx7Swxo+ddtdYBH3SbKdp8lnz2OmQeB/2wNz9FFYLIfA0GxzWomDyK5wQ==
X-Received: by 2002:a50:86b7:: with SMTP id r52mr145852901eda.100.1561474178933;
        Tue, 25 Jun 2019 07:49:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm4837044eda.39.2019.06.25.07.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:38 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:38 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:20 GMT
Message-Id: <63bf9f1f9239280359c0086375117f984ae72dc1.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 14/20] msvc: update Makefile to allow for spaces in the
 compiler path
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

It is quite common that MS Visual C++ is installed into a location whose
path contains spaces, therefore we need to quote it.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8a7e235352..3cf8cc8ffd 100644
--- a/Makefile
+++ b/Makefile
@@ -1240,7 +1240,7 @@ endif
 
 ifdef SANE_TOOL_PATH
 SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
-BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(SANE_TOOL_PATH_SQ)|'
+BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
 PATH := $(SANE_TOOL_PATH):${PATH}
 else
 BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
-- 
gitgitgadget

