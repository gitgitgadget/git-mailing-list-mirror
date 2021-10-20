Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59158C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 21:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE146128B
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 21:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhJTVWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:22:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37644 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhJTVWH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Oct 2021 17:22:07 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2DD4060734;
        Wed, 20 Oct 2021 21:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634764762;
        bh=MynkZACLtj/QUOUzj9bdS1gfJ0CBnklmlvEBv1YB3IM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=C+qzkODsOLW4JF/z7rFxuUxarkYNQRk+m8vM0gETZFgxB4MMod0Tmf3+WE/g0+Cob
         /porP51hyYv5yLgkZs+5UKUREUIhJrwG0eWVzbQnHObzd2x0c9JhLArwv70gIgUr0/
         wWyMfWI6EfwqoB5hQ8rNWlr9YED8PS3e+fCiZdIuWNKs73wZzbzWMoVTud1vfN04oM
         YDb/8d11A/jej6AzI0zyMsBGrMOMylcf5kfQLNGLOsmgVoMi1O0CaHXHSP1hP4L7+5
         lUCv1IjbSmg3wOynSOlfeLU5ejLjPjE2+hgnJgyi512L7qsTwJiHYU19nS9qPTEQ3T
         LU47NncsJLSxh3vb4Lcy2/O0ojPIIrTKh88DyTv1SkmcUBo/Nzhnd6yfyTbZGTCmtL
         miVfbWvKyRJH/F/y0tQknHCJy9U6jVpKxBcMDXX10CL2g8YDAIgEg15/TXt7BeZD38
         o68k/04YjDep4hpxfBvP6kw4rInXDgR8ti6rHYKKxKZiNZ1j10F
Date:   Wed, 20 Oct 2021 21:19:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] gitfaq: add advice on monorepos
Message-ID: <YXCHxdYot+fCHwl1@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-2-sandals@crustytoothpaste.net>
 <211020.86h7dcndlm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ti49uDDHtqrfizX/"
Content-Disposition: inline
In-Reply-To: <211020.86h7dcndlm.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ti49uDDHtqrfizX/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-20 at 10:54:47, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Wed, Oct 20 2021, brian m. carlson wrote:
>=20
> > +[[monorepos]]
> > +Should we use a monorepo or many individual repos?::
> > +	This is a decision that is typically made based on an organization's =
needs and
> > +	desires for their projects.  Git has several features, such as shallo=
w clone,
> > +	partial clone, and sparse checkout to make working with large reposit=
ories
> > +	easier, and there is active development on making the monorepo experi=
ence
> > +	better.
> > ++
> > +However, at a certain size, the performance of a monorepo will likely =
become
> > +unacceptable _unless_ you use these features.  If you choose to start =
with a
> > +monorepo and continue to grow, you may end up unhappy with the perform=
ance
> > +characteristics at a point where making a change is difficult.  The pe=
rformance
> > +of using many smaller repositories will almost always be much better a=
nd will
> > +generally not necessitate the use of these more advanced features.  If=
 you are
> > +concerned about future performance of your repository and related tool=
s, you may
> > +wish to avoid a monorepo.
> > ++
> > +Ultimately, you should make a decision fully informed about the potent=
ial
> > +benefits and downsides, including the capabilities, performance, and f=
uture
> > +requirements for your repository and related tools, including your hos=
ting
> > +platform, build tools, and other programs you typically use as part of=
 your
> > +workflow.
>=20
> In the context of git development we're typically talking about really
> big repos when we're talking about monorepos, saying "monorepo"
> communicates among other things that the user of that pattern is
> unwilling to use splitting up as a way to address any scalability issues
> they may have.
>=20
> But a monorepo doesn't really say anything about size per-se, and it
> would be confusing to conflate the two in a FAQ. I may be wrong, perhaps
> the term has really come to exclusively refer to colossal size, but I
> haven't seen or heard it exclusively (or even mainly) used like that

I routinely hear "monorepo" used to imply repositories of specifically
large size.  However, I'm happy to rephrase to make it clearer.

> I bet that the vast majority of monorepo users are never going to
> experience scaling problems, e.g. having your laptop dotfiles and
> automation of /etc in one repo is a "monorepo", and most companies/teams
> that use monorepos I'd bet are in the long tail of size
> distribution. They're not going to grow to the size of a MS's, FB's
> etc. monorepo, but they might benefit (or not) from the monorepo
> /workflow/.

I almost never hear individuals refer to such a configuration as a
monorepo.  Technically, it is one, yes, but I almost always hear it in
the context of an organization's repository covering all of their
services or the entirety of one major project.

I will point out that I personally would run into scaling issues if I
put all of my projects in the same repository.  I have many projects,
and that would quickly become unsustainable, since the resources I have
at my disposal are more limited than most organizations.

> Anyway, all of the above can be read as a suggestion that we should
> split any discussion of "large repo [that runs into scaling issues]"
> from "monorepo", the latter should of course make a passing reference to
> scaling (as the pattern will lead to that sooner than not), but IMO not
> conflate the two.

I'm happy to clarify, but I think we need to mention the word "monorepo"
specifically because (a) that's the term that's commonly used for this
approach and (b) that approach is one that tends to lead to
significantly greater growth in a single repository leading to scale
problems.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Ti49uDDHtqrfizX/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXCHwwAKCRB8DEliiIei
gVQWAP9Gbzk9CoMfMLBGiPvxWWl+1OI8cyJNOk3HO1s/oMhpzwD/Z/5ArnQfZS7t
ifp9Q4kDabiKl4bWeJrF6l8yOB9+NQY=
=ILd9
-----END PGP SIGNATURE-----

--Ti49uDDHtqrfizX/--
