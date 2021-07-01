Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC626C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 21:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E54761405
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 21:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhGAVUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 17:20:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33194 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233080AbhGAVUh (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 1 Jul 2021 17:20:37 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3B1B760450;
        Thu,  1 Jul 2021 21:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1625174286;
        bh=5wbqIWB0GQlPKTjQl3jYS4jFAwu9tNgXHnFg7QC11p0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XY8EGdwiRmvXNhtZqLPMDC6KXdbp/Tda/HPuiQ/JOzn5Qdz+74k2j/8BzFpiJQByj
         pFTyaL1tgTUeGrP3PVeK28hDsl72fsQ6omRtoX3mTICSdiFE5Di0+sQtD3PRHn5bdu
         fa4WSPkMXXuS555MJCORBfe1gMprvA79DQ+IPgtzvXxi6P1dMkXUm3WRf8s+L3Xjwy
         2BwR+4lQ+K4fF+7J60zUkghH9mp3fJyd3oODLbDJcqS3xeMNzIdPkpFpzScJ9S7WaR
         hhoAVGQaETDnAMYqRD0mpAq5i7GXAeI2tji5tqK11q/6g/TkrGU6QdcVc5U1Yup93V
         DiKXcPnXnhEgpl2JsSdeV4HPxgSBZ2H6+3oPy/KXoJ3kp6Xn/u74g0G3yHBtzG0HQf
         8yYeHp0wBDlbCA31g8t5dBniysmHi1SLWqWfzR62xb0yH73Z7pDsMenPOD4GYUXg9l
         n4UQLESXR2jU0PXjcIaLwJqkAJZhh9f5Vqhp3jtIY9GoAggfxv9
Date:   Thu, 1 Jul 2021 21:18:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Structured (ie: json) output for query commands?
Message-ID: <YN4xCRDi3JwMc+S0@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CACPiFC++fG-WL8uvTkiydf3wD8TY6dStVpuLcKA9cX_EnwoHGA@mail.gmail.com>
 <CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com>
 <YNyxD4qAHmbluNRe@coredump.intra.peff.net>
 <YNzR5ZZDTfcN2Q+s@camp.crustytoothpaste.net>
 <YN3mk0LnyJyuQ+9T@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDNJgr3oL++Op4hr"
Content-Disposition: inline
In-Reply-To: <YN3mk0LnyJyuQ+9T@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dDNJgr3oL++Op4hr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-01 at 16:00:19, Jeff King wrote:
> On Wed, Jun 30, 2021 at 08:19:49PM +0000, brian m. carlson wrote:
>=20
> > On 2021-06-30 at 17:59:43, Jeff King wrote:
> > > One complication we faced is that a lot of Git's data is bag-of-bytes,
> > > not utf8. And json technically requires utf8. I don't remember if we
> > > simply fudged that and output possibly non-utf8 sequences, or if we
> > > actually encode them.
> >=20
> > I think we just emit invalid UTF-8 in that case, which is a problem.
> > That's why Git is not well suited to JSON output and why it isn't a good
> > choice for structured data here.  I'd like us not to do more JSON in our
> > codebase, since it's practically impossible for users to depend on our
> > output if we do that due to encoding issues[0].
> >=20
> > We could emit data in a different format, such as YAML, which does have
> > encoding for arbitrary byte sequences.  However, in YAML, binary data is
> > always base64 encoded, which is less readable, although still
> > interchangeable.  CBOR is also a possibility, although it's not human
> > readable at all.
>=20
> I don't love the invalid-utf8-in-json thing in general. But I think it
> may be the least-bad solution. I seem to recall that YAML has its own
> complexities, and losing human-readability (even to base64) is a pretty
> big downside. And the tooling for working with json seems more common
> and mature (certainly over something like CBOR, but I think even YAML
> doesn't have anything nearly as nice as jq).

I'm not opposed to JSON as long as we don't write landmines.  We could
URI-encode anything that contains a bag-of-bytes, which lets people have
the niceties of JSON without the breakage when people don't write valid
UTF-8.  Most things will still be human-readable.

We could even have --json be an alias for --json=3Dencoded (URI-encoding)
and also have --json=3Dstrict for the situation where you assert
everything is valid UTF-8 and explicitly said you wanted us to die() if
we saw non-UTF-8.  I don't want us to say that something is JSON and
then emit junk, since that's a bad user experience.

Ideally, we'd have some generic serializer support for this case, so if
people _do_ want to add YAML or CBOR output, it can be stuffed in.

> Our sloppy json encoding does work correctly if you use utf8 paths, and
> I think we could provide options to cover other common cases (e.g., a
> single option for "assume my paths are latin1"). I think life is hardest
> on somebody writing a script/service which is meant to process arbitrary
> repositories (and isn't in control of the strictness of whatever is
> parsing the json).

I think I'd rather provide a general encoding functionality than try to
handle random encodings.  I _do_ want people to be able to do things
like store arbitrary bytes in paths, because many people do use that
functionality for shipping test files that verify their code works
correctly on Unix systems.  I also want us to handle arbitrary bytes
where we've stated that's a thing we support (e.g., in refs).  I _don't_
want to encourage people to use non-UTF-8 text encodings, because I
firmly believe those are obsolete.

So, correct binary data support, yes; non-UTF-8 text, no.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--dDNJgr3oL++Op4hr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYN4xCAAKCRB8DEliiIei
gQgdAP9hjf2HrQ3nrfG5tFPbnDoqNJnRG1RzulJPRaSP5SesEwD/eEq8IX6WMWFq
5CjWflijYVCKlJcBge86wHptoRW4Vgk=
=Ab1/
-----END PGP SIGNATURE-----

--dDNJgr3oL++Op4hr--
