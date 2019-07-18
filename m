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
	by dcvr.yhbt.net (Postfix) with ESMTP id BEFC41F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390458AbfGRNTK (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52040 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390416AbfGRNTI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so25582255wma.1
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XPn/tHCgwc2NQ5JCW3FcsauVSFsTJYzJ8/MQzYnX054=;
        b=E1xMuPHWC5vxBZpIP9UFHVOv59unW7S/BQxKrcYLF/eYyuaHTOWUDK+T5a7j1NPftj
         Q7LvvxiOJRpsA0FYcU7vejJELcPstyyh/PqwYLWXAM7hfZiDCFr9cAazeTdnNeTsd0f+
         +BpDKzhgIMmKY+h8bLyFoiE398pZD2jwB7QF1pB020hnyNXsB82m6F6b7bzdmoeuuvJt
         AOUHpSMj+0SBTBUeLxgXuebMhp++NM+/DRj7XYp86m7+1qkrqtzffBREPvsKkYcy5w9H
         EQaubbYF4kLUT1qSfha4pTpilv7IvArOeXgsFrbt/kcugm4UGDiSnbnAPFWvmMZbRX/F
         Wq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XPn/tHCgwc2NQ5JCW3FcsauVSFsTJYzJ8/MQzYnX054=;
        b=SlD1k7bbrZ+fB7XQU8qs31qtvgWlUzeBsILAPZI/3y5W2N1j9r6EjrLHCFaa/1ry3z
         35JCRnjbcpbgX59wk92Vn9dey5Ezf0/4CCk6A2EP9boZrGSThweogQl42tAA7JG3BMcu
         K6C8wXLwgREXSN14pzVR4fyVOP5iHuXid/L7gf4e7/OkFKRrb6yAwHeDNNfb7MBqDOAo
         X1kftIbAQChG9V6ZS4IOJVbQkkc3izKG5cFFwJ+Sbv8niYdzbw9/uZAYvSLwYYg9vhn+
         9Dq3Gt/7wj8Uj+oS8iDQOaxL1oAJkCZGCf2AyzrgOwa00Xzc48Nmho1p+IDsC2nZvWh2
         CD8Q==
X-Gm-Message-State: APjAAAVdEbiJLMNV34xHMvF5TRb44aOnjMFZssElp7q7zeMRGVqevUDn
        l7GXVFHaVUjRwyU7cJO7MfUTEPGL
X-Google-Smtp-Source: APXvYqwEmlkTGmvhmj7CjMn37Hsb+lYJmB88XL3o91qqmzjMl/A20cuNRj8DTbry/t9L7P5KSESGDw==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr38942510wmc.89.1563455947268;
        Thu, 18 Jul 2019 06:19:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j33sm61722735wre.42.2019.07.18.06.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:06 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:06 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:44 GMT
Message-Id: <e908d01f076e5954d4c2af4fb3e297c5762aaf48.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 09/24] contrib/buildsystems: ignore gettext stuff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

Git's build contains steps to handle internationalization. This caused
hiccups in the parser used to generate QMake/Visual Studio project files.

As those steps are irrelevant in this context, let's just ignore them.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/engine.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index ad6a82c30c..9db3d43a1e 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -141,6 +141,12 @@ sub parseMakeOutput
             next;
         }
 
+        if ($text =~ /^(mkdir|msgfmt) /) {
+            # options to the Portable Object translations
+            # the line "mkdir ... && msgfmt ..." contains no linker options
+            next;
+        }
+
         if($text =~ / -c /) {
             # compilation
             handleCompileLine($text, $line);
-- 
gitgitgadget

