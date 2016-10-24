Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D2601FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 14:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941155AbcJXOIc (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 10:08:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:56890 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941047AbcJXOIa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 10:08:30 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MN748-1c0rmV128e-006dv1; Mon, 24 Oct 2016 16:08:11
 +0200
Date:   Mon, 24 Oct 2016 16:02:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Max Horn <max@quendi.de>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 00/27] Prepare the sequencer for the upcoming rebase
 -i patches
In-Reply-To: <DAD768D3-5558-49DE-9FDD-E46F17933ECE@quendi.de>
Message-ID: <alpine.DEB.2.20.1610241500131.3264@virtualbox>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de> <xmqqinsk8g1b.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610231151140.3264@virtualbox> <DAD768D3-5558-49DE-9FDD-E46F17933ECE@quendi.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mMiZuqd8MBjT1HLIx38P4kznQ+pJOmPVsDJTKZl8uxzJFwowfRd
 S6IMEb+d/7f4lPrLElreFQf0wvUvUWXttSSu14GzjkExK+rjlYPrGVnLWH5kuvDGmEvF33Z
 cK+TVCXkFrRx++fJVay6eeJVU64iLrp+BzK5iiu5syQIjrJFUKiTZjMZ7SsODgAQwnl56Ip
 Zhd2Q/m6JIraL4SCR0MWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9HWqZsZuWxg=:OcUr/NlWp1qUvQjIaQxqn+
 hfQ+0D2O0QC3wptVGL9P5BCfNi8zgj2lipqnG/KPuil3tFBcn0j38Y8qNckPj8PxmFIrreBn4
 nBDX5WyURAGhUK2QTP7nQ9m7kILsnGWN96TuQggN3WkfjNDkT6you1J/TvAsCkWqT3Xrwdqhw
 U4E16jPXTDTkYgMDXtIfRjom9YdN1LKn3rc5o47ywCGBducqJHEo6gSklCFZKNgtSJuIXyDqY
 GXADYAHzumQ5wSpbt5oic3xjlVSeVSnzfQH5rmpDrgyAk2ZcgLVxGQzjXH+6rjScMIqgGqh5w
 7kO5gdeMNSC7A85kAEA+Lta31iIIQlmWJso3JKQniafUrTzoEAW57nZfgTmX6H/dVZZXnQez4
 MRA9qW6OMKZ5nW4Bac62G9HmzfhOTSzSq11D4uDtm27p9cfuDS1Y4ZLJoLQv3bNMDBlox2TtX
 g74xWTFHsE2U/pDCOGJC49j+hDJ0AcxR7WH8h6rOjT2JCet2LrbYYSa3wVtQiASgDw9IPdC4d
 9G5a8SCVEchR8QUsjPk8G4gbquX6xAoBgy+YD5aqgUNlMipcTieWvh+hBAb6Vf+a3Bsni8h7g
 +97A8p3CczNV9hnuSIdvkCi5L7Ko+hiestYIQpv7LYA62Umb18pQZy8abd69hEsK+SWOpfjUJ
 U2WTUboEPWs5tFayJG9o+K4gk7iSKUKXxt8SROXmpIJjwQ2QC0b/cXNuMcXDSTcoDRm5Q78KV
 Nf3BNWYtzcwFBu1hYCwa4Il4GYvKAc6Rkdpsx7HS/ndM5Xpr5plppEA1+b4L6NT0gzXALwuEI
 kcHWPT4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Max,

On Mon, 24 Oct 2016, Max Horn wrote:

> > On 23 Oct 2016, at 11:54, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > On Sat, 22 Oct 2016, Junio C Hamano wrote:
> > 
> [...]
> 
> >> There isn't enough time to include this topic in the upcoming release
> >> within the current https://tinyurl.com/gitCal calendar, however,
> >> which places the final on Nov 11th.
> > 
> > More is the pity.
> > 
> > Thank you, though, for being upfront with me. I will shift my focus to
> > tasks that require my attention more urgently, then.
> 
> Junio did go on, though:
> 
> >> I am wondering if it makes sense to delay 2.11 by moving the final
> >> by 4 weeks to Dec 9th.
> 
> I was reading this as an offer to delay things to accommodate the
> integration your work into 2.11. I.e. "within the current plan, there is
> no time for this, but we could adjust the plan". But maybe I am
> misinterpreting?

There is no indication that the rebase--helper patches would make it into
2.11 even with four more weeks.

I will now focus on other things that I postponed in favor of the
interactive rebase patches. In fact, I *have* to focus on some quite
pressing tasks that I neglected over those patches.

It's not like the process would magically improve just because a release
date is pushed. To the contrary, pushing the release date to allow for the
rebase--helper to be included may very well have the counterintuitive
effect of delaying things beyond even that pushed date "because there is
now so much time left" (until there isn't). It's a variation of
[Parkinson's Law](https://en.wikipedia.org/wiki/Parkinson%27s_law) ;-)

Anyway, back to work,
Dscho
