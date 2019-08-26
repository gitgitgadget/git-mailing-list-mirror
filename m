Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8FB1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 23:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfHZXPv (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 19:15:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58372 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726584AbfHZXPv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Aug 2019 19:15:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CC2A26140C;
        Mon, 26 Aug 2019 23:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566861348;
        bh=JXrNp8S/onTbIlOzgwtWJsC/VoS7XlmcGsH7pGGyQYc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Lfm8yU98SRT/yJO2ouU2KFqCjDjDSByp5apGDmO3Ahp1+31INPBAZdsTbpCLDbd45
         tr9oJ30/3gWz/50/sn4y0MxU8/Dp9BCzQvUDB6OjVyFfDQX9oltO+7zzSA4GpwLBJJ
         Xon0In4W3iHIEa/BJ/YP2I/FjeY8VT+z6exU8j7DFkhLhm27/lQUKYkynFX9yfkfjv
         gtMz7hZURXZqvLNrS9mTf3fej4qxJue7Dbjg5SVXvCUafCZ51LlwYdOz22ci2diCGv
         7AQvkc7RUV2j9q/F65BgztuEULloaK2nku1rcrAVW9xvo7t47TS96P0v97IUajDAhb
         XWHTpyFY8JQTDRRxP8/9C4vuUxgaTerPExKNFMIqudWuTgDuawMnLkVerruB1Pi3+l
         eWVWz9dMGPNpDnq8dhRaTqJWoAdkpxw9RzN1UF2PiNB0kviVj4uvZu25FTFASMAxAy
         17i6aUGUbRnWVE6NLVA1wf3TpwkCn4rufnI/dJkIN4+ZjL36q1I
Date:   Mon, 26 Aug 2019 23:15:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ibrahim El <ibrahim.el@pm.me>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] New signing interface API with pluggable drivers
Message-ID: <20190826231543.GD11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ibrahim El <ibrahim.el@pm.me>, git@vger.kernel.org
References: <tz1YiiRtWStGrH2sc42DyD-8bDtH1A52rOCCapct59Qos6jEikqscvusUs7QeOBRNmCF7L_AL1ezKurbTp6qEZCmEk7L9B28wH-TVQGBSdY=@pm.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <tz1YiiRtWStGrH2sc42DyD-8bDtH1A52rOCCapct59Qos6jEikqscvusUs7QeOBRNmCF7L_AL1ezKurbTp6qEZCmEk7L9B28wH-TVQGBSdY=@pm.me>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-26 at 19:57:45, Ibrahim El wrote:
> Following previous introduction mail [1], this first series of 5 patches =
is a re-write of the signing interface API in an effort to support easily t=
he addition of new tools with minimal effort and also keeping backwards com=
patibility with current tools and configuration.
>=20
> All existing tests currently pass with backward compatibility.
>=20
> [1]: https://public-inbox.org/git/CACi-FhDeAZecXSM36zroty6kpf2BCWLS=3D0R+=
dUwuB96LqFKuTA@mail.gmail.com/T/#r43cbf31b86642ab5118e6e7b3d4098bade5f5a0a
>=20
> The patches are ordered as follow:
> [1/5] - Adding Documentation files explaining the different changes using=
 a design document and updates to the configuration part
> [2/5] - Adding new files that define the signing interface API and also d=
rivers for the existing GPG and GPGSM X.509 tools
> [3/5] - Migrating the code to using the new signing interface API. Old GP=
G Interface code is commented and ommited
> [4/5] - Removing the old GPG interface and updating the code to remove al=
l gpg mentions from it to make it transparent to the signing tool that is b=
eing used
> [5/5] - Duplicating existing signature related tests and updating them to=
 using the new configuration aliases

I haven't done an in-depth review of this series, but I did point out a
few things that stood out to me.  I think the consensus on the list in
the past was that for adding future tools, we'd like the drivers to be
configuration-based so that Git need not learn about every signing tool.
I think such a change would be welcome if done right.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1kaB8ACgkQv1NdgR9S
9osqng/9E3rPpV4b06t/xAXAiac4z0Fqh7qvxgDA6UVjdzfi+oYXOdEHBJqS+nxE
pxAQkusagXt9qePbNXiY7aJ7SVL0pvtL0qTXjIZaHXy74WBU1daxOhI2dULGGwUv
26I5NF8XRq1JP9+TD5RK7iklyttFSCAQc1dNmRALTx4ot9yDv0IkNDqWTSPV0xtb
+jDZyUrWnUR5RxG91XGfM0P5/H/gOMb1j4d9ctMQni/ZGq/nSSwPmfTeyTstaP1U
3tE0WylF4p5QVNzYse6dnSBQkltZQBCpKMLVkVpNxVp6S4u2ZCZ+6hVN5g5Jh55b
meOL0OkIWrIHqmZYkn8rnkcamyJK28l9LPkvmGx6ZVKBpKli+k3RoOWzBj6sakUW
spnD2JrgFfoEUyawa6xAUg0puk4njXXhPGzKoTzieZqv6QXaVOaBDcjLdadRc0pX
3jX1DnZBhcebzfhBrPy/c+Dhnf6CMjgyoTz2b+Edv1q5DGMyc3L2N6IcAxLau4S7
SrrExYf1rhHzLNbvhQd5MtUJbqKukqmsfEFblijB6QiStrH8U6FH0S9faSDonzes
9SFAfbdiGgjwWwcPfw8NwGDD01UWRBbkS2kQqFBPEoXqLL+5A//BbjScTe+7UmpT
muUE1KrefoTma8YdO8ytCdJR+mLzxy1H1dspgg6XhumEYwWvKOE=
=FLVe
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
