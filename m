Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7F2C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 23:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A07C600EF
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 23:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbhDOXEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 19:04:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33964 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234949AbhDOXEy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Apr 2021 19:04:54 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6AE1060744;
        Thu, 15 Apr 2021 23:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618527840;
        bh=8DJnjQ/EUUsE7R+b+MPv76ZLBXFXNK5g9A4fgciBzB8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Na2Ym4ovhFZH4eEXD2zAj5Gj77LRKC9LAMKL2Dij5oK803Dt1Sn+fM6PZvln7elU0
         EIADiTsMvDDjTNxJ/6SrK1+a0WhiIEnVzuECMpLu6l4WlchOMxWSna8K2K+8UXWWlf
         CjOpNKNHf2bWIuszYu1wyXD8kjs//f5VkXRZXXOXwQkM0h7C42S/dBdFi7qxLOvYUH
         w663tqBo6a0kn9C/VissDvGaH4E6IaDEn+mCGUw9rYM0Aif2AaHXcmqvRNmd/q87M3
         iV0oob4Go+fG+5oSaDP0Ohqofb8r898zfnQucfTONj3w0Mik4nJx/SIJW1hqzAmHk4
         MAbx8/hRFU3LyvgVMR85j/8rroIhyW7L9FqAHVpVrSralczqyXPOmdNRCxuEKiVYq9
         K4qMWiTz7+7k8/1BzbATumd6U9CI79TqKDnE5v2E16Y1XK7Ou791fK+thTglYdpvZa
         Z3i3z/BJvSAcP3kaZ6eZ3P7qHGLmo37gyKWWAa5J418lf/3Kklt
Date:   Thu, 15 Apr 2021 23:03:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/15] sha1-file: allow hashing objects literally with
 any algorithm
Message-ID: <YHjGWifub3o5Ynj6@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-2-sandals@crustytoothpaste.net>
 <YHf/mPIyHr+S2Fpy@generichostname>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3O7iumdy3UuljKHf"
Content-Disposition: inline
In-Reply-To: <YHf/mPIyHr+S2Fpy@generichostname>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3O7iumdy3UuljKHf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-15 at 08:55:52, Denton Liu wrote:
> Hi brian,
>=20
> > Subject: [PATCH 01/15] sha1-file: allow hashing objects literally with =
any algorithm
>=20
> s/sha1-file/object-file/

Good point.  Will fix.

> I can see that you've waited a while to send this series ;)

Yes, I started writing this series after I finished the origin SHA-256
series.  That had been completed for some time, but it took time to send
out all the patches, so it's been sitting in my repository for a while.

I had hoped that things would be a little simpler than they had been and
I could have been finished by now, but I still have some 150 tests to
fix, so I decided to send out some initial patches to keep things
moving.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--3O7iumdy3UuljKHf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHjGWgAKCRB8DEliiIei
gZXVAP4yPAYyb/vFCI2HlQUmvE8frESejsnbAKx2bmeng74prQEA/s5XjRDpUzVb
xeO02gAnQbH3NxZbRKhGgSKGPv7t3QE=
=/n63
-----END PGP SIGNATURE-----

--3O7iumdy3UuljKHf--
