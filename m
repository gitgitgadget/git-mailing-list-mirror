Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA491F453
	for <e@80x24.org>; Sun,  4 Nov 2018 15:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbeKEBDP (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 20:03:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53172 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729446AbeKEBDP (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Nov 2018 20:03:15 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5930:2634:17a1:2ef9])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 96B606077B;
        Sun,  4 Nov 2018 15:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541346468;
        bh=TFs2iiyuQP9o6UOsiegcroLpOIpuS7C2fvbjPrq6ir4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CqOzS57POzIpLrLUWc+DDezXRWT8NX3BNg6eKeqHPwg3r+3ZXjWRzOT9E35QyFHY1
         Z05/Z3eGuSijcHtzJXqa3wG8F4cUGyuPjYH59JKToTXg2p5zd4cSae94b650/dNNKL
         uHpBExpYhXVy2iTiVrbvqRCoada41gJcd0eJdnyVOaQF7f1SZOAJ6qT3YbSYfBrh80
         XgervCRp/l5fIZ3xcZKnVu85RxpUYttyIRjVFCeteu0JQAxsHuBNknooXc+0oPXAlP
         mPy+9e0FHFmLHIEepCwP/LHya9ndN1fSAQwD+rTPyi4K7AAcuPlDkghL95/XXpcYB0
         EhPhNHEw4Sp1NyBqfssGWnbeizZE0OpRL2yN/07DAfYqD1DqUvA0FTAATI1O5F/nQI
         pOQ7CFI9xKYL5enZbFQEEd3HFoI4mkntTVAJ2rk2CudknyOM5dI9FgKwEZdyjRkvDA
         MwlQ5PmLWv24bGPxbJWmb5oAFvVzVMPWefcI2ozhfn7Zl/ntgAj
Date:   Sun, 4 Nov 2018 15:47:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?Q?Adri=C3=A1n?= Gimeno Balaguer <adrigibal@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-rebase is ignoring working-tree-encoding
Message-ID: <20181104154744.GI731755@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?Q?Adri=C3=A1n?= Gimeno Balaguer <adrigibal@gmail.com>,
        git@vger.kernel.org
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k9xkV0rc9XGsukaG"
Content-Disposition: inline
In-Reply-To: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--k9xkV0rc9XGsukaG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2018 at 03:30:17AM +0100, Adri=C3=A1n Gimeno Balaguer wrote:
> I=E2=80=99m attempting to perform fixups via git-rebase of UTF-16 LE files
> (the project I=E2=80=99m working on requires that exact encoding on certa=
in
> files). When the rebase is complete, Git changes that file=E2=80=99s enco=
ding
> to UTF-16 BE. I have been using the newer working-tree-encoding
> attribute in .gitattributes. I=E2=80=99m using Git for Windows.
>=20
> $ git version
> git version 2.19.1.windows.1
>=20
> Here is a sample UTF-16 LE file (with BOM and LF endings) with
> following atributes in .gitattributes:
>=20
> test.txt eol=3Dlf -text working-tree-encoding=3DUTF-16

Do things work for you if you write this as "UTF-16LE"?  When you use
working-tree-encoding, the file is stored internally as UTF-8, but it's
serialized to the specified encoding when written out.

Asking for "UTF-16" is ambiguous: there are two endiannesses, and so as
long as you get a BOM in the output, either one is an acceptable option.
Which one you get is dependent on what the underlying code thinks is the
default, and traditionally for Unix systems and Unix tools that's been
big-endian.  If you want a particular endianness, you should specify it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--k9xkV0rc9XGsukaG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvfFJ8ACgkQv1NdgR9S
9ouZaxAAgWwJg31pJoUJg1SAueaIhLAmABgH5b5SU5ce/oCgt8FZvfFvA8hz1Idb
fnf+tU9+9Vu3HHjPdT8iYxnBX9QJ7VtG7G7KCxa3bz3rX//ejtrS444iW7RnC5JP
CiQpuT2g/jko9r+aZ2sHy+ST6c0oW4cPdaM+UIacu5giUdqTseH47+eZVQYvXdq6
0SCS3lqgfkyOqTlSr/9EuJaW86Jqy33cnX3fRifjI+XthIFnSps3AkIqmp4GID/g
6nf4ZYD8hG+7bdFQmmA4Zc1rBqWuZzbhlXo7vs6b2RT/IAZwrk/hbiD/NUmngDRu
bsAbJb9h935hawAqVk271jvcdWcTmd0ToWwV9dyCs0rBpTFbAbDwPZgcw8hJptxZ
HzrPQqUZrVsEroZo3ZQ5+j0YetEQzmGxfJH7ZrGyaJ4RwrFGiP40N16cmy4WOmI0
QDpYaQELz9wMUkAkjX1A+z2pvJXTmrJbx2JCYTvPr9pHOb14YAjkm5/RRkpOmBdU
/HxWaWOBC69fmkR5L9Fs58i6o3+m+d307Hs9/wu+4e+ENUT4dOqgfp4zbFMQiyx8
aVBNDfRhPC+5NV+kYuM1fu/lZS1qsHPsY1Kg42Mw5f6RT5oqb7RkflhLA01+3XTp
bBNAChXtz+mtoNcFg2RYFzbgCcoY9frncI2OrXxUc/OC9eSRqJ4=
=bIBA
-----END PGP SIGNATURE-----

--k9xkV0rc9XGsukaG--
