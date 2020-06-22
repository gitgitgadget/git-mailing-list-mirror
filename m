Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FACCC433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 19:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D5C20767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 19:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pTug6ZS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgFVTla (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:41:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40080 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728447AbgFVTla (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 15:41:30 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B4F2860436;
        Mon, 22 Jun 2020 19:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592854889;
        bh=zEYyN+tNGWIRtVWrt56UyQUjwU2sDTzXJQ8vVCUazHU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pTug6ZS/zdTUQUDzY/kF/X3yzy+idDBWZQZACurs+LQZdzvlTUkAdOEIkblamlA8g
         K4psjytKEENb0qupIajWY74BaDJT6TvR+HmbeDM70M1+wGAn4TiaGyHaO7AQS83BhC
         VIu3MO9og63Afy02LTtgz4bNcpw70RwCMrfqEDsVOX0wAQvpjQ6SjAA4vy+Yk/+Fti
         oYqORE9nKV3KFhPvY+tv853pZvL9ZEoJegMbuWik5J4UD3JIgLemk7RG0ygGRZMq5B
         yfho6om/aVWkiEP+2aufXWw4/W72yLpNpdCCgSddc2M2THq5K5WjV/6WSFhEhIn4i0
         RBXP1/aGhUOMIDTvq5LPgFc6phbbt68jJ3uEOaXMYSANYgDdlnMPMjxZGsrD65CDYm
         0H6fOSD6IQXzNe701Azs4Hst1rOWfZ6YAXADoQwKyQIKlgWUCUCoNfYeY0TUKEF7Ys
         ooo3nheRrmxaryQ1ra0PSEG1w+EBekyJjt82xR+HYxwOniCITd7
Date:   Mon, 22 Jun 2020 19:41:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Tiran Meltser <Tiran.Meltser@mavenir.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Amir Yosef <Amir.Yosef@mavenir.com>
Subject: Re: Request for adding a simple mechanism to exclude files from Git
 merge operation
Message-ID: <20200622194122.GN6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tiran Meltser <Tiran.Meltser@mavenir.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Amir Yosef <Amir.Yosef@mavenir.com>
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R92lf0Oi2sxyK3LA"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--R92lf0Oi2sxyK3LA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-20 at 18:21:40, Tiran Meltser wrote:
> Hi,
> This topic is quite common in various use cases (e.g. production configur=
ation vs. staging one) and there are quite a few talks about it in the web.
> Nevertheless, there is no specific solution to this problem, only partial=
 workarounds (including the famous merge driver =E2=80=9Cours=E2=80=9D).

In general, this is a hard problem.  When you perform a merge, you're
asking to incorporate changes from both heads against a common merge
base.  What does it mean when you want to merge two branches together
but not make any changes?  Which version do you want, ours or theirs?
Normally merges are symmetric, so if you want non-symmetric behavior,
you have to define what it's supposed to be.

In addition, it's probably not the case that you want _never_ to modify
the contents of a file on a merge.  For example, if you have a feature
branch to update the production configuration to fix an issue or add a
new option, you probably do very much want that merge to succeed and not
be a no-op, so a configuration in .gitattributes may not be helpful for
your use case.

Because this is such a tricky problem and there usually isn't a
consistent set of behavior that people _always_ want to apply (unlike,
say, line endings), the general recommendation here is that folks just
avoid this problem altogether.  For example, your repository can contain
configs for development, production, and staging and a script can copy
the appropriate one into place based on an environment variable or
hostname.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--R92lf0Oi2sxyK3LA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXvEJYQAKCRB8DEliiIei
gcIGAQDnnmyfx1xe6ZhX7qa/nCTESFXvzSujywHNnnuIAeOOkgEA+XQyFMJywk4g
5XEdfEtvC08A1PT/gUcwogdm/BlTBg8=
=P4Hq
-----END PGP SIGNATURE-----

--R92lf0Oi2sxyK3LA--
