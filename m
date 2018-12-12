Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0827520A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 23:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeLLXrG (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 18:47:06 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57692 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726790AbeLLXrF (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Dec 2018 18:47:05 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:34d2:59b6:3b53:e993])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D1A0C60425;
        Wed, 12 Dec 2018 23:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1544658420;
        bh=F6WxPaI4l4/l3pkjBit372XwmbX60pJjBgqIBwAfsJE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LbHu42lsucj0diZmiivtMD4Nui32IQMj3Ef8xXXNDuE0i5+phgek2tj5tng3e5Rx7
         zhgOJThZ79MczyjvtvD35kvqxSvx+kVMqRWtkBwF9ylMoBu56cjJ7Csyzczrdl84XR
         TTwmPgC5VRq4JMOaiQsnnXvvMD5I2sQLP7CIssc7obALebW6BvkBym3Og39XNAic7U
         SJyTKQH9we2yzEAR7frf8GpgOKNT9yv+0BFb8Vl8PrMIa8e8rZyvx8tJxjPeFcaZV0
         IiTXBE9YYi37PLfe8gDEHLa3Oxi+ftWWjFlF9j7FVTCEYZ2k1OhRLpP9vennCGFB6K
         MdRHUPEmM2BXtYsA9eMReOwBDvgKj//ds69dg3UKm9odSTLamCvk0F30rNKPclUcrA
         0sJtFPkcaJRDdhcsOBTd4dM92M6xAQWzBcUgi3S2GK27M8Np5bxAtX1+zG5gnYt1aT
         bRpy9GMthQ9wJ8XETVC95nqqYiFop4JeUIcm3O7VpwOLwH2dEN9
Date:   Wed, 12 Dec 2018 23:46:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     John Lopez <john.lopez@iarc.nv.gov>
Cc:     git@vger.kernel.org
Subject: Re: Git Repository
Message-ID: <20181212234654.GP890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        John Lopez <john.lopez@iarc.nv.gov>, git@vger.kernel.org
References: <3e8e01d49262$27e55be0$77b013a0$@iarc.nv.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lbYR4+J2RcKO0WXU"
Content-Disposition: inline
In-Reply-To: <3e8e01d49262$27e55be0$77b013a0$@iarc.nv.gov>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lbYR4+J2RcKO0WXU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 01:32:17PM -0800, John Lopez wrote:
> Afternoon,
>=20
> I am inquiring to see if you have a repo for your software where we can
> point our 3rd party software to automatically download your software? It
> requires CAB's not sure  if you do this or not, if so can you send me the
> link for future versions

You haven't specified what platform you're looking for, but by the
mention of CAB files, I'll assume it's Windows.

The Git Project doesn't distribute anything other than source; we
provide a Git repository and tarballs. However, others do distribute
various packages, and for Windows that's typically Git for Windows,
which you can find at https://gitforwindows.org/. Their releases page
doesn't seem to have any CAB files for download, but you could try
asking in their GitHub repository[0] if you'd like that format.

[0] https://github.com/git-for-windows/git
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--lbYR4+J2RcKO0WXU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.11 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwRne0ACgkQv1NdgR9S
9ot6wA/8D2dekgcXzxG/819X46Vfy+SOYgXCM7481gcrWmYRBHqbSNy3RnsM9Qsx
d0Hwvv8/Tv6SOJkjRLlPrTREaiYU17y/lyjmQ6Dmpd8OGHrhsuYWpB+uVDKPlemT
1x5hTPehjYRtZOW1fWoj8FpkMZlJEtwbv54iYfnWnRZ+LO4FLfRpRurKdG9y+GY4
2yepmelOgaUTzXxovd26ALByCT7W0fdHuGHjAiMin9qcnggLAi2fQGmpcOyo+ZGu
9hbq8jEgxowz0ieGEI5aOUDyR3D2sVfchoAMRFCsssQVV8CZGs7RprxLYKr1gIh+
jsX2zIjSDXw1cG42GnaZbHcrV6M/b8iaheGjhnU7OcFYxPwEKazXRMyGOsGVZekZ
6ifpxuHxUBK3S236EuFyANDqJpEd6hPL+fcSD9IcDNcfr0CzERphAxnzkPpZMnfR
d1o2hgjAHxBFxr11KigE9I7c9mDxqDjibxSs8irLes5EHeom/UE5JNj1TMyHvwbu
+2L2u42/Hc0ItZw8Pk+bcOypJNBtJVcfJPfQJOoukveDWzMaXZpRHE4gnnIQne3z
nqQm2O5qyutbLBEofXAeK9xx/O4MjTBmcmYtjTvdExKBK56rGwXvpcQ4YdhbL5pm
EW6YkHqeXx4OwekIAF9mNyaiNJrmV4hJyMeBqoKd5Q0buv7cXEE=
=Cuh6
-----END PGP SIGNATURE-----

--lbYR4+J2RcKO0WXU--
