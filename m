Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39ED81F453
	for <e@80x24.org>; Wed, 19 Sep 2018 20:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeITCdN (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 22:33:13 -0400
Received: from ICGRIDDB04.SEAS.UPENN.EDU ([158.130.57.72]:44912 "EHLO
        ICGRIDDB04.SEAS.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeITCdN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 22:33:13 -0400
Received: from [10.13.0.14] (helo=ofb.net)
        by ICGRIDDB04.SEAS.upenn.edu with esmtp (Exim 4.89)
        (envelope-from <frederik@ofb.net>)
        id 1g2iqX-0001yo-A1; Wed, 19 Sep 2018 16:13:13 -0400
Received: from amenhotep (unknown [173.239.75.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ofb.net (Postfix) with ESMTPSA id 1D6193EE59;
        Wed, 19 Sep 2018 13:13:08 -0700 (PDT)
Received: from frederik by amenhotep with local (Exim 4.91)
        (envelope-from <frederik@amenhotep>)
        id 1g2iqR-0000Gc-FC; Wed, 19 Sep 2018 20:13:07 +0000
From:   Frederick Eaton <frederik@ofb.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Frederick Eaton <frederik@ofb.net>
Subject: [PATCH 3/3] git-describe.1: clarify that "human readable" is also git-readable
Date:   Wed, 19 Sep 2018 13:12:31 -0700
Message-Id: <20180919201231.609-4-frederik@ofb.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180919201231.609-1-frederik@ofb.net>
References: <20180919201231.609-1-frederik@ofb.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The caption uses the term "human readable", but the DESCRIPTION did
not explain this in context.

Signed-off-by: Frederick Eaton <frederik@ofb.net>
---
 Documentation/git-describe.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index e027fb8c4..ccdc5f83d 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -18,7 +18,9 @@ The command finds the most recent tag that is reachable from a
 commit.  If the tag points to the commit, then only the tag is
 shown.  Otherwise, it suffixes the tag name with the number of
 additional commits on top of the tagged object and the
-abbreviated object name of the most recent commit.
+abbreviated object name of the most recent commit. The result
+is a "human-readable" object name which can also be used to
+identify the commit to other git commands.
 
 By default (without --all or --tags) `git describe` only shows
 annotated tags.  For more information about creating annotated tags
-- 
2.19.0

