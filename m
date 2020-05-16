Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B094C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 20:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E9720727
	for <git@archiver.kernel.org>; Sat, 16 May 2020 20:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="i7aaL6FS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgEPUAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 16:00:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38432 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726364AbgEPUAR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 16:00:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1525260427;
        Sat, 16 May 2020 19:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589659186;
        bh=RryQVITjS7DfOT84+Crr+rdtTK+XpSaCdyPtY3AaqJo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=i7aaL6FSJyV+pvT9E7r04K16xw7W722yKJdngAcxcv6YLEYzCaUcDVChxSxIPUigC
         DA6+CGPaNTrFdYG5WfO696X9ZBrU3E7D42tnSnNCRaYLtC+Pha4gX29swWn08Lq+Wh
         ftr80YNd34JkNGCftbVOYypbBjDRYTwW5s4msRfufKG87VLrGFtBIfeXCYncjSQhSx
         GO69kZzLbbeG9T8/lGFALShRugpt9i8q94J9nP3Hql4S3rFEejIeVej0LCYtKWvB1A
         rSA7ZL9NxfcYrEOX7DrTW3MVTF6cz+3TPTldUfMHAgyYtYLgg2x+Q6nwy5dUkUhwIT
         RQ7p4M+BIx1qAzCJt5kmWWy0N407nNE+y1aUlJeiKYjX3UTeAcFTBfECf64Nv+611l
         Qqym7pBrO7h49KnM4BiVYKv9u4d+sVb+JG+SURmgbZzzWbX2ffz6x5JsKh30ZbpFrs
         Z0qOs0HUsc3c1aeNm9fflPGoqbteXWGsX9e7ZRm/QB5Gx19JW9u
Date:   Sat, 16 May 2020 19:59:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 14/44] connect: detect algorithm when fetching refs
Message-ID: <20200516195941.GG6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200513005424.81369-15-sandals@crustytoothpaste.net>
 <CAN0heSo=xUGwb8FLXYpcFXO+e9dqvpzR=h2Bs+HC_ubQdTQuWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
In-Reply-To: <CAN0heSo=xUGwb8FLXYpcFXO+e9dqvpzR=h2Bs+HC_ubQdTQuWw@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-16 at 10:40:11, Martin =C3=85gren wrote:
> On Wed, 13 May 2020 at 02:57, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > If we're fetching refs, detect the hash algorithm and parse the refs
> > using that algorithm.
>=20
> As the added documentation from patch 2 says, if there are multiple
> "object-format" capabilities, "the first one given is the one used in
> the ref advertisement". And that's what you implement below.
>=20
> Explaining that in this commit message and/or referring to "a recent
> commit" (patch 2) and/or adding that documentation here, not back then,
> would have avoided some confusion on my part, and perhaps also for
> future readers.

I'll try to reword to improve things.

> >  static void process_capabilities(struct packet_reader *reader, int *le=
n)
> >  {
> > +       const char *feat_val;
> > +       int feat_len;
> > +       int hash_algo;
>=20
> You could reduce the scope of `hash_algo`.

Can do.

> >         const char *line =3D reader->line;
> >         int nul_location =3D strlen(line);
> >         if (nul_location =3D=3D *len)
> >                 return;
> >         server_capabilities_v1 =3D xstrdup(line + nul_location + 1);
> >         *len =3D nul_location;
> > +
> > +       feat_val =3D server_feature_value("object-format", &feat_len);
> > +       if (feat_val) {
> > +               char *hash_name =3D xstrndup(feat_val, feat_len);
> > +               hash_algo =3D hash_algo_by_name(hash_name);
> > +               if (hash_algo !=3D GIT_HASH_UNKNOWN)
> > +                       reader->hash_algo =3D &hash_algos[hash_algo];
> > +               free(hash_name);
> > +       }
> >  }
>=20
> xstrndup is needed because we're not guaranteed a terminating NUL. You
> remember to call free afterwards. Ok.
>=20
> If we don't get any "object-format", we do basically nothing here and
> `reader->hash_algo` will remain as whatever it already is. The docs from
> patch 2 promise that this will be handled as "SHA-1" -- would it be more
> robust if we did a similar fallback dance as you do elsewhere?
>=20
>   feat_val =3D ...;
>   if (!feat_val) {
>           feat_val =3D hash_algos[GIT_HASH_SHA1].name;
>           feat_len =3D strlen(feat_val);
>   }
>   char *hash_name =3D ...
>   ...

Yeah, I can do that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsBGLQAKCRB8DEliiIei
gZg3AP9ytpkHNdWtQzcqq0iCt54D0N71hXkIRUXI6GufEHN/8gEA+5cicjiUP/UC
s/rGgNZl4May9+KXlFj2JZMDfai4uAY=
=yMKP
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
