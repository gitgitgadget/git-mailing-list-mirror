Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7979E20A17
	for <e@80x24.org>; Mon, 16 Jan 2017 23:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdAPXwD (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 18:52:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:39953 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751257AbdAPXwC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 18:52:02 -0500
Received: (qmail 31533 invoked by uid 109); 16 Jan 2017 23:51:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 23:51:33 +0000
Received: (qmail 13379 invoked by uid 111); 16 Jan 2017 23:52:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 18:52:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2017 18:51:31 -0500
Date:   Mon, 16 Jan 2017 18:51:31 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, git@vger.kernel.org
Subject: Re: [PATCH] request-pull: drop old USAGE stuff
Message-ID: <20170116235131.kyxzcsslr4x7ppev@sigill.intra.peff.net>
References: <20170115174635.2422-1-wsa@the-dreams.de>
 <xmqqr343c0pl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr343c0pl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2017 at 04:23:02PM -0800, Junio C Hamano wrote:

> Wolfram Sang <wsa@the-dreams.de> writes:
> 
> > request-pull uses OPTIONS_SPEC, so no need for (meanwhile incomplete)
> > USAGE and LONG_USAGE anymore.
> >
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> 
> Makes sense.  These are not used anywhere after we switched to use
> parse-options.

It does seem a shame that parse-options does not show this explanatory
text. But I guess nobody really cares that much, and you can always use
"--help" to get even more details.

-Peff
