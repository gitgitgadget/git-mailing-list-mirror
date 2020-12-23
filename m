Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55085C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1872422482
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgLWULT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 15:11:19 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38360 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728344AbgLWULT (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 23 Dec 2020 15:11:19 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0350E6076E;
        Wed, 23 Dec 2020 20:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1608754237;
        bh=VAdwEkEC3ixFJ0Hk2i669zDYtgEGtdchuaZCngrjOL4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fauV+O0ltcBmSadTOsrgL4+M44vu7F4idPDU1FCd2twp5z+6jimbkOkhTo+gDU6rc
         x+nZ6aIdvJ50pVr8vj66sUu+kiyE9YudQffuMTPJwuZ9lfkvIiVoVe5fzUldGVYxrm
         KFK/8Q3hj4cnZUEZF44IEp7kVDni9E+LZ5Hs+yJPuJkRVcLU8CTKrzp8pbZIlOwOB7
         UBY+TIsxNSY1Solz0WLCqt/o+/PjyQsxTgruZ5KsFzZq6u4YoLyD17ROz6rOKhJTtP
         bgtoAvEca/zu2Bsiclnj2JRhunkvu7ajGja3g3sXFS1L7ucGjglxRqlYd+gmE8wibe
         xJUePMHV61lTHPXfDF6TVnt+dt+33PxXClIwv6ACoUj3bztHP6SRefi3GC9cA5xOOK
         T6C8MSQzh+8XcV8SLPUeP1e6jrujGjMWHPiWmUKik8lndaeL84Adm9N9cJ7GtTp0oz
         yjR8PsjFgXX3sNkEjz9PkJ6IjCLjeoJpozwc9iqe4oj/PohE7uJ
Date:   Wed, 23 Dec 2020 20:10:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] CODE_OF_CONDUCT: expect tolerance, not respect
Message-ID: <X+OkOGkBrpbHhHkb@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <20201223061718.102779-1-felipe.contreras@gmail.com>
 <3d21cc06-415d-860b-7bd2-31047d68bc05@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qkIJJ94LVz9X/R0T"
Content-Disposition: inline
In-Reply-To: <3d21cc06-415d-860b-7bd2-31047d68bc05@gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qkIJJ94LVz9X/R0T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-23 at 14:46:56, Derrick Stolee wrote:
> On 12/23/2020 1:17 AM, Felipe Contreras wrote:
> > As many argued; respect cannot be manufactured at will. If you don't
> > respect an idea (for example that the Earth is flat), then it doesn't
> > matter how hard you try; you still will not respect it.
>=20
> ...
>=20
> >  * Using welcoming and inclusive language
> > -* Being respectful of differing viewpoints and experiences
> > +* Being tolerant of differing viewpoints and experiences
> >  * Gracefully accepting constructive criticism
> >  * Focusing on what is best for the community
> >  * Showing empathy towards other community members
>=20
> As mentioned in 5cdf230 (add a Code of Conduct document, 2019-09-24):
>=20
>     This patch adapts the Contributor Covenant Code of Conduct. As opposed
>     to writing our own from scratch, this uses common and well-accepted
>     language, and strikes a good balance between illustrating expectations
>     and avoiding a laundry list of behaviors. It's also the same document
>     used by the Git for Windows project.
>=20
> It is highly recommended to stick to the widely-used and carefully
> crafted phrasing.

I am also strongly in favor of keeping the commonly used wording.  If
you feel that wording is inappropriate, it would be better to have the
change adopted upstream.

> Specifically, "Being respectful" is different from "Have respect", which
> negates your argument for changing this word. We can only enforce what
> is evidenced by actual communication, not the internal lives of community
> members.
>
> I could just as easily argue that it is possible to be tolerant without
> being respectful.

I agree with this.

I should also point out that the situation at a university is different
than the situation on this list.  A university is a large institution
which is dedicated to the pursuit of learning and in which one may find
a variety of ideas.  Sometimes those ideas (both past and present) will
be offensive, but they are a part of learning more about the world.  We
may tolerate those ideas as existing and being subject to critical
analysis, but ultimately reject them and have little respect for them.

On the other hand, many people work on Git or other open source projects
as part of their job duties.  As such, this is a professional
environment for many contributors.  In a professional environment, we
need to be respectful of people who are different than us.  We are
aiming to have a common goal, which is to build a great version control
system, and to have a coherent group of people who are willing to join
together in that endeavor and best meet the needs of a diverse,
multicultural base of users.

The connotation I have of "tolerate" is "to suffer".  I tolerate things
which are undesirable but unavoidable.  In a healthy community, we try
to minimize suffering due to others.  I am respectful of the fact that
my colleagues may have different religious or cultural beliefs than I do
and I try to consider those beliefs, such as considering their holidays
when I ask someone to switch an on-call shift or schedule a meeting.
That can be a neutral or positive experience for all involved; no
suffering need occur.

So I think the original Code of Conduct is more consistent with
producing the positive, healthy environment we're looking for and best
meeting our users' needs, and as a result, I don't agree at all that it
should be changed.

I will ask that I not be CC'd on future replies to this thread; I will
read them on the list if necessary.  Thanks.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--qkIJJ94LVz9X/R0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX+OkNwAKCRB8DEliiIei
gaUjAP9Wqneu6gH6f9liykxvEsMeISsgeEp006YqmYlI6+PiXQEAyD/6wcmG9LP4
uCZKB8m5JrXLTWYUKSUJJDwvJoc+aQw=
=FG2Q
-----END PGP SIGNATURE-----

--qkIJJ94LVz9X/R0T--
