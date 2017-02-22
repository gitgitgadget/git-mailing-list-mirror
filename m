Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26484201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 12:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbdBVMcz (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 07:32:55 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40092 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932253AbdBVMcy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Feb 2017 07:32:54 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 255D8280AD;
        Wed, 22 Feb 2017 12:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487766773;
        bh=lWpnOENaDjQdggiPpI3XvcrVrKDLvcK6PGi04cA9DE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CsjdHO/Ns/DLvbw742qHoyDeWiCvTlMgPMOb7I2oTZN8gfohzUlt3SyVmeukc2z0X
         JGkt5S20cFiHy/SPLcfnZTZC7w1/yTQexv2638Bd1/7qicnp9Mx5apcNSb3VI02xBh
         /gb29h9DLCzio7u8fTR0juCNw8YYZckWfQqb5wVSMSmxrQySwFYrEP+oPTi7oxApFS
         VXCdIO/Tsfy0+jum9CKa39mPwUlvWOrN6BazFqTLE5HgN3P34sAEIrdeK9JQFDcLVY
         pAmy9pRt/Kgh+0fonWzAs4OSTeXN3APlgX/aBNOyKzljTEtzTJr070WlpcupwvulQo
         KEIfvmbLUco2oNi89usJzxQQ/K98+C+qQp1t6YUegpWa9ZkxLXnb4K4WniIJVlld1u
         dygW1qsZZWdf77T2thQXdgIIoMFU62Gku34WVfQ7Q7eixwmsuf3VbRNMHyS/33dN67
         ykZMNcsYcjzV9RRIS5+xNqVwGmHr5pqXT2fxK7dUvN0+lSiE/AH
Date:   Wed, 22 Feb 2017 12:32:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Casey Rodarmor <casey@rodarmor.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: Typo in worktree man page
Message-ID: <20170222123249.a26lulx3jwxug7uf@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Casey Rodarmor <casey@rodarmor.com>, git@vger.kernel.org
References: <CANLPe+NVs9sJ7XQqvMabPBLg3DxS2Fyrrg3AzvZPBoWTPpnFzQ@mail.gmail.com>
 <CANLPe+OaSnNb1jhAnFtMsOCfho0H7mHVHiXs7rqo6ZHNvRe3-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cxsd3acbtjza46n6"
Content-Disposition: inline
In-Reply-To: <CANLPe+OaSnNb1jhAnFtMsOCfho0H7mHVHiXs7rqo6ZHNvRe3-w@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cxsd3acbtjza46n6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2017 at 04:52:11PM -0800, Casey Rodarmor wrote:
> Hi there,
>=20
> The git worktree man page mentions the `--detached` flag in the
> section on `add`, but the flag is actually called `--detach`.

Thanks for reporting this.  I'll send a patch.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--cxsd3acbtjza46n6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlithPEACgkQv1NdgR9S
9otYCQ//Z3FpZp9YtE9JMHnU06Y2x5sysF7fdGrlavSWDKrgoXEev5WD7VXYDbjB
5xaeBKGcR9Olk0aul+LCQk6lDd17MlS7GgR2aj7n44sEzvc1WMjNQJXsmOVHIigN
dLCwtaVmnPj8pvyqBm0HlhhuBAoHeFrMJ+55JtNIsvIcO5URBXtOGgyYR1fV/LRb
sSwWCU5Se3+N+cw01xOxH9MI3+vlk3SLMBh0SBCG6OuPFgdX0Xn8I9PZUSOac7my
xjvrkTLNDhq4gQCXH08woPl826iYzZ3kI98tNOOjW4v4IytPmLnLVvduXQu3XJWL
AHUwFRnFZrLq4EhrL+4XMRZWxhTdIiX7GhNARWfP+EuDmL2AbfJRScu0QLP/md+2
w4O969s1Hp2apR/MOYJCzl06+jcAhEaoFhcK9IopU67t35Gh0irmSSpMArTSn84m
jGiZeYYgy1bJTPmBdDPRZOtAhy+aO7v0WOPaOPcFY6NRdMM9RhgZhqQCyfeGZRL8
4ozawsV6kRvPnYAgkv86sSmmK7H9KYjWalGLHGL5lvznaWXLmJDq9qKy0kWv7cLo
VFatP6Y9zfzK/5LxtQIoBiQTSlRRONieiGsmlk6SpOtkIovQrY34b5Adjs0C/7+e
zDOuTKGESe3xG6kFAK/2ZQno9kTHro92Q9GXxM1GEEHw1KWrdPA=
=jzWs
-----END PGP SIGNATURE-----

--cxsd3acbtjza46n6--
