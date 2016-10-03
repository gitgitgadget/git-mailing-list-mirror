Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA95207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 21:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753134AbcJCV2n (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 17:28:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:51547 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752966AbcJCV2l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 17:28:41 -0400
Received: (qmail 21147 invoked by uid 109); 3 Oct 2016 21:28:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 21:28:41 +0000
Received: (qmail 30519 invoked by uid 111); 3 Oct 2016 21:28:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 17:28:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 17:28:38 -0400
Date:   Mon, 3 Oct 2016 17:28:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, David Turner <dturner@twosigma.com>
Subject: Re: [PATCH v2 0/5] receive-pack: quarantine pushed objects
Message-ID: <20161003212838.5jpiy5mjxi3caxmd@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
 <20161003204851.klwspo6agykx6s3q@sigill.intra.peff.net>
 <xmqqlgy55dmk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgy55dmk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 02:25:23PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here's a v2; the original was at:
> >
> >   http://public-inbox.org/git/20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net/
> >
> > which contains the rationale.  The required alternate-objects patches
> > (both the "allow recursive relative" one, and the helper to add an
> > internal alt-odb) have been pushed into their own series, that I posted
> > here:
> >
> >   http://public-inbox.org/git/20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net/
> >
> > This needs to be applied on top.
> 
> Sorry, you lost me.  So this 5-patch series comes on top of a brand
> new 18-patch clean-up series?

Yes, sorry to be unclear. The final sentence should have been:

  This v2 quarantine series need to be applied on top of that cleanup
  series.

-Peff
