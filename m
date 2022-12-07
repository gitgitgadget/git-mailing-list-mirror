Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15002C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 02:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLGCLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 21:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLGCLH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 21:11:07 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D6D45A06
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 18:11:05 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 30EBF5A201;
        Wed,  7 Dec 2022 02:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1670379065;
        bh=kWwZUjl4WLfNwmYGN1brnIwF9uBYoEQdloAa3DhNCY8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0xkjxLE8RN5/tGSGItSenDmoDrJw7nxNVZE7IrYegPi18go7smK9SziR/sPKVl7Td
         P8qh2E0QMwUBXdRAkk9eSYwhqcmIm4ETGbA13zuEagM6HLIRpo78QhDK0YSkEc3+rP
         07TnGY5HMvi5KL3F9ktTX4DRuDPNBWcKuZMCdItWfnTWEFQjYOCLs4mEzHwKvtI2au
         wRC5NYqsYXHP5aNuF5TDXfQi85ZSf801rLg2XqMgYY5tki2MgfW5o2b0I6TWbsdKOX
         i3y8YXLEq1cfYsLseKiwKe01WylnmVZfGeQKQHXUBlEeioZQEvP1EQ8b/J4bHSDe09
         a40+nTskTI/iITlS5eHA2JKCwnGv/BrH09OhFylhZJpaaQzcyIZg16QtXfYkW7XYHm
         HeOQL/ROOPu8Uj6TypPgcxw+isoeggfB2KeKh8P3qOHlez4chBjuAVkdKepL6fq+M5
         z8f2rgq8S6Fzynqy7iUdf8K/0qAh4hJOGBObyNZUJuj6GN3hqis
Date:   Wed, 7 Dec 2022 02:11:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
        toon@iotcl.com
Subject: Re: [PATCH 0/2] check-attr: add support to work with revisions
Message-ID: <Y4/1uNEcM1If4sA9@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
        toon@iotcl.com
References: <20221206103736.53909-1-karthik.188@gmail.com>
 <Y4/ntYotGKz2dx0E@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lch7JlOjUCR6f4fG"
Content-Disposition: inline
In-Reply-To: <Y4/ntYotGKz2dx0E@nand.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lch7JlOjUCR6f4fG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-12-07 at 01:09:09, Taylor Blau wrote:
> Anyway, my point is that I think that this is a useful feature, and one
> that I (and I suspect other users, too) have wished for frequently in
> the past.

I fully agree.  This would have come in useful for me many times, and I
can tell you as one of the maintainers of Git LFS that this will be
enormously useful to many users of that tool as well.  I'm glad to see
this series come by.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--lch7JlOjUCR6f4fG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY4/2NwAKCRB8DEliiIei
gTOQAQDiJHLDfaMynPXea5cRTKVnRSuZwK55mwcN8PHPeOQINAEAmVnxii+XyJW9
cnBu/RGQA9993scva07wP0EA7Yg7oAc=
=pq4B
-----END PGP SIGNATURE-----

--lch7JlOjUCR6f4fG--
