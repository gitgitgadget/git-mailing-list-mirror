Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 969AD202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 18:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932364AbdJZSCe (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 14:02:34 -0400
Received: from siwi.pair.com ([209.68.5.199]:12284 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932309AbdJZSCe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 14:02:34 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7BD5E84559;
        Thu, 26 Oct 2017 14:02:33 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DB6F78453C;
        Thu, 26 Oct 2017 14:02:32 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH] dir: allow exclusions from blob in addition to file
Date:   Thu, 26 Oct 2017 18:02:21 +0000
Message-Id: <20171026180222.39421-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

I pulled commit 01/13 from Tuesday's partial clone part 1 patch series [1]
and refactored the changes in dir.c to try to address Junio's comments in [2]
WRT sharing more code with the existing read_skip_worktree_file_from_index().

This patch can be discussed independently of the partial clone series.

[1] https://public-inbox.org/git/20171024185332.57261-2-git@jeffhostetler.com/
[2] https://public-inbox.org/git/xmqqpo9afu3s.fsf@gitster.mtv.corp.google.com/

Jeff Hostetler (1):
  dir: allow exclusions from blob in addition to file

 dir.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 dir.h |   3 ++
 2 files changed, 104 insertions(+), 31 deletions(-)

-- 
2.9.3

