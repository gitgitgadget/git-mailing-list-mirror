Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B78CC433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 17:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DED32245C
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 17:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgL1RDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 12:03:06 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41544 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbgL1RDF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Dec 2020 12:03:05 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1DDCE60810;
        Mon, 28 Dec 2020 17:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1609174944;
        bh=/yc15I/74OSsP9Rl6qAvJRzldyp3v4USVBinQ042pAU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XEM5ye6O1QUPigAiCc7nZ5fhoo1I36BmLsEOUpEhmzsaVD5IgEi/Qq8g4UwzQGbH/
         +7dRalFDeU6ORMI0Wh7/y92a85yMg1QcE405YkYd1JSmcVJ+ktwiwG7yyafHj/7zV6
         84EGRhp2Y1hwtAEyQoFOnGXgjauU3xtkkkmbiXKaGXvprUfGIozldi2C3uLLFM86Wv
         VLqYPoL++Gc8vPAbZcRBmJO30Dk5jepd13VJKuZRetsvHQUN0eNuBAM22Nf8hveTfB
         8SVR59kALBqq2mtT9TxRbBXFO99ouga1vvUtfFHWIzoSZrhWMJaEsho1w21X+byueo
         +P6n8AlcQKfcOx1eQdzWQBBPXaFVm2XJEBTbJGGgvetKQx1OnkjCwDnJjEDuVF0dv4
         CEegyjOhP0AY2ZcitaDSV690CjqOu2yRUETywtCv1fasmaqJ+/3pdsSvoKzb10t7to
         RtCWiuJeXAOPrfmjOLIF5tUNLgUHTefHGqcpfFl9AmPPvpyqrWd
Date:   Mon, 28 Dec 2020 17:02:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] CoC: update to 2.0
Message-ID: <X+oPmuE2E3xVDbxj@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="31EtuZWXIppNo9f6"
Content-Disposition: inline
In-Reply-To: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--31EtuZWXIppNo9f6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-28 at 12:59:53, Junio C Hamano wrote:
> At 5cdf2301 (add a Code of Conduct document, 2019-09-24) we adopted
> a Code of Conduct from www.contributor-covenant.org; back then the
> version adopted, 1.4, was the latest one.
>=20
> Version 2.0 tightens language in examples of unacceptable behaviour,
> generalizes the audience from "contributors and maintainers" to
> "community", and enhances the enforcement section.
>=20
> The preamble we added to the beginning of the document has been
> kept, but the rest of the test has been replaced in full from the
> "upstream" and then the same customization for our community
> (i.e. the way to contact community leadership teams) has been
> applied.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This seems like a good improvement on the older version, and I agree we
should update to it.  Thanks for keeping on top of this.

Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--31EtuZWXIppNo9f6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX+oPmgAKCRB8DEliiIei
gTnpAP0WMnFvbhLKTWu0nIbbGMDOfireGhGZtsrPrW/LAWTp7wEA5CStv58zMBeR
HSYNX0vfx5Hlqmp2wE8iPVfal2I4lww=
=TMLI
-----END PGP SIGNATURE-----

--31EtuZWXIppNo9f6--
