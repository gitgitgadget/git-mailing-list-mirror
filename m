Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0EBC4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 02:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C623422C7E
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 02:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgLGCMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 21:12:12 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55274 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbgLGCMM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 Dec 2020 21:12:12 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 77A8360751;
        Mon,  7 Dec 2020 02:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607307090;
        bh=OWaUG0HoYYl2moXkG+KtRwkK2rYoCZQL60p+0TuDKZY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=huHKlKRP3RQuF1VW58RSaC8hwwgBOuv7yHav5fwfFdcH3NMSVoLBvTDi+ttypuvUs
         hAwKI7SRW6CgcRH9Ai/qBp9wr5rs2IY3P7lgQ8qkn15lKPjP9sNytUf7hiXRl4XYUf
         Uv+s8lcV0Yt1Ed0kT6xtjfOfaeij0EWUS7VaGF90+e2omFNJARfYCKqQeWFyYKRUMp
         KkFvE8PXtksLHB+IClkMFhbDzff9sii1jKjqRD2gIMKxtlAibWyXve3FzzdWRlxmK4
         3FQM8yC/sWjDcnAm+QLcZHp1SphA1X1zan0Hjy/3r7c6doow1FazQNGbP5w+yn8myj
         5boMvurhhrd5+OtcLlG3iEJB/wKwnGMxLnAnaMto21BlGdBEmNaaxu/qydAMABHQjj
         5HmesNm3gPcGc9JBpGd2vSnTDBVC0SnTjrHOGZdRP8Q2X/oXs2K+/JHXTLIQ0pLH+I
         PMPsbr8rY3Rq7MfxBUbpvJJ/Yc+7hBkoSl5A8dFBCfDwzZx1jW5
Date:   Mon, 7 Dec 2020 02:11:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 1/2] abspath: add a function to resolve paths with
 missing components
Message-ID: <X82PS2RDlpXY0srv@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <20201206225349.3392790-1-sandals@crustytoothpaste.net>
 <20201206225349.3392790-2-sandals@crustytoothpaste.net>
 <CAPig+cTbtpzwcQPHUgyf=0Oe5h2_=zory2oj9oFEUrdtaRR6ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLjK337+kj9z1Ows"
Content-Disposition: inline
In-Reply-To: <CAPig+cTbtpzwcQPHUgyf=0Oe5h2_=zory2oj9oFEUrdtaRR6ng@mail.gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SLjK337+kj9z1Ows
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-07 at 00:02:16, Eric Sunshine wrote:
> This commit message is too barebones. As a justification, "We'd
> like..." is insufficient; it doesn't help the reader understand why
> this change is desirable.
>=20
> Further, the lack of explanation about the seemingly arbitrary "one or
> infinite" condition confuses the issue. The first question which
> popped into this reader's head was "why those two specific choices?".
> What makes one missing path component special as opposed to any number
> of missing components? (These questions are mostly rhetorical; I can
> figure out reasonable answers, but the commit message ought to do a
> better job of explaining.)

Sure, I can expand the commit message to be a little more descriptive.

> The name of the function is somewhat confusing, especially if you take
> the suggestion of dropping the `many_missing` argument. Perhaps a name
> such as strbuf_realpath_forgiving() would be more understandable.

Sure, I agree that's a better name.  It shouldn't be surprising to
anyone on the list that I am absolutely terrible at naming things, so I
appreciate the suggestion.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--SLjK337+kj9z1Ows
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX82PSwAKCRB8DEliiIei
gUzdAQCjYwhnlzq45MsK6JV4WA1dMJhvGcOZO6s/Ac8RDPsB0gD/RbWr+Kn5NaFt
zDTafif0QGmOkMf7CbSmwXsWc6NOAQ8=
=TBMM
-----END PGP SIGNATURE-----

--SLjK337+kj9z1Ows--
