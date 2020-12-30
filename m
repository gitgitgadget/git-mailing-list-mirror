Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEF9C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 04:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F28207B6
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 04:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgL3EWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 23:22:49 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42590 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbgL3EWs (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Dec 2020 23:22:48 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 91A4460810;
        Wed, 30 Dec 2020 04:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1609302127;
        bh=x2pdwAg07w9UenyWhOyQ5qnK+N9eFRxw6wXcTgRYYx8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uTNFqh37MTFJxkGP3SvDKxd7O5daiMcYkilpHdxO3M4MsaJL6zCjIPDfUOLnAKLjy
         T43fKugrU/QuubDnmN5w/FfdlX2YK9YvQoYpadPn0XppiIrKV/Mma9FADx9u2APABz
         h2Xtg209Y/YPC4tc7gZA3aRj67d6tqDf7IoTU2j+xjbAOB6iRgRLVkI8iD1bKLYFmP
         TJrLLeDGWxnOAALjx16z/JRVyOG8upr+RB7g8KIES1Y2NGsPA4fdo/1D3ArYv/byth
         6VNh22ggebETU+Bx/v0oaCQyfxeifyzbWN6ue4ce3rPpGRYriQEKcDFkGJJHl+mujQ
         Ei1QvbB2ay3ZjX5N9ZqP4vO4A2AVj5XFlRhUiuAcB3Opylrn+lagCTXgCsxqsy8E0K
         7k0zE/tYp1Ng2s/+Pv30CE6CR1hA0iDHVVsUfNj9gk/9zL3S5YwnTQ5vZI4rvgE41e
         NUc3Fz/6sEd7LBPGH0XHaKx5FgjfqthAxZ78YHKxYd44F5xObha
Date:   Wed, 30 Dec 2020 04:22:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] rename "sha1-foo" files
Message-ID: <X+wAahx00v9VqzV5@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <cover.1609282997.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZhbG66b/WADeVIUz"
Content-Disposition: inline
In-Reply-To: <cover.1609282997.git.martin.agren@gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZhbG66b/WADeVIUz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-29 at 23:52:56, Martin =C3=85gren wrote:
> We have some source files with filenames such as sha1-lookup.c and
> sha1-name.c containing a few variable names, comments and the like
> referencing "sha1". But they are able to handle SHA-256 as well. Here's
> my attempt at removing "sha1" from the contents and names of these
> files.

I agree that this series looks pretty good, and thanks for sending it.
This series ended up being a lot smaller than I expected given the work
on the transition, which is a nice surprise and also means it's less
likely to conflict with other topics in flight.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--ZhbG66b/WADeVIUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX+wAagAKCRB8DEliiIei
gaTHAQCnR0AGWYxaRIr/yW1yXUjQtNSJNSbE31/ns112Qugf2AEAxgW/6w7Wyxuz
xLxf0+wGThdfunoDLwsbascQLAiXJAM=
=XrdM
-----END PGP SIGNATURE-----

--ZhbG66b/WADeVIUz--
