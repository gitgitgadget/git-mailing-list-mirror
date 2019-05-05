Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE51C1F45F
	for <e@80x24.org>; Sun,  5 May 2019 18:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfEESO4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 14:14:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35852 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727628AbfEESOz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 May 2019 14:14:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:414a:17e4:5dbd:d3cf])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0087D60100;
        Sun,  5 May 2019 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557080090;
        bh=ySqskzKt5K4yYB2ntZzfsZjgyDg2Y/Oxg1rt+P/bRyU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=y/h2IbbhHEzD4N+XDKdRlnYDSA8MYdEXlViDKEA6oXK6OXISLZGXjuew/Njl/RHiC
         bdP9ZDM0vxBeWb5Vdfs/p7xhMYBYdkrEZTnJEnjh7WHeBfL1XWYFzHneRWgg8YP/E1
         nMd7ca+ywQdrobj0+AuezlKEcWK+NPtxfUTHz0HsEUiIG3Abb1HuTcH7X+c3vSkuLy
         sx7wbnHGwO3e3hiPuUfvPo2GWOnnStF4WLEdFfctg+9RKFppGLCC0hgcxCCsYpgOGH
         EXzU3Ty585SUlAU2b+XBgWGcAgl2gC4sGBN6n2wdvoyBXs/dofLxLub5SwAw4LYaO0
         R259bXAoch2+vEKjcCDhXUmeXknIgUx/aQv3j7ZYkzAKD8QuRSwBobTYYiyyN55G85
         i/op2E4lqZDQzHFAftm9eC4KyObgsyIeUUVwXqweiY1WtWwFcvwNaPmNkh0+LVfgLY
         CXDNZ2uzZ2GRdgIfB2Db6lhXkKmIK5wGPPwVw91lqyKQLr9ico8
Date:   Sun, 5 May 2019 18:14:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ax Da <discussion@gmx.net>
Cc:     git@vger.kernel.org
Subject: Re: git has issues with international characters in branch names
Message-ID: <20190505181444.GA7458@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ax Da <discussion@gmx.net>, git@vger.kernel.org
References: <trinity-aa2c53fa-25e5-49df-83f9-68f310683943-1557052051546@3c-app-gmx-bs61>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <trinity-aa2c53fa-25e5-49df-83f9-68f310683943-1557052051546@3c-app-gmx-bs61>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 05, 2019 at 12:27:31PM +0200, Ax Da wrote:
> The documentation doesn't seem to be clear about which characters are all=
owed as branch names.
>=20
> We have been using umlauts and apostrophes in our branch names, and both =
are having issues:
>=20
> - apostrophe:
>   git removes the apostrophes from the branch name when creating/pushing =
a branch.
>   In our TFS server repository we're having the same branch name twice: O=
nce with apostrophes,
>   and once without. And I don't seem to be able to delete the one without=
 apostrophes.
>=20
> - umlauts:
>   The umlauts are not correctly interpreted when SMB is used. "gem=C3=A4s=
s" becomes "gem<C3><A4>ss".
>   (See images attached.)

I don't think Git itself has a problem with Unicode. I literally just
the other day created a branch with a Unicode apostrophe and pushed it
to GitHub successfully using macOS. It is possible that TFS doesn't like
them; that depends on the hosting solution you use. If you're seeing
problems with TFS, I'd reach out to Microsoft for assistance.

It looks also like the Git CMD interface isn't rendering them properly.
I would try using Git Bash instead, and if that doesn't work, please
report that to Git for Windows. The folks there will have a better idea
about the portability issue that's occurring; I expect there's a wart
there somewhere between UTF-8 and UTF-16. It may also be that SMB is not
a good choice for sharing repositories if you require
internationalization, or you may need to change the character set your
SMB server uses.

You may also, depending on which version of Windows you are using, have
better luck at the command line with Windows Subsystem for Linux.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzPKBQACgkQv1NdgR9S
9otJ/BAAnp5vL9PElewxfa8WBIb0MhV23KNBeYlsbFIaSliVizBGLTPWGxmUpHZd
sIwIQ8xy9snYXQj1sDDstGYQtcsab/A+585kGS0LoRh3YEpcSMvKve/khIiYRs0g
qusQmTxYfd5jcGuhPOwbIPjHDBrc7g8wKcOBfApWRwyCCW+uLVqvAsxyGZzdhkdr
2DmOGO35g+Br5TumUJhj9XG1x5RMGUS5wvTWIYg5bhT+Q3iB/SqzVBwHs+c9PELv
a427opd+O8CRGv1neaZX8RRNXUzWoghk3jPQU9jWPLtzB/7xIwLrIahZ+80HhMI/
Ntc4M0ATm6Y1lWu9FHLafYMosIXBgvJV9u8yW2/49CjZyqT7Sya1XGpm9c16RFze
LE8GNRIGBM7rdRFUklEj8PJ3kqJejQqsJmgaQ5xjBb3Ltr2pnqG/C4X2TVb/3mIl
uYwf9hh+SGZXVLxEe91rSzIL2ERF07jL4CGnubYVNH3r+WCVbjZNYx+jr3o1Qdsz
UYSPQUcfOqAMIgOKXna4RnHGlrp6hbXwURW8G/yYLh9uLFE8nSSYw6b7AvHKiCd+
Hx5hD3qUqA14iLa1KTG7m6+3GeLomcsg4mYVVLGuOQQ81EztOg5w2DsIKXgvZvJ4
zyya7D/8TGK7lAKuradZcnFylsA+8zSXPZ9rea2DUZRfahQ5+zo=
=Leck
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
