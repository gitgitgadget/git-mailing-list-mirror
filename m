Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE4F1FAE2
	for <e@80x24.org>; Mon, 19 Feb 2018 19:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932143AbeBSTrO (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 14:47:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:57142 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932139AbeBSTrM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 14:47:12 -0500
Received: (qmail 32537 invoked by uid 109); 19 Feb 2018 19:47:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Feb 2018 19:47:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6413 invoked by uid 111); 19 Feb 2018 19:47:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Feb 2018 14:47:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Feb 2018 14:47:09 -0500
Date:   Mon, 19 Feb 2018 14:47:09 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Jon Simons <jon@jonsimons.org>
Subject: [PATCH 0/2] quoting bug sending push-options over http
Message-ID: <20180219194709.GA837@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a small quoting problem in 511155db51 (remote-curl:
allow push options, 2017-03-22). The interesting one is the second
patch.

  [1/2]: t5545: factor out http repository setup
  [2/2]: remote-curl: unquote incoming push-options

 remote-curl.c           | 11 ++++++++++-
 t/t5545-push-options.sh | 40 +++++++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 12 deletions(-)

-Peff
