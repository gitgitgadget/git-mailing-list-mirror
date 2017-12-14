Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F7D1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 15:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbdLNPY1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 10:24:27 -0500
Received: from siwi.pair.com ([209.68.5.199]:51405 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752879AbdLNPY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 10:24:27 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7794E844F7;
        Thu, 14 Dec 2017 10:24:26 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D81A3844F5;
        Thu, 14 Dec 2017 10:24:25 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2] Partial clone design document
Date:   Thu, 14 Dec 2017 15:24:03 +0000
Message-Id: <20171214152404.35708-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This patch contains V2 of the partial clone design document.
It incorporates suggestions from the mailing list on V1 and
elaborates on a few topics.

Jeff Hostetler (1):
  partial-clone: design doc

 Documentation/technical/partial-clone.txt | 259 ++++++++++++++++++++++++++++++
 1 file changed, 259 insertions(+)
 create mode 100644 Documentation/technical/partial-clone.txt

-- 
2.9.3

