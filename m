Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD021F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbdLNVTm (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:19:42 -0500
Received: from siwi.pair.com ([209.68.5.199]:41738 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753838AbdLNVTj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:19:39 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 08FED84515;
        Thu, 14 Dec 2017 16:19:39 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6978084512;
        Thu, 14 Dec 2017 16:19:38 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7] Partial clone part 1: object filtering
Date:   Thu, 14 Dec 2017 21:19:08 +0000
Message-Id: <20171214211909.55868-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Here is V7 of the list-object filtering, rev-list, and pack-objects.

This is an incremental patch series to be applied on top of the V6
incremental patch which is already in 'next'.

This version fixes some formatting of the help text as suggested
by Christian.

Jeff Hostetler (1):
  fixup: rev-list-options text

 Documentation/rev-list-options.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.9.3

