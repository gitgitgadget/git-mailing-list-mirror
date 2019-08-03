Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8234D1F731
	for <e@80x24.org>; Sat,  3 Aug 2019 21:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfHCVL7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 17:11:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57264 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728508AbfHCVL7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 3 Aug 2019 17:11:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:49db:b3cb:1703:1c9a])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 73B5F6047B;
        Sat,  3 Aug 2019 21:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1564866717;
        bh=XsyiCy/jYqVxilWJbyzhwq5cYX4RD0g950XVTfQLECk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vUqJb0i/CN34fP+MrCcv9tV5Hc20dL23Uvd5WKLJ5L8kT21SfHn0kGKlzVMlH1HkT
         dqfNVYfYl83kJBa2m0qDNFGRIQulkYvFwbweJ9Woopkqfpm0MvPvnN6hCTDf081FFq
         pa4KbNisDSg7EgaRSSMK6f2p80J+DdH83NGUw2LyW4VP3tEzUEadhIWlzwvh2mDTY8
         8zistztXChGljIQMnLzIMBk3/+7saJNiqtvn1UvQrVzxQdEB4qUr96M9Rn0MSG0mJJ
         RbOwZs2sWhIfcRZZzAAI9C8BNyHZCvWQyxQI0GQ83i9FMbLtK9BDdhWtnB1VXzyJYy
         FEfR9G5jumA6pl7sl1OXORPG4zjq/WFWilxh4BjH/W3vSVqV4vRlbgV45JcDvoKpeg
         bmgPp9ZTL3Wg7yzgtHYDFEOyRJMOZCYbqis5LexAukZGw5iISHu6NtwudXjuof9yOr
         IFEe9Zd+MAcX52LFq3BeEEd22sDE5g76nenz2q+QOtZWIjxtBHS
Date:   Sat, 3 Aug 2019 21:11:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] commit: add signoff config variable
Message-ID: <20190803211152.GA118825@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org
References: <20190803193436.13158-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20190803193436.13158-1-liambeguin@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-03 at 19:34:36, Liam Beguin wrote:
> Add a configuration variable, based on format.signoff, to automatically
> signoff commit messages.
>=20
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>

This has been proposed several times. It may be interesting to look
through the history of the list and examine why it hasn't been accepted
as a feature. A few attempts are chronicled here:
https://public-inbox.org/git/?q=3Dcommit.signoff

This is, however, achievable with a commit-msg hook or using "git
interpret-trailers" if you are certain this is what you want to do.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1F+JcACgkQv1NdgR9S
9otnBhAAtwV6JGW88U6M2fYstxOBNudwO5PcwNEAaFK/v0sOOcHO7SL8Fyt5ZQ6t
VPw1UJ98VtpgaGgccejKulxaCbIhlVvNi6fTFN4yi3jm+/553PkJIKdSw3wTGBc4
FT8ZgEBXiryGTfXfaK9o9JspmfHjiACo5m4vNgoSTtRJM8vl9gKwbwyr0JkMTYZa
rTMWl2zl6GESI3DHXDLVjF3dB555g0U7OLxCXiZ2/I1DyfrSGxjxig7+WPfSTChp
aZIFF+IRqxxDGE4uqRabmqkVvuoO5RuQHwi/p8tJKFRuxCFKyxk3S5ouAfoT+giI
gBK0xCX6MWO9tUJqbCA2Ix8BEcx6+79PeIluLYazQ07+jIKF+R9E8NnhYIHfZJWT
6XBps3j+TsmhimmRM7fH3y4BJ+t/aBWOq4BOzfLdx1EJud8jKDhD5iqlkrTS734H
KXA5xkhHZ7dDUR0cp4jV9w/HRi8qb6I0jVyIUO/dg8VOdE6cN8wrmwBvRXXhj+k5
MWX8HnpR0nEn4V2ICce8XdaWDSdTcFoC93tDveyxInkQEyYjGoj+ZgHjR71LxrCr
R2TQzOtImMRGHV7ZxzSbOT+LgoWyJsjmUrCU/0teVR+EsLQdz3/YfVbyRevnvacS
BSzzWMnfAUI2cfZZEaj6sTKchsY0saBc0l8B9Jg8yScZ8CsOuTo=
=gc/z
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
