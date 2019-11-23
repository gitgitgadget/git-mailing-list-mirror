Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591FAC432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 04:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAB72071B
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 04:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QRSeD0Cg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfKWEQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 23:16:24 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47208 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbfKWEQX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Nov 2019 23:16:23 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ECF7560446;
        Sat, 23 Nov 2019 04:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1574482582;
        bh=BgE97FuWB7xoFYFZxtmKWKBGGjzEbZ/BLp61+i7MixI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QRSeD0Cg1UkSPeeZW+Z+S5eVQTw5NDnw5ScygyQ9p+8PFCe9wGy6u+tCwH+yndC9b
         Z7Xqawh8OrSfgQXDi5GIvCOb54708PVdxvtodbVK8RKuVbHUM63sHWxrBjlF9zDGbC
         Yjxm13+g7gCHXAQggAWig5XuBixXpEcIGZF+q37TjOy/Cya6Es3ZgO7/H102khXjOQ
         +PeOXpwOoNhIRmVK7umq7TuqlxM7kGcRfoVeYNQmqkQFEWsF37t2Y9wgH65Gadotj9
         gcO/+6AX3zHYXUUk/3S/CDloNgAP+hkKWMuxkuyXaCpRJL+uL2JiuEFD38W93oa13h
         MoflYcnwIb02gw6cz0gZY3J4ZjeTwAQaY2nQveMG1CwkvyvOyLSNJH4YMmwsdADcMh
         nZ9cYuNSHm/jZ4MkfynRO5ci4To31G5ljiPi2UGriCud73/oRda52F+S66E++aoIAi
         rPbdeO+rGyLjtyk9sq6Dbrpz7DpZN6XsR2mzjlK4A8dFCkVgmoR
Date:   Sat, 23 Nov 2019 04:16:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: Report of use of "local" per t0000-basic.sh
Message-ID: <20191123041616.GD6430@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
References: <03ad01d5a167$a834e580$f89eb080$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
In-Reply-To: <03ad01d5a167$a834e580$f89eb080$@nexbridge.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-2-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-22 at 19:04:19, Randall S. Becker wrote:
> Hi All,
>=20
> Based on the note in t0000-basic.sh below, I am just letting you know tha=
t I
> have encountered a lack of support for the "local" on the z/OS 2.3 USS
> platform except within a function. I thought you might want to know.

I think it's fine that we restrict the use of local to within a
function.  In fact, dash (Debian and Ubuntu's default /bin/sh) exits
unsuccessfully if you use local outside of a function.

Is there some place in particular that you've found we're using it
outside of a function?  I don't know about others, but I'm certainly
interested in fixing these.  It looks like we do use it in a function in
t0000 itself, though.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3YspAACgkQv1NdgR9S
9ot3tA//SKhaAIe7m4qX+3j6yGZgkMvjf7asgbCVk+XWUWYE3kaFoXhOPKbB6Rlk
TNfreIoNU5EH6ic3Iokz8Lx+SAJ78Z1O+/OMYpUSBah0eEXU3PetvJ5HthDz7h6M
eSYwz3cb+QJeQKJJTX0ZSoVRCUiwSzyzwBpcOnGhpCRgnRd0TsBMoWy1O5FAazSx
vlvEtl3XxhNf8ZBZP5b8VP4EsyoW2HeWumDRxndrLa+THTe/hYXEjlXtDrK1nQjc
gWw2y5feqd1AAIw7KwpYYutxjS0GY4iuBFoYn9oH/TUzSot1A64y8Y+Ce1ICQRDN
eeYXEiYFt/nCqeqZx+lukSIMLvwlZZoClpd8bIyeSVwZFkU95GRp1ExY4TLRCCPs
dzMRv37qNZ9/vuTvzhuoDfoYfqatd5wy56JefKNPKdoJyV3GseepEd6NWn/PDLgP
/C/wcUsruU+LM1twBiQshiAHetSVsNw5z+fHm9MoaQ0KHUdMkGV9+S7sikJZb+T4
27sEGpvmZGS34BnH1nnM6AY5VAZEan1psajeVjmU/lZaPtcDHg9YE0onaz/ZyVXF
GKe5Kd/7SKRwLHDsx1kqBb7NKTpC8lMhABvaPzJOc1HUBNU+V4FrW9QkKsNpxcoO
PkPzO1BqcPJ5VeFs15lHZ7lGLv0aM6BZon87GW/dZIQATFO2v+w=
=GS7J
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
