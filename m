Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F221F404
	for <e@80x24.org>; Tue, 13 Feb 2018 23:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966137AbeBMX4v (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 18:56:51 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33180 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966108AbeBMX4u (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Feb 2018 18:56:50 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8B6416096E;
        Tue, 13 Feb 2018 23:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1518566207;
        bh=gkqpPeOB857mM+FCaHNrLKZJFHRu6Y7Upi9i1Mf6mNE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=n6I9PjSqdXdax3APQR0dk6Z5xDee6N6VVfsb8HBO5bhyROMSM3hoREPZoJucWkXI2
         atgaC4eqFut9/ySiAI/l5C++6Y87c+MfLzq+KtFl3bgzyZPoaLDQ86nPSLZt3qsBDA
         7/Yh66ZMUVnZVSkxdgKl2RvlojCYe41AmvU33f3zy8zbB0alZ/Ywe0l9+7jEwDLFaF
         SDNIUw1pgWLrNtCiddhtumSgWo9Wv4cqwD9RpWBwcabsz/gUKxFq6IKBBROeJi6CXN
         CA1NMDf3llCh4c1twrO3BL15EIec67tqpu0hztYqbZSh4BWlCFG7h1y2vJL/rSC0LA
         g1ky4zTkD+8Sp4QCYMM1n81L5vQSNLvhmgdMNWuQnfYnmuaB34idrFPvS4D2CTN46+
         mhj8at44qXtsTiVsH3xA/etgqfcaKQrPlJgAkjP+UezIpFcuu1l7l/te7TeBp2d/Ru
         Xw7svGOAqsVY+GQI7k0klpz6+0NA6479q6m2fzsOd0y2OGjgcWn
Date:   Tue, 13 Feb 2018 23:56:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] Correct offsets of hunks when one is skipped
Message-ID: <20180213235642.GD1022467@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
In-Reply-To: <20180213104408.9887-1-phillip.wood@talktalk.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 10:44:04AM +0000, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>=20
> While working on a patch series to stage selected lines from a hunk
> without having to edit it I got worried that subsequent patches would
> be applied in the wrong place which lead to this series to correct the
> offsets of hunks following those that are skipped or edited.
>=20
> Phillip Wood (4):
>   add -i: add function to format hunk header
>   t3701: add failing test for pathological context lines
>   add -p: Adjust offsets of subsequent hunks when one is skipped
>   add -p: calculate offset delta for edited patches
>=20
>  git-add--interactive.perl  | 93 +++++++++++++++++++++++++++++++++++-----=
------
>  t/t3701-add-interactive.sh | 30 +++++++++++++++
>  2 files changed, 102 insertions(+), 21 deletions(-)

This looks reasonably sane to me.  I really like that you managed to
produce failing tests for this situation.  I know pathological cases
like this have bit GCC in the past, so it's good that you fixed this.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqDezkACgkQv1NdgR9S
9otItA//YysCTzNa/P2J0mGUGgDXHiz4nVuitJInfZYSUT7Gpg8woZi4k+0yXqsW
xGFcmVkGzFmXux5kgTTGYHtFkaFUO3bZhK1DKqMYUOicPZnUsFoVVPqqhKYT4lSl
LJz75gvwJ9q2qsYFo59D1j+HPsgUv2jUdnfbbavvr6igMjndXaWUgbLlYcqMaPV9
33MgNfuV5ODBMWtTRftRwhPTmrYiXW6h0K/BLI1iazgSA7m5wNbQhEz5id6nOEmA
T3djsBy2pzvbp29fxyZqY7pwSVo+u5gUZo5AiJMt/QfiKvHx5eGWEKtdodHaiadG
97JSYR6fF8jDFHT9Sib50RxEiAHlocKcm6re2WwdYn7tsjoBuLEcVKDGabsw+f+U
KUjaGIoSqHvzyx49LynA38uzkYBPeykrroZRZvuQulgivFweJYxk9jEbq86cPoV0
wv1KJpalhwLqSSiiBLZPEPHHslb4tqrJF3t7SYNS5M3K4XTAykeFjsEWEfVeCwsw
KPjsKjNTtIv1A4yAO3ecWW2ajD2AlWQQCu9a0jyt5C0Uh0IWKGkBW4dpfD3h4/2A
pHmkVjB6h4vbukEyenhech/raG2RsUa5f0ipaaiZcHC3eBoDMnmeTAdJjdAjjbP5
wqb0NeyfWNd4y1IonKG9IKKNy19p9ubb/zqky/P2STRHTHzBx/w=
=7ozL
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
