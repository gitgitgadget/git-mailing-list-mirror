Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34D31F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 16:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbeKOCgD (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 21:36:03 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:44287 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKOCgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 21:36:02 -0500
Received: by mail-pf1-f182.google.com with SMTP id b81-v6so7670499pfe.11
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 08:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oNV8UiGiwAct+iHzKGIcS9LqhFUFPULDWaZ8+DGn014=;
        b=p8ARTVi0RAo3X8yL3D5dDBXb7UtMbdlxCE9yf7KeLvXTy4oV6PegMzzCmXYg+TQBqE
         nS7VY6ogXXpJHOK9V5AYkEOWGXelinb2UeEGczPx/eLvSZTQDOyzQ8+4Bv2/Bjjd4PNX
         Njox1z3tya/UCzBcNBl0lLOzW5N9R24Y0C+xmb+e4aL64AnAJSNQYSGl5vPup85cMd7D
         EdQRxT6fFATOhniAJZ6OT6n4/0+Xlh8INthYzu+Eh9jTNuIFkd9ySDhZTgWAo2mZ6Vlj
         3eud5I4BUICL+COAMVeES5l+7gAOvhBC/fQfu3tW9+TmteK1Rq+A3tG+tXEiQP+XTdz4
         ttAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oNV8UiGiwAct+iHzKGIcS9LqhFUFPULDWaZ8+DGn014=;
        b=K/qwYTRRZnbgEbQ4CXSgHNksvETX89o4C6X3QfOO7GdhEmIG54f10y9v9k1LV9Ouve
         cNdZLp3g4AGjWxyBAbK9mVQom76AGKX3Kfbvirh77N3NnXmF0VHUox5CU/fGf9L3TzFl
         jOObgBRVaqWSKJSkBBG6MBxc4fORgxIgNp1aq/jsf54d+qkUzzWTJKVE+lXKiJ1Cy1EF
         Hm3MNcsvGPIRHn9xeUbnI6di6WrOJTWWihH1p9skwnzAEoj6MZ6xO6uTszp/OghWcI3o
         F6ZyDXDf7Uq5A7y6Q+emBlcRjp21DrV0qcr/ithipGMjWUjz/1hIcHvdGOKqdRYkow1z
         fYIg==
X-Gm-Message-State: AGRZ1gJdXJxySJKi0wh7K+HOdVNxP9rVZhVU6dGIFHkp6eIcToPkZbOx
        tvhUw7oXEWm2QztF1D6Lr03ZWqE1
X-Google-Smtp-Source: AJdET5e/JGIMKERKQmEhro97XyF23SxWDIbgq2X4NXHtrxa/Nf3QAToQdcjtliuwNlXS8Kq6WxNztQ==
X-Received: by 2002:a62:22c3:: with SMTP id p64-v6mr2714937pfj.9.1542213127222;
        Wed, 14 Nov 2018 08:32:07 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id i4sm5978668pfj.82.2018.11.14.08.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:32:06 -0800 (PST)
Date:   Wed, 14 Nov 2018 08:32:06 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 16:31:57 GMT
Message-Id: <80d50d5932779592a1ea92d0b13e8d0429453128.1542213121.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.73.v2.git.gitgitgadget@gmail.com>
References: <pull.73.git.gitgitgadget@gmail.com>
        <pull.73.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/5] tests: respect GIT_TEST_INSTALLED when initializing
 repositories
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

It really makes very, very little sense to use a different git
executable than the one the caller indicated via setting the environment
variable GIT_TEST_INSTALLED.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib-functions.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index d158c8d0bf..3472716651 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -923,7 +923,8 @@ test_create_repo () {
 	mkdir -p "$repo"
 	(
 		cd "$repo" || error "Cannot setup test environment"
-		"$GIT_EXEC_PATH/git-init" "--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
+		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git" init \
+			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
 		error "cannot run git init -- have you built things yet?"
 		mv .git/hooks .git/hooks-disabled
 	) || exit
-- 
gitgitgadget

