Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ADD71F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 20:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbfJUUAD (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 16:00:03 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:34682 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbfJUUAD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 16:00:03 -0400
Received: by mail-wr1-f49.google.com with SMTP id t16so10242727wrr.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ia5vpcTDxayZTdmXb7CSMyaLiZeSCWzSncv+d1c/QWA=;
        b=npXwzdHGluZ5m2WdpQWQZVEF6i3mz14qXuHmGYeb4KmsbDh9/rgvzhwHUUYCqzezkz
         Spd2nYx/tw9GPl1ZpA9MiiADyaHkfzPiEnoKj2gfcoiu1kCaiV0CHywaLKqfLtYaHLMo
         1yf7tispmvgj3aXzIRscLFYV7juvaws/7bHVuJEMPG9HgDIyISohK0ytVwzrLlE3UbR8
         RB0jffYShrTNLvEmprXbJs+/PUn6pcBdaf7ULqXw6lc6CqZiF3sYkpwJCSSMwIIQ+/zV
         fQcFWa7G+i4QIw3kA4XAqN7uD3fJ6vcDR+dkjTTY/DxiLYo1Mgq7DAyw5ZtXHBLo98bw
         Deqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ia5vpcTDxayZTdmXb7CSMyaLiZeSCWzSncv+d1c/QWA=;
        b=OgTCHQBspjVdV8LxsrXDrYsQ/+vRHA5+3Fka/KhlwEW6J1z72MjqzPyfmap45plRlQ
         c5pte5KGPNzGSvD9Fiz/H5pkv+WdZQEt7c9s9+BaThWkC1J4iHM+a1L/gght1Cmg6xgq
         b22II8dj3iwqQ/zM8onTRzX7ApgKU5ZrnhQq7fopRLp8t4TC9z+iwySHb8M/9OVUpJFE
         0ymoVzrZTaV0WVBN8B9MQMKaKO+ZCeCrtB45lO2ADtod4+vebry8SevyljWghZApUM0d
         cXcK41rvHJCSO9zjYhvodmu7J8TNJ85lst3ZmiioH26DI1IHJOa03Kfi++jSdYsBKuj8
         LMUg==
X-Gm-Message-State: APjAAAXpkbTy6pX+019/pKXcOtVbGSQ9pbRFuPdkTt90BUfZ9BTD5nr8
        PSHZwlDfSFsfBj0CL8hd/5pEsr7b
X-Google-Smtp-Source: APXvYqwxDgaEPwEufW6snJQO1B3JiqAZYAq/2kzhhfyYcMSfbyUKgIGrgtJiUWFuQ9f9CI8DBxNXCg==
X-Received: by 2002:adf:f40a:: with SMTP id g10mr44400wro.228.1571688001501;
        Mon, 21 Oct 2019 13:00:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17sm17125026wme.6.2019.10.21.13.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 13:00:01 -0700 (PDT)
Message-Id: <07749ab720af05b3f666e325e9bc3c4c5d8196e5.1571687999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.410.v2.git.1571687999.gitgitgadget@gmail.com>
References: <pull.410.git.1571603970.gitgitgadget@gmail.com>
        <pull.410.v2.git.1571687999.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 19:59:58 +0000
Subject: [PATCH v2 2/2] ci(visual-studio): actually run the tests in parallel
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Originally, the CI/PR builds that build and test using Visual Studio
were implemented imitating `linux-clang`, i.e. still using the
`Makefile`-based build infrastructure.

Later (but still before the patches made their way into git.git's
`master`), however, this was changed to generate Visual Studio project
files and build the binaries using `MSBuild`, as this reflects more
accurately how Visual Studio users would want to build Git (internally,
Visual Studio uses `MSBuild`, or at least something very similar).

During that transition, we needed to implement a new way to run the test
suite in parallel, as Visual Studio users typically will only have a Git
Bash available (which does not ship with `make` nor with support for
`prove`): we simply implemented a new test helper to run the test suite.

This helper even knows how to run the tests in parallel, but due to a
mistake on this developer's part, it was never turned on in the CI/PR
builds. This results in 2x-3x longer run times of the test phase.

Let's use the `--jobs=10` option to fix this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index 457c6fee31..af2a5ea484 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -255,7 +255,7 @@ jobs:
 
         cd t &&
         PATH=\"`$PWD/helper:`$PATH\" &&
-        test-tool.exe run-command testsuite -V -x --write-junit-xml \
+        test-tool.exe run-command testsuite --jobs=10 -V -x --write-junit-xml \
                 `$(test-tool.exe path-utils slice-tests \
                         `$SYSTEM_JOBPOSITIONINPHASE `$SYSTEM_TOTALJOBSINPHASE t[0-9]*.sh)
       "@
-- 
gitgitgadget
