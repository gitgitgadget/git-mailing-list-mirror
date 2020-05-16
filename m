Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2B0C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 19:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC1B20727
	for <git@archiver.kernel.org>; Sat, 16 May 2020 19:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="s6YoKhkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgEPTui (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 15:50:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38420 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgEPTui (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 15:50:38 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4F93E60427;
        Sat, 16 May 2020 19:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589658606;
        bh=969TN//DDB82oY3ZE44xTEGjwXWJ19X63RcrjyiqUSY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=s6YoKhkSAhdS1Qml4J59Ptdr1gX4dkN+GQG1RgKMVrITjiGomDRlyuTFCeZylEu98
         NWpn+4tKFG9OEtO7HPJfQpafEpVPUarJKePGMV7/RSWMFzzfO+EbQK+6T0DPEcxE0d
         FuK8TM3QrN01eHUs763cxgRxvTykjh5NA2La/lhdMG7jDnupHXde6IgaGnFnOATJkz
         5rnqZliMyXN6Vf/e0qf6dcuxEMeP+NKIOQeD4OFOtcxkaqb3vSnx4MActYRzI/xfKx
         xy2PC0dG3Zn+ydgzi+W43xmxzoUs7DxP8wDZDPolLVYN/QvB2CiIXko3nlgKt9OuDa
         67uQwX3lCIpaFbpoKHAT3LOqVm6wy3C6anaUfQu51ic6bRFHtcENkBCr643ln75LJa
         Q4J53ew2knbRpzS9lypaTMTXKwWUvC6fes6BbeK02QAxqbXiCBBqoucPt+eWndgprZ
         x+LtZb+Mar751JM871t+96tp9voO3koe1XXeecjTnJa10NoyBnM
Date:   Sat, 16 May 2020 19:50:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 20/44] t5562: pass object-format in synthesized test data
Message-ID: <20200516195001.GF6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200513005424.81369-21-sandals@crustytoothpaste.net>
 <CAN0heSqVrOTpSpptqe+zu+9-qQVYAL=jcx7tas3pNRcSVH+auQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline
In-Reply-To: <CAN0heSqVrOTpSpptqe+zu+9-qQVYAL=jcx7tas3pNRcSVH+auQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-16 at 10:55:33, Martin =C3=85gren wrote:
> On Wed, 13 May 2020 at 02:56, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > Ensure that we pass the object-format capability in the synthesized test
> > data so that this test works with algorithms other than SHA-1.
>=20
> Right.
>=20
> > In addition, add an additional test using the old data for when we're
> > using SHA-1 so that we can be sure that we preserve backwards
> > compatibility with servers not offering the object-format capability.
>=20
> I'll have some questions on this below.

I think this got dropped in the rebase.

> Hmmm. Isn't this an exact copy of the 'push plain' test immediately
> preceding it? The commit message talks about using the "old data"
> (i.e., without "object-format=3D%s"?). Should this test use a variant of
> push_body where we're not adding "object-format"? I'm not sure I grok
> what exactly we want to test here.. And does it really belong in
> t/t*-content-length.sh?

It is.  I'll probably drop this part of the patch.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsBD6AAKCRB8DEliiIei
gW6oAP9xggHn1WrhyscN5nOWvwJPi1JQTPczwGLGmPM3gCQjwQD/aNHYgDl4IwSf
AcD5xs0CUG7TWQHWx/Fpfbp1ibvvBwo=
=F6JM
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
