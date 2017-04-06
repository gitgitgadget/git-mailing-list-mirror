Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DF26209F1
	for <e@80x24.org>; Thu,  6 Apr 2017 09:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755486AbdDFJbF (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 05:31:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:57425 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757237AbdDFJ3w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 05:29:52 -0400
Received: (qmail 32049 invoked by uid 109); 6 Apr 2017 09:29:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Apr 2017 09:29:44 +0000
Received: (qmail 24508 invoked by uid 111); 6 Apr 2017 09:30:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Apr 2017 05:30:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Apr 2017 05:29:42 -0400
Date:   Thu, 6 Apr 2017 05:29:42 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Tom G. Christensen" <tgc@jupiterrise.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
Message-ID: <20170406092942.ow4mvce5miyzbgld@sigill.intra.peff.net>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <d6ba17f0-3da9-8699-8d5c-5ebf1eaef00e@jupiterrise.com>
 <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170406005301.4vmjkiu6qkj3g276@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170406005301.4vmjkiu6qkj3g276@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2017 at 12:53:01AM +0000, brian m. carlson wrote:

> > It would be great to have them on-list, as far as I can tell they were
> > never submitted? Is there some time/administrative reason for why
> > you're not submitting them? Some of these are many years old, it would
> > be great to have them on-list for wider review & included so vanilla
> > git works on these platforms.
> 
> I'm very opposed to accepting patches for operating systems that are no
> longer security supported.  Having insecure systems directly or
> indirectly connected to the Internet is a very bad thing, and we
> shouldn't make it easier for people who want to do that.

Hmm. I'm not sure whether I agree with that or not. I certainly wouldn't
want to _encourage_ people to use ancient unpatched systems. But I'm
also not entirely comfortable passing judgements on people's OS choices.
Security isn't a discrete variable, and there are lots of situations
where it makes sense to stick with an old, unpatched system because the
risk of changing it outweighs the risk of it being attacked (think
mission-critical systems sitting behind firewalls).

That said, I don't mind the argument "even the people who made this OS
are no longer supporting it; why should we?". And the response from Todd
seems to reinforce that.

And it's not like people on ancient mission-critical systems get cut
off. They can still run the version of Git they were running when their
OS went out of support.

-Peff
