Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21ABC47080
	for <git@archiver.kernel.org>; Sun, 23 May 2021 23:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07B1610A2
	for <git@archiver.kernel.org>; Sun, 23 May 2021 23:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhEXAAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 20:00:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47442 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232021AbhEXAAF (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 May 2021 20:00:05 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EE0F960734;
        Sun, 23 May 2021 23:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621814288;
        bh=yjNBrAuNuaDc7W69F6lT4qNh4IYQD5BnatdghOiLOC4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IK7V6t39REDfLtUAQLee1J/MGB8R7b+Ywcv6paaf52frGFyQfLrhNTXkscmAN6h+J
         lNsj/QG1V5FZnTdWVxs2XXipuFpWkBYtu7KS11so7t2QGyLgOFCsDJ3HX5EOCeyItA
         IK192KoBL0bv8q9YNEnXN+8ydya6R62Y9dnqwK/+XQHMmsBpqHMS4Wd6wnC1UYiPcf
         5Z+mPZOmVV1g5BKKj78wDtz+/W3Rv1FHXKb6xeZNTDWUNk8ejDFlA6WkNG1Ydvy7GN
         vejU4VqdC3pPEhCUAz9bpD6GAWQkdsT62Sazkkz4YBPTU0daYVe0IxzlG0gn/ecgt5
         /fRVQlgdkbEELpURftzrdmzcJ1EU0pWvPRvEiKhhEOU+E/MCyESph9mTB6WB8aKpbB
         WTlnkhf0h9KB3jL9UDLOBO2nSrbBh6FHo1KNXUwWWXq8Pqg6IEz4BmzwPPWNygHO5r
         lh7uu0IB+at2heCmEuieLUiemKXCwFQzBBn6CzNNm9ILMZWzMk9
Date:   Sun, 23 May 2021 23:58:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: fast forward merge overwriting my code
Message-ID: <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        Git Mailing List <git@vger.kernel.org>
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xQMlQWWaa47R7T9a"
Content-Disposition: inline
In-Reply-To: <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xQMlQWWaa47R7T9a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-23 at 09:48:55, Johannes Sixt wrote:
> [resending, as I forgot to include git@vger]
>=20
> Am 22.05.21 um 17:48 schrieb Andre Ulrich:
> > Let's say I have a .txt file on my master branch. I used
> >=20
> > git add .
> >=20
> > and
> >=20
> > git commit -m "blabla"
> >=20
> > so everything is staged and in the history. Now I check out a new branch
> >=20
> > git checkout -b testing
> >=20
> > and edit the .txt file. I add some new lines at the end, but I also
> > change some of the already existing lines. Then again I add and commit
> > everything. Then I use
> >=20
> > git checkout master
> >=20
> > and
> >=20
> > git merge testing
> >=20
> > I would expect git to tell me "hey, wait, you have changed some of the
> > first lines in the .txt file. When you merge, your code on master will
> > be altered". But git just merges everything in.
> > Just imagine this was working code, and changing some of the first lines
> > breaks everything in the following lines.
> > I think I have found out what is the problem: git considers this a fast
> > forward merge (since there were no commits on master between the
> > creation and the merging of the test branch).

Yes.  However, if Git did an actual merge, the result would be the same.
In a three-way merge, if one side changes, and the other does not, the
change is adopted.  A fast-forward merge just avoids the merge commit.

> > But this is annoying. I want to be able to choose, what changes I want
> > to keep, when I do the merge (just as in case of a 3way merge, when you
> > can call a graphical merge tool to decide what lines to keep).
>=20
> But in a 3-way merge, you only get to choose which changes you take if
> there is a conflict. If, in your example, you had committed a change to
> a different file on master before the merge, you would get a
> non-fast-forward (3-way) merge, and still no opportunity to choose which
> changes you take because there would be no conflict.
>=20
> And why do you think we need a general warning "when you merge, your
> code on master will be altered"? Why would I want to make a merge into
> master if not to change the code on master?

I suspect Andre has a goal here or a specific use case that we're not
understanding.  If we got some more explanation about what's going on,
we could probably offer a more useful response addressing that specific
use case or goal.  It might not be a use case we support, but at least
we could address it directly.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--xQMlQWWaa47R7T9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKrsCgAKCRB8DEliiIei
gUIcAP989Hn1XW4uheFNU9BGtavYZKBikaOFYyGuchXCJocBqwEAuR36yWIJ2vc/
nsHBA/tkE1qNezRw4tiGMm7VkYM3Igw=
=J8MM
-----END PGP SIGNATURE-----

--xQMlQWWaa47R7T9a--
