Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F8D1F428
	for <e@80x24.org>; Sat,  8 Sep 2018 16:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeIHVfc (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 17:35:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49316 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727621AbeIHVfb (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 Sep 2018 17:35:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e898:2700:1917:e610])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AE7FC60737;
        Sat,  8 Sep 2018 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536425346;
        bh=ZupmeCGY0gOqc/1vqpt6thNfHWBzMNlNsCdfMW8iIg0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=UMsae9HQehdemj+7QJnu+XT0FBwgUaUPP+hwOhZbY447AAM2t+PGSZxyi8NYE8Uex
         ayBsoiLH8OYhY48AHhXD2+c8z0bBJ+lvl+3VbIFGE/6vvoh5uboU8wiYM9C1nLVxbR
         evVcUJQnwj0DZglhjs98p7/UMngrLkhxRFuPtdeMrECEf0HtqZFQUvwzyram140IKy
         RKB8AtGMfxCqJ+uABUu+lfW0ZNGWZtraei8Dl2glywI4kCHNNS76fGvDpatD2d80sg
         somIvArMzOSjOxzlKrjT4K03ft1dumzf7afzYtJMq2nRmvaBTWiSqRvEbJepSVYfO9
         CL3e3yv0XILczJiBZLxTdeoiOg9e4xV+ly8xmbrHYzkNOLW7E6NQonSMLzxKSKvE7i
         N/tFgIv4BXiY3S5kI1PmumexNP9YIa0E9QYJiVkdzBdtBann7ZIi4bNn2cAn/OWT54
         edtzeAxzdIxbxd0F/gZXenSZs3SUdGz9lDhMLaBa5tvPKf5cJ3K
Date:   Sat, 8 Sep 2018 16:49:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Tim Schumacher <timschumi@gmx.de>, gitster@pobox.com,
        pclouds@gmail.com
Subject: Re: ordered string-list considered harmful, was Re: [PATCH v3] Allow
 aliases that include other aliases
Message-ID: <20180908164900.GP432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Tim Schumacher <timschumi@gmx.de>, gitster@pobox.com,
        pclouds@gmail.com
References: <20180906191203.GA26184@sigill.intra.peff.net>
 <20180906192021.GB26575@sigill.intra.peff.net>
 <20180906235033.GA100309@aiede.svl.corp.google.com>
 <20180907032401.GB31728@sigill.intra.peff.net>
 <20180907063241.GA172953@aiede.svl.corp.google.com>
 <87in3hrcya.fsf@evledraar.gmail.com>
 <20180907072353.GC172953@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gQt10JDuGyDb0HQ5"
Content-Disposition: inline
In-Reply-To: <20180907072353.GC172953@aiede.svl.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gQt10JDuGyDb0HQ5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 12:23:53AM -0700, Jonathan Nieder wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > If this turns out to be a common use-case perhaps the easiest way to
> > support that would be to make the hashmap (optionally?) ordered, as Ruby
> > 1.9 did with their hash implementation:
> > https://www.igvita.com/2009/02/04/ruby-19-internals-ordered-hash/
>=20
> That's about recording the order of insertion.  I'm talking about
> something much simpler: sorting an array (as preparation for emitting
> it) and binary searching to find an entry in that array.

If you want both a collection that is always sorted and has efficient
lookup for an arbitrary entry, then a B-tree is probably a better
choice.  That's the primitive that Rust provides for that situation.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--gQt10JDuGyDb0HQ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluT/XwACgkQv1NdgR9S
9ostQg//ev4oCfim6gkbjCHEkNTM8Y3hPbl8eRqmQ77nD6ilgbWLHwzkpQSGvbBv
YO2S6ELxDs4leamVB5qIY3bkw02odgwkfvU/g1cotF2mMDWDa83W6UAL2KgV/2dw
rwyRie8jYzkyrUdmfU0WeX7SaFqBLTCLyYtrbD1eRw0YwBiDeasnjHcu4VVLmAsE
XDUAXCGD1Y+cBt0F0dbaitO0EafYObNDrfe8PLwrdQIgHLQSSOdWawdw3rsO+JZn
BD3tISDyMMqNSNVbbZ/5H6+8ZTx54/xsIHq/2rzEZR4tOSTFrTwYcML3UVKht1Th
7vtlc7ynS9Q4MQZc8o3v7IEx7+q7t3JGKBqtmSXevmeryiimRphBQUUvPDEbztEz
xbf0qQcLMdDzZeD0S9dDrLztJWH1vVGqjJFuA37wIeuSacAEEDvnCcpxhaXlWwG2
5X+Hi3as7viz8iiF/XTgwEoHYFTdoYiyaRdX0UF9QpM4HzCQNq6wCeY4Cpz+S2cM
D+Lvbit9WAw2YLFx/k8T092iWWuLVpPxafRWHtc3NUt9VSNb9uW1vLNx6J9zuxtb
Es966sbCxv4KgL9Oc26/zr1ym3LbPq7zyvNnBsrUiAcdO6GZ2mXyQBK7SFcOSFtJ
MSYOBTvz7IWQA8niEYVF5DxFXNu8nRD8YTwxb6Ny+Z9PrYFVGwE=
=56d2
-----END PGP SIGNATURE-----

--gQt10JDuGyDb0HQ5--
