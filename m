Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731B81F404
	for <e@80x24.org>; Sun, 28 Jan 2018 15:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751992AbeA1P23 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 10:28:29 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58344 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751632AbeA1P22 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 10:28:28 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D1ECF60FBD;
        Sun, 28 Jan 2018 15:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517153307;
        bh=YT1MDWt2WPNEh5vOC68/BmXXde+SYFe5auhrWZnusCQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QiaXkwdwQEiJbh3ijx+NImENhMeIOSqQXP0202dLguSwcv0Wi5lSb4UetNeJwTB8C
         2chLF3dGsAMgwlKzy+EYOpc0kLMmOjus3vtOIN51LHip9CsMpvEMxBWtJBIztsjoHI
         BjRSUOAwho3ZavYQpBtdXpNnUtHB/FXPVwKEpaTWgFFzj2s1jddH4Ovf0LDknoxSbM
         XQtIbzLqVgvMcuzC2rsq46Z9ruRz86c7AB2BjsZ8BdkkXGFzqp7ZUmYTKDJTUiqhCd
         FdxTNmn8ShLG5nFqTCAtAMvoTKh/rEU1RVgEa6OgEcfLHLbaXwUEV/zej8TtoAZBCF
         DJwTVE0x35qq7a7hn1P7zVv1hGTp32ooMrMqYWNaknOywcRIK5EbIDQ424BAXxzW+p
         5tXEy7nzOrk1wfiTyovI9GGNkGQDpNhv0o/+NE/6/is6JTWBixvSATyUboq5dzJ9Lj
         9RRCrto1T69SnHA5N14CQ3YIj2PUnu7nU8fryjW0j0z0lpl+vtJ
Date:   Sun, 28 Jan 2018 15:28:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Filip Jorissen <filip.jorissen@kuleuven.be>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cloned repository has file changes -> bug?
Message-ID: <20180128152822.GF431130@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Filip Jorissen <filip.jorissen@kuleuven.be>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BCFDB3A3-B515-4932-AC67-F720AEB4B0BE@kuleuven.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline
In-Reply-To: <BCFDB3A3-B515-4932-AC67-F720AEB4B0BE@kuleuven.be>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2018 at 07:35:49PM +0000, Filip Jorissen wrote:
> I think our git repository is bugged. The reason why I say this is the fo=
llowing. When cloning the repository, the newly cloned repository immediate=
ly has file changes. Steps to reproduce and illustration is at the end of t=
his email. Git checkout does not work to remove the file changes. This beha=
vior seems to be reproducible across multiple computers. Is this a bug? How=
 can I fix the repository?
>=20
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working director=
y)
>=20
> 	modified:   IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Fluid_HeatExch=
angers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPum=
p.txt
> 	modified:   IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Utilities_Psyc=
hrometrics_Functions_Examples_SaturationPressure.txt

This repository has multiple files that differ only in case.  I take it
=66rom your hostname that you're on a Mac, and by default macOS uses a
case-insensitive file system.

Since the two files aren't identical, one or the other will show as
modified.  You probably want to adjust the repository so that it doesn't
have files differing only in case or use a case-sensitive file system.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpt7BUACgkQv1NdgR9S
9ovxNhAAn4y6NEQ/yjdzAjXTj/lV9yuy9I9mWyQtOgCrMU+TNg/AMTFxUg5DXldb
nRcxLwyxv8aqN/TLvzth++/MWa+zcqTXuCM42p757mLdRAb4mKsLWliCXK2KjnWW
bh8clBYlhfRBCjiCRFZOYMApF7L7eMYRQb40JPBbPgivshVsxn9YZthQmPtvu3OQ
TXnMkgkYItmEhSw9VmPDna7erUCVrYx01jLT5kh8QPW8TVHHdV+yIuMyS6nFSIJu
5u0vZl8rT1ABJsEtNLE9lU/CZBQ+IjS3kZXtuoxZKpLYQs20hIwG6UOhGwo3FF4m
7mFE0F0OcjVGTTSTrAo+ziUtKsNxjUDB6TtXBp3ZaKCYZxbKh/ekPwU3M3t9qVx9
HRJ3Ey9Yyb3zxtbeCci/PLP78wSzeIbebjxIB3I4E8zL97F+2bpZ6IaUEhMKVsb/
NvfFnvzB9AGN0JYLe88j86wMBAkazUzvnqluJdjm7z3vTSs3KKceVIAeoJbYnkZD
VWGF71dgEAryVjfruDi7PCbCosJw7BI9LuCpC+7LAPwh/aYcXRMTEoeds0gF644E
ZwfPENTrAG0WmoV7xd4HfT9jh8ougI+9TtkLTK65ueTvy2zrzwrWVS3E2QbctqH1
TV7arLG6/rsiJTehYQL5KBndZ6DzdAkNJhD4eop7B3aEvA8TNh4=
=b/cW
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--
