Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18C49202AC
	for <e@80x24.org>; Tue,  4 Jul 2017 21:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbdGDV1Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 17:27:16 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53786 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752226AbdGDV1Q (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jul 2017 17:27:16 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6BC69280AD;
        Tue,  4 Jul 2017 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499203634;
        bh=IJeISUGJG8nmrGzwX/7i1nloHEcx00hY4yXgRXUSUnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRnQoQw9lhQdoJ75x/Omut1nIg6P0N2LCA+2tHIuhKfOwqr8kLhuwFFf32LhB7FOo
         nz9rYdzAW9YL3Wv49p98o4FIowySJlDUR3BqY9f+rzt22nIMBIygEnRvR+I4uxWWA8
         V02BpPJvfksYMmXdnOF+W9Xe24NsY4lrlgZ4dRlnWRlkH9C2/zKakkOJWl//JCFE/G
         a1rN+fJeCI6cZKCQ/Ok8eFBgJIfCCRMzadqykEzNKOBX3RNoR3zHHzJVwPWpJK1X87
         OWf+cOG2OQ4eEdX4b0JX2KZZfpjXe0dw8794ZAGwwlbe9B2te+gax5JCs6bzb1pXRv
         sjRciVZVZIHCT5m9eiE5Ds7hqoXxCeYe81Zyzgl0NGqAW3MFUSw6bqJxXM4oXX7z26
         MJSEratQqH6KxupXKx5y9mdEFvBr34UhZ1P2ciQRhr4Vk/pN3v6jgm+7Q8wLb05RiX
         414EoEvymTzZacY1kgrobKH5glL/vPicOdL8idj25ZsgRfs3jjB
Date:   Tue, 4 Jul 2017 21:27:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
Message-ID: <20170704212709.vqymnj6kkz3prwty@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
References: <xmqqziczkh4k.fsf@gitster.mtv.corp.google.com>
 <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net>
 <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
 <20170622202146.cxrkjca636xl4dgk@sigill.intra.peff.net>
 <xmqqd19vix03.fsf@gitster.mtv.corp.google.com>
 <20170622215235.to6yleo3adt5klv2@sigill.intra.peff.net>
 <20170622222545.yewnynklle24ebtf@sigill.intra.peff.net>
 <20170623031315.7aw5qd7c4wdqlyf6@sigill.intra.peff.net>
 <20170704195806.ndbykl776t3vigya@genre.crustytoothpaste.net>
 <20170704212408.xy6jciggoueq6qsu@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mw6bmaahh2uxau7w"
Content-Disposition: inline
In-Reply-To: <20170704212408.xy6jciggoueq6qsu@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mw6bmaahh2uxau7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2017 at 05:24:08PM -0400, Jeff King wrote:
> On Tue, Jul 04, 2017 at 07:58:06PM +0000, brian m. carlson wrote:
> > I've looked at your original patch, which modified reflog-walk.c, and it
> > does fix the issue.  I'm happy to send in a patch with that and a test
> > (provided you're okay with me adding your sign-off), or if you wanted to
> > send in something a bit more complete, like the series of patches here,
> > that's fine, too.
>=20
> I've been on vacation for the past week, but wrapping this up is on my
> todo. I'll try to get to it tonight.

Okay, if it's on your radar, that's fine.  Certainly you should enjoy
your vacation and not feel obligated to work on Git unless you want to.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--mw6bmaahh2uxau7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAllcCC0ACgkQv1NdgR9S
9ovrHQ/+JewZ/fntvkiuR8ajMISH0t7Ig+UMql0MsxFTKlNzRf87vdFW90V+BcSk
yMAdbf5ljUuIY6LuvNp4E8jootefNKq76X86uzGEnrY+UnWNBQyIqxeu4Dt0tk5o
nxziXQpzjtXW7L1K6Uupmz1lgR5jOAM+rT0PYxL9/w99N5mQy+MzdSTSIne0G+jc
2bT836wCz3OJ0dGV19VDoh9DvFQMdtsmNARGJLIjyVcNsr24qEQYHtruWM6Pbfkd
hwq3STxwBXXa7md56vF7k66GAyRUgWGKGp7vtgK+0LDWLe8Lf41pzRLt+lY23pdJ
nwD6n2YfBUWqLwVK/4q103MR0gxExOASNpZVYk4TmZsdnUN7liEUM8CDY6HEvOBB
svFrzbkM261ejClZX897ViyXec2wAfYCHF97e1+0qll2Qa44vVHHBgVOLRw7c4rT
TIUCAcUNDGMufbXWccMa+071EG7v7xT2N7/5aClWmUDExSckINLUe//e0cMg+VzZ
LhnJtBupvTZSvZhiWQGBsZWNlTFKY2CTC0unOTl1eUTVKjdL9CWJ67mZb6D/mLfX
bwi/99ZALdZLvlbsk8T9jC9/PxIjgCOsAvwYRrecxvRCDIp3T7bHqzMldmpTxwnX
tsdYmXNaKaXDjLuYlC0mc9PnbHod3d4GxrzOmX/61mV5GdcWAis=
=NhfX
-----END PGP SIGNATURE-----

--mw6bmaahh2uxau7w--
