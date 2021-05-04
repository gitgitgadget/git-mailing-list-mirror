Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD88C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 23:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4B46100C
	for <git@archiver.kernel.org>; Tue,  4 May 2021 23:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhEDXTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 19:19:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47892 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231226AbhEDXTb (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 May 2021 19:19:31 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E5C5A6042C;
        Tue,  4 May 2021 23:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620170285;
        bh=4P1q/4DJynY0I+QxOS5BC1JT6rS3qRMfPrysB59i7pE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dym7y5kafB7rYf+kxeFthNWvEAQ815NGdzZ63x2kImIj/D/1huDO+JioHcTBMCUV5
         tCbWAhTt8OXu56MiBk0VLWkkRt+nOyG3QcXMcvYp9Xc06H45c4YiqYz0BacDvNJzBy
         UZZJ3vefnvyiCsPk4DDTcO1YZddi8krlE0z//JYrQVIiD0DWCe/JVBF19JzKKZ0fb9
         lk2au42QBmNYPdtzqU/oL6X6zxf5IUKqL+PyOBetbTVrPlHD0gSgMKs5rg4T0KrWIN
         0faO3hookEvvyTjRTEvKJPuEAdhSy3ndfwHF9c8wLcrD1T+7XZiDrO30Vx+IQfteIz
         tm4bitxYdS4laIYv5oyYimR2vzRHQTeiloxIgN74siK7tpFzuQTlMBVYhyP430WboU
         5YbAvUwruYldbG1/6CbU8s7aru+hj/xq1nSLcXX1pswhxUVg/SZx74j8Ca4M9F9UIG
         w7zNa5/MELeZIAPw3NDMUoej3cGdD9fZeLs+uEqGywv3zBRHoIE
Date:   Tue, 4 May 2021 23:17:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] CodingGuidelines: explicitly allow "local" for test
 scripts
Message-ID: <YJHWJRYOcFEvHoD/@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <xmqqfsz4a23x.fsf@gitster.g>
 <CAPig+cR19WDY1=qTbJMCzxeXjV4XtEddS1+=H8Cj6NUi5ZdN+w@mail.gmail.com>
 <xmqqsg348k9j.fsf@gitster.g>
 <xmqqo8ds8k6r.fsf_-_@gitster.g>
 <877dkgxk9p.fsf@evledraar.gmail.com>
 <xmqqpmy76w31.fsf@gitster.g>
 <87czu6wuf3.fsf@evledraar.gmail.com>
 <xmqq7dke7jeo.fsf@gitster.g>
 <87a6pawmyu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vy1cpZm5VAw8nxEm"
Content-Disposition: inline
In-Reply-To: <87a6pawmyu.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Vy1cpZm5VAw8nxEm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-04 at 15:09:54, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Tue, May 04 2021, Junio C Hamano wrote:
>=20
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >
> >> It's effectively synonymous with saying "we still want to support git =
on
> >> platforms that are so broken they can't even run a single test in our
> >> test suite".
> >
> > Not really.  Those on such a platform would (rightly) say that it is
> > the test suite that is broken and out of compliance.
>=20
> Indeed. But the lack of any reports about that suggests that in practice
> this is universally supported enough to be a hard dependency.
>=20
> In any case, it's clear you don't agree and you manage the patch
> queue. So I'll leave it at that.

I don't feel very strongly, but I would be fine with requiring local.
One of the main reasons the Austin Group is having trouble standardizing
it is because some shells implement it with lexical scoping and some use
dynamic scoping, but if we try not to make too many assumptions, we'll
probably be okay.

> My aim here was to discover if we had any reason to think that "local"
> was less universally implemented than other POSIX/C89-plus features we
> rely on. It seems that it's not.

"local" is missing in AT&T ksh.  As far as I'm aware, all of the other
major open source shells support it: bash, dash, mksh, posh, and zsh,
plus the default shells on most BSDs, so there are options for people
who would like to use Git on systems with a less capable shell.  As a
practical matter, that means someone on a proprietary Unix or possibly a
non-Unix system.  In the latter case, we've only seen Plan 9, I believe,
which is so devoid of reasonably functional basic Unix tools that it's
probably hopeless, and therefore we really only need to consider Windows
and Unix systems.

I should point out that we also make several non-POSIX assumptions about
shell behavior in our testsuite.  I fixed one in c64368e3a2 ("t9001:
avoid including non-trailing NUL bytes in variables", 2019-11-27), but
the other one we make is that all components of a pipeline are run in
subshells, which is not true of AT&T ksh or zsh (in zsh mode), which run
the last item in the main shell.  This assumption used to break running
zsh on our testsuite, but the developers recently accepted a patch to
make zsh in sh mode emulate what all other sh implementations do because
this assumption is so widespread that, as a practical matter, many
things break in such a case (the Git testsuite being one of them, but
also things like Debian's debconf).

So I'm okay with requiring a little more than POSIX behavior here
because as a practical matter we already do and POSIX permits a wide
variety of behavior which is never implemented (e.g., running something
_other_ than the last element in a pipeline in the main shell) and which
we could not practically test.  I agree that we should aim for targets
which provide excellent compatibility and that when in doubt, we should
look to POSIX.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--Vy1cpZm5VAw8nxEm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJHWJAAKCRB8DEliiIei
gVX5AQCdQChS3UEOu31eLMmjsL63UiPP/hSNYB1pxXPt/7HWmwEA8XEIOiyhV2f4
/0dju7ZD6VEgxty4A20DcLobWmyLBwg=
=ZxP0
-----END PGP SIGNATURE-----

--Vy1cpZm5VAw8nxEm--
