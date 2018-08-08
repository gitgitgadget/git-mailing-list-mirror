Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8894C1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 23:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbeHIBe1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 21:34:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45638 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727530AbeHIBe1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2018 21:34:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1154:872:78d7:2211])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CF97460745;
        Wed,  8 Aug 2018 23:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1533769952;
        bh=O+RgD4GrDm1/DMpKqwAatbfIH8oFTME3MpJ8r3iHBd4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=1FZtqBAH6U0ZvqcoAQ9mlbgV3RK7KmICnAX4t9NSnZIrMrUejuW4X40yC93c/DtjQ
         QaGMhwiyzMh83j9MuJNOMo+XegdaZTqCnmF5d4bGKjb9/Vc2+x/UBMW4H2kA1cp8d4
         gTF1c6KdOvTWQz5mSi4ge0+sw4wfrt8eyybIRmo/cTHgrsf0Nryc9PYtVunuGpyK7F
         yeKQ23J5wqrL0RnoZzaMd4CbEOWElfBbVXKSDk+HzilZlpq+qBP1Vm0hWthdSW0sh+
         SEUxGkCRokPTpsr1m6gz0vXaiSUdOywxH1TO3XQ2GzZGG6hgfhnShC2umIUdiHwIrZ
         ks2lmifOdgqNyWV6q+l92FQFHxdcF/H0nWTq9BM5vU3Tg54PbZi+Xuet4kIfhJ3Wah
         LeumF2/DSbdYe1JHi2DB0nwNmgSsScyZG7AY9tdiB+UJkc4Lc5GYOyhf02E9lZyKuU
         /UcrveEnfrtxxc/lwHCcwD5Dy28ZqMm1HRS2E9q/dgWSQQSo84Z
Date:   Wed, 8 Aug 2018 23:12:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>,
        Santiago Torres <santiago@nyu.edu>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully
 when signature is not trusted
Message-ID: <20180808231226.GA34639@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>,
        Santiago Torres <santiago@nyu.edu>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
References: <09f9803c-3f4b-a97c-2c59-e9d6b924892f@nic.cz>
 <20180801001942.GC45452@genre.crustytoothpaste.net>
 <20180801002546.du52zkxjupzcw2p6@LykOS.localdomain>
 <20180803133630.32oxubwttealvhxk@work-pc>
 <20180803154343.z3lgkudleood6lhs@LykOS.localdomain>
 <20180803160634.GA19944@sigill.intra.peff.net>
 <20180804084346.fhte5wusbfb5baem@cynerd-laptop>
 <20180808230456.GA21882@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20180808230456.GA21882@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2018 at 07:04:56PM -0400, Jeff King wrote:
> On Sat, Aug 04, 2018 at 10:43:46AM +0200, Karel Ko=C4=8D=C3=AD wrote:
> > I have a solution for my problem (calling git verify-* twice and grep).=
 That is
> > not the point of this email nor this contribution. The point is that al=
though
> > GPG's behavior of exiting with 0 code when trust level is unknown is un=
expected
> > but in the end understandable, git's behavior of exiting with 0 code ev=
en if key
> > is explicitly untrusted is just counterintuitive. I think that few peop=
le are
> > still going to get nasty surprise when I consider that this change was =
introduced
> > mid 2014 just after v2.4.0 and Ubuntu 14.04 lts (running even on part o=
f our
> > infrastructure) still contains version 1.9.1 and in that release it was
> > acknowledging GPG exit code.
>=20
> FWIW, I'm on board with returning non-zero in any case where gpg would.

I think that's probably the best solution overall.  There's a bug report
in Debian (https://bugs.debian.org/895048) that requests that behavior
instead of the status quo, and also it's the behavior that's documented:

       gpg.program
           Use this custom program instead of "gpg" found on $PATH when
           making or verifying a PGP signature. The program must support
           the same command-line interface as GPG, namely, to verify a
           detached signature, "gpg --verify $file - <$signature" is
           run, and the program is expected to signal a good signature
           by exiting with code 0, and to generate an ASCII-armored
           detached signature, the standard input of "gpg -bsau $key" is
           fed with the contents to be signed, and the program is
           expected to send the result to its standard output.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltreNoACgkQv1NdgR9S
9ov9zQ/8DGsp5MshrcSujMRWWNNCduBWVve1f8RGLakWprBwUEGUjCDu763c847h
r5BxDmz/+bOLDBUd4jUsRTM1GM3nBgddDvj12wQlMrsUms/mT3H4x/DojWCJ7wU3
gifw5KOruwLGHbEKs9dUtoEH+uOwrcE892DB+NRqdfO/vpqAPnnmQAc0NexPbyeS
ORerS/td/0INN3Bu8G5fvtxlMtA+9pbU+0YuM22rYTvb7r97Rb+/XwcAVd7m3sJf
WoIYIEs6c0TVFz+KAaU7RX6tfZOr1acvQaMHzMqbkzrsXCztR3tw7j9YmUBtVA5n
n6Zss1U518XkzjtaKm6Yo6xGszKdZF+dzIYeMsB8W+365zxvKkmR6e2cSoxQo8EN
YgKrT5bv6tv83zN1gqCqAQQlz6VfVF0pQBD89dDQslbqagQ4XyDn+KoNg+spmYmK
kV8EHObWSTua1dCuqYQxxgDKOL9099GjCT7txizx1YdA1QEqlUJ6KCgVTRjN3NoA
PAv5eO5qoA4v0TxeKPUfbRfKdLcp3nYMOtHCe8uTsy1Lo0ZZEd0r9H3sCQKZZZaQ
ZO6ba7FS5tAFXlfCM4vDhUWnhtjEAOY2VaYCw8bV8BzpS9uP/C0K1Gr1GOAotq7x
c0Dv6i/4wbVl9GR9TlSXDeIdcGVhYdStZUIe1s3/m8LWTR6P/HI=
=lBIK
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
