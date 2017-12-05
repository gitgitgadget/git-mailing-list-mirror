Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA1920C3A
	for <e@80x24.org>; Tue,  5 Dec 2017 16:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbdLEQud (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:50:33 -0500
Received: from siwi.pair.com ([209.68.5.199]:59613 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751288AbdLEQud (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:50:33 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 636ED844E5;
        Tue,  5 Dec 2017 11:50:32 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CB608844E4;
        Tue,  5 Dec 2017 11:50:31 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        christian.couder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 0/3] Partial clone part 1: object filtering
Date:   Tue,  5 Dec 2017 16:50:11 +0000
Message-Id: <20171205165014.64488-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Here is V6 of the list-object filtering, rev-list, and pack-objects.

This is an incremental patch series to be applied on top of V5
which is already in 'next'.

This version fixes a typo, add the --no-filter option, eliminates
a couple of asserts(), and updates the documentation.

Christian Couder (1):
  list-objects-filter-options: fix 'keword' typo in comment

Jeff Hostetler (2):
  list-objects-filter-options: support --no-filter
  rev-list: support --no-filter argument

 Documentation/git-pack-objects.txt |  3 +++
 Documentation/rev-list-options.txt | 15 ++++++++++-----
 builtin/rev-list.c                 |  4 ++++
 list-objects-filter-options.c      | 17 ++++++++++++++---
 list-objects-filter-options.h      |  5 ++++-
 5 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.9.3

