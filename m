Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5B851F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393239AbfAPNgd (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:33 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44064 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393231AbfAPNg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so5391319edd.11
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UIFTqxguWXt+P+iMJANnsfm86ufXvnIAqssuXHg5Cak=;
        b=cRhDx0+sF+kpbqR/gdIPdlzFi7GYMCf00LCjvZ8eoSv+Z1fpb2CDY+XhH7vdYfd3gV
         gy2PBqFpeB6GV5MvWhaqfAbe/vgmLViLfPDXNnBTOAJwDLCmx66D7tMNmbdIgFTGqa9j
         r3UnA1r9GsicOj2C+p5BLx96O4S+6j8DYdjrKbRuq+dLcUq+VRHluzmg90e5xcpCs4Cl
         wPD6/+aQaCQzk0Y3hHaEWF5c0XNs4umun/a3sxOnLtNUCh+XSxuoJ02+qr3432dvB08P
         Ek+i6TjqzI1v/gzo9IeduXRK0rrf9FeoV1Z1drfp7pe+Uy/QIt1JJau4rLU8yl4XEsM+
         LICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UIFTqxguWXt+P+iMJANnsfm86ufXvnIAqssuXHg5Cak=;
        b=j+Vkf9v2yKCovFaK37akKqfYhnIzjLuJrNZCHSKH6BMdJCQ8lQa76UzgjiWjLYZbh5
         p0kR/7uXeuHTCK4/Jhpv5RtpM4vNfUXnnxO2+gnbe42I/gHDPrHVnFTkW6YnL/Fn3eLG
         UtitS4mcEfSYtdzZQKuC76OvNN+UbNYjIWwieDFTQesl0xKksdr0p5X/EZ+FuBWLIwIF
         FzdjhRV31IaJaVBzOdf00qNN/dOrMMpMXR2rcb5O/Kp0FGZU1WlJy4mU4cUNvWqShA9B
         T1UTQTOwd7iXRvCV6xk2cckL/teS5BjTQRtSEPXJncsTsCs3qIBh09RSu9bYx1pkAOCt
         aySw==
X-Gm-Message-State: AJcUukfnglyjPfoa60XsHyV55msvC/OJB6b+N4cxVemQvRSl7HMRlzKc
        +V3DJmR0c5CDlPJ6L4sBV80LErhc
X-Google-Smtp-Source: ALg8bN6ZhZC2ReiqfhkZV58Wzhqhw+NiDp9Cz+1YI8cWYvI27wUijWAFrJvwAjYcOvL8AkM9U8gbMA==
X-Received: by 2002:a17:906:23f1:: with SMTP id j17-v6mr6851561ejg.155.1547645786996;
        Wed, 16 Jan 2019 05:36:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b46sm5583410edd.94.2019.01.16.05.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:26 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:26 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:36:05 GMT
Message-Id: <b503167084e28b242a081d00f20ee2623bd1766a.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 17/21] tests: add t/helper/ to the PATH with --with-dashes
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

We really need to be able to find the test helpers... Really. This
change was forgotten when we moved the test helpers into t/helper/

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 531170011e..9113ad86b4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1093,7 +1093,7 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
 	GIT_EXEC_PATH=$GIT_BUILD_DIR
 	if test -n "$with_dashes"
 	then
-		PATH="$GIT_BUILD_DIR:$PATH"
+		PATH="$GIT_BUILD_DIR:$GIT_BUILD_DIR/t/helper:$PATH"
 	fi
 fi
 GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
-- 
gitgitgadget

