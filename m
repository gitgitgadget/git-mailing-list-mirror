Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9811F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfEHPxy (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:53:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35795 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfEHPxx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:53:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id p26so4698629edr.2
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hrhOWgQJcuMFvddKCD1mkss829rkYgbz1EvpajHm/HM=;
        b=ZXsfLMeCPdLf7s2SHRvEYA0xKTFNug2C6T0Qnkv9wHNAarfyjy9QHELOD371uzuSgj
         yBaVAlDYpaq4BT9urewO4XCrRDUutAbrsIi9c2/EvYDXZU54vu4olmr5jHZxErl2Z+wN
         6MiQSpanEI2VqDUtF79O+Nfo508wXVCYOL8C2SdCt5Zl+YVWD7Cgpbj4KENLmtDMerYz
         2/U4gBTArRcd4icx36xQSl6VbJhLRFvNEW8ET3UCQbr8FQyBXHfR11IMbzKdBX3N+lnF
         M8wdkcDxqNFelK/ZrhIdVdSjqaUNX37zmT3jdkyXIJm/0IMi2cl9Qbt6mbZ+pQCY+bNe
         7c2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hrhOWgQJcuMFvddKCD1mkss829rkYgbz1EvpajHm/HM=;
        b=R+ukIPu2yQvzahqfEQfsFI4dZadW1l7SHUwgaTGRaAWLSvOdTkgFjCIWm7/T3tKtm3
         nCQruLgSFr8WF17b+IjQRmprAl8hGhB0QIRDhSHzCujPdyGbT5VOrADGnncnY2ALhSfk
         lnBmWBCGnd+82AMjFZST2bGdB5JVOUd3frW75js3oO67/gzPznogucOvMAJ2Tph4K5e0
         +4ASfESJb3AODzZlyfnJ3og4LVRGcXCcdFdtepOinFG973vas2vRtuZEV8lKO3hgMm0/
         U8Cg8Sde2aB/mPcKdEy3QbR7EWppygx+56AE7Oo3enYKHgcwszKahH7slqisKJmirgDT
         H8bA==
X-Gm-Message-State: APjAAAWRFHv19XHfRH+B1ofgoLvm50/PrQxhgSUKd5Y0ZblMP3hyIDX6
        SMFvsvM+shXuBEnQMDGvwuyXrbWFJws=
X-Google-Smtp-Source: APXvYqztGMD8ifI0HD76ASGwOG5AIpP8vREDinYCcQs8EcT/L+C+ehLFeyCcf65xa1mKe0GMo5GoWg==
X-Received: by 2002:a17:906:2f13:: with SMTP id v19mr3576142eji.17.1557330831436;
        Wed, 08 May 2019 08:53:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s57sm66148edd.54.2019.05.08.08.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:50 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:50 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:33 GMT
Message-Id: <f9b719fc7a6bc3e025771481af2d671a4b9578f3.1557330826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 04/17] commit-graph: remove Future Work section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit-graph feature began with a long list of planned
benefits, most of which are now complete. The future work
section has only a few items left.

As for making more algorithms aware of generation numbers,
some are only waiting for generation number v2 to ensure the
performance matches the existing behavior using commit date.

It is unlikely that we will ever send a commit-graph file
as part of the protocol, since we would need to verify the
data, and that is as expensive as writing a commit-graph from
scratch. If we want to start trusting remote content, then
that item can be investigated again.

While there is more work to be done on the feature, having
a section of the docs devoted to a TODO list is wasteful and
hard to keep up-to-date.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index 7805b0968c..fb53341d5e 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -127,23 +127,6 @@ Design Details
   helpful for these clones, anyway. The commit-graph will not be read or
   written when shallow commits are present.
 
-Future Work
------------
-
-- After computing and storing generation numbers, we must make graph
-  walks aware of generation numbers to gain the performance benefits they
-  enable. This will mostly be accomplished by swapping a commit-date-ordered
-  priority queue with one ordered by generation number. The following
-  operations are important candidates:
-
-    - 'log --topo-order'
-    - 'tag --merged'
-
-- A server could provide a commit-graph file as part of the network protocol
-  to avoid extra calculations by clients. This feature is only of benefit if
-  the user is willing to trust the file, because verifying the file is correct
-  is as hard as computing it from scratch.
-
 Related Links
 -------------
 [0] https://bugs.chromium.org/p/git/issues/detail?id=8
-- 
gitgitgadget

