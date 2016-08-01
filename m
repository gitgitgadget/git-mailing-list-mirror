Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 468B91F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbcHARhm (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:37:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:52597 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754490AbcHARhi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 13:37:38 -0400
Received: (qmail 7764 invoked by uid 102); 1 Aug 2016 17:30:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 13:30:57 -0400
Received: (qmail 15031 invoked by uid 107); 1 Aug 2016 17:31:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 13:31:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 13:30:54 -0400
Date:	Mon, 1 Aug 2016 13:30:54 -0400
From:	Jeff King <peff@peff.net>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] format-patch: Add a config option format.from to set
 the default for --from
Message-ID: <20160801173053.3ggwr6vnyywl3l4h@sigill.intra.peff.net>
References: <cover.8678faa71de50c8e78760b0bcb3d15ebeda207d5.1469871675.git-series.josh@joshtriplett.org>
 <20160730094156.etvrzqbhcpg3is2z@x>
 <20160730154034.thjrfu6zeprzwvxb@sigill.intra.peff.net>
 <20160730181246.4aifnvqfeenddzdl@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160730181246.4aifnvqfeenddzdl@x>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 11:12:46AM -0700, Josh Triplett wrote:

> > These tests follow a different style from the "--from" tests later in
> > the script (and your second patch does follow it, and puts its test
> > close there). Any reason not to have all of the "from" tests together,
> > and using the same style?
> 
> The tests covered different things.  The later --from tests made sure
> that --from behaved as expected.  These tests made sure that format.from
> and --from/--no-from interacted in the expected way, with the
> command-line options overriding the configuration.  So, I put them next
> to the tests for other options like format.to and format.cc, which
> tested the same thing (overriding those with --no-to, --no-cc, etc).

OK. I would have grouped by "things that influence this area of
behavior", not by "config versus command-line". But I don't think either
is wrong or right. And since you are the one writing the patch, "how I
would have done it" is not a compelling review comment.

-Peff
