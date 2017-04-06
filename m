Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 855F21FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 20:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbdDFUho (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 16:37:44 -0400
Received: from siwi.pair.com ([209.68.5.199]:25730 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752117AbdDFUhm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 16:37:42 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1D58284622;
        Thu,  6 Apr 2017 16:37:41 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1] WIP unpack-trees: avoid duplicate ODB lookups during checkout
Date:   Thu,  6 Apr 2017 20:37:31 +0000
Message-Id: <20170406203732.47714-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Avoid duplicate ODB lookups for trees during traverse_tree_recursive().

I'm marking this WIP so we can talk about the TODO in the
commit message.

Jeff Hostetler (1):
  unpack-trees: avoid duplicate ODB lookups during checkout

 tree-walk.c    |  8 ++++++++
 tree-walk.h    |  1 +
 unpack-trees.c | 13 +++++++++----
 3 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.9.3

