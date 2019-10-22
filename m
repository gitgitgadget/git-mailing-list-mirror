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
	by dcvr.yhbt.net (Postfix) with ESMTP id EEC3F1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 18:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfJVSTj (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 14:19:39 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:40099 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfJVSTj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 14:19:39 -0400
Received: by mail-wr1-f47.google.com with SMTP id o28so19152370wro.7
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=T0TqDKdHJPCVmbt0uBNSujYi2voJDgy8L250gUUNjQ8=;
        b=u4RI/vlpn6aqUs1uHafAPNZ+3nJsiQACMa76Iad/BaBlhkVFHPCyOx8K5HrcB+m6l8
         2mvFPwnZpDmkjUii7h++88vo3vslNSjKBPQ/+qRFY+dCRh+5EaH4AdzjdrLnhgIQxIQh
         gW6vy0khmvGO0dFBGnFaGgXfDuPz3xUHINcnMQqHK185Km/twEmlFJv84uRkkvn5NV7S
         zkzZHH7E//dblLUeJ2ObqoCTEy/hOIr15lSUOy1bolfvFmUi47c4roG5m20BocZf6BdU
         wHDdlns/PaP0aUDFzRtWz4q7xN8Y0vXI44C/q8JwQY2edn0lmH9+iXaCMNJ+ewNcmLpD
         +Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T0TqDKdHJPCVmbt0uBNSujYi2voJDgy8L250gUUNjQ8=;
        b=F/JfmOd2cEgvozrgeB1IktOLfjMaVpVl/zk6KyhrvhHwnmp+5DkgbsJEOgd2rfsBm2
         yi8lFYpxjvF3U4UmZHNweLAlABOFqwv3OTreZLC4gh8J3AqYJSyxnPJBe/0hNysivYBC
         HZIn0rTaCtiSI9ZodvvY0AiIYnSRm9MjiB4m30APK6TGMtLYpQCoG2Ay7LD+bmnrYtus
         NOk0FvvbZ1pXpqjsfjBHMw7zOC+Sanjysol0iOXn1qEuVyKU0bwsL59aVBFbDKj759VQ
         aHGfZmf+494DVZTg/mVghmzaYMtWjSN1qXc5NE8ARlqx6ZTSiEsonL9i/tdJIB5lyz/C
         pRzw==
X-Gm-Message-State: APjAAAVRag0d6OB4OAXjlbI9MayGUOfGrZZJeAMn1v4lNgXUf/eFLLuI
        Hra+3iicM79/jQZKy3oRN97kMF8/
X-Google-Smtp-Source: APXvYqxUF20xpu1zh5Q1wzri7uLCm1OpIQ0Bv/KrzrHeYDlkNRz5o6vfNnsOamJMUn5PSFFJXYYQtA==
X-Received: by 2002:adf:f101:: with SMTP id r1mr4997605wro.320.1571768377136;
        Tue, 22 Oct 2019 11:19:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c144sm2508815wmd.1.2019.10.22.11.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 11:19:36 -0700 (PDT)
Message-Id: <pull.412.git.1571768375.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 18:19:34 +0000
Subject: [PATCH 0/1] [Outreachy] documentation: remove empty doc files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove empty and redundant documentation files from the
Documentation/technical/ directory.

As part of moving the documentation from Documentation/technical/api-* to
header files, the following files are deleted because they include only TODO
messages with no documentation: Documentation/technical/api-grep.txt
Documentation/technical/api-object-access.txt
Documentation/technical/api-quote.txt
Documentation/technical/api-xdiff-interface.txt

Signed-off-by: Heba Waly heba.waly@gmail.com [heba.waly@gmail.com]

Heba Waly (1):
  documentation: remove empty doc files

 Documentation/technical/api-grep.txt            |  8 --------
 Documentation/technical/api-object-access.txt   | 15 ---------------
 Documentation/technical/api-quote.txt           | 10 ----------
 Documentation/technical/api-xdiff-interface.txt |  7 -------
 4 files changed, 40 deletions(-)
 delete mode 100644 Documentation/technical/api-grep.txt
 delete mode 100644 Documentation/technical/api-object-access.txt
 delete mode 100644 Documentation/technical/api-quote.txt
 delete mode 100644 Documentation/technical/api-xdiff-interface.txt


base-commit: d966095db01190a2196e31195ea6fa0c722aa732
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-412%2FHebaWaly%2Fdelete_empty_docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-412/HebaWaly/delete_empty_docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/412
-- 
gitgitgadget
