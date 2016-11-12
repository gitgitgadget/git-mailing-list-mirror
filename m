Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A22A520229
	for <e@80x24.org>; Sat, 12 Nov 2016 08:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934785AbcKLIzS (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 03:55:18 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:35341 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933232AbcKLIzR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 03:55:17 -0500
Received: by mail-it0-f67.google.com with SMTP id b123so2082305itb.2
        for <git@vger.kernel.org>; Sat, 12 Nov 2016 00:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redfrontdoor-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hSun5W7eVaXmOukLV6thbv6/N5tTatZkpBA3kVWcOhU=;
        b=TfDqLzNTuKBv6LkAFwvn2CUugqb8vvaoBerGXAXq5Wbpj0sUI6e/IKrfBY+P4YzSvk
         pZjAIX9r+T3fixoZ+utkYfVqDT39qPpWaF9iriKIim1ceWI9m83GOV6FxXUKasI/xNSJ
         Ft3iu6AQCQZ10FfeWXs9iI2BN/orF5WSA6IXRnalFXQT16IMTwhikcvfZ7CHMVmSF6dB
         THHZJaPxoTXa6FHUlxGjyBFeVNtWF/57ctGpj3TmrsI9mChfLQ7iP5XCV2nFjIx5RMTO
         X2+Vhpr5N1+IC5+56ynfiFfppKEmu7pXkjs+BcxFpYKwAJwhC8yKKCQ8Wp1SQKQhukkH
         +lQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hSun5W7eVaXmOukLV6thbv6/N5tTatZkpBA3kVWcOhU=;
        b=De1An2kQUAoAQHs91wtsXYvcijhjM17aMq6RyGwBseipX7waksibk8QDbCMlHYGb97
         xLT2YrAaMPbx4BS6oXdblD2rUC0lMqjReysUbG74qsPrSDUPP+epNcAxgisLIbdzc46g
         M40CLU9vtIiQ2cCFcAzqwIi96gJBCf8Xd64qgAI75ST9vG6vc+6jld/9p3D4aNR9QSrO
         8cYgziUc7NsjVWmMDD8MbJxRD8FNsGHdk1xNS8SjljvPUTEgzd6LUMx795O6jZLqV1Me
         hxNgfcbbYz//e73YhWyNP7OFL0S6ExWToVb5NnioVgENIRyVDBYs+maGL51vdh10fDUt
         gyrg==
X-Gm-Message-State: ABUngvf0Ax/QL2Jm2fgEZmrb9t334ojzumK6u+725i6WI2/c2SvuARz96+eD4GYSKULtXIggn2YQoqBMe76Csw==
X-Received: by 10.107.7.27 with SMTP id 27mr14983714ioh.130.1478940916646;
 Sat, 12 Nov 2016 00:55:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.134.25 with HTTP; Sat, 12 Nov 2016 00:55:16 -0800 (PST)
From:   Ben North <ben@redfrontdoor.org>
Date:   Sat, 12 Nov 2016 08:55:16 +0000
Message-ID: <CAHG0eJU4NV+rq_nQX_u-QutojRtD_7ChS_mLLZoioWg42EizWA@mail.gmail.com>
Subject: [PATCH] git-worktree.txt: Fix typo "to"/"two", add comma
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ben North <ben@redfrontdoor.org>
---
 Documentation/git-worktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 0aeb020..e257c19 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -133,7 +133,7 @@ OPTIONS
 +
 If the last path components in the working tree's path is unique among
 working trees, it can be used to identify worktrees. For example if
-you only have to working trees at "/abc/def/ghi" and "/abc/def/ggg",
+you only have two working trees, at "/abc/def/ghi" and "/abc/def/ggg",
 then "ghi" or "def/ghi" is enough to point to the former working tree.

 DETAILS
-- 
2.9.3
