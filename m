Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16C9C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 21:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382530AbiDTVdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 17:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381096AbiDTVdd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 17:33:33 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1A22E0BD
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 14:30:45 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B6A1E5A410;
        Wed, 20 Apr 2022 21:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1650490244;
        bh=G52tiHyZrpuLZ/SDLlVzyTjBpkB5zsuWmcYnuensYYE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fHtr65pIgRfHXg2/C8ReJrQPRom4dTxDIiMVwjyk+VQ+JsiH0I7dHXqZAUCcNAmqF
         cSU0oKK3UD9374M9im/gnp3FhiTEJ5eQ0VbK3CCZafF+EMLYiGePV9RmRhgAKbra5/
         4KqhVoDlWrA+JC48f2zIaJibEDhewslwkZEQZo9oHWn++1eFL+Ie4z8lXg4DzyxwEm
         vrmc141PBaV3IjQjdjI/XdDQbO2xADcY0b74mVhtB8C8Jxx5luFjkGJt2Hj3e7Lqvm
         sNoep520WLRTLoWuiXZ0P6g74q33wpBzYhg4uuD7MsBb54IAVPtMwTekou2tr/EHRi
         +baENB2ppQMRhjKZzBna1UWPBuo7U8onMYi5smgsaifdSvsDTcWYHf9jw/KGS77JxO
         PjaVYa/2bN+PZt3Zb2215jA+bKXi6zya3MNONJMOFmgRCo1hfyJPMuJB7Xe3wGjAGQ
         QVQStGV4XYMTLdGwuxP+7UQUrvA6NimEV6EJ67GuRkIAzItcMtr
Date:   Wed, 20 Apr 2022 21:30:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Daniel Habenicht <daniel-habenicht@outlook.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug Report
Message-ID: <YmB7gvfKY/0njjZy@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Daniel Habenicht <daniel-habenicht@outlook.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <f1647260b37d492d96ac92f8ef30a087AS1P190MB1750B08CC923A45E2C959250ECF59@AS1P190MB1750.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Su+4epPcnrrF9fnf"
Content-Disposition: inline
In-Reply-To: <f1647260b37d492d96ac92f8ef30a087AS1P190MB1750B08CC923A45E2C959250ECF59@AS1P190MB1750.EURP190.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.3 (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Su+4epPcnrrF9fnf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-20 at 19:45:32, Daniel Habenicht wrote:
> Hi there,
>=20
> I think I found a bug or at least some unexpected behavior.=C2=A0
> Please have a look at the following reproduction repo:=C2=A0
>=20
> https://github.com/DanielHabenicht/bug-reproduction.git-repo/blob/main/RE=
ADME.md

You're more likely to get someone to look at this if you post the actual
text to the list.  While I might be willing to look at it on GitHub,
other folks won't, and I probably won't get a chance to look at this
issue anytime soon.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Su+4epPcnrrF9fnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYmB7ggAKCRB8DEliiIei
gVUjAP9D25DjwW07PjaJRlk0cWIrTLSwvJ5CdI+K7GYv5s1G6wD7Bz3+60JET/oC
l8Ei06vK2ArznN3SdrOUQdwVmMi3GgI=
=IJa5
-----END PGP SIGNATURE-----

--Su+4epPcnrrF9fnf--
