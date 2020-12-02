Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4EEC64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 16:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBA6205CA
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 16:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbgLBQIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 11:08:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65246 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbgLBQIq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 11:08:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0375114A79;
        Wed,  2 Dec 2020 11:08:02 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=xr8SMfkBFig8ZzRwq/G5Y9ISIKg=; b=C/OU7a4
        UmB2bagYGDnaYlQ1VARWCwZL5wmNgivDP5N2Ckrxtm9hyQFROpXVS+4bPsetOsSq
        XxmaBO+FIrJwZ6Ok3qPxQYuMzCgzSO1b9KnZOqOfc1Vt133TyeDf/kUtm2JW1+GT
        ZQD4MMYFDDuqzEIGk6mep7ja3Q+xcU9XWBOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=krHeUy7/ppBBBDXpb8IVM/yRx67qb2Nvz
        g9b5Y56NtbQQl08gPomX+QXwp/zUu8GqyqiBLx3I+rKWHDjHllTRWVNfN4tuGZDR
        nrPRMlZs5zunrTPhAktQwHvFgusutbhnkLVLYu+ovSpAC1aVwLgXGqV8DrA6xEY3
        Irc7ZFHOyY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C84FF114A78;
        Wed,  2 Dec 2020 11:08:02 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.178.181])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D8F55114A75;
        Wed,  2 Dec 2020 11:07:57 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Wed, 2 Dec 2020 11:07:55 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arnout Engelen <arnout@bzzt.net>, git@vger.kernel.org,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: make HTML manual reproducible
Message-ID: <20201202160755.GX748@pobox.com>
References: <20201201095037.20715-1-arnout@bzzt.net>
 <20201201154115.GP748@pobox.com>
 <X8bhdyu/OlscI1ME@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GIrCAcOpC7mETZ4T"
Content-Disposition: inline
In-Reply-To: <X8bhdyu/OlscI1ME@camp.crustytoothpaste.net>
X-Pobox-Relay-ID: 8B6782D8-34B8-11EB-9445-E43E2BB96649-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GIrCAcOpC7mETZ4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

brian m. carlson wrote:
> On 2020-12-01 at 15:41:15, Todd Zullinger wrote:
>> I think this would raise the minimum supported version of
>> docbook-xsl to 1.77.1.  That might be fine, but we'd
>> probably want to make sure it doesn't negatively impact
>> OS/distributions which build the docs as a likely group who
>> care about reproducible builds.  And we'd want to update the
>> requirement in INSTALL, of course.
>=20
> I don't think that's necessarily the case.  I just tested using a random
> name with another DocBook project I have and it seems to work fine, so
> there shouldn't be a problem with specifying a name undefined in the
> stylesheet using xsltproc.

Oh, that's very good to know.  Thanks for testing the fine
details.  I checked that works on a CentOS 6 system where
the docbook-xsl version is 1.75.2, to test whether an older
docbook-xsl is similarly forgiving of unknown --param's.

> If we want this to be effective, then yes, people will need to upgrade.
> But if they're happy with the old behavior on ancient systems, that
> shouldn't be a problem.

Indeed.  Is it worth mentioning this at all in INSTALL?
Something like:

  -   The minimum supported version of docbook-xsl is 1.74.
  +   The minimum supported version of docbook-xsl is 1.74.  For consistent
  +   IDs in the HTML version of the user-manual, 1.79.1 or newer is
  +   necessary.

perhaps?

The explicit mention of the user-manual may be overkill,
particularly if we later apply a similar change to other
HTML docs (if any other HTML docs even need it)?

--=20
Todd

--GIrCAcOpC7mETZ4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQFEBAEBCAAuBQJfx7vZJxhodHRwczovL3d3dy5wb2JveC5jb20vfnRtei9wZ3Av
dG16LmFzYwAKCRBDJZOLvq8M4+D5B/91XeMxJ0hMrfA77H8pxH3ODwVcqBEFaoPP
Y1QVJL4j7/sIlqJj14KmpG3fDLU5fsN4JBlmSYLqJ17MOFK+PFEj2wcFe8QOBL70
15xLm3O8RGRkibisAnsEPbXYtJiTqOAxXU+5FzfXpxh5g4V1XhYb8idQljLUHh/7
Ck7ClJrREXT0zzhiotANsDiUXQlXz62Ley6Jw2Iv+BG1aK4RZjZTrYI99ZREmrRa
RI5DZMHlKQLLlX/hgpAKf8nyiezSDaTX/mdABeVhwAM6V+C5dY9eWNFx9X/5IGmh
xeWZun94dN2Qz94U8Xq6ZhgD2OMj3K+M70XwfttkX528i7UklSu7
=Hz2X
-----END PGP SIGNATURE-----

--GIrCAcOpC7mETZ4T--
