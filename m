Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18891F42D
	for <e@80x24.org>; Wed, 30 May 2018 23:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932526AbeE3Xh1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 19:37:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58338 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932408AbeE3Xh0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 May 2018 19:37:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:cc62:bd61:abbd:bc4b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C293E60732;
        Wed, 30 May 2018 23:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1527723441;
        bh=r2Y3PAy6XW8Lb7jgeIycibgUXQK6ekGymAL3zR+vdXo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=L4hb37kZRVFVbOoVJKDbd7Z5+KvxihovfOzk2KQWWIhHZiqs1/DeZ52FvLKm4Hf8Q
         H9a9RbKfIk0GkpxyspiQ5mQbDOt9+fF16Rl6034ylnccFrLsq5MTQnCIM6maH4K47A
         HHKe5kGKQOaqZ7N2nPggm1/TsQcU7lV6Sc1cVd81lrMZRCkt9V1KNE3zWJtsjNboOW
         BOqBTBHSPMHsUum+kjC01bHStIYLEkvIXBhRxn8OT67OLSGN1757nmIqM/3d/nVg28
         LKsE5/LRRWf+s03TIOOHb86vJwCEiT+fbQVYrv/1L39w4jcyoSis1JH+TlFtfbRZQz
         2mq+hiHBQmeSxN0b3O+dsvmvEJbCP0ufPn3dXKgnXkj0WR1CCESLWBYHTjqqUPav4T
         0+lOq8gf/vcqEo/ZsyiQfjV/PEhlluNMlmL67k+hzRbowHBWzL1nH+ol+WHUFiMGQK
         OJwvHzV2dKKjf69aGbbjHb++HJbmKo9fSrgchTWom0HqaJO41a4
Date:   Wed, 30 May 2018 23:37:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/2] note git-security@googlegroups.com in more places
Message-ID: <20180530233716.GE671367@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20180527140433.32277-1-t.gummerer@gmail.com>
 <20180530205255.13090-1-t.gummerer@gmail.com>
 <20180530205255.13090-2-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline
In-Reply-To: <20180530205255.13090-2-t.gummerer@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 09:52:55PM +0100, Thomas Gummerer wrote:
> Add a mention of the security mailing list to the README, and to
> Documentation/SubmittingPatches..  2caa7b8d27 ("git manpage: note
> git-security@googlegroups.com", 2018-03-08) already added it to the
> man page, but for developers either the README, or the documentation
> on how to contribute (SubmittingPatches) may be the first place to
> look.
>=20
> Use the same wording as we already have on the git-scm.com website and
> in the man page for the README, while the wording is adjusted in
> SubmittingPatches to match the surrounding document better.
>=20
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  Documentation/SubmittingPatches | 13 +++++++++++++
>  README.md                       |  3 +++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPa=
tches
> index 27553128f5..c8f9deb391 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -176,6 +176,12 @@ that is fine, but please mark it as such.
>  [[send-patches]]
>  =3D=3D=3D Sending your patches.
> =20
> +:security-ml: footnoteref:[security-ml,The Git Security mailing list: gi=
t-security@googlegroups.com]
> +
> +Before sending any patches, please note that patches that may be
> +security relevant should be submitted privately to the Git Security
> +mailing list{security-ml}, instead of the public mailing list.
> +
>  Learn to use format-patch and send-email if possible.  These commands
>  are optimized for the workflow of sending patches, avoiding many ways
>  your existing e-mail client that is optimized for "multipart/*" mime
> @@ -259,6 +265,13 @@ patch, format it as "multipart/signed", not a text/p=
lain message
>  that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
>  not a text/plain, it's something else.
> =20
> +:security-ml-ref: footnoteref:[security-ml]

My only feedback here is that using the footnoteref syntax to refer to
the previous footnote potentially makes this a little less readable for
plain text users, although it also reduces duplication.  I'm not sure I
feel strongly one way or the other on this.

Otherwise, this looked fine to me.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.7 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsPNawACgkQv1NdgR9S
9otJXBAAv9WIdUL/eq+GdRibPPaVXiWBnHFhLgTUJ1XTPL2oIYaN0y0WPemty5Tf
K8JQZVccDWdSV30GJbeZcPgZ/7Y75pXRovbLLFVD7EXwVHGbPpR4C2yN1GsOuqw0
mWX4+fTvwNvXtjWVp3IiJwpTK07fVgb8BHD0okUjwwKsFAhD05piwK6uoXsK4bWx
mCIMWYbccnbzr5k9jdxs6Csq81QRFE+BI92PLLhXhb4jICapS9rOI26Ai/OGJhmL
R2uKCvzQId8PT5QZhWh70vD3CjfpMmDxIZMO8bhjkivF+Iph50W43L8lt7wOrWwo
RxE6k5giIuuh0R2mcC5FQtEfS4fyro854fEYHK+uNYVBdys959cfgG7l9zxk/Jxx
pf2TBO/I4HvvX03/fSr3IM4i+cGImBJFGJFMTbEvlGtUF+Z37gsuTssOJLTG452c
X9xKE7RR8QnwDv/AIvuJdvzaB79pVaan8Uk23J1ivsNDTp0A5WXw7VyweEVlbyf3
1I1/3noY9m2E/ZpyNrjc/zAcvXtdpd7YQngvgWYfGEYX2L4Dw7Ykf11p0yolqVjB
66NamHpUyge3q4BKV8T/oCqbuMgdGmyP2rvMJoB2KF7jzJLsavpH4tL8J7IKARQr
K4mRHvnbJkFIo7Mqvtns4L5SDSR40jO08ZCnFhKMr9MB2bJKE1k=
=a6m+
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
