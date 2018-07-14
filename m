Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454391F915
	for <e@80x24.org>; Sat, 14 Jul 2018 18:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeGNSq1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 14:46:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58056 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726960AbeGNSq1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Jul 2018 14:46:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ECA2D6047B;
        Sat, 14 Jul 2018 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531592792;
        bh=0HdoDoXWTi/LmVLhAG4GQ2DCBb1WzIH1zfnNeUjszNU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=l9lDHLpC78Pj19DCFqoTLCkVPe0KuFbYxi4ydExkvFj6PeXR3BquTfgYHEgdMtgFF
         pa9FgqqLIqom4ETwNMUzxEnXGuvq2RWLgNN9OTZ2i+cy4OewXfY80SmjkngLw1RF0m
         iLhiqaFXgBw55ckhQmeq5T/4arKG4dkF/EcqoCkK/HZsKhqRPvL8JLk/3bmzBkMm5g
         Pog096tBxrGZYtrjpiEO5/f4G0ZtxFYvIh18yHMkgkpuaHL2/pcB4VlVAtbgSgkja8
         RHI2mkynAsRG64INCBlbq+mP9klEkwPLE83A9CLU5Ns8J9QU8XXAMmi9t61EO1E9t7
         0G6KJ91pUQX5HU5fQAfxvXqhoCBTwf/p0xEdlNrepIqQxKmbvb+x9Zt6uVzjfg1d9p
         rQj5hI/RkSk6gTBp3D2GKenqaxIVhJAE1YLMktvAGQwLOAB2V/+Nsk0CFy1OE7BKof
         4NMB3uRlA/KpwDGK3l+FtP5enpB2sQtNgKn4DVNlJ057lq+t6ka
Date:   Sat, 14 Jul 2018 18:26:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 9/9] gpg-interface t: extend the existing GPG tests
 with GPGSM
Message-ID: <20180714182625.GF1042117@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <f97d2d79f6a46ddffcd0065239f99b084708e813.1531208187.git.henning.schild@siemens.com>
 <20180710170901.GH23624@sigill.intra.peff.net>
 <20180711123824.7e0be91a@md1pvb1c.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
Content-Disposition: inline
In-Reply-To: <20180711123824.7e0be91a@md1pvb1c.ad001.siemens.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 12:38:24PM +0200, Henning Schild wrote:
> Am Tue, 10 Jul 2018 13:09:01 -0400
> schrieb Jeff King <peff@peff.net>:
>=20
> > On Tue, Jul 10, 2018 at 10:52:31AM +0200, Henning Schild wrote:
> >=20
> > > diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> > > index a5d3b2cba..9dcb4e990 100755
> > > --- a/t/lib-gpg.sh
> > > +++ b/t/lib-gpg.sh
> > > @@ -38,7 +38,14 @@ then
> > >  			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
> > >  		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null
> > > 2>&1 \ --sign -u committer@example.com &&
> > > -		test_set_prereq GPG
> > > +		test_set_prereq GPG &&
> > > +		echo | gpgsm --homedir "${GNUPGHOME}" -o
> > > "$TEST_DIRECTORY"/lib-gpg/gpgsm.crt.user --passphrase-fd 0
> > > --pinentry-mode loopback --generate-key --batch
> > > "$TEST_DIRECTORY"/lib-gpg/gpgsm-gen-key.in && =20
> >=20
> > Is this --generate-key going to require high-quality entropy? That
> > could slow the test suite down (and maybe even stall it quite a bit
> > on servers doing automated CI).
>=20
> Yes, i also saw that getting "stuck" on one machine. But i blamed an
> experimental kernel.
>=20
> > Can we save a dummy generated key and just import it? That's what we
> > do for the regular gpg case.
>=20
> I will look into storing a binary and leaving notes how it was
> generated, just like regular gpg does. The reason i did not do that in
> the first place is that x509 certs have a validity and we introduce
> time into the picture. But i will see if i can generate epoch->infinity
> to get the host clock or just the future out of the picture.

Yeah, I agree that would be good.  If gpgsm does anything like what gpg
does, it will require the use of /dev/random, which means this will
definitely be slow on build servers and other noninteractive systems.
We have this problem at $DAYJOB when automating generation of gpg keys.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltKQFEACgkQv1NdgR9S
9otmLhAAv7JNg8A/xp6LmqCDoty0Ve0kzEAshhXC9oIEAFarP0n0kKCLUIYpmS/q
ehRNkCJ1gz6mhC0v/CZCnbUrv/xY2lMLEq1wnaRNhtWbnmvlS+HhSyZKzaxSdS1r
FMkVGCCMTnsEDJ2cJDpawX8R3h2H292oOyNfC0PaniNfevrWt7I3HvyifSLSQ3am
7dCO1X2L7aBwUjFTXyNVIzDKDC8gj8j1sQ1dVaXQ9fCktosC7uxbhIoh6xDeRe/S
ed/R5k4qW6hMORmSM1t2w7pfNGr1wZsEgkljW1+ePnfPOfWyB3BNrdX6JXq7ScKT
C6RtgvtY3cuJ0RRvprt/SMTdzFuuj9I1btanwAPYIbla7I4GBZJRqB+9zeJ5W7S/
jSzU4OXijKNJz3Hj1ZzidFYt6g3ztaoLrV3/iFnTtaZLCiyQc1m7a5JvCofpnhm8
j8h4kk100lH2tLhOCzUSU2OynZbInn9NfnuLSS6+agaHu88T07/B3Q+geeILICFF
F/nd1VDfuQH4u+BczmtTyPy0V/2xGdz/1T2PnFbpA5H0W4r2QKHypV2nzB9k0GHe
TnD/D4c5sIcB2Qh2wwZpGXtkRDhlaTYL/7TFcjCJzs34otQThyx3xzAOiRg6xqQm
CvisA7cB7BJkVoU1DP87TVg4sE9EWjq+24hYHlH9Vhn4zgS3+ps=
=BXby
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--
