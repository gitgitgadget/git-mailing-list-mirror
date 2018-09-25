Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D67D1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 01:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeIYHUz (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 03:20:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40610 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbeIYHUz (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Sep 2018 03:20:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:596e:6738:f59:e0e0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EEFE16046C;
        Tue, 25 Sep 2018 01:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1537838153;
        bh=fj8HOJ0w8qIRTbuNYW5Utbwrvy2BwmPZTPjoqyb2sxg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CO9h5f1QHCMihtP5Zyw5SheJJjvK7SnvEsgM9FmsN85wPjEODXaZjVBfm7X433T7u
         WSOKUKk16HJOr/8K4q5EYawgbqd1OH+GWUji7+e5uGm8/4mTead6CmaciDGzZl3p0A
         IkTQx6S4WO/lJQHDZGWpXfQp2wUuUB1L7DmqoWSjG35HNdbKvxVYQCuyzvmUbaDVv1
         9EsW/eQSO0UpHhO+lavTpSWco8G7mVnuUum8mvR8mlHFnCZMOK4DFwK1U5758gxglT
         Y6eClNjLjgjECw5VEONDlai9FT/Ad7ZmqGu4K3MZU6BXEfAAYRuXfoRguIfGdx+dZX
         VBG6rRsCZTo3t571yli9PGfOxzeYScsxs7BiZG3DvqvxfRBBRp0iw3h1gTaqMFUPYb
         GKsmHWD0hS3osoITE2mozArDm5QjpXxUsbWInM5lucd2/0+rrbmbwWti888iyFR+Ok
         zkAKavzrOmyyR1HzavKGUhIlAfwjbXqLrsNUN1Sg0oRtkR0hobA
Date:   Tue, 25 Sep 2018 01:15:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] mailmap: consistently normalize brian m. carlson's
 name
Message-ID: <20180925011547.GG432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <20180508015845.268572-1-sandals@crustytoothpaste.net>
 <20180522220826.GP10623@aiede.svl.corp.google.com>
 <20180522224215.GI652292@genre.crustytoothpaste.net>
 <20180917181800.GA140909@aiede.svl.corp.google.com>
 <20180917222158.GY432229@genre.crustytoothpaste.net>
 <20180924173902.GB138072@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RWntzN4uhMukjMHt"
Content-Disposition: inline
In-Reply-To: <20180924173902.GB138072@aiede.svl.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RWntzN4uhMukjMHt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 10:39:02AM -0700, Jonathan Nieder wrote:
> Hi,
>=20
> brian m. carlson wrote:
>=20
> > I think this commit message makes sense.  I apparently still fail to
> > understand how the .mailmap format works, so I can't tell you if the
> > patch is correct.
>=20
> Thanks for looking it over.  What would it take to make the patch make
> sense, too? ;-)

I certainly didn't mean to imply a failing on your part for explaining
the change adequately.  I've just always found the format confusing and
I know others do, too.

> Most mailmap entries are of the form
>=20
> 	Some Name <someemail@example.com>
>=20
> which means "Wherever you see the email address someemail@example.com,
> canonicalize the author's name to Some Name".  We can use that:
>=20
> 	brian m. carlson <sandals@crustytoothpaste.net>
>=20
> When we see sandals@crustytoothpaste.ath.cx, we also want to
> canonicalize the email address.  For that, we can do
>=20
> 	brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpast=
e.ath.cx>
>=20
> There's only one person who has used these email addresses, so we
> don't have to do matching by name.  If we wanted to tighten the name
> normalization to match by name, I think we'd do something like
>=20
> 	brian m. carlson <sandals@crustytoothpaste.net> Brian M. Carlson
>=20
> but I can't get that to seem to have any effect when I test with the
> "git check-mailmap" command --- for example, "git check-mailmap 'Dana
> How <random.email@example.com>'" does not map and "git check-mailmap
> 'Random Name <danahow@gmail.com>'" maps to 'Dana L. How
> <danahow@gmail.com>'.
>=20
> The even tighter matching used in v1
>=20
> 	brian m. carlson <sandals@crustytoothpaste.net> Brian M. Carlson <sandal=
s@crustytoothpaste.net>
>=20
> does work, but it's unnecessary complexity.  We don't need it.

This has been a really helpful explanation.  Thanks.

Maybe I'll have some time over the next week or so to send a patch to
the documentation to make it more understandable to past me.

> How about this?
>=20
> Changes since v1:
> - loosened the matching to only look at email and ignore name
> - no other changes
>=20
>  .mailmap | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index f165222a78..bef3352b0d 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -25,7 +25,7 @@ Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoront=
o.ca>
>  Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
>  Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
>  Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
> -brian m. carlson <sandals@crustytoothpaste.net> Brian M. Carlson <sandal=
s@crustytoothpaste.ath.cx>
> +brian m. carlson <sandals@crustytoothpaste.net>
>  brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpast=
e.ath.cx>
>  Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.com>
>  Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>

Having read your explanation, this looks good.  Thanks for fixing this.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--RWntzN4uhMukjMHt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlupjEIACgkQv1NdgR9S
9ouydQ//fmoMBvafT8GGul/HfuyVYSukWu71zzrJP4F8L7iMKXyh/CRucVmA551k
W1J9ynzp8yVcH/YAj1T2c8lxKkdsOP/CXeEugUXq4zT/QsQKZcF3D2kOQXQnmiXV
htO6ezFs6gc5iOxurOcgWfXmzoUle/1ho5eky+xa6fAU/rXUVEZq8ViNVxASVJwO
Ba1FeROnio81+Rt2qvi+rrRfsHEbl1pruC2NyMEu9v3VUAxkb6rZ56RM0QQ/uMNC
VW6QLO1By3uvcvFKqqF0+ntbFHa2UemrJrggnIPm9nEku3s6SUw1wMEN03f1WeLO
2PtU4Qc+b0VuRLElE3qXnJt4XkjNtJY5fMvq4qBfGR20pWbItePoYlNwYhgJNVgT
pswNQVd2emTqVPqxEwpWUYVcxjr5iKt2Es1iwS6RNq2xdITmctRQAQLz3/rp8btT
PEcrcnIbtUOBCTweeutxKEz9L+Wyc0f8HMysJG3EUsrlQ8YEu/9WTSLs09eAqWej
oNtL6+/32tsyDECzAWL3PHcE16ZJIWqf50+/Qw4cd0NY4iYzIc2mS1qhmTwRd+1U
Qym8ft2EMtlFmY+ubFu7egqZC0+6f/9jADo8pEHMKXXqykLRfFR39AhyQytFV5ry
UMQ7j94PSuWi+FVAK/x+M4I2xzljvK1pyjLC1mxBUCPrOlFdtjU=
=i2cc
-----END PGP SIGNATURE-----

--RWntzN4uhMukjMHt--
