Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC6352095D
	for <e@80x24.org>; Wed, 22 Mar 2017 22:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbdCVWYM (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:24:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:49812 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752005AbdCVWYK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:24:10 -0400
Received: (qmail 30852 invoked by uid 109); 22 Mar 2017 22:24:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 22:24:09 +0000
Received: (qmail 596 invoked by uid 111); 22 Mar 2017 22:24:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 18:24:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 18:24:04 -0400
Date:   Wed, 22 Mar 2017 18:24:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jan.palus@gmail.com
Subject: Re: [PATCH] t7406: correct test case for submodule-update initial
 population
Message-ID: <20170322222404.jl3smvai2a3r6tzc@sigill.intra.peff.net>
References: <20170322213953.oddbgw5nfrvmzjgm@sigill.intra.peff.net>
 <20170322214948.12015-1-sbeller@google.com>
 <20170322215951.f4xbxehzvsd64c4y@sigill.intra.peff.net>
 <xmqq37e5hsg8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37e5hsg8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 03:12:07PM -0700, Junio C Hamano wrote:

> >   sq=\'
> >   test_expect_success '...' '
> > 	cat >expect <<-EOF
> > 	Execution of ${sq}false $submodulesha1${sq} ...
> >   '
> >
> > but I'm not sure if that is any more readable.
> 
> Yup, my eyes have long learned to coast over '\'' as an idiomatic
> symbol, but I agree that it is harder to see until you get used to
> it (and I do not think it is particularly useful skill to be able to
> spot '\'' as a logical unit, either).  ${sq} thing may make it easier
> to read but I think the one you did in the first quoted part in this
> reply is good enough.

Sounds good.

> -- >8 --
> Subject: t7406: correct test case for submodule-update initial population
> 
> There are three issues with the test:
> 
> * The syntax of the here-doc was wrong, such that the entire test was
>   sucked into the here-doc, which is why the test succeeded successfully.

This version looks fine except for the repetitious repetition. :)

-Peff
