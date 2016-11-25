Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6DF1FC96
	for <e@80x24.org>; Fri, 25 Nov 2016 11:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbcKYLFf (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 06:05:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:49825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751227AbcKYLFd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 06:05:33 -0500
Received: from virtualbox ([95.208.59.185]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4WuC-1cvi7f0TMK-00yiHn; Fri, 25
 Nov 2016 12:05:03 +0100
Date:   Fri, 25 Nov 2016 12:05:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming
 builtin
In-Reply-To: <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1611251201580.117539@virtualbox>
References: <cover.1479938494.git.johannes.schindelin@gmx.de> <cover.1480019834.git.johannes.schindelin@gmx.de> <3a10fd72cf336743891d6bc9a003cfeb5c3f0063.1480019834.git.johannes.schindelin@gmx.de> <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611242211450.117539@virtualbox> <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:t3yK5iolY3ThQ+em4ExWCujnlc5UJgwSYUS+x7dxTvUQqEi3JMC
 pTUfEfzVdkdWqQaxvtKRQDplxXXUW3B4t6gyIaETxwPzzSvAww+Z7rRnFNkWvrYNIKbxO5W
 48Y6JpDvjfSfeiKz8FwPNKt7+YilA2wKDV9w3lSmbuAFzPtVDldaLwy+EV8ktuW37IDmg59
 AmXvDD+72njbTzik8PEdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a4mB661UPjQ=:/Nc4j5SRvfNfxWNjoQfqb7
 hnM+x0bZ7Y7n+VvW8iWTCq77ItchtcFzJR5NxnOSfDPdqp09iWcoee23zEaohz/aIL0Q3slNa
 L1lPK9zUEu6YlyJOlkgVxXu4QCs7vCRvHHvDc71i9nqwkjm1RK+8oIhuUQ5/22Zzz9X0uCNUS
 8vsiA6wJmvgD2b/y0a8WpOAPqVI9LeUtnc/piQfx6rB/oBNh8fqUisjsPQ8xmH8psGYhHZL0L
 73+JwhaI4LkCwDHmMJgUjQm7COSmsQUfqdlxNWqtYfq3m933m7IP/BptrV8sCXYaFmLpoh7t2
 b9j3GvMSekHVx7MOI7iSczXHHCHUZPJcAuB9zT5YAK61Twgh2e+ZBtksTzcgQXH/q1vvt56LT
 ncOO8D8A0+rr//iT126ofTblAWvMRivLPYaSR6tSD9S88jaBEBFp2GPAduU9mURDv4m3FDK4z
 buinFgTXHdWs1T3I4O06fh+ZK/js4mAWxPYe8GLaCjut8OftAkpp2JqHpRg/ZfL3ap2g6EnTk
 y5sE8XecT+okuv7HRJFSsGMJwsy9VnB9CoXVJMPafixKi4/zeR/g0OQP9CUXbBOn2jHDd8Wc6
 XkS5i4M+ffZkmqolMP7YtYoT86Q1WdyFPmcerLSgY3nHRD06KU3fuUq8i99wxk7CBjFT2Z3hz
 gO6Swsd3xNxkQCOouOzxYPeoFopaARoPucZZVjVArdoFWt0CbccbRc8vcKmwwz4NsbZOr7zNn
 KYMd2KJciYRqPWFzpD00aL3KScog4RBE6evyEvRPdGNGPKgPU87WWLHrM984OTwfj6mA9UGFF
 vB5Qmdt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 24 Nov 2016, Jeff King wrote:

> On Thu, Nov 24, 2016 at 10:56:23PM +0100, Johannes Schindelin wrote:
> 
> > > I think it would probably be OK to ship with that caveat (people would
> > > probably use --global config, or "git -c" for a quick override), but if
> > > you really wanted to address it, you can do something like what
> > > pager.c:read_early_config() does.
> > 
> > The config setting is already overkill (and does even make something much
> > harder than before: running tests with the builtin difftool used to be as
> > simply as `touch use-builtin-difftool && make -C t t7800-difftool.sh, now
> > I have to edit t7800-difftool.sh to configure difftool.useBuiltin, and
> > without the repo-level config even that would not be working).
> > 
> > Imitating read_early_config() would be overkill deluxe.
> 
> I would have expected it to just be a build-time flag, like:
> 
>   make BUILTIN_DIFFTOOL=Yes test

That works for Git developers.

I want to let as many users as possible test the builtin difftool.
Hopefully a lot more users than there are Git developers.

Which means that I need a feature flag in production code, not a build
time flag.

> I'm happy with pretty much anything under the reasoning of "this does not
> matter much because it is going away soon".

Yeah, well, I am more happy with anything along the lines of David's
review, pointing out flaws in the current revision of the builtin difftool
before it bites users ;-)

Ciao,
Dscho
