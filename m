Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 330F31F597
	for <e@80x24.org>; Fri, 20 Jul 2018 22:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeGTX0d (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 19:26:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33904 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728396AbeGTX0d (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Jul 2018 19:26:33 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f1fc:eee3:60de:bdd8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DE6B760734;
        Fri, 20 Jul 2018 22:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532126173;
        bh=WGSkX3S0Ztr3ZN6WjnxTuLX4tHfRfRJvXdLGWJEAZ3A=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=puPdCSzXOyfdN5iJWyCd1QzfPZzKdHvqKY6VTqdx4cKqBlXETtlyQXFz1x3+ryo+b
         39NlUdtL9rVR1P3gBw0tbpg2qf40b34Mc7RdxeSPr0Iq0KQqVJZokJ8NYelLD6XAfb
         rEHNr/wc8vL9E21Y2g0FF3oaeP5gcYtY9+urLTlgqz4na2D3Qh2wNa/00KghOkkgjc
         XKZE/xBVOrUI+4aS8GTWgu7FIeJqpMMI/I407LhUg8amDlnT6cljEtujdS9pZ7Dnzh
         dhSUo8B2hxsl2H+4GJQyCCIsbm7ut5kt19AEDK8D+MK2/7EYjrFt8Jgz9bqA2leuHT
         SpptwlFfQSbrHhSpjMNhv1pUokDCqR6Nrqq15zR/56/3oYX/2teUe/vhGPSJAJmrp+
         kEx6HO5Bo0ts64hwL7LGPjXXkhuLqIrz0iwgarcKFdcMZjZnJDwIGDoHuj2NxfU68a
         HHPrpGZxxnDmh/T7n1ahlmEWlCDnE/KJSHjqjOu3I/Wozo7Qldy
Date:   Fri, 20 Jul 2018 22:36:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix --color option formatting
Message-ID: <20180720223608.GE18502@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Andrei Rybak <rybak.a.v@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <ccf73807-1856-1ce8-365a-0c4fb25ea7bf@gmail.com>
 <20180718174944.GB3084@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Content-Disposition: inline
In-Reply-To: <20180718174944.GB3084@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2018 at 01:49:44PM -0400, Jeff King wrote:
> On Wed, Jul 18, 2018 at 07:37:48PM +0200, Andrei Rybak wrote:
> > diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
> > index 085d177d97..901faef1bf 100644
> > --- a/Documentation/git-for-each-ref.txt
> > +++ b/Documentation/git-for-each-ref.txt
> > @@ -57,7 +57,7 @@ OPTIONS
> >  	`xx`; for example `%00` interpolates to `\0` (NUL),
> >  	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
> > =20
> > ---color[=3D<when>]:
> > +--color[=3D<when>]::
> >  	Respect any colors specified in the `--format` option. The
> >  	`<when>` field must be one of `always`, `never`, or `auto` (if
> >  	`<when>` is absent, behave as if `always` was given).
>=20
> This is obviously the right fix.
>=20
> I am guilty of not always building the documentation and eye-balling the
> output when I'm not specifically changing the formatting. I wonder if we
> could provide tooling to make that easier, by showing a diff between the
> text-formatted manpages before and after a series. I've manually hacked
> stuff up like that in the past, but there's often a lot of noise around
> date and version info in the footers.

Both AsciiDoc 8.6.10 and Asciidoctor support SOURCE_DATE_EPOCH for
reproducible builds[0], which should reduce the date noise.  We could
also add a Makefile knob to set git_version to an empty string or an
--abbrev=3D0 equivalent for such a situation.

[0] https://reproducible-builds.org/specs/source-date-epoch/
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltSY9gACgkQv1NdgR9S
9oviARAAqewyzMTfF1+nDKr8WOpaFnb37qYYHXEiQnU6102JhbIkhwoSc2kdwTCn
lALLp1J+5CwoyVf83HmdgmClobSqOhQCbM5RUp6J8rtkTIMW3uAvCw+Y02DDBWhV
hji5qLgsmseDnxl3JpCdl0ZeqLip5MUjK5peEjBKyKM3PjCQdlS3AN16IyonAWis
AdmpzT9HJeTOyn7CRoHWbGy/h2/mOp0b3qLyBgfmsWRimBufReTajHO7qWFu9MZ7
uhS7+EhUM7o61mB3UjMhNvNDQqV8HkQeNBEe/W2uCP4y7I0XQYfADIwXqLZHyG+T
englqQDRqHvMYIv1p5qjcUkpaZ5X5Yt3efI+OZqOFoMp+ChgUuXcXUeQYyMBpkfW
aH+quchpom7dA089W/+ac3cOzVOb7nkKmNE51UnIZFm/kZx6gZa1Kj7tnkx3zP0Z
RyRBtQSRNkT7HuZlhYeTuC3+xFIYj70WKMPoDQjKmndD1KBNi7bwRG8rcuRNAjWg
r8eaJ0e9JRW5uS537jzMv9R1vOirFsaAkw3BLQStEUH79Rrlzx6VWE7AMx2EtIkU
v4nxatTs7xdom3Yaz9qFDjIS3SAS38Fmtos92LJEoiGD0UhI8t0Tc7nhgZo2KZqA
5B9M7r6R3ZWgTaaazV4GhXtWbO7qW2eGAjUO9XabkCFP84cIfas=
=qdEL
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--
