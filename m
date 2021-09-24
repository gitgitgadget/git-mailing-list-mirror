Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBB8C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 11:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBE860E90
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 11:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244956AbhIXLNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 07:13:10 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56780 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244324AbhIXLNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 07:13:09 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 961B91F8C8;
        Fri, 24 Sep 2021 11:11:36 +0000 (UTC)
Date:   Fri, 24 Sep 2021 11:11:36 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3] doc/technical: update note about core.multiPackIndex
Message-ID: <20210924111136.GA15127@dcvr>
References: <20210922221342.6867-1-e@80x24.org>
 <9ebb4c34-8cdd-3120-ff9a-0e47099c3cf6@gmail.com>
 <YUy9HzRgHU2zvI4P@nand.local>
 <20210923201252.GA25980@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210923201252.GA25980@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MIDX files are used by default since commit 18e449f86b74
(midx: enable core.multiPackIndex by default, 2020-09-25)

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Eric Wong <e@80x24.org>
---
 v3: I cited the wrong commit in the commit message of v2 :x

 Documentation/technical/multi-pack-index.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index 1a73c3ee203e..86f40f24909a 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -36,7 +36,9 @@ Design Details
   directory of an alternate. It refers only to packfiles in that
   same directory.
 
-- The core.multiPackIndex config setting must be on to consume MIDX files.
+- The core.multiPackIndex config setting must be on (which is the
+  default) to consume MIDX files.  Setting it to `false` prevents
+  Git from reading a MIDX file, even if one exists.
 
 - The file format includes parameters for the object ID hash
   function, so a future change of hash algorithm does not require
