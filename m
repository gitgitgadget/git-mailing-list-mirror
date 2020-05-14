Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B9BC433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 00:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53BC20659
	for <git@archiver.kernel.org>; Thu, 14 May 2020 00:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OF3ON7mB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbgENAvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 20:51:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38350 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729581AbgENAvW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 20:51:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B41766044D;
        Thu, 14 May 2020 00:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589417481;
        bh=Cw0JZxC4KupKAR2FH+w8tNiIWTjB9sj+9Erp9mqvJh4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OF3ON7mB0oullPDLZoGhP6IRLGtIxMb7G/OqinXuGkk8ZLz3bc1cuMo+ScVY8rVPO
         omUhKLSEe37IV+txxea5echPwKL80wwTcY7insCOkFOUKpqLUuM4dtv55az6wehMrC
         zdBCd2N9oKBNvdYqWxjg1a38VBHBUPw6VorecptvbiHKuRQO7/7fZv9qokIgg8kpyl
         QJzqUNuY9itmY4WEqOFklxkLELLrrDK4meA+lHS4QxWLWZw2H5RafeIMjG/J4B5CUw
         MOWLpENaYhF7uzqmB9f1hRRHcmC2BZ6JDTtjctXeNB4hzsPIRp1xRLaWP+7EWHeSTU
         /MU+hqKU6QKxnjhDWg8BDOoHtq8ZUi/raig8K79PElcegkyPM/kHbvOeLNXiEYcaPd
         xLg+JfUPzSgWr7gjK1uSdTZ2fRXC99HTqXtDrBWP8pqamMOpuCzd8xwcElmu6hWbRz
         5+s6+/U2Wc4RIgMMKSgkILo+xPKwRaAJg+p0wFw9Bc6MhyeznsB
Date:   Thu, 14 May 2020 00:51:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mark Wartman <markwartman1@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to Not Track .metadata
Message-ID: <20200514005114.GH6605@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mark Wartman <markwartman1@gmail.com>, git@vger.kernel.org
References: <DD111BBE-F04A-4E44-99FE-5672FF2934B5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZYOWEO2dMm2Af3e3"
Content-Disposition: inline
In-Reply-To: <DD111BBE-F04A-4E44-99FE-5672FF2934B5@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZYOWEO2dMm2Af3e3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-13 at 23:51:44, Mark Wartman wrote:
> Hello,
>=20
> In a sentence, I cannot get Git to not track a .metadata file.  How would=
 I correct this?
>=20
> Please see .txt files as the mail system would not allow me to mail it.
>=20
> I can say that I did try running: git clean -n
> I realize that the -n is for a dry run but it did not return anything any=
way.
>=20
> I am using:
> git version 2.10.1 (Apple Git-78)
> OS X El Capitan version 10.11.6
>=20
>=20
> Thanks,
>=20
> Mark Wartman
>=20

>=20
>=20
> I have cloned a repository that a particular .metadata file was pushed to=
o.  This .metadata file seems to be causing me many git conflicts and other=
 issues with Eclipse.
>=20
> So lets say I had a folder named rev.  I navigated into the folder rev wh=
ich there was nothing in there to start with.  I ran the command:
> git clone https://github.com/BenArayathel/0427Java.git
>=20
> So now 0427Java lives inside of rev
>=20
> Then inside of 0427Java there is folder called usf-batch-workspace
>=20
> Inside of usf-batch-workspace are java projects that I and my fellow batc=
h-mates work on.  I have a .gitignore in all three of:
> java-project, usr-batch-workspace, and 0427Java and all three .gitignore?=
??s are the same.

I believe your problem is that the .metadata directory is already
tracked.  A .gitignore file has no effect on files that are already
tracked.

If you want to have those files ignored, then you need to remove them
first, by running "git rm -r --cached usf-batch-workspace/.metadata" if
you want to keep the files locally and without the "--cached" if you
want to remove them from the working tree as well.

Note that the files will be removed from others' systems when they pull
that change into their branches, which is by design.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ZYOWEO2dMm2Af3e3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXryWAgAKCRB8DEliiIei
gZUeAP0cbg/kDxWsT4V3zHShVby9mJL9UGv6LmpAE17LDEXq/wD/RWMm0VmwdZ3o
63MZzGl8FdgsEv6bHVHR4CCuny35IQs=
=wf+8
-----END PGP SIGNATURE-----

--ZYOWEO2dMm2Af3e3--
