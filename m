Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5711AC2D0E4
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 00:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5152085B
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 00:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgKMAJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 19:09:04 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39804 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgKMAJD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Nov 2020 19:09:03 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 724B96045A;
        Fri, 13 Nov 2020 00:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1605226142;
        bh=oc1ufp+SivSe3BVGgb5hQ3S0g4h8n0zZ9Zn2ULBi1T4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wYrTQLVlK3AKgg41lF2l3sXSvjiHTVzxeRbvhlZMlTR5+DOf6ib56H1/RqpsKIBQW
         2BVwZn9rrjRZ3pHz6FFIh5S4a/cY1/RdeM1qnjjGIxf3qehS7xaH+d8PRtcppdVg2K
         mHJ0CANs9UwelTSagUOaPkgMPrl2sPjg/DIN+W0bf3/C/Q9z1FDpQeayPPevMEhgLB
         Cid3k4xE3/yO9l9DkLDFxUoCtU2n4632HWBqw/y6ZT0V0MgD8n1B8Q1yVtJ/w2FLlx
         eXQmXrgcRwDeE1PSQJh3hhqZworg886rlM2FZqQO6keY0wXrbPjBfdHlw2PTR7pL5P
         juCL+NQydG582PbBvuSrcKwK79L/xtw6kHNX00/5V6NOXYcWlr/Pps9n12lc0RVc3U
         So0nOwiYPPMmA2opg52PGxICWYNYSrRcTPfzem4pO2F9LaffHAXJFnO6BJw7l2mcUs
         oFItAhZKmuK5UjekXVtu33LM145wO1x9FEHFRTfTZwxldxOefGr
Date:   Fri, 13 Nov 2020 00:08:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     email nans <email.n4n5@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git bash limited to 64 windows
Message-ID: <20201113000858.GK6252@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        email nans <email.n4n5@gmail.com>, git@vger.kernel.org
References: <CALjz=4x=8dewN_Dx5jH+9M9Wt+g2cvJkxsx8E+a6QGxt1cAHZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OOq1TgGhe8eTwFBO"
Content-Disposition: inline
In-Reply-To: <CALjz=4x=8dewN_Dx5jH+9M9Wt+g2cvJkxsx8E+a6QGxt1cAHZA@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OOq1TgGhe8eTwFBO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-12 at 16:42:20, email nans wrote:
> Hello,

Hey,

> I wanted to know if this is normal and wanted, if git bash is limited
> to 64 windows at the same time.
> In theory this is not a problem, it is normal that there are limits
> but why there are no explicit error messages.
>=20
> For example, when I use git bash in Visual Code Studio, it produces
> output error '256' but no message like 'Too many Git bash at one
> time'.
> If we do it from a terminal, we get no message.

This is probably better addressed to the Git for Windows issue tracker.
Git Bash is shipped as part of the Git for Windows project and isn't a
part of core Git.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--OOq1TgGhe8eTwFBO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX63OmAAKCRB8DEliiIei
gRq7AQDB3PR7xMfHTMWHUy+XC2b/Z0YOK3kQZGoEP5WpcK0bxgD/bYQoQoDP+InU
kw2bm8NOQxnHGeCl3yJKCj6zGvuq1gs=
=nkjl
-----END PGP SIGNATURE-----

--OOq1TgGhe8eTwFBO--
