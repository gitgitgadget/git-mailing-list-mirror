Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54648C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 22:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A9A613FB
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 22:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243727AbhDUWeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 18:34:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39004 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235362AbhDUWeI (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Apr 2021 18:34:08 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0D6C76042C;
        Wed, 21 Apr 2021 22:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619044384;
        bh=pgtFyabPkQqmFSGzN25CVkl7hiAz5Cdqo8HorYi++yU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vPJsysiPobQAWnwARWtxXXB3+fmoe0R0qHcTy5wifPPxn8i4daSkb0GBsQNHrtB5m
         wS25nfm6Wx5t2c+XuN4Au2zhAwuyY+FXoUeJFlGttwOZcth1/K87hasz/FqkaxBl47
         XVUJjnjO0/QfFsxCYShnGRU1wMjBzW5YywxFlFakaRxmI1Dd7dgnRuFz/f6xOcFoCq
         ed2K0ajGtekaXY7xfdug2NTl7woZA9n6+CEdffYs8e6I8he5KxgyUcID8oDCGVXAue
         So1IxmLhrQxCkxxxkkpy1MWtf6l3ypEZPm1Sudcwcnd8ODLxubXCuypZf4+2vFadAR
         xj17ozVul2PngZNMijeFOUsjMWV1JJhzlIRovjMgue824w8A/woFKyTRObQtCm80s8
         fO/R7zUfU3yQ7S/+UIdhCZ0/tMDQ4idTdDujhPUvf0Izu0Y2H/j+WAdfzHdNUA2mG5
         Ks6NFHuyLEUp+sJ4I/53fA0d1KU+zbRUr6wyrYYa39zNP0ek/cp
Date:   Wed, 21 Apr 2021 22:32:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
Subject: Re: What's cooking in git.git (Apr 2021, #05; Mon, 19)
Message-ID: <YICoGeaxHdf6pemo@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
References: <xmqqtuo17t6t.fsf@gitster.g>
 <87mttt2hcu.fsf@evledraar.gmail.com>
 <YH9gPt410QBRjG59@camp.crustytoothpaste.net>
 <87tuo02gdd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Swl0Rq7kzf8gsLYM"
Content-Disposition: inline
In-Reply-To: <87tuo02gdd.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Swl0Rq7kzf8gsLYM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-21 at 08:26:06, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Using something like the:
>=20
>     git --object-format=3Dsha256 <cmd>
>=20
> Approch I suggsted in
> https://lore.kernel.org/git/8735vq2l8a.fsf@evledraar.gmail.com/ ?

Yes, I generally like that approach and will likely adopt it with some
modifications.  For example, I think we'll still need some sanity checks
to be sure that we're not allowing users to specify a totally different
algorithm from what's in the repo when working with the repo because
that will likely break things in a variety of ways.

What I want to do right now is figure out what additional changes are
going to be required and in which programs these changes should be made,
and that requires that I do more work in the series so I can have a
better idea of what's involved.  Since that's going to take some time,
I'm going to drop those patches so I can get the rest of the series in
shape.

> In any case having something like the OPT_OBJECT_FORMAT() I added in
> that WIP patch would make sense wouldn't it, to reduce the duplication
> of current "object-format". It would also save each current caller from
> doing the "unknown" and other sanity checks, since they could rely on
> parse_options() having died in that case.

I agree that's a nice improvement and would be happy to see it come in
independent of my changes.  I'll probably pick it up sooner or later if
you don't get to it first.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--Swl0Rq7kzf8gsLYM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYICoGAAKCRB8DEliiIei
gVsBAQDkjYosIu0s+LXpNJUAKxnaFJRpWuUCoBty+77t2LkWRgD+OS1hKC8kM7ti
tl9xyCUXtvJWPGOg28UwyA/QOnp6QwY=
=405j
-----END PGP SIGNATURE-----

--Swl0Rq7kzf8gsLYM--
