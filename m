Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B597AC433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 23:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 734DC611F0
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 23:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhDKXw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 19:52:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59514 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235768AbhDKXw4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Apr 2021 19:52:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 943616041F;
        Sun, 11 Apr 2021 23:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618185128;
        bh=LXwzEGOtwXfjdsDEWhfrWvgp7oGGwJ6A3kbcUoI5YF8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jm+R0DO7judIRuv8JYQ1dmCEQMY3xRH6HHbZOdKSLB6tForKUi3Buc/mg/eJEk+l+
         k90l8Cm/eM3YPsICtKNGSBLxAMnepQcio5ZLxMcp3yIND/sa2Ka0e/fPTapd6V0bXf
         EjcvUsVeLlz63yDlwRbP5i5JRP9pAZx4aRQNzEux0e77cktgjqZtcAx82RKGQojvVQ
         pd4gcv+w0U9lFZr994dnVmLgCb7WPu2NwgyBHwTHgdUpE4Yglv3JcI2YsGBfu/Wczx
         1yCReNnWvZ2Dg7HTzAUHDNP2wizawhPrGAH5Zooeciopdc6fUEcuKHbdqViyVtb8um
         XTJDowphSb49Yqu2KJ8ar5oCfV0PmJ1iMYItE6ssbl5j+ZBdyU2Sjy1G8TPRcS8d1G
         LhV4MSAyZ20bqrJSbR1sOSHQfj0axMK0E8I8cdAlv8DdF6FRxX8ppyv5C/Tj3cxpoh
         5NgVyle711Aszg/j1iOckxF5vQbW47xipQ99bXeujaQBEaSY2uF
Date:   Sun, 11 Apr 2021 23:52:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 09/15] hash: set and copy algo field in struct object_id
Message-ID: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-10-sandals@crustytoothpaste.net>
 <87k0p9f2z9.fsf@evledraar.gmail.com>
 <YHNusqcmwv75P6Ck@camp.crustytoothpaste.net>
 <87wnt8eai1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="47YmQYLRaL6NG91h"
Content-Disposition: inline
In-Reply-To: <87wnt8eai1.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--47YmQYLRaL6NG91h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-11 at 22:12:38, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sun, Apr 11 2021, brian m. carlson wrote:
>=20
> > On 2021-04-11 at 11:57:30, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >>=20
> >> In this and some other patches we're continuing to add new fields to
> >> structs without using designated initializers.
> >>=20
> >> Not a new problem at all, just a note that if you re-roll I for one
> >> would very much appreciate starting by migrating over to that. It makes
> >> for much easier reading in subsequent patches in this series, and in
> >> future ones.
> >
> > I'm happy to do that.  I thought we were not allowed to use C99 features
> > because only recent versions of MSVC support modern C.  I was previously
> > under the impression that MSVC didn't support anything but C89, but they
> > now support C11 and C17 in their latest release[0], much to my surprise.
> >
> > If we're willing to require C99 features, then I'm happy to add those.
> > I'll also send a follow-up series to require C99 support, which I think
> > is overdue considering the standard is 22 years old.
> >
> > [0] https://devblogs.microsoft.com/cppblog/c11-and-c17-standard-support=
-arriving-in-msvc/
>=20
> I don't think we can in general require C99, e.g. I found just the other
> day that our CI's MSVC will fail on %zu (to print size_t without %lu & a
> cast).

That's a shame.  I think I'd like to try, though, and ask people to
upgrade MSVC to a suitable version if we're going to continue to support
it.  It's not like there aren't alternatives.  So I'm going to send out
that series anyway, I think.  That's independent of this series, though,
so I'll add the designated initializers in v2.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--47YmQYLRaL6NG91h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHOLowAKCRB8DEliiIei
gf+ZAQCnbZiK7RLb+0lGxziV2bwcEdj1zeAZPcFqOnFPLAqnHQEAwol9mSA0UiKl
/E3P95DaY2AOqiqku+y/PW4cQBQT0ww=
=5W25
-----END PGP SIGNATURE-----

--47YmQYLRaL6NG91h--
