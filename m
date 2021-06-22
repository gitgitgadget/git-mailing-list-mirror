Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9E0C4743C
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F15360230
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFVALh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:11:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54268 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229747AbhFVALg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 21 Jun 2021 20:11:36 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1778560459;
        Tue, 22 Jun 2021 00:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1624320561;
        bh=l25qFTBbtPScS+5vwa7mrb0tf2z00YdHSwg8d24Ul3E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tmADd4K2lgUIUfODcG5UTUuyc44ib+J4aNOnqCgdX8CK9xM/CSsjCZM/xz8AOZP8L
         CTt37VOkok/Efo6UIHzb3W2IHtpRMD5G6NAnUGv0r/NYCvVonYN9CpdyJjnSFliXgB
         JxpV8uXGiT3aRbXpx/ssYoxHHOoB3Livzu26l1gZvxDliWOPWUgLZ2yIjDrI/4JXiA
         3XzuAePB2ANEIb79tUqgUQOjIfSahMnG7+qQZ7SLm4dmCBomE6NamZf9S/+q6AZrxy
         V7k7bbUeP945nEZfihs2G2m35Ah5ohg1+eH8RySFsnSnQO+NoEVEO7zyieRIEbeeb+
         BSsVterGUuzDkI5xJBopkfZAWmlC941exUhMdVyajIOpEtV75rMjxDp3vqwRF8qaeM
         MwW1W1NPyZRj4PuGnTCoIDDBpo85U0aHUWcLxR6h+VXd8T1i6mHiHL9ebJk/P4W/Sp
         Xhwp8glJSkTtjGulSCFQz2Em07I9GUSnesKJOQmJ6QpYjScz4PH
Date:   Tue, 22 Jun 2021 00:09:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Roland Hieber <rhi@pengutronix.de>,
        Git List <git@vger.kernel.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: allow to run from subdirectories
Message-ID: <YNEqLV9N88eKLdfo@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Roland Hieber <rhi@pengutronix.de>, Git List <git@vger.kernel.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>
References: <20210620213836.10771-1-rhi@pengutronix.de>
 <877dio3vg5.fsf@evledraar.gmail.com>
 <YM/yqPsRutV2mUbb@camp.crustytoothpaste.net>
 <CAPig+cQa3JC-YkGeB-NDy-iP=Mv8BRL6jyXTGXzaqpTLcxj8+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0d8RCrzQAAZvsenh"
Content-Disposition: inline
In-Reply-To: <CAPig+cQa3JC-YkGeB-NDy-iP=Mv8BRL6jyXTGXzaqpTLcxj8+w@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0d8RCrzQAAZvsenh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-21 at 02:10:10, Eric Sunshine wrote:
> On Sun, Jun 20, 2021 at 10:00 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On 2021-06-21 at 00:35:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > > On Sun, Jun 20 2021, Roland Hieber wrote:
> > > > Currently, calling 'git bisect' from a directory other than the top
> > > > level of a repository only comes up with an error message:
> > > >
> > > >     You need to run this command from the toplevel of the working t=
ree.
> > >
> > > How does this affect out-of-tree scripts that will be run with "git
> > > bisect run", is the cwd set to the root as they now might expect git =
to
> > > check, or whatever subdirectory you ran the "run" from?
> >
> > As for the idea itself, I think it's a good one assuming everything
> > continues to work.  It will certainly be more convenient for a lot of
> > people.
>=20
> There have been multiple patches sent to the project over the years
> with the same purpose. One problem, I believe, which has never been
> fully addressed is what happens when the subdirectory from which
> git-bisect is run gets deleted as part of the bisection.

And that's the thing I was missing.  This did seem a little too simple.

I think there are certainly cases where we know the directory isn't
changing; most of the situations in which I've bisected things in Git,
for example.  But we will, of course, need to specify the behavior when
that's not the case, and as Junio said, it probably will just fail in
unexpected ways, and that wouldn't be a helpful user experience.  At the
very least, we'd need to document the behavior, and ideally try to make
it work reasonably gracefully (e.g., by not removing the directory in
that case).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--0d8RCrzQAAZvsenh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYNEqLAAKCRB8DEliiIei
ge/gAP4zsM+DFMQjIdyEn0MK06ReiOkLGUThDJC+W3jpqkmuZAEAj4971PIpBHFl
lfzrUvlFoWZHvIF6gBG3Dkg+oyQGpQ8=
=fUzN
-----END PGP SIGNATURE-----

--0d8RCrzQAAZvsenh--
