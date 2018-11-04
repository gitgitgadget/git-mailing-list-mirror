Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3D671F453
	for <e@80x24.org>; Sun,  4 Nov 2018 18:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbeKEDyU (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 22:54:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53178 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727834AbeKEDyU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Nov 2018 22:54:20 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5930:2634:17a1:2ef9])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9E14D61B76;
        Sun,  4 Nov 2018 18:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541356700;
        bh=4FpGXN4fhbvU6gSNgomwDDnwpu9z/oVMfX89SgOIHQE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HLeWKO8M5x50taCCo1lO/b3nQMk4CCXa8Uk/6JC8YS0g53rXCPfOVYLX/Ts+mc0gh
         FE0iEPbfEmZjuv0QIZ4WfkAmAU8torEJQvEm8zVcNkHiRvrL6Ak9g6uUeK0f7RIE87
         /RoGMiBGq3PAXrZ98T5BTlzYRYi4LEOxzcHsKlUFuRZo9CRjiyZrMoi6r/Cx98vJNw
         h9Ksl2GVNW3Ovo45uEg2offJBO5tKe25maslDAyseN/BeLirPImQaxN8jAIxhW+HXr
         6pLXNEFcqsu4OSoLFHZ034AbQ8mgBbMYTV/NkfNK8newcYTJPfnBzhw2vNhpRHt50o
         B1xIjObg6U5Bc4P6hVcji9x05muq8kFRbDXJypZq4PiwE/PSPHF0h7worIk+0uLnx+
         XcdarzdLQX68W6PjAyFbdFkwbkrZCTxfLgbnLr7Q/D2W5X9fiy+2rH4Q9lLgs89c1T
         1r55ivSWDFUfrln4NjTKSPjktU71LzjU33nM2vTmxvRlfruCoqu
Date:   Sun, 4 Nov 2018 18:38:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?Q?Adri=C3=A1n?= Gimeno Balaguer <adrigibal@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-rebase is ignoring working-tree-encoding
Message-ID: <20181104183813.GJ731755@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?Q?Adri=C3=A1n?= Gimeno Balaguer <adrigibal@gmail.com>,
        git@vger.kernel.org
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
 <20181104154744.GI731755@genre.crustytoothpaste.net>
 <CADN+U_Nw5wCyK1SPRgsxzFbJ-KKnOV2Ub8YA3_a80SZYwKC5FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fU0UwhtRbpo05rnG"
Content-Disposition: inline
In-Reply-To: <CADN+U_Nw5wCyK1SPRgsxzFbJ-KKnOV2Ub8YA3_a80SZYwKC5FQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fU0UwhtRbpo05rnG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2018 at 05:37:09PM +0100, Adri=C3=A1n Gimeno Balaguer wrote:
> I wrote a "counterpart" easy fix which instead only prohibites BOM for
> the opposite endianness (for example if
> working-tree-encoding=3DUTF-16LE, then finding an UTF-16BE BOM in the
> file would cause Git to signal the error right before committing,
> diffing, etc.). That way user would be encouraged to modify the file's
> encoding to match the one specified in working-tree-encoding before
> allowing these actions, therefore preventing Git from encoding to the
> wrong endianness after file is written out. With few repository tests,
> this new behaviour worked as expected. But then I realized this
> solution would perhaps be unacceptable for Git's source code as it
> would violate that Unicode standard. Anyways, here is a PR in my Git
> fork with the changes I did, for reference:

I actually think such a solution (although I haven't looked at your
patch) would be fine, and I would encourage you to send it to the list.
It's my understanding that many people on Windows want to write things
in UTF-16 encoding but only little-endian with a BOM.  Allowing them to
write that, even if Git won't be able to guarantee producing that, would
be fine, as long as the data is what we expect.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--fU0UwhtRbpo05rnG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvfPJUACgkQv1NdgR9S
9otwtQ//ZtwQs1As0ikLMinv+rs9gpODoRQ42lBbYkeLXwGmXTfB89FrbvuxD3MN
vZMVW+JcjVO0jnEZrOaWWgRqCxgEAdT9EIAqRp/4QKH/N/sALQbNPSH2NV3t13h/
N5hzUazRMAionfPhPsadMn9iwYtOphQPasWMaI65DsFoIj3ZmrFrhs/ILuFhyvmC
xvyf8j3oEq+Zzeu0IZz5AlrTEr2jegiL593U2UHolZ+e8h1vJK2/7snEK6SgjCOV
1sD1Dl/tPPLTar82xkcuqrr9HkAJNrFzPn35U99dKkXZgYOreWBDjVi7TjytuaBj
gfAOscGsnxLHKGdAJcrreJ7hKOFIoX6AoQj76liHgVJamsIe1EdodTwppX1cfDwq
JAf0rqOKbkcFw474F5ie5BhaxlmFH3a9RIK/YAcn8din1dbHYNNU5fVcxTbjiDFt
hoABbQKZTwfQ+atYERVnTQbWkZNYwUfxio1ygoCw0nJlSOqaC89MCxE3EVdhWJti
yqTGP88l2mgRpl/dhc6ofi3wuV+ph+/vehoibgGLa7MVb3GUyuEj8vCdj7XFJWQF
smVNv3pW1Hamt1zThPI62Mpq12V2NPxLEKML0QqnkKtD33K8ZarAYjULNGnM9dR8
gl9UB1MeCLwIarmLDjob5HvlZRKxa8dLYdnDKMMH06GSVA3s4mU=
=FXgY
-----END PGP SIGNATURE-----

--fU0UwhtRbpo05rnG--
