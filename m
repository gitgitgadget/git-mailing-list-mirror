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
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6CC1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 22:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbfIPWA0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 18:00:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42650 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfIPWAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 18:00:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so496343pls.9
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 15:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1P8umtgM+1oSUyNndKEc3T8YmqQ6dOM2DGtYVpxRORI=;
        b=aepOiZTnQaJY4vq9JbYmN4JRTeOb7tJLKNKVY6RE97FuDo4Mk40CDmlhfxQ/SpMtqe
         iC9GWOScErjYomOjIAl3ACHx77ZO9ybdcO9nul9leq2sM4Ue3j95H4YiiVIIp0UnQUQ2
         c0P4tfZedtZI1QnQ4HG5KKKXb495dgErDBY1uCKVKdw0rpJY7ol7Yxq+10ftnZjt2/fS
         OegolFe6EeWGyI0Tvw34bRrlmzF+s6Rj1O8SJZzdYEw++2H3Rt7qIqeP+kaaIGmFNLpw
         +9h+PbC0uQYF/XCI7TxaK7L7XXD5APLqDSXNBpl/Pqz2PSg3r7IHDbnITHuTTXSiwUo0
         sRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1P8umtgM+1oSUyNndKEc3T8YmqQ6dOM2DGtYVpxRORI=;
        b=TIypLw+k0XMGbzHD/XloWVujiWnQUsF4qsN46ZJhSi/9haL+CWwGe0zGVuMECHKlAh
         DJUKvMIfv8f5lf5lz5ivgvQgBB7BfeNL9Ch1ApcRyTHbljqL+/viNAVf1O/sJGNx3gDa
         x3nKEnlz0e8BOV4NydtOwJ5VYq/xclMWUhVPT97xxKwZdvxmyVLHXaGwTBGr0hU/2jul
         /rTVRleONL4BATSsaSM6y0jIhVhNi3rBliqv9dYf/M4qCFmRBo3vBg/qG71fUL/PNglB
         AeX4iYtKXGz17l82vBy3HOGTX3BcflFoYkCJ0iqjBejdMdxuYrJGG3sx/6Vqjd5Jo8Lx
         4NiA==
X-Gm-Message-State: APjAAAVCZqNF7H7hMOerUG+BPKUScL8EHOs+CY9KWtfteB2heLC/gUmI
        w+DixdN84QKbwZeHrCd+DFHq0rEPve4=
X-Google-Smtp-Source: APXvYqyudhoJMeM7QpkaegA2NV9/g6V4i9xVYHj2Ncdhoo0+iLTPRzVLWqj+Avshs8mmIu0LAMIh+w==
X-Received: by 2002:a17:902:467:: with SMTP id 94mr318917ple.208.1568671224445;
        Mon, 16 Sep 2019 15:00:24 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id g1sm65291pgg.27.2019.09.16.15.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 15:00:23 -0700 (PDT)
Date:   Mon, 16 Sep 2019 15:00:21 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fixup! Makefile: define THIRD_PARTY_SOURCES
Message-ID: <64cc6feae0df61268c09c20573d03f60349649a1.1568671170.git.liu.denton@gmail.com>
References: <xmqqmuf49cze.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmuf49cze.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* expand the comment to show what it's used for

* alphabetical ordering fix

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 522342a46c..617c25d16b 100644
--- a/Makefile
+++ b/Makefile
@@ -1147,12 +1147,15 @@ BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/worktree.o
 BUILTIN_OBJS += builtin/write-tree.o
 
-# THIRD_PARTY_SOURCES is a list of patterns compatible with
-# the $(filter) and $(filter-out) family of functions
+# THIRD_PARTY_SOURCES is a list of patterns compatible with the
+# $(filter) and $(filter-out) family of functions. They specify source
+# files which are taken from some third-party source where we want to be
+# less strict about issues such as coding style so we don't diverge from
+# upstream unnecessarily (making merging in future changes easier).
 THIRD_PARTY_SOURCES += compat/inet_ntop.c
 THIRD_PARTY_SOURCES += compat/inet_pton.c
-THIRD_PARTY_SOURCES += compat/obstack.%
 THIRD_PARTY_SOURCES += compat/nedmalloc/%
+THIRD_PARTY_SOURCES += compat/obstack.%
 THIRD_PARTY_SOURCES += compat/poll/%
 THIRD_PARTY_SOURCES += compat/regex/%
 THIRD_PARTY_SOURCES += sha1collisiondetection/%
-- 
2.23.0

