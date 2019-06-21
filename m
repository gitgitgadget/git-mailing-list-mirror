Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 022ED1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 13:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfFUNQq (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 09:16:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:37231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfFUNQp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 09:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561122997;
        bh=qo7v2mT0HovWjaxpdMmhTmi2x0jsySb3GqEsaZLoAvA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TRDJz9hcLhuB2eOGAWkpLtavhg4N6iv+UGaJBZtocQ45Vvn+HE9BIh1gZzUp5+RIs
         fn7iDCN63yUy+VyrPX3thSz6BAkFuFLqGvXG2AMmN0bWqCtQpEA3a9ho06dR3OWKxC
         pIbG1hXMtNHArKcGcChsTAgRwHKjoSUklhyz7Umo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWkZL-1i7g7D3JkZ-00XxMv; Fri, 21
 Jun 2019 15:16:36 +0200
Date:   Fri, 21 Jun 2019 15:16:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
In-Reply-To: <20190619191709.GF28145@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1906211515160.44@tvgsbejvaqbjf.bet>
References: <20190619095858.30124-1-pclouds@gmail.com> <20190619191709.GF28145@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2087275535-1561123013=:44"
X-Provags-ID: V03:K1:jW9STlTN5GzpcQeatprFnZfaNkgP9pWSKv8GuvIltlMvGayK4U4
 SBkzkx6aNWkXQ+bdkNyhMBeHfSmt9fJEM08e+YMM+MuT6mbxjKEKQkb/FjO+Gm9Cpx4PZ/m
 DSqi4tyvmlSRp7EUNmbw4aMkZ33SwxNue8Et93yvNE07nZGEpODjAUZlMGpV8YzgzN5QrTh
 6xGX/p/rDBkffJn+l/7bQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nZgmEu4+eJ4=:yq13y+DJWdqj/5j6n2oRIJ
 ho8hV5UVTs5+gbODIsESXkvUDhsPfkGq3pJpZhxHhdAtSUIf1TJdKBbKCVCkermAojLHoo5RD
 mkFiY6i0vfsbQrMWWKDB/L/bCZlvQkBkbkj/5yLWqZ/tb7w530ThTSefp07fSXUyHOLA+pYFU
 qc2RSYr0lPYqiqLGvmanIXpGTpEHLROOU+b1Wj/O3vzErGGpZt6ln5dDO4SW/8NgqvsdtvJJ9
 Kv3ERgIfFSoypldaES6Yj0LmJMGxi3hhKUIGqd52jGgVhjoCfHKKRkgnYY11M0d9ifG0kEFOd
 cO7a1XqqaXVlgqyv4r5h80quh8CkbiFzGkkI3xw5DFtJEy7bI2AGLrCkchwUfni+kHrGjBR0y
 r4ME7qQ3gFo6rg6Mnk63D2j/BhC1sa/7ESv2Yv5GKtw2LVSKD70VXqGVURbNwEaoBKj9Rrwzy
 U/adJW7GllZdKVi4St+mGRyNBV9eVCteea2r2QMLI8nbvuEYABjPrcbRkqn7i1oT5OnSBMkCf
 PscvLU5bHpfXrPw3/EFqNGUPkmhfgDb92SQ75M2B5xu5bu2njWrOPCCf23YZiv7gG4GS6ROOC
 Tay+xOQ/eO1nkEDNiAycHujhBsm1VhMVqF6ctDPZecqYs+SqgRUwd7f3bDqltjlev2xSrWLVF
 kjnkbqpZ0T26XrwhMqbDIj3hK6WyZWwrl7BxkA62aW2v7RSfGHLkxi7Au9EFecXD6lhmEauac
 9HHvnIZ7+ZSoyeYmDGuxLJHPVztIJvy5dVJJlyL+ssBkhY3JMTV5R9vK+G+IlhwsLBNv8nJgn
 P1Hm/iDAd7ReDu05ZrpJfPVNBYoxFaUdI4mAkEsfQgT/r8aneoWAQ/bfRDI4SxXi8yZH7GD/T
 VqTAWchtXUhNz5zi5XwGhh4mY0qnkq2fAagMXZF9NUYl+8VdG+IuorcOI+dmboLkkpI1NU+TB
 Rhej2c6/Kw/Jq48f+dZ+dIZoAL/wSrY3guJqQqrIK6cM6k6Brv04j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2087275535-1561123013=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Wed, 19 Jun 2019, Jeff King wrote:

> On Wed, Jun 19, 2019 at 04:58:50PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
> > This is probably just my itch. Every time I have to do something with
> > the index, I need to add a little bit code here, a little bit there to
> > get a better "view" of the index.
> >
> > This solves it for me. It allows me to see pretty much everything in t=
he
> > index (except really low detail stuff like pathname compression). It's
> > readable by human, but also easy to parse if you need to do statistics
> > and stuff. You could even do a "diff" between two indexes.
> >
> > I'm not really sure if anybody else finds this useful. Because if not,
> > I guess there's not much point trying to merge it to git.git just for =
a
> > single user. Maintaining off tree is still a pain for me, but I think
> > I can manage it.
>
> I don't have any particular use for this, but I am all in favor of tools
> that make it easier to access and analyze information kept in our
> on-disk formats (some of this is available via --debug, I think, but
> AFAIK most of the extension bits are not).
>
> And I'd rather see something like JSON than inventing yet another ad-hoc
> output format.
>
> I think your warning in the manpage that this is for debugging is fine,
> as it does not put us on the hook for maintaining the feature nor its
> format forever. We might want to call it "--debug=3Djson" or something,
> though, in case we do want real stable json support later (though of
> course we would be free to steal the option then, since we're making no
> promises).

Traditionally, we have not catered well to 3rd-party applications in Git,
and this JSON format would provide a way out of that problem.

So I would like *not* to lock the door on letting this feature stabilize
organically.

I'd be much more in favor of `--json[=3D<version>]`, with an initial versi=
on
of 0 to indicate that it really is unstable for now.

Ciao,
Dscho

--8323328-2087275535-1561123013=:44--
