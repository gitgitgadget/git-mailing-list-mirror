Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897F0215F4
	for <e@80x24.org>; Tue,  1 May 2018 02:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbeEAC3l (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 22:29:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37002 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751512AbeEAC3k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Apr 2018 22:29:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B121960129;
        Tue,  1 May 2018 02:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525141779;
        bh=C766+kfwHO+pyb5htMISDurMwskQs44CY358GmIEZTI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=k+71TuUWiceXy5elInfGGmejUxH4cRHtA05iE0MHqFZ2wQ9jr9OqLxp0TSLJu08WF
         a5gOOcqlXtLwiMb1+5CGke6OZw4t9oRY8lyx8+v8y8pAnYQtMXSH4TY1kOsz/eWdPG
         ykxOK/KUxdXyiXMs1duNIsCzxqpriUOBfDZ/6xw3AS15tSjw2UTf3IgbjRhC5epUfl
         Aw2qzZpcMYvdO+slEpOA0hGxAR+0RA8qzQ5J8kw2vGA3yFWGpb5YpRdiY/CwPRPWtC
         n5o8qH0SRGENfm4kXsvBy0ZNo7okycYbBgIt/aF1pNrw7MgZrQcIHAIRlvyB1HBvEb
         dQh1+hvpWQdC1fjxFGUQ3Ttp6QzoFpFGS8AtwaqAenmtFnRIb7pDyjVJKp/SzrrA0U
         ytYxtqSQSaL/Dhc5Y5TPpKc3vdcdbb/Vdo+T/VbDdOALq7Fa/7AW1ZzkTyuYdSgKle
         4igMNFgbSiwcc1cep4XDkKrqWnSaO53O6axkS6V4e9JIJJOvLQH
Date:   Tue, 1 May 2018 02:29:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 31/41] wt-status: convert two uses of EMPTY_TREE_SHA1_HEX
Message-ID: <20180501022931.GF13217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-32-sandals@crustytoothpaste.net>
 <CAN0heSpoe7SgNZnYDHXS7ByMmh3TH+exaS40btK7pq21MZ3cEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Content-Disposition: inline
In-Reply-To: <CAN0heSpoe7SgNZnYDHXS7ByMmh3TH+exaS40btK7pq21MZ3cEA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 12:03:35PM +0200, Martin =C3=85gren wrote:
> Just a thought: Maybe it would make sense to have a function
> `oid_hex_empty_tree()` or similar to replace the
> oid_to_hex[_r](the_hash_algo->empty_tree) idiom. It would help avoid the
> buffer here, but also get rid of a few instances of code peeking into
> the_hash_algo. I dunno.

At first I wasn't going to include this change in the series, but then I
thought about what a good idea it was and decided to redo the
corresponding patches.  So I hope to have a v2 out tomorrow with this
change (and the rest of them) in it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrn0QsACgkQv1NdgR9S
9otCOBAAlAEDysM6fLfBpAyOvL1bQ9Mrb2WSr4DwMYQxvWM8lG7tNLvdhrjuNLx6
JSCsiQYFWIfWCZS4YCPBI27o+/oUMQ7sWCbDwD8wuqTZaxLQ1i9yTy3AK4wLQqdj
pisMEtS6ZiG7RH+o9dVpfSe6fJdpYckgPCw5tn/vcZN/tlTZVZHkwoPWApRMfD5l
QlS6OH+uRDj0YffezPxengz4WEjEkoSvJkz5dub/J264apacFBvXquxFoZqdqOpw
NiVb/bY5V754CXsDeiH9/rS6QXyDs6keR54wqUSYUupPrEbFc/PqVYXy/TEmeRul
DYIy0Up7ebgZhM4Eph8fmtu40UH5bWh1LMWEyK9aXmK/cRr3LywBXT/+qAw6Dt7j
SBFZndekki4Grb4Ye/T3kDl+8BUGJmYYAoTFuj57aEd8q9FtIsb2cSpYTKfCoVH8
n37rJDEmZmUDill+2ZfuNx/JAI2lKsBLDDH4gnHxj2A+9hEJoi2Us1rEGPSYbUih
odfnqCUV8+NiRLpExUp0OCIQYR/ce5QI6X8jPQE5u30v0QVZOe+M1s8aWkSFMoxS
C7qCjUca7f2NHPHcO5B6GNEsY7ioEN0LIcdokdIVfv/9DPPaMzM2l4rYaBv93zR8
AYV0QcQAMM/k9ESjEtvFL9r3B7bQfJTar9QLIaa3cK+VwTkPvs0=
=CZvM
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
