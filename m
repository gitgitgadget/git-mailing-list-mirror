Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60275C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138F420767
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgDWU6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:58:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:37802 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726082AbgDWU6x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 16:58:53 -0400
Received: (qmail 17787 invoked by uid 109); 23 Apr 2020 20:58:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Apr 2020 20:58:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13356 invoked by uid 111); 23 Apr 2020 21:10:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Apr 2020 17:10:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Apr 2020 16:58:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 0/2] minor fixups for gs/commit-graph-path-filter
Message-ID: <20200423205851.GA1633985@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are just a few bits I noticed in the test-tool helper when the
topic hit next (my -Wunused-parameter patch complained that we never
looked at argc).

  [1/2]: test-bloom: fix some whitespace issues
  [2/2]: test-bloom: check that we have expected arguments

 t/helper/test-bloom.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

-Peff
