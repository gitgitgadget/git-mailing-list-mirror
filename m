Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F9161FD09
	for <e@80x24.org>; Wed, 31 May 2017 15:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbdEaP1m (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 11:27:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:58602 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbdEaP1l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 11:27:41 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEtba-1d8vrN1iN0-00FzyZ; Wed, 31
 May 2017 17:27:23 +0200
Date:   Wed, 31 May 2017 17:27:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>
Subject: Re: [PATCH 6.5?/8] version: move --build-options to a test helper
In-Reply-To: <20170530210530.o5gbz2k24wxrfner@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1705311726110.3610@virtualbox>
References: <20170530051742.3j3yn3ipfmyrrteu@sigill.intra.peff.net> <20170530204553.25968-1-avarab@gmail.com> <20170530210530.o5gbz2k24wxrfner@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-195662968-1496244443=:3610"
X-Provags-ID: V03:K0:uQwejHKHU6I/IqxV68feqMJvPZH5oJsvs6kl8i4a/ZTnJi5uTPN
 OEJIs8NvZ47qAY3h7lK8+92hh45gVro+gBLzbVM4p+5phYHYE7oAlebEsTCq1JN7b1rdZV6
 RHkQKaEqxHlYz7cuCvlr2mPx8cwyrqL0E1erfWLtvOi/XpdngNCIGa1qdlzSsJDgBeKAZsU
 Eej1xQnhrDg2bv8TO29rA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HyzCj983EYQ=:zJXn5q2ScK1Z6dyvpb4EtE
 RWU52kIMcDYlZAyTF+xY9teikSf+qVt72g9V4YeUYArHJpwUvTmUiDfpt61rpz3M3h+TvE+LE
 2jYQ04upWv4Ol7j61QDm9ENG3Ged0AuC6XCSqD5363JsUxhD0lGc9Cungm6NTdeviNdeYIIoY
 5/PspdKN9sWr8EDM0Aehj8iKar/YkdYVxugygLjKI590xQ+bx1cWJ9PUTsf+3L4cLKUhJrqFD
 uJm8F+cH/qOQ8o1UxSBvkz2VOesv3teTZRfAQ+OYA7oZ2iS8EnKTDRuSWvmbTaZDV1NWBW7Sd
 C265NQuDYVxAnwZ6UOUXilxrDkp08x6zSP5cD2vXc2cwN5mnKydr0sXrYEhCGbAwpmoRsChtV
 XnyPwgtHF95VGTVFbct750xYR+lF3UO9WpgV/1JR2v19bd5Zbo4Szk7cNZqeIFPG3p07XvPFB
 PC3urzHdjovar+8ub8BrGdORgc42lDg2GmzycJe5IuvMu7DqNgAGygSywuFstvsArPUfPp1Z2
 8mtMXzIULcltGINrzPHLRTjExNA5f0Tykz4XJD2C9dYLYQUKPlz7p6RWm/iupJ2nRl26L0Vad
 5TJeqr9P9xf3OAVxu/RtfYopspQt848wuF0jX8OE5wfSANrZE+4PzG4Zh1j3ChNFF8wJrg29h
 qBm/vKtuhljNnPupvJvkHjZJOD+4iAEvGDyQGbUDCHsBaKnuomQEP/9OOiYT1QCMn1y9S/tZy
 DUi9tl5mRZw8liaUJ+APENigUkJ7m6uGbwwZ6pmwzfyyc+UaOHFt54b1jul6XwkiLNHprb1xF
 5ME3VL4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-195662968-1496244443=:3610
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 30 May 2017, Jeff King wrote:

> On Tue, May 30, 2017 at 08:45:53PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>=20
> > On Tue, May 30, 2017 at 7:17 AM, Jeff King <peff@peff.net> wrote:
> > > The "git version" command didn't traditionally accept any
> > > options, and in fact ignores any you give it. When we added
> > > simple option parsing for "--build-options" in 6b9c38e14, we
> > > didn't improve this; we just loop over the arguments and
> > > pick out the one we recognize.
> > >
> > > Instead, let's move to a real parsing loop, complain about
> > > nonsense options, and recognize conventions like "-h".
> > >
> > > Signed-off-by: Jeff King <peff@peff.net>
> > > ---
> > > I assume nobody was running "git version --foobar" and expecting it t=
o
> > > work. I guess we could also complain about "git version foobar" (no
> > > dashes), but this patch doesn't. Mainly I wanted the auto-generated
> > > options list.
> >=20
> > Looks good to me. I started hacking this up the other day, but then
> > thought "wait a minute, isn't this just a test helper?" and wrote this
> > which I've rebased on top of your change.
> >=20
> > I may be missing something here but isn't this a much straightforward
> > way to accomplish this, or is this used by some external program
> > outside of git.git that's going to rely on --build-options output?
>=20
> My intent in putting it into the actual git binary was that it could
> also be useful for collecting build-time knobs from users (who may be
> using a binary package). Like:
>=20
>   http://public-inbox.org/git/20160712035719.GA30281@sigill.intra.peff.ne=
t/
>=20
> We haven't filled in that NEEDSWORK yet, but I'd rather see us go in
> that direction than remove the option entirely.

FWIW it also helped Git for Windows.

The two additional bits we added to the build options (the commit from
which Git was built and the architecture) did not hurt one bit, either.

In other words, it would make my life a lot harder if --build-options were
moved to a test helper that does not ship with the end product.

Ciao,
Dscho
--8323329-195662968-1496244443=:3610--
