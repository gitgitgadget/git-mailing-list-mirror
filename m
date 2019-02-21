Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732821F453
	for <e@80x24.org>; Thu, 21 Feb 2019 02:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfBUCSd (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 21:18:33 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34964 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbfBUCSd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Feb 2019 21:18:33 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5C24A60425;
        Thu, 21 Feb 2019 02:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550715511;
        bh=M3v3qNAA03/3Pubm8AF7LJwKaUDxJOJIYqV/vAFd0mk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zjtaUX8vsnmr6f2BRrkhXbpF6wrPil7MJlgi8MaD5WexZgy6O2qIBM+iGpUqL2Pyp
         lhtlN7CxxeHNsEHmfX3I/Qbk7V6Ceq/cgapCZlyJYzN4CZdGVnr0WmvBT6ztHQLGwp
         7vktpNRO/+fBxe4Nr5bd/GBGcpSWs7uYSRjfgKk+8+5YPzj4t4WWccdFzTZw3v+qyd
         Y7kQMPL/Q0n3hPpqviNlfgEUnHV8mJQNqI8pnyBMMbNHJxzT1b0+w0K7DGzXmrJlA6
         2yd9SS871B9T4KMO+9RkJLvT+9b57VkUkA1ozileZCy+9E+nI5OhdO8jq42sQywf6o
         jRngNoraC08zAP+5wBRsGoCCAI9ayLMtICG+Jg3Gul9TsAN3PWRIdgiKYRcVjQZFpS
         K0id0zTIFeswVHHGNSzgUsduk1T1AmTyXPGgjGFnm60Oftk601hydUZ6HS+Kz/u81G
         H3MD4rJt5eTZSr+7mFvZ3hSBsjKiGWonxb0HSOg/xYgttzU+Jwb
Date:   Thu, 21 Feb 2019 02:18:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mateusz Loskot <mateusz@loskot.net>
Cc:     git@vger.kernel.org
Subject: Re: "Submodule registered for path" output with config aliases mixed
 in
Message-ID: <20190221021825.GB488342@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mateusz Loskot <mateusz@loskot.net>, git@vger.kernel.org
References: <CABUeae_N3NFXn-E1+LHORL3RDf5iTCFn=zyuOo3c2Aot2QF7pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <CABUeae_N3NFXn-E1+LHORL3RDf5iTCFn=zyuOo3c2Aot2QF7pg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 05:51:05PM +0100, Mateusz Loskot wrote:
> Hi,
>=20
> $ git version
> git version 2.20.1.windows.1
>=20
> I'm running `git clone --recurse-submodules https://XXX`
> The command seems to run well and completes with success.
>=20
> However, I noticed strange output from git:
>=20
> ```
> Submodule 'Binary/A' (https://XXX) registered for path '!f() {
> ~/AppData/Local/Fork/Fork.exe $PWD; }; fBinary/A'
> Submodule 'Binary/B' (https://XXX) registered for path '=C3=80   =E2=99=
=82=E2=99=A6Binary/Intergraph'
> Submodule 'Binary/C' (https://XXX) registered for path '!sh -c 'git
> log $1@{1}..$1@{0} $@'Binary/C'
> Submodule 'Binary/D' (https://XXX) registered for path 'ls-files -o -i
> --exclude-standardBinary/D'
> Submodule 'Binary/E' (https://XXX) registered for path
> 'mergetool.TortoiseGitMerge.trustexitcodeBinary/E'
> ```
>=20
> I managed to identify where that garbage injections come from:
> from git aliases I've got configured [1]
>=20
> Could anyone explain what is happening here?
> Is there anything wrong with my ~/.gitconfig [1] ?

I see the right behavior on my system (Debian amd64/sid) with
2.21.0.rc0.258.g878e2cd30e and with master. I've built with ASan and
don't see any memory warnings on my system.

Does your .gitmodules file appear to be correct in the main repository
when you clone, or does it contain unexpected entries?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxuCnEACgkQv1NdgR9S
9osdBQ//dnssyhkUUGluK3Qf0pp/ITLJtH3wtTBKlQM5BauS7kc9ckrHykAY+PaD
LC7k3SZI3W7jNPDF/UQZHOFBJ7zEz9dkS/K8e+AInxY0QgNgY/lfoDJoZci60pvH
rmDt8ZAQI2jLow0BP+GmEcXl3x11pHjdEyaPHYizwm7UCpOBSIOYN7PPxFG2Ysvs
Wds/ac+CyNKyOeQ7JzszOEiwMTefi71bmTi9s1cseaNlVRiG/pZLyNyhIZohu/BY
G5iyO8crMfPbLq9VCJ3FGtNQQJsQ4Y2m3csywI8lxX/mRnrd0MwzeuAvN+LEO9La
nKCx2CBwdTo95AvTG7ubSKmnnLexnSbi4MXd+aFGwxB5LkDaRTIAZ7uORZbrnm6h
hB5oHMDNScKCywiODFewAMSAg4yP3mWY1M4+auLFDt5u0uaWpb90pvcIceQV+kz0
gtaz4Da7tFhlchKOBzGZOecaktbtcEafyNn6pQqMVt1kXPBL/WrAVbWrlD3vzBVQ
GsPex3ajeGkwPclAQr1BXKUWSf4FXPC9tFuTISxKOvYof1FEtoT2dliLH7YgiUbJ
Fhw+ve5jssaKumDUYeXwTcLNwK7iF9RG2C4ASgaO/OZ9yPqjBx6la8upWEatrehS
rwOu7Hs6LOlb0rK+qPaPhINLK8utALWKzbnS/NNUpTATBqZl7TM=
=y1bM
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
