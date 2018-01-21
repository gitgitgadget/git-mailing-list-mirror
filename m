Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20CF81F576
	for <e@80x24.org>; Sun, 21 Jan 2018 19:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750930AbeAUTzV (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 14:55:21 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58202 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750878AbeAUTzV (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Jan 2018 14:55:21 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2E2716048F;
        Sun, 21 Jan 2018 19:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1516564518;
        bh=JmYQCWhTYEs50N1P0hFGCGFlnxflWhiPon0b3qHKaTs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WJl30EpjRK4cS8aJQ12zWvlXpg1cvz51iLVd8KlAApbRCvI0y2lPmxkxDuTRVcAcR
         MMZ6vKxDyIvZFhcsOXo6XA1Fs3Kz31sekhp0n2hhYERfo7ojaWDZ4aO6o8+ycMu9Gu
         9Zyt0Hhag0SnF+UH6B5rGUMrQJrgf3qVgJ78tQrOdbSVHoh36l/lX2XHGSTqtLU25J
         b3EBo35hcmt/xFhIT+kavWFy6k6tMDqI6nYcOckOZxeKmw/9VcLFBioIXuwydelWwK
         8mfvqNr9C8fwuNc5i2OeR9BglWK2llGJtWPe5Yz2F1i+DS0D7QUUUIO2t0GjmuN23C
         vcMhEASeZ9TOgwPheGHixrQzwmIvczQk83ccU3vCccgddeXOMQ2i1pE3EA1QjmXJUG
         kJNmmVA8aXoJB4A8Fa60bIKV9m460FfAuqGn8nZ5v5K81lYOcofSoOIbyAvCLIiqtZ
         07C3iPDm1fSiMTJ9UVehyMzAS7c35Jt63teeUA/RXI2Pr+HmajQ
Date:   Sun, 21 Jan 2018 19:55:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>
Subject: Re: [PATCH] t: add clone test for files differing only in case
Message-ID: <20180121195511.GE8965@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= <aleks.bulaev@gmail.com>
References: <20180119041825.727904-1-sandals@crustytoothpaste.net>
 <20180120203324.112522-1-sandals@crustytoothpaste.net>
 <xmqqa7x7oecq.fsf@gitster.mtv.corp.google.com>
 <CAPig+cTW+vO7FWYViUrO-aV8pPL=KKhGf7Wkgh_51cbrxKZPEQ@mail.gmail.com>
 <20180121080728.GA20770@flurp.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <20180121080728.GA20770@flurp.local>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2018 at 03:07:28AM -0500, Eric Sunshine wrote:
> On Sun, Jan 21, 2018 at 02:46:15AM -0500, Eric Sunshine wrote:
> > Yep. In pretty much any other test script, this would work (it was
> > developed in a stand-alone script), but t5601 (which nukes .git as its
> > first action) isn't the most friendly place.
>=20
> Here's a re-roll which fixes that problem (and has a slightly
> re-written commit message.

Yes, this looks good.  I did indeed intend to forge your From line on
the message and actually test that it was fixed, but only tested it on
the vfat partition, not my ext4 partition, where, of course, I got
distracted by the various other failures.  Sigh.

Thanks for fixing this up.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpk8B8ACgkQv1NdgR9S
9ovXuQ//YWUVFRUzhBn72nDK/x4j1eX7X1qVlqtGiX64s/Cr/NppjnZ3ez7v6SEe
p7q7BSJu6wuKDvhZKLRbakFvXSGlY3C+5Fq+ztFBPv3q+XIoE64Q5LLX7dPRVi3Y
UblJuZu/qsBNXS/Lbawg9ESKSwpmkMbXo4bRwj0v6jNb9WOOMe93gad1OXlMZ3gr
Sjfdau8pFZTcLjAAVEUb1s/yGDBJqq9PwLxJfqvgNDw0JtNtifH99FIDyJ0LcFkA
lN8xwmzhyB7p9tDybd+BVNzjig4kZMGL5R2wewAwdtAG7/ntmEzdaf0FafaLgyuK
c4ue3/OXjzp9gFvqDJ+MenitxIwLlADLnSiSkAmanV4REZ5PsndeBElVzqQgsoPL
lmRH71N6O/bHl3bCtfWcFn6Je32qTmSsSvNZh0S4qbUtaFoJMle/bxDjP9L9asK4
bxygbJpAI2j96yZPJVBuC69Z6VzwOK9cz0ozaKU48NYn2nd/9YOOlMiEw1GjSEd9
Hk72hR34x71jIi9n5SWF8AVNcIhBnaAQiHnmXDyBM7Bv+VQXkTmsQDEVYTpgbTTK
EktGbXz0MOuWgxlTk1FamKDjv66maJLXqAKSKmX2apxfMP74lGGn5ez+qpMkHurM
D8TAKYFbe3CUUt1S9OuGtIJOqvxKi3ZULffk3pN2Dcsdf7s1JgI=
=KWpb
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
