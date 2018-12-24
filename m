Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3BC20A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 02:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeLXCUz (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Dec 2018 21:20:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57928 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726361AbeLXCUz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Dec 2018 21:20:55 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0306F6042C;
        Mon, 24 Dec 2018 02:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545618053;
        bh=mzJoWa8ovg9FnK/xO0iilcQ2p0tLP7Vn6qpj41WBufo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bfAFEQYkGZKAjrigdisBcmBoy/5oCwFi1mhgEIIQQ4UNdz9HOwLMCeUyCjO8QttWB
         x3bNF1sELxR0QjHmb6BRMDQeW/HVgxBb3Wqgq/MozVxKc5wkb0hbKJCnM6MvhaLXNX
         JDfqW4ZcqPp/D0Vt+63nIIrSnCXvGWcZ7Lr0fT1UpGgV/V1Xtd9nACqzfkRZOu5rLq
         nME+yq5SeSgo7DmK+7C0/lNXM/lLs/Zmdn/B0K+samhVVGY7NZpQP7hdWfnRXpvhqm
         VHNCXy/x0Dx7GdEq+iAgpTtGn4bv++WgweMTseiVSGOqK+eHdKKEm/4GJZ47uzRyim
         XzS/ExZRVa489YWe8CUzw2GVongwJFquw+69PWjiqk2+Xw+2c4V9w8dz8f8mZ7YPJt
         FLeDBGnxKp+GEN3is4sbIi4OP8qWg7SwugkHEc2JBqhw7xCTRBZTSWMnxGbzvi6aiP
         5hEKSi7A2IsBR6VtC7TMgX9HBMwlJSw5ff1kGv5jqsH7OmVIaMP
Date:   Mon, 24 Dec 2018 02:20:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Passaro <john.a.passaro@gmail.com>, git@vger.kernel.org
Subject: Re: Can git choose perl at runtime?
Message-ID: <20181224022042.GE26554@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Passaro <john.a.passaro@gmail.com>, git@vger.kernel.org
References: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com>
 <20181221234231.GB10611@genre.crustytoothpaste.net>
 <87y38few5h.fsf@evledraar.gmail.com>
 <20181223231834.GD26554@genre.crustytoothpaste.net>
 <87wonzes23.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Content-Disposition: inline
In-Reply-To: <87wonzes23.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 24, 2018 at 12:34:12AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> Yeah, but my reading (which may be wrong) of John Passaro's E-Mail
> upthread
> (<CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=3DTzm5ydzeChBQ@mail.gmail.com>)
> is that for some users this is the path of least resistance to getting
> git-send-email et al working for whatever reason.

I think we should just ask Homebrew to ship a functional, complete Git.
If they need to use the Homebrew Perl to install modules instead of the
system Perl, then they should do that. It sounds like we're engineering
a feature that lets users shoot themselves in the foot to work around an
easily fixable distributor issue.

I'm sympathetic to the difficult job of distributors, but Git is not an
unreasonable upstream, and I don't think it's unfair to ask Homebrew to
solve this problem in their distribution.

I've commented on the issue on their GitHub repository, asking them to
address this problem.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwgQnkACgkQv1NdgR9S
9ou+UQ//d4bkLO7e0nB5HIEOHHwC4h51NZWDhKNqMSaw31JTnz0LjLSImWW9VwOY
5YBUSBDKB5G8pdmkkCSgO0gRkknZXhCM2c3Kt/TFnC6ozUGySa9SLfNwKXRnLa5z
Bg3UoqNpp4TGGGcyNzjQ1KY8ZgPr+YHtwamPpoqfxd0/LIZNWt6UhuXxQopQs2p6
Smj5S131eUJPoNz+GHtcm9C1KCzh0VCa7nDWwqL+tHS9dSnAmvDnTKoe/yVOhTax
bCFKNni4oY0drz+Uhn/TkYcVG9fFBofdhC/kU4zLv29gnYG+WW7A8Kft+RhzB08t
wqwB7OnNDum8mPMgtBdif53TdMFNHEpaM4IdCdGB0R8yXRFAkeQw+LaIgo+hovA+
rsw50UCHJM7fwWhQZE5SL5D+QWkmIc+52fpKM5gqrYbS1rl6ZlhHhmYaaMnmRkhx
DKaUICIeMgyNJHwVyiNUKjHv/dQkZxVt+FTNS3pyL8WiiUZzJ7Fia9hGB7yG9+zr
iKivjCjnvVGx7gEIIEvkhNWInOibVzeaVBIVYo3Io7VTea0w3jolOT2mrRSFCKyu
NtUg1BoVzVtjvKVA3TZQcWJ0WgMJzEmoeYPW5zywOWN/UHOfP94XkREnZNYu3jp3
DF+cYbjGOrOkZQMiUiHwRNX5IMczk4E175GrjBhDYq5a+ApKKzc=
=ddCY
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
