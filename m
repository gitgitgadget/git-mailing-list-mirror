Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9B7C32771
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 02:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A96D2253D
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 02:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iwedctEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgAUCxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 21:53:19 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43372 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726890AbgAUCxT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Jan 2020 21:53:19 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1A97660735;
        Tue, 21 Jan 2020 02:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579575197;
        bh=W0xgT52ekx5FZ2rkVuN6w1aVlmHBT4mzIAj06ErPRAM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iwedctEzqKf6GtMfYxlq1xAQRe5xUprvctl8bP/0d/vYpKJ32xlQnQJXRsOm98xqE
         O1Xcl59yna+hU87hd3UNx+NXi5/XU9I6n/YOEjGC+gCk3P6MpiEaxBScxrrP38jdus
         va4cMWXM45xioDTOyBhnJ3/MwlXZ2CaqBMUxbeq8B/KPZPW6DjjwXphDrMhk7ILaXQ
         wj5x0o2zUx/Mfr2FthirBfpNLSOV4KFD6cpiajzXP3S8uqOJcju+JcSOg9zUorI9Hw
         cdGxCRcaTB94F0uCRcHh573NzoQJdnPqgnQID03/oQYLj2nzyfvwDtamP6Mdj9Gz97
         4QVRLaufkn4Us4tM8lfU/XYb5WZj9twx2ahQuQnrXzdO4Ly6Pa0G67VX/q8w8qUufP
         U1sNcT6JNXrjhMKdo/g+X4WsU+6HK48q6ftjlsJ1COfRfd/TGIxgwOoJA6MIF8unTW
         3aM35BE3xLfwqb9fVe/GJlU0ERw8ce7o0Gj8R2NAKMOE6Ek2Yqt
Date:   Tue, 21 Jan 2020 02:53:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Christoph Groth <christoph@grothesque.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Stat cache in .git/index hinders syncing of repositories
Message-ID: <20200121025311.GA4113372@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christoph Groth <christoph@grothesque.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <87v9p9skjz.fsf@drac>
 <xmqq7e1od41x.fsf@gitster-ct.c.googlers.com>
 <87pnfgshxu.fsf@drac>
 <20200118194204.GC6570@camp.crustytoothpaste.net>
 <87d0bgs9o4.fsf@drac>
 <nycvar.QRO.7.76.6.2001201248480.46@tvgsbejvaqbjf.bet>
 <87ftg9n0r1.fsf@drac>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <87ftg9n0r1.fsf@drac>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-20 at 23:53:22, Christoph Groth wrote:
> Johannes Schindelin wrote:
> >
> > On Sat, 18 Jan 2020, Christoph Groth wrote:
> >
> > > OK, I see.  But please consider (one day) to split up the index file
> > > to separate the local stat cache from the globally valid data.
> >
> > I am sure that this has been considered even before Git was publicly
> > announced,
>=20
> I would be very interested to hear the rationale for keeping the
> information about what is staged and the stat cache together in the same
> file.  I, or someone else, might actually work on a patch one day, but
> before starting, it would be good to understand the reasoning behind the
> current design.
>=20
> > and I would wager a guess that it was determined that it would be
> > better to keep all of Git's private data in one place.
>=20
> My point is that it=E2=80=99s not just private data: When I excluded .git=
/index
> from synchronization, staging files for a commit was no longer
> synchronized.

To try to answer this question, Git stores all of its state about the
working tree in the index.  Bare repositories don't typically have an
index because they don't have a working tree.  Whether that state is
staged contents or stat information, all of it is in one file.

Storing all of this data in one file means that only one file need be
mapped into memory and rewritten.  Git writes to the index by atomically
creating a lock file along side of it and writing the new contents into
it, and then doing an atomic replace.  This approach wouldn't be
possible with multiple files, and any update to it wouldn't be atomic.

There is support for a split index mode which means that the main index
need not be rewritten as often, which is helpful when making small
updates to large trees, where the cost of rewriting the index is
significant.  I don't know how locking is handled there[0], but I assume
that it is, because the people who implemented and reviewed it are
capable and thoughtful.

However, having said that, nobody has provided a compelling case for
using multiple files for storing different types of working tree state.
The existing options are available for cases like yours and others', and
they work.  Since there are clear benefits to the current model,
including simplicity and robustness, and few downsides, nobody has
decided to change it.

I should add that even if, for some reason, we did add support for
splitting this data out, I'm not sure if we'd support syncing only part
of the repository state and blowing away other state.  We don't really
support that now (other than through tools like fetch and clone) and I
don't think we'd want to encourage that behavior in the future.

[0] And I have not had the interest to look at this present moment.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4mZ5cACgkQv1NdgR9S
9ovMeQ//c06QriZZ9OzSKTwDG/jgs8ChSTXutBlT6NHLEVUNDkyFg9O1O9ZaBCGr
AKzQPh/Umc3iJzjL/eqnznOFBpBNodYB4KZ6KCiccp4UdqSdcKufwJoNDywoZBT+
NfVlBIe+tvecrFwMdi5E9x3G4GxvF3H1etDiiPbj/LdHF51kCqOrI68WlI8c+hZ7
E8uv0beY1ASb8gfnt3rwfGfy39BxA7dBlRjM6Yr+7g9M+vvvwa380wiphXGK4J22
5mJGGBV2J5N18a/ZQLyDe/ITQAC8xXKiy6pUwJD4e/D7ANlGT7M/oLkpJK/hhnJ8
XhErqIkDiCO6Oo7l+n4idVkbMdrUbQdb7sL4TKICSR+OcNN5CMEXmOsbxkqNQiAr
Lg0MRTB5RjX9gyFFeWcmEKb8XMXDX4PZwZSiPQPjamOOKUfm+yYoeeUtxbElIZJS
NZZB2U31KsGUQGi15PWSA3hGftiBNH683S9NXiiJnUf1qG+3UrQzlA9g+lgYC1Gn
HCLkPkUmKScmJxLI70IHgFpRw9ocA2Gone5faMUT7JIK+NnOeLNQsyM6v7Q1mUzW
vmUQEtk+80W36I3TmPTVdUk2BWHjcZCNp1t81KJhwjemolEtgYCpiHBGfrC22H+L
vuD4n5OKBkoNULcpDBc7s4be2RQKXjyP0pqmTFnto3rreSlFbL4=
=wi0h
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
