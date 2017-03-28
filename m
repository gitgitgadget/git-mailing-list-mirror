Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8095720958
	for <e@80x24.org>; Tue, 28 Mar 2017 11:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755262AbdC1LOw (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 07:14:52 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:58530 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754727AbdC1LOv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Mar 2017 07:14:51 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 19606280AD;
        Tue, 28 Mar 2017 11:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490699599;
        bh=fhdPbxfxTV+WY7wmlj3UXfRT+Qo4B+4Sfd2OGGu8FRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AKNkVc2iDlP+AVIk7VUbWWmjp1xIxOO6KeTlS/RXQzlgm/PrE+KfkNS7BS6QaGvSr
         rQrh9g9rG1dDOoHzk1o/LcwAOPmUQCskZ/328s8OggJkSxZ8QODB1papU4zacntDFh
         2nSSnqADdg+FB2ZSW3a6dQmqQiyRQulZxq6gnfmznFKoLFMCoiecexGhZtB6ho3GqV
         URBD6BdQDds6RNSfBKiyoICR4sikqsKZn7r2zUM6unIjujKwIWZ5PkFJdkWTrAo9E5
         GxWqP0K9T2XqOYHrzqWC2VqRc1qB62XuI5pfbo+Gv57Wyl3pI44yXzpIQ9f50It7/N
         xxMHCTMHPc5xP64GJC95/zd75sYPCz+Z+nSbMbei+qQz7Vi+gUb8mcB/3DxD5a3Nse
         81ueqFz1ID7z1Gae9datQD3ll7r4oGNywsDzoVS3PRhA1tdUsf2NdkGfTHnDBsiAAP
         ElgdsPjc6bJpqdMld763rxEv7ymRG2MrlP4IjhzZ6MojOsMJ1Fd
Date:   Tue, 28 Mar 2017 11:13:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/21] object_id part 7
Message-ID: <20170328111315.i6rhhy4pj6hhf4bs@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
 <20170328073159.k3xemw6auh3iedgs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wgpo6vkoqbrylggr"
Content-Disposition: inline
In-Reply-To: <20170328073159.k3xemw6auh3iedgs@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wgpo6vkoqbrylggr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 03:31:59AM -0400, Jeff King wrote:
> I read through the whole series and didn't find anything objectionable.
> The pointer-arithmetic fix should perhaps graduate separately.

Junio's welcome to take that patch separately if he likes.

> I suggested an additional cleanup around "linelen" in one patch. In the
> name of keeping the number of re-rolls sane, I'm OK if we skip that for
> now (the only reason I mentioned it at all is that you have to justify
> the caveat in the commit message; with the fix, that justification can
> go away).

Let's leave it as it is, assuming Junio's okay with it.  I can send in a
few more patches to clean that up and use skip_prefix that we can drop
on top and graduate separately.

I think the justification is useful as it is, since it explains why we
no longer want to check that particular value for historical reasons.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--wgpo6vkoqbrylggr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljaRUsACgkQv1NdgR9S
9osoKQ//SLVoM1kQhbRuqemYZgt2brEgMe1yKWwz5VEnVEVwKaT5uxwYwccZiTw8
SDQO0zf7P3GbGBDYWcX/3nqvTI415jqZ300J+WQn1FEiahl2YZXKU+A6oVyFxhDO
ehfY36CIl0Q819dnOs2jwVtZ3YtFzCrl4Rgk/LNGctI8r3os9RAAF1nidlJefboS
O3mz+3twCxyW4jooyU4I9FPV2lgvYM5DIBqBkIwqrM5Ili8BSRlunzz5u8TtRNCf
AmgmleHu3HHtHrp8fuw6r+lHNrQyeOhRsRMIlJzgwABXR6bF5CdjQLvc9SE+t9sw
iHzKGdNTSYUJgUpyJYmIbu80IrBWW85ohqC7BNT1mzksn0zTzs9vmCs92kHUAB3j
vq5VfTJz0A5RBQkC8ZKl3D7tKNquv3OHr1aBHG0osElH7hFHKnIdyzluCLQJ1J8L
50i8CAm0bb84huhgv76Ubzwn3w6FdEPg/Sh26X8rI3ZSX3QwWv6ehHRh/qDXWaCL
bGT6HhnI/2Yl46kwYr1xm0PjHE0uw9NymEdT0BZelmPzQZvCwwgGKjB6eSuTEMKj
jZrpFM2QzlQ1tdDo8vDFWS1PTMC3kFKXGxhgOGjgLtr16186mqzcfLSfWnyYG+kh
v3knM51qkBSKgq903oKVV5RyMlnBJRB6bESF+vE03r7pSz4WgAk=
=XDxF
-----END PGP SIGNATURE-----

--wgpo6vkoqbrylggr--
