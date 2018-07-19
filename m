Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95BCA1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 22:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeGSXL2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 19:11:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33242 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730469AbeGSXL2 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Jul 2018 19:11:28 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:2083:6aa4:1a5:3a95])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 48F106047B;
        Thu, 19 Jul 2018 22:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532039178;
        bh=xBgm6KtaUf+FOn06rp8Eu++FlEvSKXC8gVVcJHJ0C5k=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kfJq/aO0NvPSsbJxsxBEPDWJCYkvaGdJWAfemrNSNGo6marB2413x4WNr0wZ4060H
         AJFok5tYAoZypc8TKaWLkY8uVdlQ/GKVxi1PdO4OBFDTk5WhNO186vA1CmF842VnOF
         p0U5t2DC+BMVDrsignjof4ZdhRKlaEkSjNPoaD0wM40XT2sn2EA0NfWBaGn5YOT9sg
         RTTcHXwrxEnLASG6lIbJ+ABxBESisd47osmjrO8T/XJLerxxx4ueDIY9cE29S146tT
         nq22U+UNFt+HVpDig3T5jKH0K2KTb7BiKC7vWJfW2WqF/bR1H/U/Xio0pxWXRfKV3S
         ptZpEl/jiSNPRlaNKiZfTN0DDYKUil/oJWkv/yASU2LCeS2mUuVwTUwti7+DPapN1Q
         8cM8WL8LLMes1LAF7tPBn3/LN4BrfASCpr001tF9b/cEvvbX7fsQWiItetHykBojPJ
         j15Yhdl+jPi78RC4+jepKBAl8XVl9rLy/tyGUHUihh7sZYERA7s
Date:   Thu, 19 Jul 2018 22:26:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org, paul@mad-scientist.net, dnj@google.com
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
Message-ID: <20180719222613.GA7066@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org, paul@mad-scientist.net, dnj@google.com
References: <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
 <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
 <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet>
 <20180709195822.GA9000@sigill.intra.peff.net>
 <20180710035635.GA13459@sigill.intra.peff.net>
 <5b445ca6.TkV9Dj8T2KFinxZP%perryh@pluto.rain.com>
 <20180710140310.GA9246@sigill.intra.peff.net>
 <20180714205132.GH1042117@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1807181418120.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1807181418120.71@tvgsbejvaqbjf.bet>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2018 at 02:18:44PM +0200, Johannes Schindelin wrote:
> On Sat, 14 Jul 2018, brian m. carlson wrote:
> > I will say that at cPanel, we have a configuration where end users can
> > end up inside a mount namespace without /proc (depending on the
> > preferences of the administrator).  However, it's easy enough for us to
> > simply build without RUNTIME_PREFIX if necessary.
> >=20
> > If we turn it on by default, it would be nice if we documented (maybe in
> > the Makefile) that it requires /proc on Linux for the benefit of other
> > people who might be in a similar situation.
>=20
> Is there *really* no other way on Linux to figure out the absolute path of
> the current executable than to open a pseudo file in the `/proc` file
> system?

Nope, not that I'm aware of.  You have to read the destination of
the /proc/PID/exe symlink.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltREAUACgkQv1NdgR9S
9osHtA/6AhuPz6Bph2MuHQOAOK0Ds1tOFeu8tYWcnCywDLl7SUlw+4b0lIsY5BPr
HasuyE/Y/ILvKEC/DrDkeyeArqu5su+77ee80wKki0qtorZNA4BUAdzJEW9DYtbG
yHjFAVCcwp1Is1v/nIiwOKJJIrSNUHSu1Nw3sgG5Cj9RWDdXKFkj+JGVgq1KfFkK
hGircK2BGkiBD4fxYHrpSiE2ymg+vZI1l9m+7j+IUPaaHJqs+JOP7WOLk3LjlxbH
O1RZ6RscwylsfsVZAqaBbQsJgEJ8u8XZJGWCECkThjtDuV7irQZuGS94ic9IU5YJ
/wM+2ceuf2R9ynm83mCohxufnASe2xuVZCmRlWW0roeQc7UOQrRQv9xsIn2KNfOr
j2+Bk36wXBTxrveI+2lUNXzGmcpQ5MlGJpT4A5bHES9d0SndG7s1LfBT8WaOQVA2
j4K+Rj3Huys1IZ3DCEYOs3sNsG+rVnsMwEe0rYV0nU4BZaC6arorWaeOop2kkEyg
bd2wmBU4mlaM7kQsdDa57RNmeEBO1rs+FxV1NOzbEeAl2gFkHp9Llyfo2ha+8Ixv
U3k2TuK1DaUdcH7bIiHehsjCCOVkla9+zETu6VNIWpMGBiZsrPmsnkwCBMUXUrol
iRO854xTDI9YbxsycTepE2u2Ssg6BYKoCWia6/7a0mCcs61Gxi8=
=fbVO
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
