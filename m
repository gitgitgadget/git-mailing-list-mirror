Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39281F404
	for <e@80x24.org>; Mon, 26 Mar 2018 22:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeCZW1d (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 18:27:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43266 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751374AbeCZW1Q (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Mar 2018 18:27:16 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 677D160428;
        Mon, 26 Mar 2018 22:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1522103234;
        bh=AA7Ilw3kMfwQVRDpfZt4JxyfiFNxZaXRhXQf9T5Za3A=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=V5AzDaMgoyEB/0pGRounHkwyA73iYcLlmpN5CeZiLBV189ZJxMMgYjozp/9YlTXs6
         vbuLHj2LH3H6/ZIOM78c/fTUqJNFNz1se0VRF2E6mO1Ef9n/wBl394rNVNW19Yl78S
         R40FB/qwbj3fmzHBbBwqtdF4dJtLS6NIc0LWExyvaYeqV4zMcLGRiX7nvFQ+uwxqVD
         BI8CxvaEzwYMk9lQwuVrTUd+iDK2fmqFSZM4QqexNI3+Y88wPLqsf5mZ27b2hg3Eu1
         NB0V57ZA452ft0ZfPEUzeLFKBuG8t5Pw+zgxDHxn+aiGsV1vO09Swe9Qk9IXKvKZgS
         7XFjC7SdF485QDO1n3QnzxfjXSh5RJizFMHbmIKYf97hhLc1DdmEXN5/aezkmGSoOe
         qHF4Y0cNRYUGwz5Q4pyPGDzzt0sFxqSYFnh9QTRVYL0VMkQYmh4wtjZcIC5/eQ2yrP
         8OaOi/YA1LC58+6tZaqBeru5zDx9sGPVyohEY0jcVZLWZYghIkG
Date:   Mon, 26 Mar 2018 22:27:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 00/10] Hash-independent tests (part 1)
Message-ID: <20180326032411.GF74743@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
 <CAPig+cR==SNfGdhwqPdvW75fUxXg-VSQ5Tz_OR7Sy_c0L94axQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Content-Disposition: inline
In-Reply-To: <CAPig+cR==SNfGdhwqPdvW75fUxXg-VSQ5Tz_OR7Sy_c0L94axQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-rc5-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 25, 2018 at 10:10:21PM -0400, Eric Sunshine wrote:
> What's the plan for oddball cases such as 66ae9a57b8 (t3404: rebase
> -i: demonstrate short SHA-1 collision, 2013-08-23) which depend
> implicitly upon SHA-1 without actually hardcoding any hashes? The test
> added by 66ae9a57b8, for instance, won't start failing in the face of
> NewHash, but it also won't be testing anything meaningful.
>=20
> Should such tests be dropped altogether? Should they be marked with a
> 'SHA1' predicate or be annotated with a comment as being
> SHA-1-specific? Something else?

My plan for these was to treat them the same way as for git rev-parse
and git hash-object.  Basically, for the moment, I had planned to ignore
them, although I like the idea for a prerequisite to get the full
testsuite passing in the interim.

Ultimately, we could use some sort of lookup table or a test helper to
translate them so that we get functionally equivalent results.  t1512 is
another great example of this same kind of test.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlq5c7cACgkQv1NdgR9S
9osPDQ//ZVOOp2ez856X5DhIRK6avIE1vRsTUkYQY+C1azBi3HUZV40fYCJBTd0x
N+QKbxESlgl0u/tsLEPwYD7rZwdZ59Lw6tgg0QHXkHUvg9usv9/vxSxUE+ngOcsy
xCkkIvj178rS6Z8hnaSpkOwCSPRR3Vvo/PXwA4/Dw2vHlUtWwr+y7g4oemf5FozT
Iu5xZx1OJnaNhHS9b5YCYPlkdNcCqvLBo/PN8IDI0tXmtv7Z9uA1J8nprJNA0zve
txXTDlU9FsLeBbYqK2K56TsKHcYpmN+nV05bmTwDyegJIYPPsAG5+aZP0aWGQiEo
wDm3/9S3eAyEUoH9vf/w+ZAM7KP/wpHHwafUIDvFkjqQp8/NmJ3IhCi6+TdQm4Lz
d3bHgrZVK/h4ARMG02ID0pd1X7DoeWZiqUbzcme0NhteFN7PsTT0F7xf/+D9le1d
ho4c6F00qRGRaQFHX+gcKN9WtLyOzsabnCZ9TiIudmn+isXs29gkgdBL0vGvuJw9
jvdIKOXFJ0jjrcFYPyCEkQlRcRwKXkDVul1vKKwnA9EaQlbLG+PewwTO72aCiU/S
kABSEDkTkE6oa9/F4kvzh00KX7UsWv3KvVjb5X5C4fO7JmJpn/LzinAXbbI0N0x/
ZWb9Na4CrZFSKQFs7DxWmxvfFsMWwP62SY4Az+p6xhK3mlvB2PE=
=T5Xi
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--
