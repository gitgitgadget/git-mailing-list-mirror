Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E2E420248
	for <e@80x24.org>; Sat, 13 Apr 2019 22:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfDMWQ7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 18:16:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35474 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727092AbfDMWQ7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 13 Apr 2019 18:16:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:4828:c54d:8751:d24b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F05BF600FB;
        Sat, 13 Apr 2019 22:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1555193817;
        bh=P9N+0yAijhBUFszN/FF6icKXpchmQKXsI2xpCccT8a8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=A84NYLcIXB++iZ1xrZRNm2XnRoLprOvmHkYfz8pMBQIxBdPFsXmgPIhd8+wp56RcE
         RN7MUNskcnNWXs7jACKqcAJPoVIMByONPA7FBNw/YFPUFL4Nbn793sy5yKZ450vmWZ
         3zc9/UGKtcwqcyP9p8oTpSwzc/FV2ePV4NGVjIBd8rX/JYiUXBUAjhYNVWOQ6QiOny
         CY2SET6+Bbjdf0HRTRNjRj2zr3lYNEsrWF5HCf/iuuzqABY2MGFOzvXjCfmNV8YpAp
         2jNnn19YNLYlX7yn+2N2lzfBd5Qo9rAFbJxGhm56KfRgagj0nG1jgZVtam9NJEo0Xv
         nUFfVC1AOpzyHwhF+ioJT1Fgz7buNqHTe4IpXz4p5yWAWi6aVllBTOAEnveK7XOF39
         PMsDS4yas10yh4Ahfta9T7Z57Rno6vmz7FCQrOEYKuCtBZ1+holzWCutgogMl34fAS
         PdFbsVhTI7lXN2Gv4gulpKwuQ1bYuvod8k8gQ593HwhdjI5PhLf
Date:   Sat, 13 Apr 2019 22:16:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
Message-ID: <20190413221646.GL12419@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
References: <pull.145.git.gitgitgadget@gmail.com>
 <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com>
 <20190413015102.GC2040@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JQ29orswtRjjfiJM"
Content-Disposition: inline
In-Reply-To: <20190413015102.GC2040@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JQ29orswtRjjfiJM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2019 at 09:51:02PM -0400, Jeff King wrote:
> I wondered how you were going to kick this in, since users can define
> arbitrary filters. I think it's kind of neat to automagically convert
> "gzip -cn" (which also happens to be the default). But I think we should
> mention that in the Documentation, in case somebody tries to use a
> custom version of gzip and wonders why it isn't kicking in.
>=20
> Likewise, it might make sense in the tests to put a poison gzip in the
> $PATH so that we can be sure we're using our internal code, and not just
> calling out to gzip (on platforms that have it, of course).
>=20
> The alternative is that we could use a special token like ":zlib" or
> something to indicate that the internal implementation should be used
> (and then tweak the baked-in default, too). That might be less
> surprising for users, but most people would still get the benefit since
> they'd be using the default config.

I agree that a special value (or NULL, if that's possible) would be
nicer here. That way, if someone does specify a custom gzip, we honor
it, and it serves to document the code better. For example, if someone
symlinked pigz to gzip and used "gzip -cn", then they might not get the
parallelization benefits they expected.

I'm fine overall with the idea of bringing the compression into the
binary using zlib, provided that we preserve the "-n" behavior
(producing reproducible archives).
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--JQ29orswtRjjfiJM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlyyX84ACgkQv1NdgR9S
9os0Pg/7Bemjw9IJ7M2V/uJJLNjTRi/uzhczmay9BLmNtA2yQGoXU3rRuaX45l6B
3oTtnZmiOHcaJ2YxZX3SsgNIDPmDGCB0OQSUUUP+9H9nrXUL7fJi9OfHx49DDAtI
nG3907VHZz2tFKySh0v0mfQTt6Ctm/2K6fRSg+FUmawlB1WnwSBl6ooCeTl5lyvN
A1pqd9wHKh5Om9MVNk7FW/lxhDuBrAsXA141joKGH3WuEYv0nkkaezDHDL1bqFD5
Y5D3JgMDsJPBFwWybjcJVv/SfNIg8K6JSEeLgtwSZzyDPsF6iY0koIz60ylnQIQy
uFDS09r4iqvx+gdPxVd7ELDGMZ4MD50a6cKIdQNVpQp65ETADCiFKBhiZU9C9z5/
k+xYvVNigsOnm/TGuJAYJBQgGwZ9hnkDS+qNG7T8rwEPIxfBXiy3NKSLos6Klyp3
k3WcjFwDG0Z15wBCQfFCFMnMiyh0vrtGRLznsXKn542lfZMJry7jGUJEVWv797Is
iXBMjA6HD+OLDi9+w8xUghoMm2fEkywtI38seJdpsRDRyBhBvyKGJHhW1RyX7kQh
RsHxlh+nhguZ+yy1LX8gAi6ap9Qd1rLsQhAcJKJTqEK/r2HRsZuBmm8sP6GmQbI8
zmaigQHv6txbmS63tlSGeohhMkOVyp16ufwowxcfdGEaGc/qXWQ=
=/7+n
-----END PGP SIGNATURE-----

--JQ29orswtRjjfiJM--
