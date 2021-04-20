Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8C8C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934456141C
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhDTXOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 19:14:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38100 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233964AbhDTXOo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Apr 2021 19:14:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 61D036044F;
        Tue, 20 Apr 2021 23:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618960451;
        bh=HL9UttM14C5+ThpJnf+tGsT0+iP+i2IDgnfnmP7/Fqw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QpxIbmxbc90XvjW4SDHvTHV+Y8X1PjeNAbSvB2s90S13ZC+847WpgUiTwQa2NyLhU
         FbIFa57s2kKwkK7e0aU43GcgnOfEB1/4VLfPFydZqY+AddYxZvz6CSKlrERFi8iRIS
         6H0OyD9jUytiwBpmXd3K7tfhc7mtkXkEKTkXCXINDkEzIEs/FEL/Muget1NlRN/dZe
         oo1v/Nj7RC8HtmKpA6ljKXQhGRdxH+wp2Ez4ecfpCw9wwfhYuHOkdZdEOcPzsdLKSW
         jYtCJyO4xg+GPbEHhRhZTBhoagCiX2W3AnA53QzCFJz5symYLMXk/c+XEM3AS/aEau
         CQlSRXmiZOBReLFrSKVMZBExYEHm9YTuDCG0djzfy/404ZAQC9mzh+kmNi/eGE3hHt
         KX7VHS1Ud6JQzwlJLi/OjvfEBYsMkUzyZ5ghoG76nahypIqsBFtjrJ0fS/5OBI90id
         CAU65VIrGdZyjhtxlMQxMvb7f5CPWCAdNELLuTbHaFcTOy3EOhu
Date:   Tue, 20 Apr 2021 23:14:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
Subject: Re: What's cooking in git.git (Apr 2021, #05; Mon, 19)
Message-ID: <YH9gPt410QBRjG59@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
References: <xmqqtuo17t6t.fsf@gitster.g>
 <87mttt2hcu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FGM4kBYtec6ZYe5V"
Content-Disposition: inline
In-Reply-To: <87mttt2hcu.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FGM4kBYtec6ZYe5V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-20 at 13:52:33, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> This has a textual conflict (no longer a semantic one) with the above
> ab/unexpected-object-type etc.
>=20
> As noted in
> https://lore.kernel.org/git/87mttx121j.fsf@evledraar.gmail.com/ I had
> questions about the approach in hash-object.c, in particular I have
> POC/WIP patches that make one of brian's TODO tests pass, by doing the
> "we are in SHA256 mode" earlier, which is also less code as we won't
> need to add special handling to a large part of hash-object.c (or, in
> the future, other such commands).

I'm going to drop those first two patches for now, since I plan to
implement them in a different way in the future.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--FGM4kBYtec6ZYe5V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYH9gPgAKCRB8DEliiIei
gURrAQD+D621yUREe9qtHtdOi0MyxC88ggHoscU1JxemFzZ7SgD/TTW0Rm4S78w+
g7eD9TD1QZsMfTmdd6gGvi6C7A1a3ws=
=6XeU
-----END PGP SIGNATURE-----

--FGM4kBYtec6ZYe5V--
