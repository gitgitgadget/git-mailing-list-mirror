Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A420C433FE
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 15:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhKXPNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhKXPNs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 10:13:48 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC68C061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 07:10:38 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2600:1700:f991:38c0::485])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9223F5B462;
        Wed, 24 Nov 2021 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637766637;
        bh=P22pGueTMd7fZq5eGyNfp6Ug3MrSYO0hfM2BsBbJTWM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=UZTKLsjq3DsvrEpbfPoOh3EOiCyjeA5g+j8JMEg6KqNDc1PM4KBYfyzeCuRcVOgop
         mizag2CSNVvrf8dRJRwaXBnsdiIB9Is6TtUxIq5FSRq6v0MTL/004LgJE0nLrQoItT
         xNH6L8CYVRDMlnV9pRPAfybdht9tRaKssllULyufWy0GS5L+Dy88DifPWaxn4yIWB4
         WF7ak6+pZEHDoR3UhAfVjsTxXS9uhhq9dF09dHjKYW/HXzxBxaOqZxTxDFpdOVaU47
         DlEvaVnukRMUSDB4guSZilBkauKrIb3Ptbc0b/ozAkjLBBz9G1PIHEH6p3HhgZZA7d
         IEx+S9egyOHWzR1kCC+YzGalRr1jtMSaPcCILhTipC159lzwZOAtHr0myPRhfBtl7y
         RRndzrECg3e9AkJwkTQ+cUzi6wUOXJ7SLkRe0rQuYUUO3N9Q24u8O46Qya9biYDoEQ
         PHbtvxJtG+72xLmQFBMp94EoRgFaXTva9PNewe+Rw2bEodYAbeV
Date:   Wed, 24 Nov 2021 15:10:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99 supporty
Message-ID: <YZ5V1I7Mj5dx/pMt@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
References: <xmqqk0h7423v.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2111221242320.63@tvgsbejvaqbjf.bet>
 <xmqq1r38hzi9.fsf@gitster.g>
 <CAPUEspibE6AMyoxwJGno9R=21JU5MpFVGBxCQYBCbCBwx-y25A@mail.gmail.com>
 <xmqq8rxgf254.fsf@gitster.g>
 <xmqqv90jewwa.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2111222300580.63@tvgsbejvaqbjf.bet>
 <xmqqwnkzdepm.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2111231331530.63@tvgsbejvaqbjf.bet>
 <xmqq8rxe8w49.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b0D0j5fr9aggf023"
Content-Disposition: inline
In-Reply-To: <xmqq8rxe8w49.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--b0D0j5fr9aggf023
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-23 at 20:17:42, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > I thought we were only dropping the `--std=3Dgnu99` part, not the chang=
e to
> > the `git-compat-util.h` header file, nor the patch to the CMake
> > configuration for MS Visual C.
>=20
> Ah, yes, I think these parts need to be kept.  I am just dropping
> the latest iteration with -std=3Dgnu99 from consideration to merge
> down to 'next' and below.

I'll try to get a v3 out relatively soon with those changes.  Due to
visiting family in the U.S., I've been a bit busy with things, but I
should have some time coming up to do a v3.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--b0D0j5fr9aggf023
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZ5V0wAKCRB8DEliiIei
gemrAP4yiSCu3AC8+Yjo49Q27oq5hI5usNkFKapMtv+jKojIPQEAwqx2bMRxpYS7
cl0LdVvRviqR1H8Ht8EJuA5aMSNI3AA=
=3x35
-----END PGP SIGNATURE-----

--b0D0j5fr9aggf023--
