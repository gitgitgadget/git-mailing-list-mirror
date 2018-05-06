Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAB4A200B9
	for <e@80x24.org>; Sun,  6 May 2018 22:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEFW4h (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 18:56:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41014 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751878AbeEFW4f (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 18:56:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E0B4160444;
        Sun,  6 May 2018 22:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525647394;
        bh=XprAacQyY/dxweCjkn8BUncno0aF7Zv1uGfD5ez/naI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cKPZpvIRx0obU6XjsQZ9zd5OJsdo1chaO8eYxZ3rNWunct720FAuX6Eos4ox1u3bk
         tCCqPEPlMy/IDbpHPykRVAXbV6+sAWbB0JGG5J/mKMs1tq3TZDG/jhzyutSaGnHzjA
         COXEHjUT9akvTvuyaNWtDJPzsoZTEJKyK95Wq5fg9CU5ozpsFtqNdru2lhgjEc8zf3
         2bO1MHfmTtai/OS0lZ/xNEg8Dy4kT5sm4bxhYeM+VhlDwL7DII8JFaJIUzuNGOxUCq
         Xf+Hx9i9J95+y/UnkimI3ab3VfP6wDpVIVXG2bfD39FGrZO3KYTofSGdZnwaa7TTlQ
         pwCzSlUy4PyDis0UttZUOyUFqQzCZUHa6Vxb0RpncGSLyGw5nuf+UxOSLi+tzC3Pxj
         8EHMhOMzg0ygj0DQ3GzbaGNJRmbS5PTbnQ9oD5undNcHwrDAkFyj1/RCRGrAEsJjaw
         1y1h2uG+UXQt/HRK96aVTsJ+Eb40P41eqm46OPUonYcgw5PFYiN
Date:   Sun, 6 May 2018 22:56:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/18] Add `branch-diff`, a `tbdiff` lookalike
Message-ID: <20180506225627.GB953644@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 05:34:27PM +0200, Johannes Schindelin wrote:
> The incredibly useful `git-tbdiff` tool to compare patch series (say, to =
see
> what changed between two iterations sent to the Git mailing list) is slig=
htly
> less useful for this developer due to the fact that it requires the `hung=
arian`
> and `numpy` Python packages which are for some reason really hard to buil=
d in
> MSYS2. So hard that I even had to give up, because it was simply easier to
> reimplement the whole shebang as a builtin command.

I just want to say thanks for writing this.  I use tbdiff extensively at
work and having this built-in and much faster will really help.

I did a once-over of v1 and I'll probably take a look at v2 or v3
(whatever's the latest) later in the week.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrviBsACgkQv1NdgR9S
9otDbw/+PLGHG4+TwUhWzrsYZu/rBZDQXY/OXCktirnxcn6343sFmHlqGWq3b29H
2XwUdvLxtrY+dEnlL+akGr6qcgnqsFJ+sxxsYuNlx1aFEM8flAG1ATCB6eGZo3/u
Dw9Avx6XvUuj1F20/ReHpebWX9GXdA3zgC7I0qcZkunWy4QBkp/gG7/PfKnA9KTm
hqev9V/d3J6wNDbV4mgNxShAe02qQpjk8VkIR9fLGf6beZOYcCpUWEeSeJ/yDasW
FtrQMFRoFct6reV/wdah3wsDfLtXdppy1lYim6Xvae932yftPFnVyq6zcFcFkSlB
5o3/45fpERTH6EEXiRmIeb4B6pfmWjf5ehvo+foTZi1nlgII9sLMufkzShKFjiao
zSS2BVP6XZ2LcdGRDQ8HDy7vfRkoPyjAa42Y3LVCLBmkGr8wkG2q0KFB1vAR0ExI
Q3NC0ttn5jBdVccAo0TebIKXgkIsF54X0Yle8XE/hf/0znChye0cBHtIsxMsfge+
7drwU2YMm5/P2MqYV1rqF+6is3OYMSbRg9IQE4NlEevtergMTKBgLJe3JPsAxqsT
flmomewolrDIwNSTThnbDAIgPsTlLZwNSW5qjxfYPdZrPPV2N32VojXhluD7/dw+
WUO9ZlNd468oKXr6d6ltkVt076MNcmj4m935IdFGi/5GkDNUS7k=
=S6RC
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
