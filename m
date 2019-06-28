Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57BE81F461
	for <e@80x24.org>; Fri, 28 Jun 2019 12:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfF1MvA (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 08:51:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:56477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfF1MvA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 08:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561726245;
        bh=/yLrgm6ucMSoF5gUrF/ZXt2U0EOYdYHqHN8TDHKwN18=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YqC8DOgSzEKCGpagKXX5jiRMcqj+hXXxTVCc/BpRLFHPX8JnuIaNkT9dQlGhEFrPp
         rqL+YELBmhNQHL8/i7u4wVRl4Gih4sN0QOPLOddzIX/GuKuGpRPRrsOk+aRbnbJ3j9
         y7eVWj4qvyQjokBcFKADatlhfNHoanlZ/cbvIlvo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRQq-1i8Qpd1OTE-00Tlpw; Fri, 28
 Jun 2019 14:50:45 +0200
Date:   Fri, 28 Jun 2019 14:51:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [GSoC][PATCH v7 06/10] dir-iterator: add flags parameter to
 dir_iterator_begin
In-Reply-To: <CAHd-oW6c7EoY+t-ymkcBmZM20YcGb1SWhM7XMO35Fofj-UNmYQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906281449250.44@tvgsbejvaqbjf.bet>
References: <cover.1560898723.git.matheus.bernardino@usp.br> <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br> <nycvar.QRO.7.76.6.1906261528360.44@tvgsbejvaqbjf.bet> <xmqqwoh8cjeg.fsf@gitster-ct.c.googlers.com>
 <CAHd-oW5zea9wzobAQG4FzN-KSS5BsRoM5vf_x_F83=yqGRfUQw@mail.gmail.com> <nycvar.QRO.7.76.6.1906272046180.44@tvgsbejvaqbjf.bet> <CAHd-oW6c7EoY+t-ymkcBmZM20YcGb1SWhM7XMO35Fofj-UNmYQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XnqCGMfDwaAlLE+dRqZkMSqMmF7ApC56/sjwkYnTKsWJqDVTEbC
 xzR47U7PLiFSOyYUbY4pKjk0sU4VeAc+97NqFPgXmWuZJc0FlU7ABkvkylufMjzDpRSu8/f
 DeYhtRcx7yNPehEwh3v08Wg3c7R6B44J+uQdd81rGMnu6OONCCQKrkwpZxKeIoktXErQXXc
 7upvU4nNVTk46HzHLVb4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R0mxKFpv8XQ=:cTNvuR9V/m31JPCHD+xYSS
 Q8EzvTTFKsYhwMv26oTP30d3gEYnFGZGUN5k7mw3Riwp8d1CayesSMVrc2YDwc5k+QN6HYWgH
 L2g6Wl/FShi5LuBe5DUD2CDs5KnL/8a7PLIZfKvrIWWw06RHrwV8AhCai3vi+rLTE0PEdqgA2
 9uc86zGZKNYZwXBGDwz8lblLDLZtwtBReE9xN80v0dgYBbZAT0h2rwYIZAFA8+W36HxJ6Pkfg
 QPriooz8lJJNmkRzGZQoza3ZKFcBBCA4VJRSTWoHUKuWRoTpxHcJmS5Y3qwqZaiqsEduB4u2K
 yNGMw9tDcxfks29btsES/8jpvq8cZjdkHGE6zUMb9+T6caS6QBIKqwjuLdKQ5PHW+hlcSDgun
 X2PKZM8/ZbJ7atj2IrCVmOKdJUWg4z/bPr/YR2iWko2DxJ/5e6/ojUV9KOCqP7PWe4B2muVZU
 6aLlrxC4kh9TqN13wX+qdM01gy0dk9wfGBnAMNWRUYKcHJ5La2b9Em8c+7TNZuln286OnuWlP
 csLbJiVHcFyKL10/tsCUcmeQQoP3YtGnMbWwAvcO+HknjOwjlQ2G8vzU0cJUWEP/rVUQ1cKDJ
 aOfgUkLud+tVI/wDEDTRdEgvvSJLZBgQGqtpxyZ6uJtC+tID4tXuXy4Ds1ZUTDOc6SNykHyww
 bUQ8qbRZhvlq37817TRRJRTM5Fd5HAp0fRUb59MWUIxhZEr08BInKKgFh1rDrW8gmftwFsZS7
 v2VPhgbPrGgfeGCo3upbuIpNMXiyO7b3GfkBBslrAqDizt44Zgtmmi+Pxt42maLzl9uwDmuFN
 tO/Lhg5JR99EcsBut7fq3jQiIaKu4yqJa74S8RXgPD5aNIxUEdOZubOj5XaSGzHSOPkJgs406
 yfbIiUrv21VBgsxMSiX170T/Gw7alIrDo7ZNxjhU/K4Z0aLt6zFiPwWpQZyIX9vtrSEFV/DhI
 bOKGXhrzvimJ8917laU71zLWjJp3RdOMAz19nFcNSTpmy9K1YpxsJhd2quZZ0ChVmF2gPhvsi
 9gj9eZERiM4QTuE5gXEXAEzcscb51/d4b1/eXXEeLwAnRvArX30YA2DBUNvmlNvj/6d5+BZ/A
 pgKj3NvB9BWh74xGGXnusVlIWayqof8VvTl
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Thu, 27 Jun 2019, Matheus Tavares Bernardino wrote:

> On Thu, Jun 27, 2019 at 3:47 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 27 Jun 2019, Matheus Tavares Bernardino wrote:
> >
> > > On Wed, Jun 26, 2019 at 3:04 PM Junio C Hamano <gitster@pobox.com> w=
rote:
> > > >
> > > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > >
> > > > > On Tue, 18 Jun 2019, Matheus Tavares wrote:
> > > > >
> > > > >>[...]
> > > > >> +/*
> > > > >> + * Look for a recursive symlink at iter->base.path pointing to=
 any directory on
> > > > >> + * the previous stack levels. If it is found, return 1. If not=
, return 0.
> > > > >> + */
> > > > >> +static int find_recursive_symlinks(struct dir_iterator_int *it=
er)
> > > > >> +{
> > > > >> +    int i;
> > > > >> +
> > > > >> +    if (!(iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS) ||
> > > > >> +        !S_ISDIR(iter->base.st.st_mode))
> > > > >> +            return 0;
> > > > >>
> > > > >> +    for (i =3D 0; i < iter->levels_nr; ++i)
> > > > >> +            if (iter->base.st.st_ino =3D=3D iter->levels[i].in=
o)
> > > > >
> > > > > This does not work on Windows. [[ Windows port does not have
> > > > > usable st_ino field ]]]
> > > >
> > > > And if you cross mountpoint, st_ino alone does not guarantee
> > > > uniqueness; you'd need to combine it with st_dev, I would think,
> > > > even on POSIX systems.
> > >
> > > Ok, thanks for letting me know. I'm trying to think of another
> > > approach to test for recursive symlinks that does not rely on inode:
> > > Given any symlink, we could get its real_path() and compare it with
> > > the path of the directory current being iterated. If the first is a
> > > prefix of the second, than we mark it as a recursive symlink.
> > >
> > > What do you think of this idea?
> >
> > I think this would be pretty expensive. Too expensive.
>
> Hmm, yes unfortunately :(
>
> > A better method might be to rely on st_ino/st_dev when we can, and jus=
t
> > not bother looking for recursive symlinks when we cannot,
>
> What if we fallback on the path prefix strategy when st_ino is not
> available? I mean, if we don't look for recursive symlinks, they would
> be iterated over and over until we get an ELOOP error. So I think
> using real_path() should be less expensive in this case. (But just as
> a fallback to st_ino, off course)
>
> > like I did in
> > https://github.com/git-for-windows/git/commit/979b00ccf44ec31cff4686e2=
4adf27474923c33a
>
> Nice! At dir-iterator.h the documentation says that recursive symlinks
> will be ignored. If we don't implement any fallback, should we add
> that this is not available on Windows, perhaps?

I do not really care, unless it breaks things on Windows that were not
broken before.

You might also want to guard this behind `USE_STDEV` as Duy suggested (and
maybe use the opportunity to correct that constant to `USE_ST_DEV`; I
looked for it and did not find it because of that naming mistake).

Ciao,
Dscho
