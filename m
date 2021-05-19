Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3DCC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 02:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAC761369
	for <git@archiver.kernel.org>; Wed, 19 May 2021 02:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhESCJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 22:09:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47310 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234117AbhESCJe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 May 2021 22:09:34 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1875160479;
        Wed, 19 May 2021 02:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621390064;
        bh=Oa48qbKBC5HEG1/vXqCDVASGQJcvCFAJqINXpHhyld4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YeeLBH6eko44mAFAnEPeC5E4HmSVdxG0nSVS2JETIz/8UjiKQJPwEHftoviUip1ic
         ygvkZF1n3WM55HLWFiWMb1jILBC2Rjie5Kua8czpF6HXoI9oYehm06eSn5SqG/mTEI
         A9QhMczL7xyZrqYuIR4HVXpowTB8cdf9FzZgyfp8vr0WuIrTVNGlZfVink6emgclSo
         SwI84qtCu03ERimP0KRlSMJT0PgTrAz7+6pT0eVp+MBk5kxZogqmmpGo99WmNuOU9a
         GPyhCrJo8Ff6tfMryiDo3TzGkiInDOGMMIaKRqs1Qd3HbChBmuAJ+4NYQbNKwGchUu
         AplKgb7qdmv2FQRUGriiMnvn0/Nrq/TSML4k0APxkHv3n3z8SNUMeONa7EYCbNCPNs
         gWLW6ZjzZNNrE73jbiWNb61QlIKX9Hh0iL0PH0+yXQgm2dkwcvAYROsK2XAoRrDEwg
         3aDmKxN41vm+OToT4PI5pgtos4+6esfZA7Je0xzxxlixwJWNp0F
Date:   Wed, 19 May 2021 02:07:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] help: colorize man pages
Message-ID: <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <xmqqfsyj1qe1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="woe9A1d9o8/PoRKL"
Content-Disposition: inline
In-Reply-To: <xmqqfsyj1qe1.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--woe9A1d9o8/PoRKL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-19 at 01:08:54, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > In general, this is made worse because Git doesn't honor the unofficial
> > but widely supported NO_COLOR[0], so reading the documentation is
> > obligatory.
>=20
> I vaguely recall that we were contacted by NO_COLOR folks to be
> an early supporter of their cause to break the chicken-and-egg
> problem they were hagving, and (unhelpfully) answered with "sure,
> when we see enough people support it---otherwise we'd end up having
> to keep essentially a dead code that supports a convention that is
> not all that useful".

Yeah, I seem to recall you were somewhat negative on it at the time, but
I do personally find it useful, and someone on Twitter reminded me of
it just today.

> I wonderr if it is just a matter of hooking into want_color(), like this?
>=20
>  color.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git c/color.c w/color.c
> index 64f52a4f93..2516ef7275 100644
> --- c/color.c
> +++ w/color.c
> @@ -373,12 +373,17 @@ int want_color_fd(int fd, int var)
>  	 * we always write the same value, but it's still wrong. This function
>  	 * is listed in .tsan-suppressions for the time being.
>  	 */
> -
> +	static int no_color =3D -1;
>  	static int want_auto[3] =3D { -1, -1, -1 };
> =20
>  	if (fd < 1 || fd >=3D ARRAY_SIZE(want_auto))
>  		BUG("file descriptor out of range: %d", fd);
> =20
> +	if (no_color < 0)
> +		no_color =3D !!getenv("NO_COLOR");
> +	if (no_color)
> +		return 0;
> +
>  	if (var < 0)
>  		var =3D git_use_color_default;
> =20

Yeah, that will probably do it.  I hadn't looked at it, but I assumed it
would be pretty easy, and it looks like it is.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--woe9A1d9o8/PoRKL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKRy6QAKCRB8DEliiIei
gc4sAP9eg5P7KbHBQAr6yKXjUnrdkevvrsTHYwzwxQ1euFbYpwD/T9mg1D3k/3kE
MP2ctc20Aff9TDWRbO3NpoGry61Vnwo=
=UUx8
-----END PGP SIGNATURE-----

--woe9A1d9o8/PoRKL--
