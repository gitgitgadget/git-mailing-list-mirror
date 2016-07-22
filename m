Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E13920195
	for <e@80x24.org>; Fri, 22 Jul 2016 16:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbcGVQ1L (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 12:27:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:48680 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751244AbcGVQ1L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 12:27:11 -0400
Received: (qmail 13031 invoked by uid 102); 22 Jul 2016 16:27:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 12:27:10 -0400
Received: (qmail 7232 invoked by uid 107); 22 Jul 2016 16:27:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 12:27:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2016 12:27:07 -0400
Date:	Fri, 22 Jul 2016 12:27:07 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 0/3] minor git-jump improvements
Message-ID: <20160722162707.GA13905@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Here are a few quick fixes and features for git-jump. The first is a bug
I noticed and fixed recently. And that reminded me of the second one,
which I'd been carrying in my local copy for a long time.

  [1/3]: contrib/git-jump: fix greedy regex when matching hunks
  [2/3]: contrib/git-jump: add whitespace-checking mode
  [3/3]: contrib/git-jump: fix typo in README

-Peff
