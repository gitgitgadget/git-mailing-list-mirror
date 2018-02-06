Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F27531F576
	for <e@80x24.org>; Tue,  6 Feb 2018 08:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeBFIma (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 03:42:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:41890 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752054AbeBFIm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 03:42:29 -0500
Received: (qmail 23556 invoked by uid 109); 6 Feb 2018 08:42:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Feb 2018 08:42:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16125 invoked by uid 111); 6 Feb 2018 08:43:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Feb 2018 03:43:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Feb 2018 03:42:27 -0500
Date:   Tue, 6 Feb 2018 03:42:27 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 0/2] minor GETTEXT_POISON fixes
Message-ID: <20180206084226.GA26237@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I set NO_GETTEXT=1 in my config.mak, and happened to notice that running
the tests with GETTEXT_POISON fails. I think this has been broken for
years, but I don't generally play with GETTEXT_POISON. ;)

  [1/2]: t0205: drop redundant test
  [2/2]: git-sh-i18n: check GETTEXT_POISON before USE_GETTEXT_SCHEME

 git-sh-i18n.sh            | 8 ++++----
 t/t0205-gettext-poison.sh | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

-Peff
