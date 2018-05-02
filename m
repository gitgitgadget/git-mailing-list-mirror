Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3862200B9
	for <e@80x24.org>; Wed,  2 May 2018 23:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbeEBXmt (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 19:42:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38552 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751837AbeEBXms (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 May 2018 19:42:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7ACDE6046C;
        Wed,  2 May 2018 23:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525304567;
        bh=/PiWoaCsraB5hW0+Ma09ocrIPe4sZx0VKZBttGGe/KE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ncvYuOXymC5+4fjsSwciJYUtVJ0Qlc2Z3HvpTSOlxSwuUbA8Usm23qd9lBg5NZIbh
         RAFlm0/ftivXccjw9+OJGvOdAa8dnTgj5XsElq4jhx+ZsIYXyzL9TrNWJwWlC12moP
         ckyvPasrQ8hgPSwbARtWFQEpu0e0CsXVzyF6NQGZHAPMUOoEvyXwB7hNO6PwmUj20j
         Y6PEShEoMbwqMzr+6v15cd+6n/eRIkksIccViDshRwAdZ9YZN+Ov+2gXkv0Z074XrJ
         0R9V/i+vU5Ou2DSxlX/TyAN7qNJUiedTebzF623H/WsKMeSYJBTMywFQHkEhduFGHC
         6fVwxl4TL6RekgCvzyW7JZYhBCo90ZgtSi5c12SpHE41Rtyyv9zHl8VkIPRKk9tk8n
         REfIGoFd8pCgbfbMqK/Ryz2XZnpBP90YkEhnHrZdwDjxkR/Iv/EQA1p7aOgLRkGVSU
         0jPi0aSYdtGgDeqLmoWFyXdxwcNBuHlYLQR1sdodDMXaLD0sbNi
Date:   Wed, 2 May 2018 23:42:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 00/42] object_id part 13
Message-ID: <20180502234241.GL13217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
 <20180502153224.GA8237@duynguyen.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FxlYARId5dseejUu"
Content-Disposition: inline
In-Reply-To: <20180502153224.GA8237@duynguyen.home>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FxlYARId5dseejUu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 05:32:24PM +0200, Duy Nguyen wrote:
> Interdiff for people who don't have time to read 42 patches yet

Thanks for this.  I had intended to include tbdiff output in my series
but had forgotten when I reformatted the patches.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--FxlYARId5dseejUu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrqTPEACgkQv1NdgR9S
9osFZQ//VqZYFePZu/l5i2AcY+WLaj3WVxY+dpR2W/yif3zxwiHdW4SQtOj7Obww
dCmekxHManhUqHArATJ4CPo/kknEFJ+uMnjywWddQKCRJGQB127xpIS40zC7R5zW
9J5ZzXqiqasPx76rIPXKNoAKcqe6W4ZE9OS66KrPHW1Sf0Qk3rR9iFK2BuFh0LLK
7yHE/iyOVwasla8UkknhTiHmQ4yDNblkOgeUym/vByusJTFRJekE5X2xmhRpvsri
x6XECALsNrjPfKoMY0Y3ts5bMk8bPnSFd1kGP08BIgU1xifGRDAX7eWEEyOdI385
y+3VQHDHdGvqW6c82sFd/OtAXaPEkpJzjmlbPLaDda5DZnpORDfeS8kRX+klG5Ce
S6SJTJ7aiCc/Suz+Y5zeFAsD7Nr7TaNxGCXqWdEWqrGmss2ewN6ag8y0awbBdTal
zgOhmZKKsJ7ogt9GMNptkDM56CXP0kuq8+S+ZXP6NUhVLMPfKCcEhEjZ/vMb86+P
YYnzY1J8+M9s8UWqAZ1u7OduK5cJV0XU5FXpSPXdUvVnvsjUJjKHbtcgOD6yLvyn
eyfnDMfmmOaIYv1RakN08vXEhQkUw3guzPKzRWvvAMRceWuzy7gAH5YbQzbYSfca
0Y6iQzpwA+R1O2NMTMVJkTApD3cJYtFAkxRRdECRv3ifazzpeX8=
=srL0
-----END PGP SIGNATURE-----

--FxlYARId5dseejUu--
