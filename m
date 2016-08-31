Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EF641F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 10:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758909AbcHaK33 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 06:29:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:57972 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbcHaK30 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 06:29:26 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LaaVn-1bFJS91zRv-00mJmF; Wed, 31 Aug 2016 12:29:14
 +0200
Date:   Wed, 31 Aug 2016 12:29:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed
 tests
In-Reply-To: <CACBZZX4NyjkK0Nf1JVGFRhc0xnLYg2YX6ctO5OxK3Pi60r5KaA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608311227150.129229@virtualbox>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de> <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de> <CACBZZX6iEmbb68tzRKNAryp5qmt=iU9FMuOe2ONV=2ojcazoEg@mail.gmail.com>
 <20160830205151.k6ufhfzl6gh4uuog@sigill.intra.peff.net> <CACBZZX4NyjkK0Nf1JVGFRhc0xnLYg2YX6ctO5OxK3Pi60r5KaA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1811746671-1472639354=:129229"
X-Provags-ID: V03:K0:t9NYKyKkkUIO+luAwkM3wbR3J67jhUjkvN++UnTk76+m2fnGyzH
 k1t7EQbPxAaNqmXTXVciEioLNc4+tB/16AeFAgk7pPZ0tXqNdHktc3DGpIOwiP9T/MOcwfI
 pMvvhHzG67iUDefYyl5HJO4ixPhEqF4NEVdN3JjFvyWY6DBY0ZewOlZjhB1HzqtuDd/wQrs
 oHvgGYqnWHm3202B6kiLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x/FdrWIxdcQ=:hehJF/8GX4s4CuFuYgkkPL
 OAj8D88VEXm/bUV+O9/kxB6Amra6ltFiYSozLrGDjKtp7ZCUxm41rbfENBjpwwFQD0ayYdRGx
 TEKydy3a/T0TQcXnUb2fhH3VvyVafE+XU9BYDgY22NVI8jMLQXWfU+cdBwp9QQfQiPEnzdFro
 thBUp7F23ZjbxaSqSoDAYA+nkZ7lMEJZ0fWJFcux0274p16Aqap+sn0fvGtwg7BTKcwS6Venc
 hr3nuoh0otBMxVqzHP7M4cfQxQ+WXhr9VEbg7JWImr+RI2j9XvDsyO+ruhd+CssTIEqyZ8EIr
 dyg9ex65rf/62XH8TUyoPU2sYyov/yTD2paAq5hJVIy/Gc+L1oIJwL0mZ4wCCsi3tawQjE8H1
 nY5Xn4TA6ov76tZxf5Zl1pp9w3RbVO1wr9olZlf8xYjhESjidCck9/oLcRQCeluak1YeysQKX
 YKxnhKtXUARfpd2UtUIcRk0XgMzMV2sGettg85+SE4Y6uxCEjbXIddVhIrlm4W0NV6WCyytNh
 lcZEejjTgFy8IpTISId71gs82RxFvBbM9W7DBEWK2JLokccW+VqtUYPp6anz44YGez07R8cxs
 S0fekdGaz3uNJU+t8tH5xF95aF+VsFsedIL+hH0mI/mas01Do6hnsduWXgPf/sgtligmtNw3e
 22qRR49vAJ/F1qwLLwxg3psTexMkJ34ozaJt4B8nK1fCTU5HLoKrO5ufkHYO1MuF259Bjr0ea
 kM/mTzvA/kpLy1XDrKa2WLvK6UtVXyugGmfgHHsdd+PO9ag/3zPPpQFxeinhpQTnVM5e7hBtx
 WeAGT90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1811746671-1472639354=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Tue, 30 Aug 2016, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Aug 30, 2016 at 10:51 PM, Jeff King <peff@peff.net> wrote:
> > On Tue, Aug 30, 2016 at 10:48:19PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> >
> >> >  -failed: $(patsubst trash,,$(patsubst directory.%,%.sh,$(wildcard t=
rash\ directory.t[0-9]*)))
> >> >  +failed:
> >> >  +      @failed=3D$$(cd '$(TEST_RESULTS_DIRECTORY_SQ)' && \
> >> >  +              grep -l '^failed [1-9]' $$(ls -t *.counts | \
> >> >  +                      sed 'G;h;/^\(t[^.]*\)-[0-9]*\..*\n\1-[0-9]*\=
=2E/d;P;d') | \
> >> >  +              sed -n 's/-[0-9]*\.counts$$/.sh/p') && \
> >> >  +      test -z "$$failed" || $(MAKE) $$failed
> >> >
> >> >   prove: pre-clean $(TEST_LINT)
> >> >         @echo "*** prove ***"; $(PROVE) --exec '$(SHELL_PATH_SQ)' $(=
GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
> >>
> >> I don't at all mind this solution to the problem, if it works for that=
's cool.
> >>
> >> But FWIW something you may have missed is that you can just use
> >> prove(1) for this, which is why I initially patched git.git to support
> >> TAP, so I didn't have to implement stuff like this.
> >
> > Heh. I think each iteration of this patch will be destined to have
> > somebody[1] point Johannes at prove. ;)
> >
> > (But I really do recommend prove if you can use it).
> >
> > -Peff
> >
> > [1] http://public-inbox.org/git/20160630063725.GC15380@sigill.intra.pef=
f.net/
>=20
> Sorry about that, I see it's been mentioned already.

Yeah, it is true that prove(1) would be able to help. If it worked
reliably on Windows. (Probably Perl's fault, not prove's.)

> My only excuse is that I don't know how to operate my E-Mail client :)

But we use email to discuss all things Git because it makes everything so
easy and convenient... ;-)

Ciao,
Dscho
--8323329-1811746671-1472639354=:129229--
