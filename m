Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D5CC4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 16:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F090720658
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 16:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="u4lkz8BB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgCVQ7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:59:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59546 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbgCVQ7V (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Mar 2020 12:59:21 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 49FCF60478;
        Sun, 22 Mar 2020 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584896360;
        bh=H00b2oMUewVmunhjmaE3xcSrBT+G96b7nHX4cpoOFeg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=u4lkz8BB+dqJU80IUiheRYQgEtKv5e5qCx86pKhmqzBnVABKv42kSSut3oKg33Rdm
         oBbKIPl9V21Z9e8Ufha990wz2aHhAxRjBezaZr575tDPbioV62uuZpO83D76y1etNO
         sOKFKcY20Xf3NlqpCk1nCpDGVEJFCQGxEoKurC8o+nAF0uW8cIqTWkTo1mtDtFyf9a
         R47v2qJ48UWM3JUsqj0wBihcMtdnV6xr4SqblJs2CIwTcns5oIzDHeDejnyJXIh3RO
         tOyiDNDsnzsB9CIQ8OHOGjhXwiS93NTi6qzwDVswy6XUScZt5W57ftGGuyN40kqlHr
         0GYN2YJJRln0RjO3QAstK6HwADBg1PckvgIWP3T8H9zEMOLwgiTDu1ucp5t4iFR5Ry
         2HC5k3SCsutF1rkc68Qf2NfLzAsXMwe+hm2BEyUP1YjodyOPuWtnFJ/yCdf7X2MEMp
         B0xNK6jpuqowt3U4iBTDIrB0hr3mFDH9Z32lNvX7wXmTXbxX0J7
Date:   Sun, 22 Mar 2020 16:59:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?Q?Andr=C3=A1s?= Kucsma <andras.kucsma@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: GIT_ASKPASS absolute path detection bug on Windows
Message-ID: <20200322165915.GA6499@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?Q?Andr=C3=A1s?= Kucsma <andras.kucsma@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
References: <CANPdQv+tCnfy_csM8EwuqAYBtgkJ3RhRvo+ALbzO=BcZA7qJtg@mail.gmail.com>
 <20200322073105.zh2tqycu2fgydf3e@tb-raspi4>
 <CANPdQvK4LRZ2b_K0QuWErxNcc2wpW0W4zvmj3HzKDnOvgBNHfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <CANPdQvK4LRZ2b_K0QuWErxNcc2wpW0W4zvmj3HzKDnOvgBNHfw@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-22 at 11:44:33, Andr=C3=A1s Kucsma wrote:
> My proposal patch is to take advantage of find_last_dir_sep function's
> OS specific directory separator knowledge.
> I posted the diff below, which is also available on github here:
> https://github.com/git/git/compare/maint...r0mai:fix-prepare_cmd-windows-=
maint
>=20
> diff --git a/run-command.c b/run-command.c
> index f5e1149f9b..9fcc12ebf9 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -421,12 +421,12 @@ static int prepare_cmd(struct argv_array *out,
> const struct child_process *cmd)
>      }
>=20
>      /*
> -     * If there are no '/' characters in the command then perform a path
> -     * lookup and use the resolved path as the command to exec.  If there
> -     * are '/' characters, we have exec attempt to invoke the command
> -     * directly.
> +     * If there are no dir separator characters in the command then perf=
orm
> +     * a path lookup and use the resolved path as the command to exec. If
> +     * there are dir separator characters, we have exec attempt to invoke
> +     * the command directly.
>       */
> -    if (!strchr(out->argv[1], '/')) {
> +    if (find_last_dir_sep(out->argv[1]) =3D=3D NULL) {
>          char *program =3D locate_in_PATH(out->argv[1]);

This function (locate_in_PATH) specifically says it is not to be used on
Windows because it doesn't work properly there due to file extensions.
I'm pretty sure a proper solution would involve touching that as well,
although your solution does indeed fix the issue you reported.  That
function also uses a colon-separated PATH, which I'm not sure will work
in all cases on Windows (although maybe it will).

=46rom looking at this earlier, I think the problem here is that we're
trying to use the Unix codepaths (on Cygwin) and then expecting those to
handle Windows-style paths, which they aren't intended to do.  This is
likely one of many problems on Cygwin.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXneZYwAKCRB8DEliiIei
gQmoAP9XjS+Z9HDZ6Bn85wU9ZAP9BZPU7Sje4e8TIJ9KY+umBQD+Inz3bxJxgJi3
g5YfMbtTNq9DdUlLpfpdWMz7nwDRDAQ=
=Eh8y
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
