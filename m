Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE83C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 02:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1D120715
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 02:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgLGCjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 21:39:31 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55302 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbgLGCjb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 Dec 2020 21:39:31 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BD0B960751;
        Mon,  7 Dec 2020 02:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607308700;
        bh=gwtoh+hf8QG0ovMRCbboJFDJhq5lpENKMlmIwOSBTa8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ke4S1HjGsnl+WDA5yrwp22X/R3H8zbHOE9IJ0v2F677WfkcEKqBesesgwGCmPHDCQ
         xIBdL0PYZpLbhhDrzrVOUZs6JlP0E+oK0CktFAnLYqXuTT6bk5Hxt4FTgzVoqwNcBp
         +uTIouFYrAtR+ImHwDRBIMuoU8GLzM88c2x90hzn4VPhAxxXQVrXqcuHi9NCnC7jO1
         HdEk2VLU/NCPuymeFQrQjp5/eOyZ1Yiqsc5RZWIVxEomxGTq7UW1UT0KHxsrzI4FUT
         gKNOP6Wd9Ul7+ZO6c+0uDzjuRxD6P2oP1bz88SIUiiwbqttuqvHmqhHPU4FqadP0Ew
         xjiMPq9u3Lei0ChnfK4zUou2oZXNnPSmlB+yCEUbS3CEBQ4n0PmOuWCTKKv/6yxsas
         SYQbtAw4cFXF3m2HShlReUXZOaQnsHBfB6pT82q7YUuY/wYa1OlbZD7dKiXbmvPpo4
         DCMB/+Dblfe1T4XBhG6JUFU6kfeVyr1OYsyTtyzT467n8wOsOjS
Date:   Mon, 7 Dec 2020 02:38:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 2/2] rev-parse: add option for absolute or relative
 path formatting
Message-ID: <X82Vl7YmZ1/Sr4xS@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <20201206225349.3392790-1-sandals@crustytoothpaste.net>
 <20201206225349.3392790-3-sandals@crustytoothpaste.net>
 <CAPig+cS-2Vw84rejMFAiDeF8dd5gtBOmQZUMpOy2ufA8nU7W7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3nBQJlViqAgsgF4T"
Content-Disposition: inline
In-Reply-To: <CAPig+cS-2Vw84rejMFAiDeF8dd5gtBOmQZUMpOy2ufA8nU7W7g@mail.gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3nBQJlViqAgsgF4T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-07 at 00:30:13, Eric Sunshine wrote:
> I read the commit message and looked at the implementation so I know
> that this option can be specified multiple times, but this
> documentation only vaguely hints at it by saying "options following
> it". We could do a better job of imparting that knowledge to the
> reader by saying so explicitly, perhaps like this:
>=20
>     Controls the behavior of some path-printing options. If
>     'absolute', [...]. If 'relative', [...]. May be specified multiple
>     times, each time affecting the path-printing options which
>     follow it. The default path format is option-specific.

I'll improve the documentation in v5.

> Since this option can be specified multiple times, should it also
> recognize `default` to request the default behavior in addition to
> `absolute` and `relative`? (Genuine question. Maybe real-world
> use-cases wouldn't need it, but it would be easy to support and make
> it functionally complete.)

I don't think adding the default is helpful.  I can think of situations
where people want absolute path names or relative path names, but in
what case would someone want, "meh, whatever Git decides to give me"?

The problem we're solving here is that Git isn't consistent and can't be
used to provide valuable information that the user wants.  If a user
doesn't care what format the path is in, then they can always specify
absolute and it will almost certainly be correct and work for them.

> Leaking `realbuf` and `prefixbuf` here.

Will fix.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--3nBQJlViqAgsgF4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX82VlwAKCRB8DEliiIei
gYriAP9FVc4s2wNXrpBqzwBNhcpmshPkYz0trta5wcTqsvEPoAD8CP5syBApIYtD
eyEioU8Q0GNDR7Swc/qVHJ4fljmlKgY=
=4p2V
-----END PGP SIGNATURE-----

--3nBQJlViqAgsgF4T--
