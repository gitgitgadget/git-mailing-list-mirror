Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AD571F404
	for <e@80x24.org>; Mon, 26 Mar 2018 06:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbeCZGBi (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 02:01:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:42762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750783AbeCZGBi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 02:01:38 -0400
Received: (qmail 29751 invoked by uid 109); 26 Mar 2018 06:01:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Mar 2018 06:01:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17016 invoked by uid 111); 26 Mar 2018 06:02:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Mar 2018 02:02:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2018 02:01:35 -0400
Date:   Mon, 26 Mar 2018 02:01:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] Remove contrib/examples/*
Message-ID: <20180326060135.GB7594@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878tafyito.fsf@evledraar.gmail.com>
 <20180325204653.1470-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 08:46:53PM +0000, Ævar Arnfjörð Bjarmason wrote:

> There were some side discussions at Git Merge this year about how we
> should just update the README to tell users they can dig these up from
> the history if the need them, do that.
> 
> Looking at the "git log" for this directory we get quite a bit more
> patch churn than we should here, mainly from things fixing various
> tree-wide issues.
> 
> There's also confusion on the list occasionally about how these should
> be treated, "Re: [PATCH 1/4] stash: convert apply to
> builtin" (<CA+CzEk9QpmHK_TSBwQfEedNqrcVSBp3xY7bdv1YA_KxePiFeXw@mail.gmail.com>)
> being the latest example of that.

I'm in favor of this. I don't think I've ever come across this directory
and _not_ been annoyed (because it was the result of a grep and was just
cluttering the results). And I think your README change leaves a nice
signpost for people who might be digging around for plumbing examples.

> The people on CC got this, but it seems the git ML rejected the message
> as it's too big. The abbreviated patches is here quoted inline, and at:
> https://github.com/avar/git/commit/cc578c81c2cb2999b1a0b73954610bd74951c37b

I was going to suggest re-sending with "-D", but it looks like "git
apply" will not apply such a patch (even though it could in theory
realize that the current blob matches the preimage sha1 and it would be
safe to remove it).

-Peff
