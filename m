Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13DF51FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 14:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755491AbcLNOZk (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 09:25:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:56386 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756109AbcLNOZi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 09:25:38 -0500
Received: (qmail 31101 invoked by uid 109); 14 Dec 2016 14:25:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 14:25:36 +0000
Received: (qmail 25272 invoked by uid 111); 14 Dec 2016 14:26:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 09:26:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 09:25:34 -0500
Date:   Wed, 14 Dec 2016 09:25:34 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 0/4] "make tags" improvements
Message-ID: <20161214142533.svktxk63eiwaaeor@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A discussion earlier today made me notice that our "make tags" target
includes some cruft that we shouldn't be indexing. This fixes that, and
starts indexing some of the shell scripts, which is something I've been
doing in a hacky way for a while. It's very convenient when working on
the test suite (especially because I can never remember which functions
are declared in test-lib.sh, and which in test-lib-functions.sh).

  [1/4]: Makefile: reformat FIND_SOURCE_FILES
  [2/4]: Makefile: exclude test cruft from FIND_SOURCE_FILES
  [3/4]: Makefile: match shell scripts in FIND_SOURCE_FILES
  [4/4]: Makefile: exclude contrib from FIND_SOURCE_FILES

 Makefile | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-Peff
