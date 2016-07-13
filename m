Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F99C2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 18:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbcGMSy0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 14:54:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:56451 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbcGMSyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 14:54:25 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LraSn-1bFw9829aX-013L2h; Wed, 13 Jul 2016 20:53:47
 +0200
Date:	Wed, 13 Jul 2016 20:53:46 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <xmqqd1mh34eh.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607132052520.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607120927410.6426@virtualbox> <xmqqpoqj6i3d.fsf@gitster.mtv.corp.google.com>
 <20160712151630.GE613@sigill.intra.peff.net> <CAPc5daWcb5bfgsxMP0vCrQ7gBdeYBgefzPNHztaaCKzqbCv2aQ@mail.gmail.com> <20160712153520.GG613@sigill.intra.peff.net> <xmqqlh167tjd.fsf@gitster.mtv.corp.google.com> <20160712160921.GA2965@sigill.intra.peff.net>
 <xmqq60sa7rj2.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607131600110.6426@virtualbox> <xmqqd1mh34eh.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dlk7exdt/Lmbtfjlcgkw3llkEmnQX49GXV6Mc6HDn2JYBnoAIlu
 JRDZbq17rgx0+UfrIiQKDtdY/QoYI7kSK8DXmI1QDFJq7ASu9vjN7vM8SQQucU0k61lfTUe
 /6GP6FrcULvQgtG70vo1RHCKic1dosjkXBR3g0Tz4qu6NEEQEXIN2nqgyY15bJIbxoYYHGC
 QCMpYTHzC1nt5UY3tcWbQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:MK0nYU5iwzM=:kme8EnAk8Z1RyRWNGhFETR
 0RzHwklGqkFNQfvVjSkgB22aSpGxAGMH+ztvDAlNndc2s/I7XTSRsclVPF9j/noNrSmAWjUg1
 /jPeVd6adLyJ2mR/Agh2YMroOFPfOpC93HZyisOVnVjHkUWe/mWMaRo2U0t6vG/WSJkXC4SaO
 6DxGYTOyGgeDCU2EbmRNnuhv5UuEW9Mo49fSTVt0eclun3vBu0rLOhsi/KOpfWe76/Ob/hrkU
 UriF57e3vtSUHY/Q44Wkltto6PHhvXajWIHaSPY2si+SoqHNy7I5m+CM8FfK5wGkAywA0DzNg
 wRnqGIgWz7TV5uo4GXZF3U0sy6mCfrkAKNC+Zlyvhqva/9MJiJlZzBVX3aHLyipKWTJWEE9Yo
 AuoDYFOKhpx9k2cKC1YMZSiesO9SB1uvQopoDVe468URcwUNoAAfIHINhSkKHgN0vKA8aVFnf
 LXJRQDbPSx3YuYlXWVE0w6+13FrFfyq7F7IytF0HlMZn4fhL6vhYNROSOxDjKjfN0ErObwJDY
 67RjRSF5emkEzS7llfOnEccHH9xx7arPXYvkTrMuJ71X+9454f4IzbI3uX6V0g2fbldzhDe02
 0ia6Ry0tYrH1Tmpx8+cFLCWJjNoc2r8hSOu1Ns3pelxR1guy98m+OuJKpXHUNUqmTlUzEfXcs
 K9VyeawXbpj5IHrYqNJRoqQFNk3WJuUqmCtGr6lHMiOsgX1wMWcTVHwt7ioUN+BGeGEkV4w9U
 IcHS0z5Y0I5NSfabct+S9pTSB+gfxuuJlaFdlJe4Sr53iaL3kEkT8fDLcDLygmqoGNmU4FmcK
 remoxgN
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 13 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 12 Jul 2016, Junio C Hamano wrote:
> >
> >> Jeff King <peff@peff.net> writes:
> >> 
> >> > In case it wasn't clear, I was mostly guessing there. So I dug a bit
> >> > further, and indeed, I am wrong. Linux never bumped to a 64-bit time_t
> >> > on i386 because of the ABI headaches.
> >> 
> >> X-< (yes, I knew).
> >> 
> >> > That being said, I still think the "clamp to time_t" strategy is
> >> > reasonable. Unless you are doing something really exotic like pretending
> >> > to be from the future, nobody will care for 20 years.
> >> 
> >> Yup.  It is a minor regression for them to go from ulong to time_t,
> >> because they didn't have to care for 90 years or so but now they do
> >> in 20 years, I'd guess, but hopefully after that many years,
> >> everybody's time_t would be sufficiently large.
> >> 
> >> I suspect Cobol programmers in the 50s would have said a similar
> >> thing about the y2k timebomb they created back then, though ;-)
> >> 
> >> > And at that point, systems with a 32-bit time_t are going to have
> >> > to do _something_, because time() is going to start returning
> >> > bogus values. So as long as we behave reasonably (e.g., clamping
> >> > values and not generating wrapped nonsense), I think that's a fine
> >> > solution.
> >> 
> >> OK.
> >
> > I kept the unsigned long -> time_t conversion after reading the thread so
> > far.
> 
> That's OK at this point; it is not v2.9.x material anyway.

Got it. I will try to get the patches submitted soon, anyway.

> The primary reason why I cared 32-bit time_t is not about 2038, by
> the way.  I recall that people wanted to store historical document
> with ancient timestamp; even if we update to support negative
> timestamps, they cannot go back to 19th century with 32-bit time_t,
> but they can with long long or whatever intmax_t is on their system.

Fair enough.

Ciao,
Dscho
