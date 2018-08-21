Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1FF91F954
	for <e@80x24.org>; Tue, 21 Aug 2018 12:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeHUQNE (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 12:13:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32899 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbeHUQNE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 12:13:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so8473600pfn.0
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mZqje63yJ4Au23xsfBMM4im3dLBIe54in3LoBEmAvBE=;
        b=QFDZIfl57+BDoZO/TNPOmru289b54UQasAItl2E9h3WeblWIC8gQokXhpuXtUsSpBi
         1FbTsZgUCsyEFTMOzuXBSBjH0XPpejMHZvmME2yqg0Gd3NBg7Xxu/U4INZvgBKaxLdnX
         aR14zJ6RxeWPsX7PEuK8wHCT/dwr3nRjgCPcVZzXYsz9T1wEbGx2tNU68uL4FgKJarM4
         CRMY/4NRxMfoQ+xLDQvEoEx2pS7FCmmVwXrP1QxIyX8q8Iwvk9Jisfmk8REKZ46a/z/9
         ke5jwhQr3KseoB1Q6+p4k+8Ip+C+0Z4kqAyHbdqVWu7sKFzJT8bx0Hn2k/Pablck+bca
         GSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mZqje63yJ4Au23xsfBMM4im3dLBIe54in3LoBEmAvBE=;
        b=AaLb68z2MTUgj7YLVF9ZfmH6HBBqICyM+DOGf50Ua4SD5jmjLqlA5OE1BUeH6MrLj9
         x/cmTer5PezlemJ0VdXuA7afk8Vm+UBWiHbgESKZq0MKRPjuTYrp58tCUkc72T1+5k/X
         tE9vbDQB/GaqvSrJkkqb428NmY298JWYAHsNM4fzcN+WmNcB4xH2D7gGw/zwatOYDKsF
         bC9yblvqM7nO1gmnpnnwqNFK8DgTanH1B/6vaSkWQqqHgElvOxaOl2eu7TVN2bqg71QO
         3TBq10TU04XaPDaBXv2WnxsQkjOvlCRHcCEdsvMR6cJOi5y0bVq1WffiSV6Lr65AcKdn
         efoA==
X-Gm-Message-State: AOUpUlEIEa467yksW+/wBPBhqaMWDJNhF+S2Xk3pB/tG8sBOf0+Jm/WI
        f0ONKX0T1SpXdrjdEWcoINGuEqO6C1Y=
X-Google-Smtp-Source: AA+uWPxdv0d/fLFRBrW2FCbBdjSdvP8vuZEFCYcmuhsmgICBmFQDg8uRI+H+PayRZRs9I4vy6O7awA==
X-Received: by 2002:a62:c182:: with SMTP id i124-v6mr52301497pfg.248.1534855982207;
        Tue, 21 Aug 2018 05:53:02 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id t76-v6sm20495185pfe.109.2018.08.21.05.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 05:53:01 -0700 (PDT)
Date:   Tue, 21 Aug 2018 05:53:01 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Aug 2018 12:52:58 GMT
Message-Id: <ef5af2ccc7ea662a4059d118772cdbe282fc7e43.1534855978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.22.git.gitgitgadget@gmail.com>
References: <pull.22.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] Docs: Add commit-graph tech docs to Makefile
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Ensure that the commit-graph.txt and commit-graph-format.txt files
are compiled to HTML using ASCIIDOC.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d079d7c73..841e4f705 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -69,6 +69,8 @@ API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technica
 SP_ARTICLES += $(API_DOCS)
 
 TECH_DOCS += SubmittingPatches
+TECH_DOCS += technical/commit-graph
+TECH_DOCS += technical/commit-graph-format
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
-- 
gitgitgadget
