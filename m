Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A481F453
	for <e@80x24.org>; Wed,  1 May 2019 23:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfEAXgu (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 19:36:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35794 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbfEAXgt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 May 2019 19:36:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D627B60443;
        Wed,  1 May 2019 23:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556753806;
        bh=i+QQG9ePnbvks0e+FzrC/sk/AA6+1FxPCiHif45zmoE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=j0BsLN6PIzPYGGOVVYHxeih9yOzX9IRhb6cfnRWFcqpYh72ubxxXLfdhSBMyL2/zE
         mj/26JmiHoUzQFWq6eELw5SoioiBGsYFo4/Jbj/fj0emf89ZI/J557TYVnn/SodwyD
         Y1FN5lmBSSDOaNGAzy5SuOqCNniZscKzxB7uqW2VMTR0BO7GUMNlaFV+6IdwlmHNFU
         6qgeGp1FKTBWNsjlHCaS46Oc28fk0sopbFQ9LZnzZ88wFYweBkgMooJw4q0r5cuG5D
         8yLkoSz7XoCVdFF0Ex8+lQeseaqoHsQjqT2ftjF4zSEiCNQfvTOz6RhTIaqN8DbS7O
         XsLsdv3OfylBUFayJ3jWYeFEhc4C143M/5S0n1SDfQekOpWzjIOc1OiYRezRDWHxJc
         irYo/AQCbVo+AUA1GWw3Q5mEnQCVQfTC/914lZD4mObSc8KuZeKPNNs5Rg652sBRrh
         gLrC0QgM+NAiV/O56CQahcRXfGGySVQsrbch5uqdnQpGEmkm+H6
Date:   Wed, 1 May 2019 23:36:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@i10z.com>,
        =?utf-8?B?xLBzbWFpbCBEw7ZubWV6?= via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mingw: enable DEP and ASLR
Message-ID: <20190501233641.GC202237@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@i10z.com>,
        =?utf-8?B?xLBzbWFpbCBEw7ZubWV6?= via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.134.git.gitgitgadget@gmail.com>
 <e142c1396ec3541486317819e885cf42be24af34.1556575015.git.gitgitgadget@gmail.com>
 <8e59dbf6-a339-74f3-4e60-e56b3817aea5@kdbg.org>
 <nycvar.QRO.7.76.6.1904301838400.45@tvgsbejvaqbjf.bet>
 <2e7be484-74d7-7258-954e-3a4a34a36c01@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <2e7be484-74d7-7258-954e-3a4a34a36c01@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2019 at 08:39:22PM +0200, Alban Gruin wrote:
> -Og also exists to debug[0], even if it=E2=80=99s far less known.  Perhap=
s it=E2=80=99s
> better to check for -g (and its variants[1]) as the user clearly states
> their intent to debug the resulting binary, rather than checking for
> special cases.

I can't speak for the Windows folks, but Debian frequently builds with
-O2 -g and strips the debugging symbols into a separate package that can
be installed in case of a crash. So -g need not be an indication of
non-production use.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzKLYkACgkQv1NdgR9S
9ou6FA/+MDPWCqJ5K2d57vpSU/Je2rzXOEucoRibPhXyiJ5tYKXFuZiLbkgA26Va
GB8beArNVgReCe1ooghr8/bw7Y48ewDgvojQmizhc9FKQvHOwPYl2g1/zkiUyisH
QUlLyR967qdv0gjM4GcFptNRjIwNRMYulRy5YAEJLxl+SXnPvnApd9qLX7obJWSh
bn0zIymFBMBjVIi5ChdsAg1ogV/eA7pXBZHxkJ+0OfqMzYr1tbdRUZG8+ReoE/hd
Xm3RRZUvXN4GkX0DMj0Lv2CQE2wLcyiw4QD1rkhg+tXth8PWkpdijsWdSeWviwpP
M8miAL2CPwzZ6R2ln7+WYq4GYqfkkryVDdg7SGZFBoieuJGMvRXEfsqk7MIeg0dt
bAFLC0egoV/CTGC+s/I35ZXx82fvrflO8IAj4KJW/Mc3mM2TBGgw7YF74E6uYwSH
IoJwZ6nJu6JsPehUvgBaXkIGjTd9XffkYWlGNVT1/aRbDNRBaMP4w53QZqsY4shC
VomWQk+uNEjUPFhI1QFgx4F7eY8FkPr32YYUFn40PI7mI8sO6uBCqapXcIJ0OJSG
qSXFrJoLPD35/atF53pBMzcQP7j0NGQqBonhecpyE2k03IgRyM1LUpt0r+1Ibc25
SvtRRNSZ6uC/cX3Hi5Y7xgipDBEe10tkKuzBi7tGbe3whtuy2CQ=
=bjd3
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
