Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690B3C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EDE20719
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oVVnMlze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgDCU1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:27:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51550 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgDCU1Q (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Apr 2020 16:27:16 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 47F0E60734;
        Fri,  3 Apr 2020 20:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1585945635;
        bh=/vSTzQG4oAWn6JluNM0YRDdVykZBT6yIGSZXQ1qdne4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oVVnMlzeh9BNgBpbW+wcLc6indfPdsqV+R9bVyC1ZULZ39WcGwj6wagS3F4H6+ser
         w1nysm2zlm86keGv9/kkYQQKLrn24UE2WA7t2BdZ1JR3YUqXV7Z8TLnbXVKUOkB6CD
         FZ1PPNxE1IYVnqDMEgxIUMpQqYCqs6JCwBDc+B+XVMSMgTDTxizU6o0uFnzZA1H72r
         sLlq/DG17xzHgqzuOjVSU08M0JoB/BrH8UT9nwoq0gEd7SKYIUwXvw11oe0wdAEW16
         1kIomYk10QNW+pQcC4xvz54svzHZCIY+HyOjGBnl6uJdnRf0W3AxPqrD3iGWlUa87k
         45kqkLj9RbKYIpyFUdTBeCC3VXngATSlUs1zPfmvNWJBBb6NbFXtWvUF/nC3imBlGD
         M8ZnUtx+WQ7M53hhPC4sqHGpIL3R6Jmk16wrbvsTKELaKpXI6HJYkUtqRE+iCd7o0b
         eORuaV54zif3PL75b1W64CACRuuS4ehI6bgFJ+ZIkfdD6+CjDle
Date:   Fri, 3 Apr 2020 20:27:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     number201724 <number201724@me.com>
Cc:     git@vger.kernel.org
Subject: Re: The closing bracket is missing.
Message-ID: <20200403202709.GC6369@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        number201724 <number201724@me.com>, git@vger.kernel.org
References: <8d439c14-6b39-bbb7-a558-61c1e79ff1f3@me.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
In-Reply-To: <8d439c14-6b39-bbb7-a558-61c1e79ff1f3@me.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-03 at 02:39:10, number201724 wrote:
> command-list.h:53:69: error: expected =E2=80=98}=E2=80=99 before =E2=80=
=98;=E2=80=99 token
> =C2=A0=C2=A0 53 |=C2=A0 { "git-apply", N_("Apply a patch to files and/or =
to the index"),
> 0};
>=20
> command-list.h=C2=A0 The closing bracket is missing. In the master branch.

I don't see this behavior when compiling on my system, which is a Debian
sid/amd64 system.  Can you tell us a little more about your system and
its version, including what shell is being used for /bin/sh, how you're
building (with make or with configure), and anything else that might be
relevant?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXoecHQAKCRB8DEliiIei
gRRiAQDCxbeDQPM6UwRzbJKG+MXiK2dXKlpsa0bWf0b0aoTCtAD/ViyuUbOpg9dP
ZfYdeViRLFSe4hUikPBGN4lUxYJ5DAI=
=KrBx
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
