Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D09DA1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 01:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfBEBkv (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 20:40:51 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33718 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbfBEBkv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Feb 2019 20:40:51 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c489:9935:372d:73bb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8AD6960737;
        Tue,  5 Feb 2019 01:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549330849;
        bh=3+1i0NNJDA26QZNTr7xGWAVj5qufGl6ow4nmyrFdipw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JDHzIGzixB/Z82YEzLpVR7mNYUAyCUJaAkHTRIlUZNoSnxcFFT16vKyB5IqgVe5l6
         YI/dq+sSVg7zrWxvWhTJWMj5dNUZGlTVMd0lKnwrky+KWOM06iKE2O+Yz56g/kuOR4
         RaL6vcBS232vtPyabj7Makr62gE+5M41M25wZYma9w4Q7TeVeSFujIdsQ4xiW5x2V9
         8UjcINa3Ozr+W0XH4KVXu5Al9Th7ym4wmcfwLPdrN+0SCpyHsblCd4BN1dl1L+6OdT
         7rtHF7NcSXJ/WXkESCq4e8yibjpGEoND0xz0kg8BhhEBpURE7jZQA7w/gPPV5mCb65
         BNoCkw6K1OBLdpDg2LDi5zLVfWOjqdNpEDvW4vAG+IQRMiNp9P4DyrgFF8raB1FJLo
         aXQchnRo7GE63/Km75ukyTCY8cA6Otf/JRWgsn8by/It/Z4DuI4hvcxuyQDkgQt/Ka
         91FUPpnXRpvECKOr2uOlA2Kx6Scl/0hwWoSJxFqwzgQUBREmofP
Date:   Tue, 5 Feb 2019 01:40:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alireza Alipour <alirezaalipour517@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What is =?utf-8?B?4oCcdW5hYmxlIHRvIG9w?=
 =?utf-8?Q?en_object_pack_directory=3A_=2Egit=2Fobjects=2Fpack=3A_Not_a_di?=
 =?utf-8?Q?rectory=E2=80=9D?= error?
Message-ID: <20190205014043.GA527887@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alireza Alipour <alirezaalipour517@gmail.com>, git@vger.kernel.org
References: <CAOYf8At-gCD-Ctm9RevPLSkrfo+B0fj8oXtC1uzxAcntPp9ggA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <CAOYf8At-gCD-Ctm9RevPLSkrfo+B0fj8oXtC1uzxAcntPp9ggA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 10:06:05PM +0330, Alireza Alipour wrote:
> Hi everyone
>=20
> I have asked this question in Super User but I have not got answer. I
> have described details in the my question__ link in available in
> bottom__ but for more information I add following info:
>=20
> I checked one of my past projects and I notice that
> ".git/objects/pack" directory exist but there is not anything in it.
> Now I want to know that what is causes of this problem? And what is
> work around for this problem? And also I want to know that can I
> continue to commit on my current project and push it on my GitHub
> repository without any problems?

Can you tell us what `ls -lF .git/objects/pack` produces? It should be a
directory, but it's not for some reason.

If it doesn't look like anything useful, you can remove the file or
symlink there if there is one, and run "git init", and things should be
fixed.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxY6ZsACgkQv1NdgR9S
9osWtw/8DsKqsbFrkOenfCmBqclREYtIVi21HbddwTYKdTzvj4ZVVjP8JjN53ztP
0+6R/pdAb4VD781mUfw9mZgJqKHAr/SmEqno+D7fpNIP/60uR9h4bJd+xi4O9P7A
ZoM276a0kaUj9ISCUE8l4mAaQcT60k3PLU7kAvUb7F9sOGCn2yXZvtbrk6Y0pBg3
LCQ6HpUe5l9+Ips2o5jYEPFdwi2eXcEeCIWbCrBcUVZbIfa1CQvwmV8MxLducn1R
ehzOd1tPMd8zFdEIGdp4YDtp4Tj1hXqghVxZfyeNMT99HqxIqVnAJU61M4m8w4uy
ysOhZZjP8u1VpRpTMpQF2C4w9aF6KrvkmBabF4gRmQv2t7zy7PZDwrpg6CkIz4kz
i+xfdFE8YnvcznwOYPRc6sdHSt1H32XqgPQ0O/J5bVnB9Ch0IZmIFQGY9nWldxVZ
QzTRoR9Yi6b89uKvS+3qsZIzqPbM7nPe7rceKxg5lHmpzD5mhMHwfz+wjyQCaIMQ
VN3acdVhrjZ1julgL4IEYoxEPrgoWafqq9hq+e9L9ofjvvulAwVNDsyUMFGnStAq
+qUnOFsynBXXRVqr2pRxm8RJSIyFjzp9cLwGazq0fdbwiDLXNHv+4VN01T7z8h38
sV/68dlEY+Hs3mGZq2LdutYSaYBLFTadkoiQGEn108Gouw4oDJA=
=cDuF
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
