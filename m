Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CF4C20970
	for <e@80x24.org>; Tue, 11 Apr 2017 20:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbdDKUIO (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 16:08:14 -0400
Received: from siwi.pair.com ([209.68.5.199]:34813 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752580AbdDKUIN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 16:08:13 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6DC5E844D2;
        Tue, 11 Apr 2017 16:08:12 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 0/2] string-list: use ALLOC_GROW macro when reallocing
Date:   Tue, 11 Apr 2017 20:08:00 +0000
Message-Id: <20170411200802.31638-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 4 greatly simplifies the p0005 perf test. It now uses an existing
repo -- either real-world or artificial from t/perf/repos/many-files.sh.

Jeff Hostetler (2):
  string-list: use ALLOC_GROW macro when reallocing string_list
  p0005-status: time status on very large repo

 string-list.c          |  5 +----
 t/perf/p0005-status.sh | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 4 deletions(-)
 create mode 100755 t/perf/p0005-status.sh

-- 
2.9.3

