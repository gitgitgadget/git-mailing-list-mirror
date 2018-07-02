Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605B71F516
	for <e@80x24.org>; Mon,  2 Jul 2018 21:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeGBVLD (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 17:11:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:56844 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752683AbeGBVLC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 17:11:02 -0400
Received: (qmail 7838 invoked by uid 109); 2 Jul 2018 21:11:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Jul 2018 21:11:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27330 invoked by uid 111); 2 Jul 2018 21:11:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 02 Jul 2018 17:11:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2018 17:11:00 -0400
Date:   Mon, 2 Jul 2018 17:11:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Aleksandr Makarov <aleksandr.o.makarov@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 0/3] un-break for-each-ref --ignore-case
Message-ID: <20180702211100.GA20885@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to this patch last September:

  https://public-inbox.org/git/79c946a2-532e-1c9b-7bf2-1f1ccbff721e@gmail.com/

The patch was the right thing to do, but:

 1. It needed a commit message.

 2. It needed a signoff.

 3. It needed a test, which then showed that there was _another_ bug. :)

This fixes 1 and 3, and the extra bug. I've added my signoff to
Aleksandr's patch, as I think it is a trivial enough change to fall
under the DCO part b. But Aleksandr, if you can give your explicit
sign-off to include the patch in the project, that would be better
still.

  [1/3]: t6300: add a test for --ignore-case
  [2/3]: for-each-ref: consistently pass WM_IGNORECASE flag
  [3/3]: ref-filter: avoid backend filtering with --ignore-case

 ref-filter.c            | 11 ++++++++++-
 t/t6300-for-each-ref.sh | 11 +++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

-Peff
