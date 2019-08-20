Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C691F461
	for <e@80x24.org>; Tue, 20 Aug 2019 22:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfHTWgR (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 18:36:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58152 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730273AbfHTWgQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Aug 2019 18:36:16 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 521EE6047B;
        Tue, 20 Aug 2019 22:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566340571;
        bh=9gQE68/WPC4debgY/t/9cZ2YqeelnY7C+o178oTQ4mk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Sx/+UieTv6+EZ7Ag0GT3HSo5to9oxbgSwYBhRJsot+WnEvlZ6HE/lbeTCpIWCZjhE
         43zK+8KfMhg/q2mvnZNhuAdp9G32aNRqWcqbmulC3n3OHBEifXLHBMv0rncGPQ2hMF
         QF1ubx5r6TC94eDyl2Nij14vrwqdTbs7Qr/UqTV05RtQq96wCoGJN3b4yImgG/S8xF
         7v88KBkIHHiFMG21RLw1QhKU4G8EEUvnWYi0gdhx1Dv1rDWxpx+Nd4WYGkSHC9SFey
         uHe7YybFSmFEJ7EPEkxIoiPsfJa722Uir5KgYVmCb/k9538uMTQ/XTZm6UynQykXJo
         ZTrBPD9W/NTgPOaF5aLV1B7+Q2aRz3feb+GNUfl7DtCMinqjxmebYEaKEoIbt6La5y
         5JOhMdBwPSMPq1BVt19NPhqQdEObH7P5gQbWSIwhW7HTfmzjSx1G8bcqSqQT0bJdTl
         anwKvWQJDWXhyW0UsPLFwlIDnx/T8F7jO6fKaQDLmBq35s7sJmj
Date:   Tue, 20 Aug 2019 22:36:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 02/26] patch-id: convert to use the_hash_algo
Message-ID: <20190820223606.GJ365197@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
 <20190818200427.870753-3-sandals@crustytoothpaste.net>
 <1d3b46de-155a-6072-5e44-2622ac821230@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M0YLxmUXciMpOLPE"
Content-Disposition: inline
In-Reply-To: <1d3b46de-155a-6072-5e44-2622ac821230@web.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.2.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--M0YLxmUXciMpOLPE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-20 at 21:12:00, Ren=C3=A9 Scharfe wrote:
> So perhaps this on top?  (Or squash it in, if you like, but it's
> certainly not worth a re-roll.)

Yeah, this seems sensible.  I'll include it if I do a re-roll.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--M0YLxmUXciMpOLPE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1cddYACgkQv1NdgR9S
9osrcxAAubhYljCZ8mxIsECyIWoW40l2xHN+gLvG1rRBbeR2NK5ij7zu3brwFQQO
XwsECu07xVO0X9Kfm/UUuuC+cvjyGPBDzLi5/1wy6oxWe/0j7/+G9kdcW4MXvexD
A2HetoDV1mN/Xos83umdu0/9kE1tqXTffkFAJKZQ8uZUxBWPuDfKp240aGobpD1J
8KSPllUB4hC84NXxn6to+1KCxwirFyoN423WPdiyxSXuX7milsntIpR/tXFEFvxm
aHpalUW6nFEGMJJe4mIGL1tpyUScelwLenB1/tl27dct2haxsoC/STpqi+cUSdJ0
NF13yaM57fBnOC30C4dAOkxLI9uk7s/XRdNisgJ2D0qj2huMNZGMilnjMnkqq/7h
bP0t4EQeIuZn0qM7LvmZtaYouYGfnexXIJG8V3lBT0dppkHBe1m3CyATURtMxI9J
ukCX3MDbG/40xJOEHm62nNxlEkAK4jgTkgBtvUJt3WfD8b0/tPHqREH7NAidpDyV
G1zxJeH4i47jGete2VYBhlpT5fyt0vHH8Rp5j7r3E6Xd0BqurdE71rd1IgeJuYVJ
Ja+9TqiBhwHMDKR+OmHTUUeppTIUae7bxmE0+9D2jXBU+NkYOP9QsfxKXYjzbqx/
3vrZe6Nl7oXuPBsEVpfDMEDI8SF8yTAiQ29iMigQo1AcLUE1sBA=
=tBjv
-----END PGP SIGNATURE-----

--M0YLxmUXciMpOLPE--
