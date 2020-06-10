Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C101C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 22:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B742074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 22:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kI4tRmwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgFJWwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:52:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39180 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbgFJWwO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jun 2020 18:52:14 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CD8246048D;
        Wed, 10 Jun 2020 22:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591829503;
        bh=gdHTmG96wD/Be5wvXD0OKfOUTTIiDPk1quR/zjX/HRY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kI4tRmwNl3S+RPi3PPngC1CLNMTQ67kdRbXgLIbcpGnvkpAdIj2illib217FmhTrZ
         68pCytNy7OHB4xc/bh1plyJvID8a2hsmUF8hmh4PZNz5biEFme5h/S32+lBAPTrr7F
         B6CABVMpfwxP9YGt91U+DuDm0H7cs5wi6JbFSNVY9ogOUOMOIx5mQT3odIrb0Up81m
         AqBn2jxqURRvEnqKzADRtp9iU2tLsi1gm4O+AVMooOm+fsuhYnJF43arn5jYIM+T4d
         fLTbD5L+ywS6w/5R6SupWd2OJb3evgGe2mrgDSbWKbn1617r7M4pEQjtha9T6+uFe2
         zQNOD7XkitPYuD+44/n7QFoQ8DANB5MM3XG2lsNpyRHvAvfy6IQvlUsZzbR4A0ZpSr
         MU8IzDFnnrxwSADWcKLEGEn9VxI5RPESReJulYk1+m/JqU4x7X7Qpisbm7r8DivYlB
         CohmzepZimhAJGpNuz7Xv9D7otKClGfWrCdAQbc0rWcEdIwcmtU
Date:   Wed, 10 Jun 2020 22:51:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Simon Pieters <simon@bocoup.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200610225137.GS6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Simon Pieters <simon@bocoup.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>, git@vger.kernel.org
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l4+/aJnPlhOv5JVj"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--l4+/aJnPlhOv5JVj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-10 at 21:30:31, Johannes Schindelin wrote:
> Based on the above-mentioned patch series, I have an end-to-end
> proof-of-concept (with one or two monster patches that still need to be
> split up) to change the default branch name to `main`. It is complete in
> the sense that it passes the test suite (also in SHA-256 mode when merging
> the `bk/transition-stage-4` branch), but it has a couple of too-large
> commits that still need to be split up:
> https://github.com/gitgitgadget/git/pull/655

I appreciate you working on these patches and also your consideration
for the SHA-256 work.

> Or maybe there are a couple more natural seams at which to partition
> those patches better, to improve reviewability (and to reduce
> reviewer fatigue).

I think if you can split out the automated portions into their own
patches, then it will be easier to review.  It sounds like you're
already planning on doing that, so I don't have many other suggestions.
I look forward to seeing the patches.

> So let me make my intentions clear: I do care about inclusive language,
> and even more so about inclusive culture, and I would like Git to be
> changed accordingly.

Thank you for saying this.  I agree wholeheartedly, and I feel very
strongly that the words we use matter.

> Tentatively, I would like to propose having this meeting in the coming
> week, via Zoom, just like we did the Virtual Contributor Summit last
> September.
>=20
> Could I ask all interested parties to reply to this email?

I'm interested in participating as well.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--l4+/aJnPlhOv5JVj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXuFj+QAKCRB8DEliiIei
gb05AP9asMfsoadp74VxvZQCu2x81Hpp5zuslzuned4hFvebbAD8DrX3fkJXRFGI
Z4q1TMW3YT67AvENhg03R3Gyf4FrQgc=
=P2q9
-----END PGP SIGNATURE-----

--l4+/aJnPlhOv5JVj--
