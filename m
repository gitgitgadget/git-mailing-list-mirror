Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A8D1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 20:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeBYUeI (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 15:34:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33814 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751826AbeBYUeI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 15:34:08 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5983A6042F;
        Sun, 25 Feb 2018 20:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519590847;
        bh=TW3oPWGIdJg3Ny1hapooXD01fUng9ie50+Idsa4SRk8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=biOZw7X+znwgeZfaHGuUq/OeQKOODDXeHLagtzUPlai1CZgUzkON/wSOq9WnO0I7x
         Y3qybqDcm5e3k9zkku8wXXT/tU08BoNayWUy47itjM85zBf11+b+1SfJJFUSgB+uM6
         M9x2a9odJUIi0dvwq4fdqEppxm9g/aHcxnIjQTcpxc07a/flnq+7bqTGUpzHl47IDD
         bYyThv6J9E30OlEE3yEhWei4kSj5Y1N5EiLpIT94bn9+idRd9dr1E/6mWk+zr0KPH1
         NaV7TiHc3RJD2X55biBjrnfOaJcdVMW5yfdqtc0ifdRhWfMXxIwNcVX5xgjBjQYXAU
         9qayOhRwo6g2l9kJlO5+1d5KUD6DIUbyGbsALxeF/a1VEHNvTnnOrHBZhMdlGgLYXK
         pSp6djGDA7SpheRohZYfrXdRuN7k6vicnQMkxdxUl3jxTg3OQFpc6PwB8OgiOeRJcA
         mH//MI3EPJplSdP2inV8Iub/ExUtrwcArnurC7GQhl85TlBCkbB
Date:   Sun, 25 Feb 2018 20:34:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sbeller@google.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v3 0/6] Fix initializing the_hash_algo
Message-ID: <20180225203401.GF4620@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sbeller@google.com,
        sunshine@sunshineco.com
References: <20180224033429.9656-1-pclouds@gmail.com>
 <20180225111840.16421-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Content-Disposition: inline
In-Reply-To: <20180225111840.16421-1-pclouds@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-1-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2018 at 06:18:34PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> v3 refines v2 a bit more:
>=20
> - fix configure typo (and stray words in commit message)
> - use repo_set_hash_algo() instead of reassigning the_hash_algo
> - compare hash algos by format_id
> - catch NULL hash algo, report nicely and suggest GIT_HASH_FIXUP
>=20
> The last point makes me much happier about keeping this workaround
> around until we are confident we can live without it. Interdiff

This looks sane to me.

Reviewed-by: brian m. carlson <sandals@crustytoothpaste.net>
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqTHbkACgkQv1NdgR9S
9osBLxAAxr4ndDxJqrHncQYqts2PoFayscOcr7WZUaoClbk/KoR3+ubAaLoC5roh
79G8wNCxeEybPbxle1h8a+jFRLWokAZ6sRqSq2tPrsKXaD7M9X+mhPXCKBndD7Bq
6tWDmCZesaCZRh3oyifJhxA6qApie/1kUJKltCcX4yadyqTazpEz5QQodWi2z85J
ih1cHV4o027GOhbR9OlhgF2I+KqfGlYhkiQrcxOPGZgOiajIUngdnZmhTHcaaEhb
LvnmON0XH02cuURzfceyuS93AQ1t1g1pRNfI3JkWAb5Lz/TuLnQ7RK8Ba/tMfTQO
+oHl3QJ4DfdN3B5c0s30Qku/HQtwq6W7RQGwDvjBAWySOjPmiLRwdEciCE2a42bg
FY7xN7pyBbzbJn0tT+obsn7tsLru8Hd/LQhVqoUlDZL9QUqIwKOq8tqCTPfdgobH
EdPHxfKy8Y10A7Z4WanuTOGDRzA0Q3IRrxdY+JSdsEiHlkbea7fB6HDCLkTozv2e
bIsvDdSTbM13yyBaklqd7SIIgmhYZryb0BUdIsWLzc3EowC+nsABU4nYLNWGlvh6
9Z7INnSkKLDy73/NlVc5o0AfXRlx44k/MI9GpSaz/mVsHTM3CWZ+KnDGVVuPiUKO
ETAAOuako62qoQwh3XViwf24a4L4cHNwZnoP8q4QvRKn48TV+h4=
=c0Zp
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--
