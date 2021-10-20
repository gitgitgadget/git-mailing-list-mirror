Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2E6C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 22:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4848F6109F
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 22:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhJTWUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 18:20:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37698 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhJTWUH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Oct 2021 18:20:07 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2057660734;
        Wed, 20 Oct 2021 22:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634768242;
        bh=rgpGfSgKIvVtzvGWe0WUdQu1bVsQghUBfthUjYBNXDs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HYyAIdieZj684gEvx4yuJGSaabzJEKEBOsBafTAVs7BrzbWB9hrFGc+M8pdS7BDum
         euX+MR095zw6Gjyx9j6E9QwdZCUc/1bwthv7c3MjMuD0YGpUFbSt5zNEVO5tcBYFhH
         XYItB13LnBPWCnapQ1uI1XkKBUjyZmIiRoUf8RBpNo9o14JYNXkyVyCA/CSEBMYHzJ
         6bjPNC0BsCNcbU0IZuFimZh5f4ywel1ZxubSgFuvDFUn4g/NYH1wO8whfVNtqQagrS
         di2F04338xnlHav3nZM3CwJ0/u2WRuxsCH4snG50u5UwCAzYNhonVqZ4a0A73LAmEe
         tHRmflo3b60hzvijf2pJH5ZoRgjed7CwD0+HkRrZWjD6KegXqHXPHJt5/0VarBnhsE
         BRJY8m6SLThfWWn5Uc+EW7hd/P2Cspmsnj1G42T3MNq/EiAVao2Y1l4h93GKEYVwKf
         0j22AVh4J0XC1456RLoLeZrnQqKE3Mp+xpw+JVfS7kyO+C0Yl9i
Date:   Wed, 20 Oct 2021 22:17:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/4] gitfaq: add documentation on proxies
Message-ID: <YXCVXvQYxVhj2aWN@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-3-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2110201357110.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MOXnXNfgDIcNMTrp"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2110201357110.56@tvgsbejvaqbjf.bet>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MOXnXNfgDIcNMTrp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-20 at 11:57:42, Johannes Schindelin wrote:
> Hi brian,
>=20
> On Wed, 20 Oct 2021, brian m. carlson wrote:
>=20
> > Many corporate environments and local systems have proxies in use.  Note
> > the situations in which proxies can be used and how to configure them.
> > At the same time, note what standards a proxy must follow to work with
> > Git.  Explicitly call out certain classes that are known to routinely
> > have problems reported various places online, including in the Git for
> > Windows issue tracker and on Stack Overflow, and recommend against the
> > use of such software.
>=20
> I fully agree with this patch, therefore: ACK!

I CC'd you specifically because of this patch, and I'm glad to hear you
agree, even if I'm sorry you have to deal with these reports.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--MOXnXNfgDIcNMTrp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXCVXAAKCRB8DEliiIei
gSnkAQDBfkLGNqKdSObiPQldNAHs9UlcecgyrlfFkbkY0l3scQD/W94tkvwsY/ms
QQzTLGevekDUR6S7PSQQ/jM2NH1maw4=
=G+sk
-----END PGP SIGNATURE-----

--MOXnXNfgDIcNMTrp--
