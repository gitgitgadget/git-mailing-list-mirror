Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0FB01FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 08:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbcIDICm (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 04:02:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:60543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbcIDICj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 04:02:39 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LsgvV-1avopQ48SX-012H1J; Sun, 04 Sep 2016 09:55:42
 +0200
Date:   Sun, 4 Sep 2016 09:55:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed
 tests
In-Reply-To: <vpq8tva1cou.fsf@anie.imag.fr>
Message-ID: <alpine.DEB.2.20.1609040952110.129229@virtualbox>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de> <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de> <CACBZZX6iEmbb68tzRKNAryp5qmt=iU9FMuOe2ONV=2ojcazoEg@mail.gmail.com>
 <20160830205151.k6ufhfzl6gh4uuog@sigill.intra.peff.net> <CACBZZX4NyjkK0Nf1JVGFRhc0xnLYg2YX6ctO5OxK3Pi60r5KaA@mail.gmail.com> <alpine.DEB.2.20.1608311227150.129229@virtualbox> <CACBZZX6exynt_9_wVtEN19HQt_rPJdo5Ck3jujdQ-hLdMAGdmg@mail.gmail.com>
 <alpine.DEB.2.20.1608311702440.129229@virtualbox> <CACBZZX56fjJZydnBrWUYtU6V3xyQyaLL4MYzVVF0yD4dRdducw@mail.gmail.com> <alpine.DEB.2.20.1609021406340.129229@virtualbox> <vpq8tva1cou.fsf@anie.imag.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-330533137-1472975742=:129229"
X-Provags-ID: V03:K0:qAOo6/mIz50YNbCTD/CO8qJpPqY4yyjkrfakMRLmljISZwSlm2/
 OzklVV36iQjMCHvvBpxh5S9AZv05XxYUtlFNU1LdqsfZfJGxgjgYaa7VaJjQFq3WwZxjlL0
 rFOOJcNRwF3axcRe7tsqIRXJrLr0/oOWp+8XXFN6Yw+q8HrhcqgK8BOQMOvkJV6fc9qA/XW
 AVSaUjtxX3x4rbcLj9z8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cZDVeTimvRg=:DFEBwnZ1rc5GKimty1jzsF
 /KkuHX0jLpuf6+/Z/hWfjhqww/jEWnUErJOu0Ii/Hq0/dOx1hmowMt1EaW1VypkfrdUHm6otg
 VqPhTfeu0pA+XJ4NYUy04sv0hfKMXIM/llY4FCGghHBVKp+gFwd6lz6M6zBql+hCZuGThJo7j
 OuTZpWMPuLpAPogxiUAdwyrxYFISEy8ypYYuqIQx9AamA8AoDwRafF4wyD35HP1iFPEW5+XIg
 Pbimb3EQSFvrNaDpz6boZnodKvH40tZEpZodAbwtJwYRxqKnDh1l7NrxuGzAQg/eob01cbL9B
 8N8P2C0ss42O6/7UySH5BBYMiSQ4+D2ULs4cJ0hX7y47ggic4pqt/GvN5tMld9ytudYAAOmUH
 WPBu1vbM1eMGF+65YXob25AXVjBtpke/jGqMHqk41ijzgQT8HTxN7vx6++RLNguYg3LaJqFNu
 sGUEEg/tyRHG9kAYMxjW/D2/GeK63l/Hgvvvf8fnt4iUIR5bdLxXWvWk+NfQcOYifEG0YcVr0
 v4RHklNs/rZOECUfdKU0XkyCqJiolkPvH8m/il47NV+yHi9jwSqhOJbH8H+/AQB40JCyYXObU
 2jmLozh0fSbM/ichnguIksVC4v9/uBsioYI1V4WqJLaJuIT4y0OiTlslbX1tQagzyQIGfKQP+
 4kgcPS0UAMz/LMTzHg3z8YS7daERqe7a4JqWuRIdpANN4sp0E3506Cv/4Vu/1u2IosDSpNYtz
 NBiwtKPy2sGSUYCtHUzx1hOvqx1i72T3c+yrDfrbl02+sNoQ1fMZvLUfprUodq7Ukfpc0qXKv
 9gV7Ru3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-330533137-1472975742=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 2 Sep 2016, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > Hi =C3=86var,
> >
> > On Fri, 2 Sep 2016, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> On Wed, Aug 31, 2016 at 5:05 PM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >>
> >> > The biggest problem with Strawberry Perl is that it is virtually
> >> > impossible to build the Subversion-Perl bindings using the Git for
> >> > Windows SDK when using Strawberry Perl.
> >> >
> >> > Which pretty much precludes it from being used in Git for Windows.
> >> >
> >> > And then there are the path issues... Git's Perl scripts are pretty
> >> > certain that they live in a POSIX-y environment. Which MSYS2 Perl
> >> > provides. Strawberry Perl not.
> >>=20
> >> This might be me missing the point, and I'm really just trying to be
> >> helpful here and make "prove" work for you because it's awesome, but
> >> as far as just you running this for development purposes does any of
> >> this SVN stuff matter? I.e. you can build Git itself not with
> >> Strawberry, but just use Strawberry to get a working copy of "prove".
> >
> > Yes, the SVN stuff matters, because of the many t9*svn* tests (which, B=
TW
> > take a substantial time to run). So if I run the test suite, I better d=
o
> > it with a perl.exe in the PATH that can run the SVN tests. Otherwise I
> > might just as well not bother with running the entire test suite...
>=20
> Maybe something like
>=20
> \path\to\strawberry-perl\perl.exe \path\to\prove ...
>=20
> without changing the PATH would work. I wouldn't call that convenient
> though.

Wouldn't Perl-specific environment variables set by Strawberry Perl (such
as PERL_PATH bleed through to the spawned child processes?

We're dancing around the issue, really. Rather than piling workaround on
workaround with no end in sight, I think it is time to admit that using
prove(1) on Windows is just not a good solution for the problem to re-run
failed tests.

Ciao,
Johannes
--8323329-330533137-1472975742=:129229--
