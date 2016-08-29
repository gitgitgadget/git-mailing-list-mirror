Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10ED1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 22:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756774AbcH2WZV (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 18:25:21 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41340 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756751AbcH2WZU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 29 Aug 2016 18:25:20 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1C620280A6;
        Mon, 29 Aug 2016 22:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472509513;
        bh=6zB6GAon/wlws+bZ5iAU6WxqXDdorcumXZzwBBeqIO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZuuqyQneQXpmHWC/frRhHoR0UWYf0gF+xuSqJfGVTb4dz/7F9qYa1utpmUm0ROGvo
         K/zhEP2Kn2OUIpET8wXcIepTCczuj83yxe/WoqGXwWvnQ669DBbfDABi9cnw+cjQBp
         URRfV3/OuJSG3xHVvzUlTIm240ovofAOi6dpBK6NC0RiDFlex5PA5ig/0gfVGqoudN
         5nTPWL+FvqZmKKru4dQI94TPffddt1uX0JZfyQZ5gITYzo1SvUyhzr5nrkw13jjRwc
         r9KlsVXghpq+lgDptfJdmiBqZK5m9DnyOLllLpvP8tgXHDf+LnvX1hWbVGxhiaUaxf
         l0kknIu9LcGsdjpmsqTzwhuCmzJAh5Q38AYE2veWdeAi4AHDHwIxX1Bdmq84KF56Z7
         1aDhEOkp9mdoubrbkZ6aV0nPu5NazwkcfGJ+KKUysnH2rst4EVg1RJReXZXED1xXGu
         6ZFPxCFtIn2FuN1QnheGmdpuxCRvWy1sLrxZV0E0esPfpnwCF4a
Date:   Mon, 29 Aug 2016 22:25:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/20] cache: convert struct cache_entry to use struct
 object_id
Message-ID: <20160829222509.nyms2kexdilwe7y5@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
 <20160828232757.373278-2-sandals@crustytoothpaste.net>
 <577f6266-42ec-6c7b-8b21-1e4997f2b816@gmail.com>
 <alpine.DEB.2.20.1608291743060.129229@virtualbox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rozgqzxfbqynjq32"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608291743060.129229@virtualbox>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-rc7-amd64)
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rozgqzxfbqynjq32
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2016 at 05:43:41PM +0200, Johannes Schindelin wrote:
> Hi Kuba,
>=20
> On Mon, 29 Aug 2016, Jakub Nar=C4=99bski wrote:
>=20
> > I wonder if writing this patch series (or rather the following one)
> > would be helped by using one of semantic patch tools, such as
> > Coccinelle[1], spdiff[2], or Undebt[3]...
> >=20
> > [1]: http://coccinelle.lip6.fr/
>=20
> If previous work by Brian is any indication, he did use Coccinelle and the
> commit message actually shows the definition used for the transformation.

Yes, that is the case.  I used Coccinelle because it's been used with
success on LKML and it seems to work for the job.  I'll make a note in
the future that it obviously the semantic patch doesn't include the
actual struct change.

My goal with using a tool is that it's less error-prone and it helps
reviewers have more confidence in the changes.  Also, it makes large
changes far less tedious.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--rozgqzxfbqynjq32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.14 (GNU/Linux)

iQIcBAEBCgAGBQJXxLZFAAoJEL9TXYEfUvaLwWIP/iQ9gRBBdK1FrsUCGBCVLw2V
0tZKQ4363R1Iste1vYAFaWhy5gPFvXIIHIcUAOrFLth8m5FKQEA7Yb3GzdoGt3Fm
BxIw/mUd2hjZJR0jRj8siPAzB1Gm90tIu13GcpCv81/Kkc4OBWfz/S9mBx9+PBbn
pLc6Ew3tj4qrDTrX/Aobt09AitLTQ3Kqsa5xBvIsv9q08haIYl6Xx2oIY0W9qSB1
bnTp75zh4BZszYxT9r27lhmNe0CKbgrvPJuff54k2zDi07W9YAhRHlyvLksg3rbN
jGT6kIticNXNubtotJYEEr1nOWggeQJ4MHcXRm9Nu9KYVbTY9n2GGuB3G1BN5xRe
EsCJGN80S2T9YwKF6Aadmd43dTRQlHSn5LuDmK2vBIaQVPTIQKCYidESJx+8rrm5
k0VWJ2yNIfI2AaSrtxfmlKfiAF7KcjpxJJMQhCgfhhnp1+2CO73hmv7fP1thb2Jx
PyD6LN+cJ8FqHDSaOQjTOVDP2hgTzlrTJFEDna1NLndivgHYsGHh3b1mHsCS7KBC
qxgcnZcC4hiOnSRVeka1DnpSewzNu/xVuycUWpskcBWdEKz1r1XMNOBYHEzQQ2uH
I4SxmwJBAC7NziElBO4y3lCy+bbBD9060Ulppe6nlAZuvkbjZfCF4bBYTCVn1E3q
qWND/+ETCZxwLzLACtgv
=JZeF
-----END PGP SIGNATURE-----

--rozgqzxfbqynjq32--
