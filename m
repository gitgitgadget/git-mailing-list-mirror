Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E95B20A10
	for <e@80x24.org>; Sat, 30 Sep 2017 07:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbdI3HiE (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 03:38:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:55372 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750933AbdI3HiD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 03:38:03 -0400
Received: (qmail 10751 invoked by uid 109); 30 Sep 2017 07:38:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Sep 2017 07:38:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11507 invoked by uid 111); 30 Sep 2017 07:38:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Sep 2017 03:38:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Sep 2017 03:38:01 -0400
Date:   Sat, 30 Sep 2017 03:38:01 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 0/5] Support %(trailers) arguments in for-each-ref(1)
Message-ID: <20170930073800.67jko2bns6mccevk@sigill.intra.peff.net>
References: <20170930062238.87077-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170930062238.87077-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 11:22:33PM -0700, Taylor Blau wrote:

> Attached is a patch to extend Peff's recent work of adding parsing options to
> "--pretty=%(trailers)" by supporting those same options in git-for-each-ref(1).

Thanks for working on this. The direction and general sketch of the
implementation look right to me. I noted a few problems inline, so this
isn't quite right to be picked up, but I think a v2 should get us pretty
close, if not all the way there.

-Peff
