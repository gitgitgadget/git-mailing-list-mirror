Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BEE91F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeIVEKS (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:10:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36346 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726904AbeIVEKR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Sep 2018 00:10:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:68ab:e3d3:c0a3:4717])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 02A4160735;
        Fri, 21 Sep 2018 22:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1537568363;
        bh=DVxXf0GJ1hnO6JMw6ZYmcr1peeQYtWQ5w+4BIBTcmOQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=e+Cuz4A/db8lDHewXSY2tAEjgrX0RNViPK0g+/MCNnKBkVvZDyyXMJxHKFjd+9AZQ
         VYnu1lTDDYdcZJOM6B+BcJ8NwACR8LPX6CmLhaZhGkMNZOdu1ssO+YCLivV82UdcUs
         UmtIX9IGedSC6iaL8YwmzT6rrynTqaFh3jFOjUN9hTu1pZTZ9JzqxHAb+NhokU0w1s
         AFwx/1j9jwrp1w4GqhpBgjg2MBhLE+FM7pmzSGa2nDc0oK3M1ztkH9AjCwtbP3Dwgj
         9f6floUXP3P0RdkUZNVC0RuRgdAmsQZOnSHe6CcfkmdFpRQdspR7V4N2tv59ZoJx1x
         RVLGMYXqjGy+WLZDI0UV4h4vSEsAd4IHGN/YVo/qbNgs3KNOd8fPef6eeJkUqOqtUQ
         NYpTyB2xvQpT34nOoO5hRY6R14P6+GSEtfSoyD8Zl8gCJ4XfwIhiz6uqLPHGUOd3Yp
         wuFCXFooe9pGk6EgEjYG2iZmExQkcaIe0cv1IoxX9w94cLVDylH
Date:   Fri, 21 Sep 2018 22:19:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Add an EditorConfig file
Message-ID: <20180921221918.GB432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
References: <20180917230307.588334-1-sandals@crustytoothpaste.net>
 <xmqqtvmm42es.fsf@gitster-ct.c.googlers.com>
 <20180920000013.GZ432229@genre.crustytoothpaste.net>
 <CAPig+cTQuwMDMpHe4inO61=Mq2+q1OdGsEG_hpii+dNmjXHZLg@mail.gmail.com>
 <20180921023503.GA29606@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V4N4TvXMNzuFMHdo"
Content-Disposition: inline
In-Reply-To: <20180921023503.GA29606@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--V4N4TvXMNzuFMHdo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2018 at 10:35:04PM -0400, Jeff King wrote:
> On Thu, Sep 20, 2018 at 10:26:47PM -0400, Eric Sunshine wrote:
>=20
> > On Wed, Sep 19, 2018 at 8:00 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > > (I am having trouble getting make style to work, though, because it
> > > seems to invoke clang-format as a git subcommand, and I don't think t=
hat
> > > works.  I may send a patch.)
> >=20
> > You're probably missing this piece:
> > https://llvm.org/svn/llvm-project/cfe/trunk/tools/clang-format/git-clan=
g-format

I am indeed missing that.  I looked for it in git.git, but didn't think
to look for it as part of clang-format.

> I've been confused by this, too. In Debian they ship it with the version
> number. E.g., /usr/bin/git-clang-format-7, which is a symlink to
> /usr/lib/llvm-7/bin/git-clang-format.

I filed a bug report asking Debian to include a symlink in the default
package.

> We might want a Makefile variable to let you override this path (I think
> I just ended up putting another symlink in ~/local/bin).

I may send a patch to do that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--V4N4TvXMNzuFMHdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlulbmYACgkQv1NdgR9S
9os8ew/+M7jOg+rJ9UxH71dUt+Fcl9S3pp0gL3Pa/VsLX2ix9zTw5mpSc8w16BOc
bwltIXF3CRBjQCoEAn/0NRNXoogtbMXSOvvYPr63FeHzc07Zx7MkutC10KLazWDy
VkgtZeKrnqzu7LGKLWWqd3zWtINUH4sUmPItjIABEf2EbdW8oEW2GZ8EBisGsqE2
Q99hauhyf5CwWvO5KlNjVjg9o/UZodhDnl0+YwMQyItaNPi0Qof/tZkxSIu28Ziv
KBm4FKySS6uuAtlv62NcBlLsa5dFrfbapwiKWGwKjaonIM/yyZfJSVP6FS4JkrrW
+seYaz8/zdoNN/XIBs3iaSFRLOFHu9LIiAx8L+A+OvFAvVvikSXXHGz7x6JMepzF
KIRVv+KDo5XWrgJhtBzJYdc3LdCZ/3kPviMosfZyvMkaZSYg+dQwK+yBIpDHBx5o
rocq5sMo+gObBozywXA8ZtsseOgMceqm0mCt1JYolOJlOSS3itNQPYKGi3/CRyws
fcxIXe9FEc5/Z77HG5szrCi688S7NdciiZ32P30ZWAUuTPa0sLKayr/K4zBRcx3S
F6xQCyUW5dXKEcjdqMQAkKIw0JQQ2wHmAKPZkyMN0nDrG0iOYDGv+T1SWS0cbpLv
n8hanpWee5UeliWO1TGCRsVSCHBZ1slFjnTrxoHJRY03FcLncxo=
=+Rry
-----END PGP SIGNATURE-----

--V4N4TvXMNzuFMHdo--
