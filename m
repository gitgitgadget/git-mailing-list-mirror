Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9569CC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 01:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69AA120758
	for <git@archiver.kernel.org>; Mon, 18 May 2020 01:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="d7MMlY4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgERBCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 21:02:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38482 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbgERBCK (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 May 2020 21:02:10 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B9ECE6045A;
        Mon, 18 May 2020 01:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589763699;
        bh=UvFuGdaY5Nr81v/NRoaL8jw6eCTuo0RsCTCseq7c5/0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=d7MMlY4tOs4W5E5bAWoVyC2gfzplcRo7hYCpZWB9wqh5o4b29R+w5GhTfFDROyEdU
         aEdZqunXwnXJsXg09YthvEhQXtfS4RDHGmYx1djA0VM6zjVeTjAYs/hyjaPekGreuL
         0VINexmnYpdcNpA2B3HcNvn6/ylVsMR1WbrbRrMqfGmraZ7WUdp375Yugfp5pjHjzW
         fmBnHwr629areTn4HM3AZJ5V4pgG9Smi0xn0EbAPvI8XlpZHS20VRhiMRO6xz7UZxX
         TLSdi0nf9oH2draoZiJ4lgNWINUNM41gG625bxUQtZ1XmzTC8S2aj3aL+BzM7CORy8
         oKS7bW5K4/ss3QIjv681Nv2JU5UV2d/XtzBBUuflBiLvpj29fJddtfTaBbMrAXG14l
         zMaaRpNJFjlkP6QRYJ/gwpC9AGp3ttaHj7FbVENdZdApMKw2EAFzS2fErNLoVPU27H
         fKDkBJaZRFq73yWiI+48PjnpqWz3plcXszJZzkuQUxVl0jI5Jdm
Date:   Mon, 18 May 2020 01:01:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     bruce <badouglas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: contents of a .git file
Message-ID: <20200518010131.GM6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        bruce <badouglas@gmail.com>, git@vger.kernel.org
References: <CAP16ngpd_GbfUkSuBks5jk2vskks5_SRmVHOmfaEUTLoWiD8hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yklP1rR72f9kjNtc"
Content-Disposition: inline
In-Reply-To: <CAP16ngpd_GbfUkSuBks5jk2vskks5_SRmVHOmfaEUTLoWiD8hQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yklP1rR72f9kjNtc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-17 at 21:58:41, bruce wrote:
> Hi.
>=20
> Hope this is a place to ask this.
>=20
> There are lots of foo.git files.
>=20
> I'm trying to figure out what's un a git file. As an example,
>  gets the drupal repos.
> However, I can't seem to find the drupal.git file. Even a net search
> doesnt seem to turn up a file that I can view!!
>=20
> Any pointers/thoughts would be helpful.

The ending ".git" is just a conventional approach to indicate that a URL
or directory is a bare repository.  When using HTTP, the actual files
are served from other locations, depending on whether the site is using
the smart or dumb HTTP protocol.  Most major hosting platforms prefer
the smart protocol because it can send a lot less data.

So there really isn't a single file; instead, there's either some static
files and some manifests (for the dumb protocol) or conversations with a
CGI client (for the smart protocol).  You can read more about it in
Documentation/technical/http-protocol.txt, and if you're interested, you
can run your operations with GIT_CURL_VERBOSE=3D1 to see the endpoints
that are contacted.  (Be aware that that output may contain
credentials.)
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--yklP1rR72f9kjNtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsHeawAKCRB8DEliiIei
gakdAQCfSUmfkFHiGHriYwW0TmTxa4aYsrtLF6uk2nCafI9O3AD+N+vX5+pfq4zv
4vCea9chMT6tl4O/Zd7utAyBFoNQLgk=
=tQlD
-----END PGP SIGNATURE-----

--yklP1rR72f9kjNtc--
