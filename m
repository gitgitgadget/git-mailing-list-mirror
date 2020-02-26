Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6E6C4BA06
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 03:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BE021D7E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 03:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Gbje9nvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgBZDFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:05:51 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41544 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727880AbgBZDFv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Feb 2020 22:05:51 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 82BB660456;
        Wed, 26 Feb 2020 03:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582686349;
        bh=9DSFnUA0E8cgH0hYFnuzOZvaDY3hobMD092vMK6OSas=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Gbje9nvpqrVbz9+DJJatbabNIvZshA6DRYxDsTXhzdNwazUPc5M/Kwrsxv0iJ3xI3
         eeyw2Wb2Ei0oWSEPdK1b8lGGu9jEj5HN3PdhFi1JO2Dale7WY2V6w22sHjXW7aOIDf
         uxkKCNSO7kYv1pbnZsCIJtalEaYUBvoUnn5d+InPD8vkzSAqNRzOcsuW2xK2dg9FR1
         mXI2NaAvrBEvR4Slc/uWmKkLIHC582tbxGjFF8jfOm32m7j5R7gS6fl42B2chfrcr9
         U6E5Etl9Owzc9fiuiYzKgv99Wumx932d+IR5ylMC3+VtX6HEV1sLZ5ZzyITptRCKwC
         CDyAvjhdLf7M06iwbjSgJhu4H9kd2615TUrixGhINKsswKpKFA+WSTAr2MNMsdmUSQ
         TZ4pEVsnFFXTnGlk6BMSvdgueW0MFgF1rXyw+x5QHG7RPvzJqOyIWEa9WK29xESFtD
         0v6EZcGxsSasiG9pU8zbQKDxKV4v3ivA8PKfcnDhz/GV1BSJllX
Date:   Wed, 26 Feb 2020 03:05:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 18/24] gpg-interface: improve interface for parsing
 tags
Message-ID: <20200226030545.GD7911@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
 <20200222201749.937983-19-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2002251127320.46@tvgsbejvaqbjf.bet>
 <xmqqh7zemptx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <xmqqh7zemptx.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-25 at 19:25:46, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> >>  	/* parse signature first; we might not even have a subject line */
> >> -	*sig =3D buf + parse_signature(buf, strlen(buf));
> >> -	*siglen =3D strlen(*sig);
> >> +	parse_signature(buf, end - buf, &payload, &signature);
> >> +	*sig =3D strbuf_detach(&signature, siglen);
> >
> > While I like the spirit of this patch, it makes the Windows build fail.=
 I
> > put this on top of Git for Windows' `shears/pu` branch to fix it (maybe
> > you could adopt a variation of it?):
>=20
> FWIW, it's of course not just Windows, but on anything whose size_t
> !=3D ulong, e.g. https://travis-ci.org/git/git/jobs/654661788 (Linux32)

I will likely not get to a reroll before Thursday at the earliest due to
other commitments, so if it's more convenient for you to eject this from
pu and just pick up v3 when I get around to it, please feel free.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXlXgiAAKCRB8DEliiIei
ge6eAP9SWphHfwFF5NHFlnDj99Vz/t5XdtHzknZVW3klJhQQagD+I62mbCpcWwTk
3kzjfbV73naCVmZTSQSjySiegPo7tQY=
=kk9F
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
