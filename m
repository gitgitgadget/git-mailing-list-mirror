Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1FB820970
	for <e@80x24.org>; Fri, 14 Apr 2017 19:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754765AbdDNTwI (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 15:52:08 -0400
Received: from siwi.pair.com ([209.68.5.199]:57550 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752257AbdDNTwI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 15:52:08 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BAEB5845DE;
        Fri, 14 Apr 2017 15:52:01 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5] string-list: use ALLOC_GROW macro when reallocing
Date:   Fri, 14 Apr 2017 19:51:51 +0000
Message-Id: <20170414195152.33919-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 5 addresses coding style comments from the mailing list
in the perf test and squashes the changes into 1 commit.

Jeff Hostetler (1):
  string-list: use ALLOC_GROW macro when reallocing string_list

 string-list.c          |  5 +----
 t/perf/p0005-status.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 4 deletions(-)
 create mode 100755 t/perf/p0005-status.sh

-- 
2.9.3

