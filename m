Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799C01F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935278AbeFGOx2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:53:28 -0400
Received: from siwi.pair.com ([209.68.5.199]:49124 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933674AbeFGOx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:53:26 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id ACB333F48F3;
        Thu,  7 Jun 2018 10:53:25 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 451F73F48E4;
        Thu,  7 Jun 2018 10:53:25 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [RFC PATCH v1] telemetry design overview (part 1)
Date:   Thu,  7 Jun 2018 14:53:12 +0000
Message-Id: <20180607145313.25015-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

I've been working to add code to Git to optionally collect telemetry data.
The goal is to be able to collect performance data from Git commands and
allow it to be aggregated over a user community to find "slow commands".

I'm going to break this up into several parts rather than sending one large
patch series.  I think it is easier to review in pieces and in stages.

Part 1 contains the overall design documentation.
Part 2 will contain the basic telemetry event mechanism and the cmd_start
and cmd_exit events.

I'll post part 2 shortly -- as soon as I can convert my tests from python
to perl.  :-)

Jeff Hostetler (1):
  telemetry: design documenation

 Documentation/technical/telemetry.txt | 475 ++++++++++++++++++++++++++++++++++
 1 file changed, 475 insertions(+)
 create mode 100644 Documentation/technical/telemetry.txt

-- 
2.9.3

