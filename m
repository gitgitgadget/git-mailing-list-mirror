Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA8F1F51C
	for <e@80x24.org>; Mon, 21 May 2018 23:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbeEUXIx (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 19:08:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51734 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750942AbeEUXIw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 21 May 2018 19:08:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7906460444;
        Mon, 21 May 2018 23:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526944131;
        bh=DYGn+c+CMRuItMPXuleXSVGC0srT6JWCQpF6AzzBou4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Y6VyrjIeGvptR1LrGkQgsJRCdnwSaC5t8e1ZFhgjHC6UKYQYbO2beqMroTACDp3sw
         5qqXXDiDm+8nxM00EnTLJ8VCHcgeUdgwIXSoR/oSn+rhqhkmDAPV3HQJm2vctRpn0E
         MKLP7YMhRhVQYh1R43Fvl8NaAuh8vONaU3NoTsYogaZcrpg3T53hxBEneXpS3oEytR
         L+OBfeUAbKPyga873IjrLan8pdI0V0FTNLCTeRqFmqlZWy4Yn3iSI2ytW/oRRG1HxB
         yCNfCi7wyh3UhCD+bW3GGlK2J3Q6TM0xDOIoYrJM5zNeOslXntPgQu+YlrAa3JXesU
         PlNu04PPWPa8j6w78V5BMySF2XiuQoQDFdXhpRQqoXrsnAr4mYbIxoB7y3NEVLk+u9
         +4KYmB8xn+oq6+JM2urWGweYnctf4K2DJ9YSzlyxhe9SThyx3lmG06rFf/xKq6FnGl
         xxdlsQas0cWHT0aCnH0GjJDUADBHw+IA0jpGQy50up4oYBRmZmn
Date:   Mon, 21 May 2018 23:08:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 00/28] Hash-independent tests
Message-ID: <20180521230845.GG652292@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>, Stefan Beller <sbeller@google.com>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180521020147.648496-1-sandals@crustytoothpaste.net>
 <63adc6e2-19c6-72c9-1c56-47503e128231@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ewQ5hdP4CtoTt3oD"
Content-Disposition: inline
In-Reply-To: <63adc6e2-19c6-72c9-1c56-47503e128231@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ewQ5hdP4CtoTt3oD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2018 at 09:17:39AM -0400, Ben Peart wrote:
> Do you plan to update those tests that hard code the SHA of the index file
> itself?  For example, t1700-split-index.sh has hard coded values for the =
SHA
> and currently only supports different hard coded values for V4 indexes vs
> others.

I have some additional test changes that use the SHA1 prerequisite,
plus some that fix issues due to the use of a different hash algorithm
or a longer hash algorithm.

Ultimately, I plan to discard the SHA1 prerequisite and update those
tests to use a translation table to look up the correct values depending
on the hash algorithm in use.  However, we haven't decided on the actual
algorithm that NewHash will be yet, so I can't write those translation
tables at this point.

I plan to start a discussion about the choice of algorithm soon, since
we'll soon need to make a decision in order to progress, but I need to
do some research and testing in order to have sufficient facts to
present to the list.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ewQ5hdP4CtoTt3oD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsDUX0ACgkQv1NdgR9S
9oucIRAA0LMf8tledw47YFqFTSqWwYJ/+p1UuRma6p5GdFVcSjW0pcGgaNVhPQ4J
6W8jlBZ67JgGtAQ73V8OqYpqqInzNEDqfeSrAYrO+bAbWVCNBk6qbmYolFVwe34y
uYkW8z9tuDjTzuKj71s4aXPtkt9sMTUvZHVLkD2HY1qrD+g2iE0ZB1gJR8qO3cvc
O9CKB0zmh+9eJpWQFIevMXi3WDbAXCSUkZyKd0+K2RZYEpPBJ7QBjfnrkhmYuF6B
7uzU/FRs79zb7hQ3dNwLmYU8MfqV7Iv72+lmobhlJl4UE38g9e8n9Ph6JBNj2OeS
K4H63kmxWL6fx2mvW4yV+NEaotu8uvfsuv8+BUfGHlDg4+JGoA3ELyHWYgB6kdXl
rqx79M65bMDkhr1D1l6IVPZfUDQv9LXNJ9L7XRisOU3XPP1VapXnPQftx/SeE3Cx
Cz4Erop1s+vFoVUOfqXZOnqZJxqAW5vUky470E7voghSn5o+LE6sxKhtbIKWMd7i
U2k/M2lLmPOjycTTijhKd1bcvHhXlORXbIPo5dT2Tah6rsav2L0WJR2qr1tZia2k
s9Fs3l0CjHv9BgLDlULd0YAOOog3tSoCYxDXFzX5cN0cMpBmWjoKZ/lG+RIuG6c4
JmakqLNsNcXFIvM3x6lqSdjNedhFEpji65yM3LoohpUyS+32PTk=
=6Qcq
-----END PGP SIGNATURE-----

--ewQ5hdP4CtoTt3oD--
