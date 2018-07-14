Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D9561F915
	for <e@80x24.org>; Sat, 14 Jul 2018 18:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbeGNSdq (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 14:33:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58024 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727580AbeGNSdq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Jul 2018 14:33:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 48CA06047B;
        Sat, 14 Jul 2018 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531592032;
        bh=OnECoGhlZeR0NBM1Gkvr9xwKOjk7EFcJaDvo/cO+xf4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RFUwsE6LwFpzmwJItxceKYLjccd4wSkmuGf3/BtT/rmrmRA+wUrINSLbS1AtHBob3
         mj7vMHgyzS1pRG1K+wBhThNfxWH/vvtrmGbxKGq5pTvJUguSRj20zygGZNPyCYxxiC
         OkUX/OMwmXC2+DeU07oox+lZ0/+BqcE6RRutRrEQ6mHLME4CQyRvjG5h9dP6XOYwuw
         keLBfw8YPSWMK6N7qFCinABPzdButRl//v1SYhTDF6hQZATuC/EyxHL33M1ja/gmef
         /9O41jpwZuMXOO1EjJbthutBt0lDkUQEm0GglUbGF5YZfEtw3Lew9fvll8l4v9w1xU
         eWz5nwIsb94Eu3Y6F6BizP9Z7OBeJCVjIX8Eb/WkcKBm2ALmfpQWh5RMG4TrU/hvkm
         VP4I9B9EYpXKaJM6BulEWVpBYtrabZV7iETqUxvCtccKPkCxxVyFLG5QPBvge8ragX
         FeIJpAR+jJZc+F0RAoJXJssUOKJMuq+v+MNST1YDLcGOtq7O2Ym
Date:   Sat, 14 Jul 2018 18:13:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 7/9] gpg-interface: introduce new config to select per
 gpg format program
Message-ID: <20180714181347.GE1042117@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <4905c1907a866c0fd1a4dac978dd6ca3e468ac43.1531208187.git.henning.schild@siemens.com>
 <20180710165412.GE23624@sigill.intra.peff.net>
 <20180710165638.GF23624@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline
In-Reply-To: <20180710165638.GF23624@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 12:56:38PM -0400, Jeff King wrote:
> On Tue, Jul 10, 2018 at 12:54:13PM -0400, Jeff King wrote:
>=20
> > Should we allow:
> >=20
> >   [gpg "OpenPGP"]
> >   program =3D whatever
> >=20
> > given that we allow:
> >=20
> >   [gpg]
> >   format =3D OpenPGP
> >=20
> > ? I think just using strcasecmp() here would be sufficient. But I wonder
> > if it is a symptom of using the wrong tool (subsections) when we don't
> > need it.
>=20
> I did just read the discussion in response to v1, where everybody told
> you the opposite. ;)
>=20
> So I guess my question/points are more for brian and Junio.

I'm okay with us forcing "openpgp".  That seems sane enough for now, and
if people scream loudly, we can loosen it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltKPVsACgkQv1NdgR9S
9osmFQ/+Lg8efIc9251Ys5yG+G0xmIx4Yh8zHtp732agXMCCySyBrUfUNJa+lemS
dR4a/Cram357wG78uAiimTRqda1QsPe9PpUwlFqtroJ/xoUEKan3YR31k95Gci0H
PYAuvs+WDXf6LP5aCWJkMSQ96HMk51FZWKSrz+35Kti22AuRDcLWtWua5J+1z+iA
DcylcD2kxIsazuYqmqeqjYgCxwSjeiuH1+OHvU9Bsi1jxnSLH/wOLnnzcc6btxeR
O7s1vdH/zqyUWpspSMjnMkcyv+f6C4XRFf7VX/Jku6zq0tEl35e5Bvlv3FW1zWjO
95nBvyScHOjSU5wtw5msLVD6qFz611NP5HbdIzLSiIdqG5LkmY+6dztTxMeRnekd
K1IXRinjBD1VOCyMia2p2AkqF1HXwVs9FiG/rA11MB460AFcMTUrDIiiAxu9c2Mn
Y5GfrifVlp4iu3A73vObBkMAC5/vwbJo3uFnm4D3O5WpzixS4bww/Y+O8DUMuWzv
/2VCBhKevD0MqOoCLF1xs2IuB4cbxxvbdGeQzpktJ2JD6g+oCyNulZTeKFViaHL+
FGVXx9FkdcnhZ55nvvXK0GZTkx57M+lF6gepdzd9Relm0XpVwFzSM1//Izpj5ig3
+PbWlGZNKeAvvP/m6twWiHhyd/qzjrE9na14JwETmYR/FmiGMnY=
=anjG
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
