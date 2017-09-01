Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D291C1F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 22:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbdIAWD0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 18:03:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:55374 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752564AbdIAWDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 18:03:25 -0400
Received: (qmail 18150 invoked by uid 109); 1 Sep 2017 22:03:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Sep 2017 22:03:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6483 invoked by uid 111); 1 Sep 2017 22:03:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Sep 2017 18:03:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Sep 2017 18:03:23 -0400
Date:   Fri, 1 Sep 2017 18:03:23 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc/for-each-ref: explicitly specify option names
Message-ID: <20170901220322.stzgclld56r5lbt3@sigill.intra.peff.net>
References: <20170901144931.26114-1-me@ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170901144931.26114-1-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 01, 2017 at 04:49:31PM +0200, Kevin Daudt wrote:

> For count, sort and format, only the argument names were listed under
> OPTIONS, not the option names.
> 
> Add the option names to make it clear the options exist

Yeah, this looks much better. I could see having a general "<format>"
section if it was used as the argument to multiple options, but that's
not what's going on here. And even if it were, the right thing is to
have individual "--foo=<format>" and "--bar=<format>" items in the list,
and let them refer to a more general section on formats.

-Peff
