Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DF0C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 01:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EFA20829
	for <git@archiver.kernel.org>; Wed, 20 May 2020 01:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ARBZzDwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgETBiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 21:38:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38520 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbgETBiT (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 May 2020 21:38:19 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3FB0E60482;
        Wed, 20 May 2020 01:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589938698;
        bh=XdsUU3wCHDKWH8jkSCtq07I35fDBPnuZSd4KFbP334g=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ARBZzDwoCNa8jfzfnBTplpQBma9lcGFqULdBJhUF1KuS7WX9MFWt8BdIpk/GvnvNo
         NGK8StNdzooNyDjaVFPba48wUGCaRnQhhgexcM481AkGP5sGP74P5at1jjwyIlOPH5
         hZ5BVkgn4vzEd5k21ftarB+0QHyQWVVqQi5hjFQ/uRjlyDxSAp0r/thkMy6G3rbC+9
         NFt+3r1lM16zDy8HjMZxhBvqDEvv96urhJe0qDJ4SukDzuyoKpX6qXFOzryhEDH7vv
         vDlpTu/e/R/Ury/VFtwEMq5SBU7DW+DHhtY+hE5DcjHt1CneJJx+Nh4LKSjNRnpXAI
         dbKkJDOFFj6I6hin5deDkfEAdK9rKVtAssucMxPmw5K28QccJumgjtZy5NC8LMIqtE
         7ZM2yzcPEDDiGFfqyIec/9T2GF6O9YfW9kw1j4N6+KAxTSm6xlfePjGCC4WKqxWVjB
         UAj74rMpKDK7l2eFXFSGdrI+C/Xhtja9RF8fqxZ9hpr14kj+b6h
Date:   Wed, 20 May 2020 01:38:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: Git Test Coverage Report (v2.27.0-rc0)
Message-ID: <20200520013812.GS6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
 <853759d3-97c3-241f-98e1-990883cd204e@gmail.com>
 <20200519234208.GR6362@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XaepPZQT0uxAV0NY"
Content-Disposition: inline
In-Reply-To: <20200519234208.GR6362@camp.crustytoothpaste.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XaepPZQT0uxAV0NY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-19 at 23:42:08, brian m. carlson wrote:
> On 2020-05-19 at 12:11:15, Derrick Stolee wrote:
> > On 5/15/2020 1:22 PM, Derrick Stolee wrote:
> > > brian m. carlson	13e7ed6a builtin/checkout: compute checkout metadata=
 for checkouts
> > > builtin/checkout.c
> > > 13e7ed6a 625)        is_null_oid(&info->oid) ? &tree->object.oid :
> >=20
> > This is part of the following hunk:
> >=20
> > @@ -619,6 +620,11 @@ static int reset_tree(struct tree *tree, const str=
uct checkout_opts *o,
> >         opts.verbose_update =3D o->show_progress;
> >         opts.src_index =3D &the_index;
> >         opts.dst_index =3D &the_index;
> > +       init_checkout_metadata(&opts.meta, info->refname,
> > +                              info->commit ? &info->commit->object.oid=
 :
> > +                              is_null_oid(&info->oid) ? &tree->object.=
oid :
> > +                              &info->oid,
> > +                              NULL);
> >         parse_tree(tree);
> >         init_tree_desc(&tree_desc, tree->buffer, tree->size);
> >         switch (unpack_trees(1, &tree_desc, &opts)) {
> >=20
> > The double-nested ternary definitely complicates the coverage here.
> > It also points out that all tests have `info->commit` a non-NULL.
> >=20
> > This certainly looks safe, but I don't know.
>=20
> This is me trying to be defensive.  I think the code path that is not
> covered here that can be is the info->oid code path; I don't technically
> believe the other case (using the tree) is possible, although the
> checkout code is complex enough that I can't be certain.

Actually, with more research, it looks like this can just be simplified
since info->commit must be non-NULL.  I've analyzed the code and am
confident that's guaranteed to be the case, and the test suite has
confirmed no segfaults by making that assumption, so I'll send a patch
imminently that just does that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--XaepPZQT0uxAV0NY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsSKBAAKCRB8DEliiIei
gTMuAQDVjVrGz3dnn8xmadvqfBVxwIzmguI5sIh+6kLa5wO5YAEArIeKxwZQhoZQ
+st9unmNZ5xkZU09QC3htE1vcbjXuQI=
=T5xh
-----END PGP SIGNATURE-----

--XaepPZQT0uxAV0NY--
