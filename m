Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F113FC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80B961100
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbhIVWPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 18:15:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54090 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232149AbhIVWPN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 18:15:13 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 93A281F8C8;
        Wed, 22 Sep 2021 22:13:42 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc/technical: remove outdated MIDX default note
Date:   Wed, 22 Sep 2021 22:13:42 +0000
Message-Id: <20210922221342.6867-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Multi-pack-index files are used by default since
commit 18e449f86b74bab35b150549c8342d252fe7ae00, so the
outdated note was misleading.

Signed-off-by: Eric Wong <e@80x24.org>
---
 Documentation/technical/multi-pack-index.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index 1a73c3ee20..2038fb7995 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -36,8 +36,6 @@ Design Details
   directory of an alternate. It refers only to packfiles in that
   same directory.
 
-- The core.multiPackIndex config setting must be on to consume MIDX files.
-
 - The file format includes parameters for the object ID hash
   function, so a future change of hash algorithm does not require
   a change in format.
