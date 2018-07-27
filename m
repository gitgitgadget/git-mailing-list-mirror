Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FCEF1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 20:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbeG0WWx (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 18:22:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38204 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389373AbeG0WWx (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Jul 2018 18:22:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f1fc:eee3:60de:bdd8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D78A16046C;
        Fri, 27 Jul 2018 20:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532725154;
        bh=nxbM8XT1alioEntpzyhKveot2xi1dM2RQ4aTqRpE0sE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xNU9uLxRo1TPEU8zGpUY/p5ecvE2Ll9gZ2oc/GwMMkTWxy/T+871DdFeSCm5f0x2l
         Hqq9pCsREMmF/WuI9I5G55CHclsAAybLfQxBrY2KCtGTvJyp+KN5ySS6jfTt24RIrx
         ggvpB3ldEI7gWm2tJVIVANjW1g5W+1rrfsfboCDeX8y1LqlCxBDU7M7RleTelrz6Xi
         Z6FakcM2woLsq1JPyIMR9OA1jKG6QNKttgtfpdBgTfsaHjZSCko6PUso5ydLVXt7td
         WnfBtIY0hQxGTPqntqz3yKQkh5BFGZZ+OhJuMlmVsbTBaZqmTIeEg5TbxUYDSXOI9Z
         5VRka/8Yu9xhYQnW6jTKdLzaBRRnMxxjfGf+R1lTzbca/4PiozIBKu6DoqcBo0XRYg
         Z+wTvnQ+8krwmMcQ0EgmFpWgcJ+/x2ksF80bXVe9wsMnLu4mIo1b1Z3o+gN729gMtt
         1EgjA2Mkd7OloOjGa/CuH19xoyaI1k+2+nfiO6C3707AhKNLR2P
Date:   Fri, 27 Jul 2018 20:59:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UGF3ZcWC?= Paruzel <pawelparuzel95@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git clone and case sensitivity
Message-ID: <20180727205909.GC376343@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UGF3ZcWC?= Paruzel <pawelparuzel95@gmail.com>,
        git@vger.kernel.org
References: <24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 11:59:33AM +0200, Pawe=C5=82 Paruzel wrote:
> Hi,
>=20
> Lately, I have been wondering why my test files in repo are modified
> after I clone it. It turned out to be two files: boolStyle_t_f and
> boolStyle_T_F.
> The system that pushed those files was case sensitive while my mac
> after High Sierra update had APFS which is by default
> case-insensitive. I highly suggest that git clone threw an exception
> when files are case sensitive and being cloned to a case insensitive
> system. This has caused problems with overriding files for test cases
> without any warning.

If we did what you proposed, it would be impossible to clone such a
repository on a case-insensitive system.  While this might be fine for a
closed system such as inside a company, this would make many open source
repositories unusable, even when the files differing in case are
nonfunctional (like README and readme).

This is actually one of a few ways people can make repositories that
will show as modified on Windows or macOS systems, due to limitations in
those OSes.  If you want to be sure that your repository is unmodified
after clone, you can ensure that the output of git status --porcelain is
empty, such as by checking for a zero exit from
"test $(git status --porcelain | wc -l) -eq 0".
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltbh50ACgkQv1NdgR9S
9ovnPQ//VZtmfcaXqaOYHDjguYq7m30rV1U9fsSIEe7yRpSRpyXy/cIlrGn7smDk
jMuj/gIs7rVLKYCeJJTaF0vYsDSzlqHfsP9WpNkdFnn2q+ZghHdp7Tvt0xO2BE1N
hYhTBWpPEC+4mH8/LnhkY5nDcd8U4pOzxSDKyupxDI5UXxvEgOV3yarOJglPHFmH
gZ9gBx6m1RBJczghH4nTdQzY5xzw8aGp20UO1WqR4L+/9srKgx3u6eL+uvoEmcA7
vVH8xSXIVyQqPpyuZQluZ2Qe29hZfuHwbiK2opp0grxKIGivWydoI2Ncu5WrpILo
qZUdbejmMvPzjeeshHUj0H3No7ZPzwCkSlCquDbahkS4xvxGen3dNYWNTibKsxCJ
ED2bFEECSlFnlgfN2AQd1AsNxfZ9WRWtSeQs1LTgIJfHAUaTFWED61G4B4px5uws
U+n1Pn3Fde/0a9FRWHqrzvZFWqblJZBYk/HN1hIJyZOfsryVBv0D/fzJ1ENnNyRp
w5tbbHUvO3huZ8+38lsa3uAIWV+V29EW7LVpEUDnuHdm91avhhfTwgB1/mYaTMLa
JSh0k/JSYmMtDKk9vZ6OxZO3NW2bGsxiu+wvXPTMgs8JdeVNMiOp6RfZD0EmXVjY
FOtuq3HLW0KahqqB0xLUhebW+rxUBw+wcdsvrB3Gg5YFxF7nnuc=
=T79W
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
