Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC74C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 23:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3555020866
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 23:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JpIWDG6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfLTXSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 18:18:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41254 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbfLTXSr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Dec 2019 18:18:47 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 566B660458;
        Fri, 20 Dec 2019 23:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576883925;
        bh=rONb8Yt90UcgC3STbu996lIrANQLTH0ugO0nfShM2hk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JpIWDG6NqdF45CqRvY2gHQF7PZUsoQQFQYaGQD8hYTuGbSloG1FF27pSYNegjVe+f
         LEOz4UIWIYpsHcjtIQPp5NPQxz1Jm9Y2Y5WX7j40Bu5SHMLa8IXwBk3MnL784iyW1b
         MhUk4LsbRU9iyG8XVri0RHViEgZG6A4Vp9VB01zxLRSCjAYitCxeJodv7okhJEnvia
         OHiw9NyMWXoKJrzVCx8zLU+d7gh8rYlRBeyqVhpopbm9Y42yWyUWhG43SdNTB4jOVR
         2ii1M94mIgWuekmpPXxb3s/CSBjy/KBm4G4ylsKCatNyePv4aVZTO3gECmy5yBFPjU
         MWDU3MYeObQy21yuNnapf8FPFCSoWkRScLJ1IMP2XpUDGLbgvJ0dXcIDoSS0Y8d2fo
         BVpw76BNw51tn1tnqTWqK3mqOvuN2TZf+fbT1ROxznwWJApZ8FlLAn8pDfcctmyBfC
         qk2ArZq2j4jTtCcgxUbF+kTwK4F179RknfREYmZmr5JY6c45vdt
Date:   Fri, 20 Dec 2019 23:18:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Keith Thompson <Keith.S.Thompson@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Cygwin git with schannel ("native Windows Secure Channel
 library")
Message-ID: <20191220231840.GD163225@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Keith Thompson <Keith.S.Thompson@gmail.com>, git@vger.kernel.org
References: <CAAHpriOh=9Mh7_moxWCzXBHYTtNi9TOQQPBxa4CX=uLgOnpNtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
In-Reply-To: <CAAHpriOh=9Mh7_moxWCzXBHYTtNi9TOQQPBxa4CX=uLgOnpNtw@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-20 at 01:52:04, Keith Thompson wrote:
> I've posted this on Stack Overflow
> https://stackoverflow.com/q/59381061/827263
> but I haven't gotten any responses yet.
>=20
> When I install "Git for Windows" on Windows 10, the installation
> wizard offers the choice of using either the OpenSSL library or the
> "native Windows Secure Channel library".  (Whether that's offered
> seems to depend on what's available on the Windows 10 system.)
> I believe this is referred to in the git sources as "schannel".
>=20
> Is there a way to configure git under Cygwin to use the native
> Windows Secure Channel library?  An ideal solution would be a
> modification to my .gitconfig, but something that lets me build git
> (and possibly curl) from source would also be good.  See my Stack
> Overflow question for more details, including some things that I
> tried that didn't work.
>=20
> The problem I'm trying to solve: In my work environment, I can
> use Cygwin git for local operations, but I have to use Windows git
> for anything that talks to a remote (push, pull).I'd prefer to use
> Cygwin git exclusively.

I'm not 100% certain here, but I believe the answer is no.  In order to
use SChannel, you'll need to link against MSVCRT or a compatible
runtime, but it's not possible to link against both that and Cygwin at
the same time (probably because they both provide the same symbols).

If your constraint is that you need to interact with the Windows
certificate store or such, you could see if there's an OpenSSL or GnuTLS
plugin that will do that for you and then build against that library or
plugin.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl39VtAACgkQv1NdgR9S
9otYCBAAxbXa+Hby2FDLoka8QpLlGO6deJbgEDyaAJzQa9qKEJwGyG+uh8fbVuAE
7kfssHnSquxJI43TleNX1t8QGG7cagEUvJ30QjMMH5U6Ivqpubb52JRLffpG/1dT
B+gHg5zNAYT7exfwqKywMIeasUWriU6Bhz8w12RUSYfVYXtD8PXMKD/0iaJOrII9
46oFe5cLKTU+1VMgNIP7u5hhNM6yOv2tJBlba1deDwRj4KAu+EFXS6h/u/JFiRTL
leCBGf5MT2++rI88M3XDIIf5OhNq0K3tOfzTnnSp5s7MAN+GnTwLDuFGyWLAXh56
3spYI3Ktkf1AZCslFk1HZgeOpQze3tbb4Qij8H9vCZgIordBPR9DE3WNNuFlVjD/
Bl0k8KXRYHnTeZVR1JWb50N/RhLHkpGh00hYUk+hL3TTmX0DiI4cbj/1ZGvh9gLf
WTVC8U1384ZP6whLYSidjEGVu3dPRgt/tVGUZMNAMPJzjHZvmESbtVwLBF7FhNsS
ivESj0SbXvT8spywQtQCa70vBPgKgSqNWLJvZA2H4ocaFajZ+XhPsMmYNA2LeUNP
k5qFzkeAOvXtM9eT0wfKf9D1eYor1sJxuc1AdWXsCzw4XdiKkR5m1Cv95C0xPLWS
3XUm+/soXb2H1Y0/1sq3Jvx4ElYyRY/vETV1SYE+Vn+svlZeTp4=
=KQYq
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
