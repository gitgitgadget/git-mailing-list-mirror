Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8D6520193
	for <e@80x24.org>; Wed,  2 Nov 2016 18:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756308AbcKBSQ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 14:16:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:37571 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756196AbcKBSQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 14:16:28 -0400
Received: (qmail 8500 invoked by uid 109); 2 Nov 2016 18:16:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 18:16:27 +0000
Received: (qmail 4740 invoked by uid 111); 2 Nov 2016 18:16:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 14:16:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 14:16:25 -0400
Date:   Wed, 2 Nov 2016 14:16:25 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 0/4] t0021 perl portability fixups
Message-ID: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
References: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
 <20161102170415.GA6420@tb-raspi>
 <20161102174021.awhmbmuffbzv5b7t@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102174021.awhmbmuffbzv5b7t@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series should fix the portability problem you saw (in the final
patch), and fixes the failure to use PERL_PATH along the way.

  [1/4]: t0021: use write_script to create rot13 shell script
  [2/4]: t0021: put $TEST_ROOT in $PATH
  [3/4]: t0021: use $PERL_PATH for rot13-filter.pl
  [4/4]: t0021: fix filehandle usage on older perl

 t/t0021-conversion.sh   | 30 ++++++++++++++++--------------
 t/t0021/rot13-filter.pl |  2 +-
 2 files changed, 17 insertions(+), 15 deletions(-)
 mode change 100755 => 100644 t/t0021/rot13-filter.pl
