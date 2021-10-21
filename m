Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A72C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 00:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F2F611CC
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 00:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhJUAmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 20:42:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37824 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231424AbhJUAmy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Oct 2021 20:42:54 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8A24560473;
        Thu, 21 Oct 2021 00:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634776808;
        bh=mjgigpmBRqnkTIp9XR9UyMlSBDPSdra8sSaV4UxAjcI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EadR8WMXBhlcYZAocpB+SsFgajtDeT8ZBhfxvW32vO+fk0i0W2Vm2bPJWtcMfODth
         HxURoAwy5Dom7Or3jJY8wGodeor7l2LeCKT2FOfUJE4X6QgAHXbJLVg88bJHkgQzmr
         YlnJQ3B2jSZQ+6GSjMNZOlPkp8w7Fe+1dqkQ3dM04wCu4Mq8dBzoWYnOuKLB6Fmyiu
         8wqHZy83zOuIv9cCSqktaAYNHv7Eq5uvZmpL5VhpoWlz7oTswCbv/LqX2jjhJPaRHf
         Q8D7Hyue9/DDGve74ToWsNiKzgRt6hR6kINhHH+X0Sx22/mbs8ibzWRwphl0+6yq/d
         fT7UYiNGoeGaXCnpjmHPnPsaBNQirPgnKgDZ3c+BR7PJ3w98C2hVRR20RwkFb8Xlxc
         YEmLD1yAw6lCEOKsQvNqBaNsb0zaj+J8fofRhufiYC0jzjCW0/D9NoGpELySl6f9Wy
         Qntix9IrwsKvDcW1zewrPzi0/c7qO9oWxzy29PTsTNNP3OolLJz
Date:   Thu, 21 Oct 2021 00:39:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     BARDOT =?utf-8?B?SsOpcsO0bWU=?= <bardot.jerome@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Questions, improvements
Message-ID: <YXC20wWfiu0wHel/@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        BARDOT =?utf-8?B?SsOpcsO0bWU=?= <bardot.jerome@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <9ad3d241-5441-9fbd-76a4-7c47c6a1b70e@gmail.com>
 <YW85Gs8aU9rrBDOv@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2110201340370.56@tvgsbejvaqbjf.bet>
 <9009a3af-9d21-cad1-6a4c-e1a81ece6f83@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ACvb34RAtYH/Tdfc"
Content-Disposition: inline
In-Reply-To: <9009a3af-9d21-cad1-6a4c-e1a81ece6f83@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ACvb34RAtYH/Tdfc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-20 at 12:40:10, BARDOT J=C3=A9r=C3=B4me wrote:
> On 20/10/2021 13:42, Johannes Schindelin wrote:
> > A quite complete, cross-platform credential helper (included in Git for
> > Windows and enabled by default, but it also works on macOS and on Linux)
> > is Git Credential Manager:
> > https://github.com/microsoft/Git-Credential-Manager-Core/
>=20
> We only use GNU\Linux for our work, i see there is .deb, are they
> integrated in official debian repositories (stable) ?
>=20
> We avoid tools not Libre and not package by default in debian. (with few
> exeptions)=C2=A0

I believe this tool is open source, but it requires .NET Core, which is
not in Debian, so it's not included.  I don't know if it will work with
Mono instead, which is packaged in Debian.

I _think_ Debian prefers Mono over .NET Core because it is substantially
more portable in terms of architecture support.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--ACvb34RAtYH/Tdfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXC20QAKCRB8DEliiIei
gTCKAQCTSfC7wgsO2kZ7bKNovoJValk21nZpoVgF5aaxn62/5gD/UUInFj/qbmhQ
/1buJchTWlCcP/Yij7cvEuOhwnsJnA8=
=yVQ4
-----END PGP SIGNATURE-----

--ACvb34RAtYH/Tdfc--
