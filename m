Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844B01F404
	for <e@80x24.org>; Sat, 24 Feb 2018 22:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeBXW3K (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 17:29:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33750 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751399AbeBXW3J (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Feb 2018 17:29:09 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 022CE6042F;
        Sat, 24 Feb 2018 22:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519511347;
        bh=+QU8EbLnVNpgbNch0dMCfUs+euiaGYrbeZrDv+Qg6vE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fvp21KdzgJjg88F0SRpKB4m7DIjkvTfWupLkQ4zhtSBTQ27pbQ4YJGm9F0lOZGgLZ
         vZke6mj879HvffVE0VtGSkxoi7owEPyB2sRZOF5yIrjfilLxjawSKdpgYSeboheIFO
         k6VPDhUVEgMZvbRBNy9TvGpu5wnr4YViplJHoHcJV01noAUv5cBcIoggwPKmaZoJ9n
         C/kVJxIfxEL9lgyWP27eACeZHEs+tLTl/FV5FqwKyuvpdaJvOpsb70fYdp8KZbt7Zr
         6O9H6Xc7vcui06lqMX2KzFmY0gmsPUkhiptBAM8e1639g4VFRizPQXF3LwgBHxm0tD
         5kkXpvFgZmLxZBmmUCCgJXtDygDPuaCG9SSfIS9cjNU/qHmeW+fpWQmBMlpOTrWAht
         CoI6glOLhSTBUxri7fLwh/KOOxWHgixDIB2HUgMNSw+ohdqNu2b2wCj+BgF8WqMw96
         kehD9inEhRPzpn29atzd/6VyCmXs1GV1Pz6zcuOrdctbmhnvM8E
Date:   Sat, 24 Feb 2018 22:29:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 4/5] diff.c: initialize hash algo when running in
 --no-index mode
Message-ID: <20180224222900.GA4620@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20180223095640.25876-1-pclouds@gmail.com>
 <20180224033429.9656-1-pclouds@gmail.com>
 <20180224033429.9656-5-pclouds@gmail.com>
 <CACsJy8AUXf4uA-zymrhWUagW84bUzfB6JBQLyaHDJtudTcNy=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <CACsJy8AUXf4uA-zymrhWUagW84bUzfB6JBQLyaHDJtudTcNy=A@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-1-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2018 at 09:36:03PM +0700, Duy Nguyen wrote:
> On Sat, Feb 24, 2018 at 10:34 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy
> <pclouds@gmail.com> wrote:
> > @@ -3995,6 +3995,18 @@ static void run_diff(struct diff_filepair *p, st=
ruct diff_options *o)
> >                 return;
> >         }
> >
> > +       /*
> > +        * NEEDSWORK: When running in no-index mode (and no repo is
> > +        * found, thus no hash algo conifugred), fall back to SHA-1
> > +        * hashing (which is used by diff_fill_oid_info below) to
> > +        * avoid regression in diff output.
> > +        *
> > +        * In future, perhaps we can allow the user to specify their
> > +        * hash algorithm from command line in this mode.
> > +        */
> > +       if (o->flags.no_index && !the_hash_algo)
> > +               the_hash_algo =3D &hash_algos[GIT_HASH_SHA1];
>=20
> Brian, are we supposed to use the_hash_algo this way (i.e. as a
> writable var)? Or should I stick to something like
>=20
>     repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
>=20
> which allows us to notify other parts inside struct repository about
> the hash algorithm change, if we ever need to?

I would definitely recommend using the function.  As you pointed out, it
makes our code future-proof against needing to more work when setting
the value.

> If the_hash_algo is supposed to be read-only, maybe I should convert
> that macro to an inline function to prevent people from accidentally
> reassigning it?

You could if you want to, although I don't really see a need to, since
we can just catch it in review.  If you wanted to, I'd make it an inline
function for performance reasons.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqR5ywACgkQv1NdgR9S
9osEIhAAnBUB+/YRM86UJJGzYgW/BaVzqiIoTSByRWRcJDOsIbUApNE3OeVj1LKf
V0UrUtAxI0pfVGt/U4nTbOxfdTVPim+TCO0E+9muqt6AT9DETd1//q1COuRIHayn
BJFdNmw4OWDubO8aCQBRo8SbUdhyb4XuOVlw4EYnUp7VUVqIWjEhReRwaAlWhAA9
KdWqJXcExCvJVswxhme7BftH5JFUES1R/u3Oo0NAyGEh971KQqO8sL8aY+eHPbus
IRZj02t8G9ZxshwKkE2j4E2ENq42mATbMPbmLx5CZWaiaBO6WwFZZ6iyowQCrn7n
bW2Qfm5hK0mRoZh0pI20FODklsDejz1pvsGiB+bH4EMxRF6YTNMdzds3RVl5Rj+i
WGcKOcKBkBde6Y/I3IZMbtjgtflKxqPyymW2ijO3gkkF+cM7HmEvI2ixISzgg04Q
j4QYlfny8IJjFm1FJm6fdtPFd8WhqA2V9M4AxLDHwvOE+O0Hyl+fYln3A5MBAf20
Gm3nSYRua21ttKwJPIUtOkM0I0+UHBLRgO5H/pQ2YmC9mTYvGAUoG+W8jzVdD0rb
gyXw+/hdHnMhxparzXYlL6hQ4knEFDTjQbJpzUf8MvkplIFdilIwfeTaP6YDvLIN
hUjTYTKEtyO6THYLtD40iQ1+qG6DKSoHhAev5GMRS4Hf/aBF90M=
=AhAo
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
