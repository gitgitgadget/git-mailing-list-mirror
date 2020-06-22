Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32C3C433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 20:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986F720776
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 20:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xqSs2EiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgFVUoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:44:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40094 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728787AbgFVUoW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 16:44:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A856C60436;
        Mon, 22 Jun 2020 20:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592858630;
        bh=wMiv4r8IYEY3clsn2no4RJQPfFuf6daniOrzM5P81Ak=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xqSs2EiD3p62K3KNW2V36VxaGOtXB2lg5g5BukVNaivlk8/mrthmFp4ppYPhobQSC
         vX88+4HlDM5MHYT5lZxE+FUdo5D+XHZ89Z6+iVnKRDXTnsjVhHasizQGyxb8oYRoEb
         OJRDWTfGg3ko9pdmlKRZ4up4FDk/dcl2l2h3BxucpmLZIYzFQXKSHQq5RvjcybC/EJ
         bzVT/EZtOJZ9NH4/JpBvqwYvinP0e74qWHr5xutA7auzK6O9Sj/OiiSfj+S+LOQGLk
         EXI5Or46yrPNEspiJLqPuCy460Y+iv1JSBgNsA/UEYgQVi4GNyt1UHsZ3Ya+JLsd81
         i3JcFi/D7XiZw1qlUm34lTap6t8OmuQerwXlvHnmkVBCBfK8MSo2VsIXEHGWKTNAXe
         oLQspZ94+104tYpV2MQ4XM/is7ENeZVy7Stxf1xfos7CJg1nH9EVAbFynqXFoilrqu
         Qf4ZiOZ7mh+mBp8kMWuM9iPE0VtJMLvQ0OEUuVVKMuwOUXbaQgc
Date:   Mon, 22 Jun 2020 20:43:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael Ward <mward@smartsoftwareinc.com>
Cc:     git@vger.kernel.org
Subject: Re: Git 2 force commits but Git 1 doesn't
Message-ID: <20200622204346.GP6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Ward <mward@smartsoftwareinc.com>, git@vger.kernel.org
References: <dea24348-770c-1228-115d-23153fbecebd@smartsoftwareinc.com>
 <20200622202122.GO6531@camp.crustytoothpaste.net>
 <a42d038f-bf14-8f1a-927e-7488796e7710@smartsoftwareinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X78YbkCBd9ye7Cvs"
Content-Disposition: inline
In-Reply-To: <a42d038f-bf14-8f1a-927e-7488796e7710@smartsoftwareinc.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--X78YbkCBd9ye7Cvs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-22 at 20:30:06, Michael Ward wrote:
> Versions in use are 2.27.2 and 1.8.3.1. This behavior is seen with regular
> pushes.
>=20
> I'll look into the http-backend functionality. If that will help control
> that, we'll definitely want to use that instead. What surprises me, thoug=
h,
> is that even with DAV a 1.8 client appears to work correctly in that it w=
ill
> warn the user that their push is about to clobber the head, but 2.27
> doesn't.

If you can provide a set of reproduction steps for this, I'd be happy to
write a patch to fix it.  We should do the right thing for non-force
pushes in both cases.

I will say that overall, few people use the DAV-based protocol, since
it's significantly less efficient than the smart protocol, so it doesn't
surprise me that there may be bugs there.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--X78YbkCBd9ye7Cvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXvEYAgAKCRB8DEliiIei
gYLzAP9PaKaTBVrJqIZjFvxS6vOclmalLUJiwXFW8bWabVJrrwD+NUGqI/MMXEtZ
5hG4kRscvIQcO8zJ6atP4ZTWXHAKPQ4=
=Ex6f
-----END PGP SIGNATURE-----

--X78YbkCBd9ye7Cvs--
