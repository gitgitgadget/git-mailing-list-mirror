Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA82C20756
	for <e@80x24.org>; Sat,  7 Jan 2017 22:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755558AbdAGWIt (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 17:08:49 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38626 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755454AbdAGWIk (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2017 17:08:40 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3CA04280AC;
        Sat,  7 Jan 2017 22:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1483826918;
        bh=Ebhx9b+hMIVnVrMydIHewuWs/glniCrBjA8PELpX2DY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oIRd32yQkin1K2FZNxSUG5gH6OIBMVwu9/fNouS3kfshUReftWgTETXvFrzO8kEGw
         7KMUZ67Yf4NkVO1q3sREXjzD2oOsKNWxfxaDta6TPIsdbCDImkh6E3/PxLIXlMM4bd
         GFrVO1MxN7xv/7c58VaiHfiQVwYfGi6oijav5WGgL6er11I6WyEaGBRDxBOTZUf7qN
         OkC1A2Dv29aXoXvd4z4Z/AWNY/o+APL128zUjovw3M+W8DUh8rhgSEbhh49XjHmWpS
         Hip6rvl+dX4Yac2ufJDDZBML6lC7Sr9NA2Rm8nl4KoG8UEExL3x8c83eiM10Wo1v4n
         U1z96iqzkaxTXsAkMDzh2Z0AH8GlkQ51ACUBlCwLkgSo/eXQQRR+Y1NaERRPwyWVQs
         VSEE5zZ+oW1mq9+4JxYVoOzTmUDj3XJ6HedN11MonqgTJHcnTvgIcZ1iMQonRPGCM6
         m/1SQrdtgtxRSsGoVZdewE9uiMQQkSZD5NYr6oWEaRl9Cy9Ir7S
Date:   Sat, 7 Jan 2017 22:08:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] asciidoctor: fix user-manual to be built by
 `asciidoctor`
Message-ID: <20170107220834.uge5ksdr66asw27q@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1483373021.git.johannes.schindelin@gmx.de>
 <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de>
 <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net>
 <1D7C66EA-E87A-4154-ACAC-8045D28477D2@gmail.com>
 <20170105164556.b3bzeqqzx4pvni4z@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tga4cybpifehw6es"
Content-Disposition: inline
In-Reply-To: <20170105164556.b3bzeqqzx4pvni4z@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tga4cybpifehw6es
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2017 at 11:45:57AM -0500, Jeff King wrote:
> On Thu, Jan 05, 2017 at 11:05:29AM +0100, Lars Schneider wrote:
>=20
> > > The git-scm.com site uses asciidoctor, too, and I think I have seen s=
ome
> > > oddness with the rendering though. So in general I am in favor of mak=
ing
> > > things work under both asciidoc and asciidoctor.
> >=20
> > I am not familiar with both tools but it sounds to me as if "asciidocto=
r"
> > is kind of the "lowest common denominator". Is this true? If yes, would=
 it
> > make sense to switch TravisCI [1] to asciidocter if this change gets me=
rged?
>=20
> I don't think that's quite true.
>=20
> The two programs produce different output for certain inputs. We tend to
> see the cases where asciidoc produces the desired output and asciidoctor
> doesn't, because traditionally the documentation was written _for_
> asciidoc. So whenever asciidoctor diverges, it looks like a bug.

This is indeed the case.  Asciidoctor is a bit stricter on some inputs
because it provides significant performance improvements, but it also
has features that AsciiDoc does not.  It also has some bugs that
AsciiDoc does not (again, usually due to performance concerns).

For example, Debian's reproducible builds project would probably like it
if we had better support for Asciidoctor.

> [1] I think we've also traditionally considered asciidoc to be the
>     definitive toolchain, and people using asciidoctor are free to
>     submit patches to make things work correctly in both places. I'm not
>     opposed to changing that attitude, as it seems like asciidoctor is
>     faster and more actively maintained these days. But I suspect our
>     build chain would need some improvements. Last time I tried building
>     with AsciiDoctor it involved a lot manual tweaking of Makefile
>     variables. It sounds like Dscho is doing it regularly, though. It
>     should probably work out of the box (with something like
>     USE_ASCIIDOCTOR=3DYes) if we expect people to actually rely on it.

Yes, that would probably be beneficial.  I'll see if I can come up with
some patches based on Dscho's work.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--tga4cybpifehw6es
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlhxZuIACgkQv1NdgR9S
9ouQuBAAuPdDd4s3/kW16T1Dk+WgnMbaPAsO/J3zItB0Xom6agWR462RDUwBJDnt
sIsclb0N/gbv1s8Zwf9XQ7/NenRF9rImo6vP7YS09klGVpt9o4HgJgPkAq0O0d1y
9Uz+A35+VN6wD+CG7htcAIkcQm7YVajnurm9EuALizNl5MY6AElG84xL61uur33a
s46PPSGCfkfR0WwwbNK0ttRZj3rI7TcWxVcMlPJ0CvYS3SS9l/g/BkhsBsR989/O
NQvAA8WY/jQV3sPUxdZefPIAGxHkZtBDUpoQ9V7yzIa+tvOQrvr4LVfE/LacAb+l
RBf9MHDZGOXCxIuixRXoht7ZWUJPMFIp8CMb+s+FhxkzyIrPi7r8NupVlYr4MKwu
Tq4zRupSQtRklqLIJmewYE6RiSNvx+qE+D7e2WJJpzCgYZMbshlb6IsGwbt+tals
npzsyPJVJNmeeFrv39tzZiTg9YUGBHoI3QiIskxeus5bOevXcDQeN21mRQonGKVC
H1gGDchv8f2DQiZBrt0CE46SpuqvKucSPQzU3Lp6TQ3MnBVYpPTtIK8OlkQWN4YC
4AZmPAZ/ofyBxEwyJis1BaLG0YvPhTYgs73XaGRoyg7fY3LgT0jtOZYqJ66l3ZYj
Ta6A9grzOVtm7ue8IfN0tDPiUzbZuCcuLHc9ksi6iD09r1fvJcE=
=4zpH
-----END PGP SIGNATURE-----

--tga4cybpifehw6es--
