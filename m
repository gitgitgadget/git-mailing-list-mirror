Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1D4C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 23:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0224D20709
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 23:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xqhNhk1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgHQXM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:12:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42494 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbgHQXMZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Aug 2020 19:12:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E987260129;
        Mon, 17 Aug 2020 23:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597705943;
        bh=t2aGGP8OI9RYfCscZtNMX+FijW6Isxlhi8TqezlLRpg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xqhNhk1qAVe6z6GraHGtEEpZzVx0mEP0nazAnzvvl5mKkxF0sX6POZ6Nf7wGIIa4i
         e3OgCQtmEcB4uzKyiz3LvaBlOqqwPOnsSdgsDFGtrrVGpAB+Mhxf5CXW9gOG63nH3H
         km5+vBLEUxE21GsqnmWaBM5jy5PJHVtlJOlAwyvTRkpTq6zUCEJ57/WRDH65e+LI28
         dMLfpFqbqHAuvKVi8YZy8ZAFuZnuBcRiZ9XgQm0IYChqRszlcs0L9dbJ4fFvIX2mU2
         hgmK3ZN7eW1/EPRAVGez+jfiCaRQlMI/rXv+7GdUuIfn0vZi8/jhWSpDiLa4ra0w+s
         wsHXw919LIQUHo0fNeWyXY+sXtHfbvhXkofDBswXCOucyG3Ug8m2KzQel8/33H4hzs
         XX4xu/Fygxwqa9axUZ7gpbwaszW6CkiuPxbbd4IERXLDc0P8/QNG4HGWxXSH8xDYNH
         +jv2ZMqKG8Z1FuyXCM0ZXYgork/q0m5deHEVIhJeOW9/VVnD044
Date:   Mon, 17 Aug 2020 23:12:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com, me@ttaylorr.com,
        abhishekkumar8222@gmail.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/3] SHA-256: Update commit-graph and multi-pack-index
 formats
Message-ID: <20200817231215.GT8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, martin.agren@gmail.com, me@ttaylorr.com,
        abhishekkumar8222@gmail.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
 <pull.703.v2.git.1597673089.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WQ40utMgiyDduspJ"
Content-Disposition: inline
In-Reply-To: <pull.703.v2.git.1597673089.gitgitgadget@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WQ40utMgiyDduspJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-17 at 14:04:45, Derrick Stolee via GitGitGadget wrote:
> As discussed [1], there is some concern around binary file formats requir=
ing
> the context of the repository config in order to infer hash lengths. Two
> formats that were designed with the hash transition in mind (commit-graph
> and multi-pack-index) have bytes available to indicate the hash algorithm
> used. Let's actually update these formats to be more self-contained with =
the
> two hash algorithms being available.
>=20
> [1]=20
> https://lore.kernel.org/git/CAN0heSp024=3DKyy7gdQ2VSetk_5iVhj_qdT8CMVPcry=
_AwWrhHQ@mail.gmail.com/
>=20
> This merges cleanly with tb/bloom-improvements, but both that branch and
> this patch series have merge conflicts with the corrected commit date pat=
ch
> series [2].
>=20
> [2]=20
> https://lore.kernel.org/git/pull.676.v2.git.1596941624.gitgitgadget@gmail=
=2Ecom/

This series looked sane to me.  Thanks for the patches, and feel free to
have my

Reviewed-by: brian m. carlson <sandals@crustytoothpaste.net>
--=20
brian m. carlson: Houston, Texas, US

--WQ40utMgiyDduspJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXzsOzgAKCRB8DEliiIei
gTaPAQCKCJY885rHmJvUbG07UuoLWpkf93pa8IKupTKakp80iQD9EzJivM2KaZb5
1LJmrlIxuskPngQCOjMIGL3yhpdnMw8=
=Q6zx
-----END PGP SIGNATURE-----

--WQ40utMgiyDduspJ--
