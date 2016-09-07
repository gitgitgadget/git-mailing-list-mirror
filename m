Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15B041F859
	for <e@80x24.org>; Wed,  7 Sep 2016 22:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbcIGWWO (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 18:22:14 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:43628 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751913AbcIGWWM (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2016 18:22:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5F217280A6;
        Wed,  7 Sep 2016 22:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1473286931;
        bh=4Z326cK8P4uKlOeD8hdJ1WgZiwXsheQjqE1nF9eyFGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ICkfUvpveXNA5t0ZvoQcpSKPL+Mx4E4Dy8ToJXykJDA6LelJlN6wDEtwNGqbIWAbC
         fD1bGVE9FnnQz/qjnmbubwC6SzepE2GLoziFNbgvjn+Cx5SfnOPOCviBVD5SwP7dmT
         cFpo8AGcluhcGTtMvfWuQCSPLbd6TBAgo8GspdAZo0pLoMCwqzwbBH8IWbIq3/A8oz
         JtKkv5wQyL/IZQ74RSiOQeDyKWC0E2bkjm8lVOyPC89IrtWwkg5HkziLsbWwByzMYQ
         I+eXWQJftlXWWPhTMSKAzzVou18A3ecLQaqcBtofWn2bX4QRzA9G5iizH3yc4NKHdk
         n8iJp6qxvWzYwbAtFH8AoT7B+ous9ZWBlI8KaEoqckezm1Kx9+ZKSDbGlbJZsvJt5T
         YwPahYEegq7JeUTiGmoYjBSYpIXmpp9nfrC1B2cAioSEaKWJVMuqmb/M5hn56DPB+T
         Neg9ejmRHqnW4YvXCm+2sFAnvOEjhqdBZjzNbKJGI8Px0Ozgib2
Date:   Wed, 7 Sep 2016 22:22:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 00/20] object_id part 5
Message-ID: <20160907222207.6fdorwi4q4p72gro@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Paul Tan <pyokagan@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
References: <20160905200811.697889-1-sandals@crustytoothpaste.net>
 <xmqq60q7lbae.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gslhfnuu4wfrpimk"
Content-Disposition: inline
In-Reply-To: <xmqq60q7lbae.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/ (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gslhfnuu4wfrpimk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2016 at 01:12:09PM -0700, Junio C Hamano wrote:
> It is a bit unfortunate that this conflicts somewhat in builtin/cat-file.c
> and heavily with builtin/apply.c with other topics in flight.
>=20
> Let me see how bad the conflict resolution is and report back later.

If it ends up being problematic, feel free to drop the appropriate
patches and I'll fix them up and send them in in the next set.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--gslhfnuu4wfrpimk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.15 (GNU/Linux)

iQIcBAEBCgAGBQJX0JMPAAoJEL9TXYEfUvaLhdUP/2oKknxYobbFmkS0o9UViNTP
PnEGb1IcgIrJd/1WUqee+iJ2/sn9IrWhQVMvHLwxbgK3HT+LhLD6b8uvoN32GFZC
BfXWmx2XamkY7QZXBol0jY0Ok18WmxdF3HqFEaR6qUkM4mXijwPc2hafpvDgItYE
/SLtMo8B46vvYxjU2sWWiZmvmu7FcYKAQdekJoKgYn9Suv3ErnNrVQN1hGpZ6I+k
FZkDk5My0H3eNYkzrTtxUi5uqU2KaCGKt3cFEYxZruXpiIbZMWOHfh0D0ubSJ7wT
TwS8n+BLBQLlNvYV/VGBG3EPMOOM/TEwelFUH1ZM2ykwE2X8kJVw5tJAF4wh5HhA
LZBkJmkK+5Nv6Vs9u8ExxI9fszK54CFFaynTgROuGrGhM4Z7mdTCkVO1nr2ZP2i/
pUuhbJU7nwUc5EHd24eCx5DKqjnIinHo3+UITQvJ7COc8F2sIjHKafKAvACY1fCO
/jorhM8ZliDeGVuVQk+gt0aFEV/ZQG9BTjqGNpqliFeflhuWV8P5bicVcHhO4jmR
7V2qu7O6VkNf6t6TSWuWVz+3gmu27Oim33e7Q7qwoDx4Y0gJBWhpOzi8MCoM4Wkn
PXfy1khXvZYD7jR44cAlevfeAxzBiI6RFJcNf2A1PP1R+sEYgd5Op070wfC+sGXi
36yfgoVaaO0JnUHX/dvf
=g4Ff
-----END PGP SIGNATURE-----

--gslhfnuu4wfrpimk--
