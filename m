Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B277CC433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 23:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8340120674
	for <git@archiver.kernel.org>; Tue, 19 May 2020 23:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QpyDh+5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgESXmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 19:42:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38510 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725998AbgESXmR (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 May 2020 19:42:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 73BB560482;
        Tue, 19 May 2020 23:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589931735;
        bh=EYO4apr3dG8Q3bfIPu8ppacwOzVdRLlLsNMkLqgDbQU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QpyDh+5pbFL01s9+FbRrQxi7ReidgnNERJFV7C8skA2L9cAvhVVNUOgL0LGRlC2AS
         FjgHa09OkThNFvL5yGMB7v3swymGbSGTxwuZ1uKrwBaB1SUhtjyY5i5Bh6fYnwFo5O
         17OhupygrVRk7BRTU434PFM5ky/6he8ldil4i10W0JDCBtGP4ULDWdwJ9UN5U7UUBd
         lfUg5x1AnUSak5D21sdNF33COcSiyn+3QytS10UNcGZILIByIILOvCXbNhlR/LwxWQ
         7zuj2/Gmqh212RvnrJoY+aDBx2e/YjkvERo0DIzNXyn+m5z5euUVCAfGnl7LvEwtX1
         7gBzijxkYDEzegmLuIRonOPTEIIcz3LID/Upob/8RRLSivUZ9p9OQPL4Ww91H14DxJ
         S3q/nEGguWXvPn9Gtj+YchDFnM/r9WXFzK8BBxVaokWO9v/qlrktb8xy8Oc2porzGx
         T84c7oinLBOxkgOikD8QGbpgR/GnXqt43VV+iO6AJW5VEEzKMFv
Date:   Tue, 19 May 2020 23:42:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: Git Test Coverage Report (v2.27.0-rc0)
Message-ID: <20200519234208.GR6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
 <853759d3-97c3-241f-98e1-990883cd204e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G9m07da55tKJni3T"
Content-Disposition: inline
In-Reply-To: <853759d3-97c3-241f-98e1-990883cd204e@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--G9m07da55tKJni3T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-19 at 12:11:15, Derrick Stolee wrote:
> On 5/15/2020 1:22 PM, Derrick Stolee wrote:
> > brian m. carlson	13e7ed6a builtin/checkout: compute checkout metadata f=
or checkouts
> > builtin/checkout.c
> > 13e7ed6a 625)        is_null_oid(&info->oid) ? &tree->object.oid :
>=20
> This is part of the following hunk:
>=20
> @@ -619,6 +620,11 @@ static int reset_tree(struct tree *tree, const struc=
t checkout_opts *o,
>         opts.verbose_update =3D o->show_progress;
>         opts.src_index =3D &the_index;
>         opts.dst_index =3D &the_index;
> +       init_checkout_metadata(&opts.meta, info->refname,
> +                              info->commit ? &info->commit->object.oid :
> +                              is_null_oid(&info->oid) ? &tree->object.oi=
d :
> +                              &info->oid,
> +                              NULL);
>         parse_tree(tree);
>         init_tree_desc(&tree_desc, tree->buffer, tree->size);
>         switch (unpack_trees(1, &tree_desc, &opts)) {
>=20
> The double-nested ternary definitely complicates the coverage here.
> It also points out that all tests have `info->commit` a non-NULL.
>=20
> This certainly looks safe, but I don't know.

This is me trying to be defensive.  I think the code path that is not
covered here that can be is the info->oid code path; I don't technically
believe the other case (using the tree) is possible, although the
checkout code is complex enough that I can't be certain.

It would look like this, I believe:

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 4bfffa9c31..a69ec3c4b7 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -408,6 +408,25 @@ test_expect_success PERL 'required process filter shou=
ld filter data' '
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
=20
+		# Make sure that the file appears dirty, so checkout below has to
+		# run the configured filter.
+		META=3D"treeish=3D$MASTER" &&
+		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x=3D.r" &&
+
+		filter_git checkout --quiet --no-progress $(git rev-parse master) &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: smudge test.r $META blob=3D$M $S [OK] -- OUT: $S . [OK]
+			IN: smudge test2.r $META blob=3D$M2 $S2 [OK] -- OUT: $S2 . [OK]
+			IN: smudge test4-empty.r $META blob=3D$EMPTY 0 [OK] -- OUT: 0  [OK]
+			IN: smudge testsubdir/test3 '\''sq'\'',\$x=3D.r $META blob=3D$M3 $S3 [O=
K] -- OUT: $S3 . [OK]
+			STOP
+		EOF
+		test_cmp_exclude_clean expected.log debug.log &&
+
+		git checkout empty-branch &&
+		META=3D"ref=3Drefs/heads/master treeish=3D$MASTER" &&
 		filter_git checkout --quiet --no-progress master &&
 		cat >expected.log <<-EOF &&
 			START


I'm about to go make dinner, but I'll try to get a patch written up with
this tonight or tomorrow.  If it's more urgent than that, you may add my
sign-off.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--G9m07da55tKJni3T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsRu0AAKCRB8DEliiIei
gdJvAP9d6cRCl9QUtSztHRlip5W9KzG9tQyxThVLcUlmr05YBAEA5XxCdXg0Q77g
PCVWJxoxKXeG2EXLFYWuLYlhQheEkwk=
=9Cfy
-----END PGP SIGNATURE-----

--G9m07da55tKJni3T--
