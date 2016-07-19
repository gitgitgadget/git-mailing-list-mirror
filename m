Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31FDC1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 18:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbcGSSpP (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 14:45:15 -0400
Received: from vpn.foo.tf ([195.154.43.236]:50044 "EHLO mail.foo.tf"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbcGSSpO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 14:45:14 -0400
Received: from localhost (unknown [10.10.68.1])
	by mail.foo.tf (Postfix) with ESMTPSA id F220E388E75;
	Tue, 19 Jul 2016 18:45:11 +0000 (UTC)
Date:	Tue, 19 Jul 2016 20:45:10 +0200
From:	Antoine Tenart <antoine.tenart@ack.tf>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Antoine Tenart <antoine.tenart@ack.tf>, git@vger.kernel.org,
	pclouds@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH] worktree: add: introduce the --name option
Message-ID: <20160719184510.GA28551@kwain>
References: <20160719144701.571-1-antoine.tenart@ack.tf>
 <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 19, 2016 at 11:04:59AM -0700, Junio C Hamano wrote:
>=20
> > Adds a --name option allowing to specify the name of a worktree when
> > creating it. This allows to have multiple worktrees in directories
> > having the same name (e.g. project0/foo, project1/foo etc...). This
> > commit keeps the previous behaviour by making it the default value, i.e.
> > by using $(basename <path>) as the worktree name when the --name option
> > isn't used.

[...]

> Hmm, is this related to an earlier discussion
>=20
>     https://public-inbox.org/git/20160625051548.95564-1-barret%40brennie.=
ca/
>=20
> in any way, or is it an independent invention?

Completely independent. I made a quick search before doing this... too
quick :-)

> The conclusion of that discussion thread was roughly "users
> shouldn't even _care_ about the name, and if they have to use name
> to identify the worktrees to do certain things right now, reducing
> the need for such 'certain things', not making it easy to give a
> user-defined name to a worktree, is the way to go", IIRC.

I agree that users shouldn't have to deal with this in most cases, and
that's still the default behaviour with this patch. But some use cases
require to change this default name: I use the same repository for each
of my projects using the Linux kernel while working on them in parallel.
So I end up with something like: project1/linux, project2/linux etc...
where other names than 'linux' in each project directory wouldn't really
make sense.

Being able to manually define the name can also be useful in some (rare)
cases, where you reorganize your project directory tree. But that's not
a strong argument for adding this option :-)

There might be other solutions, so I'm open for discussion. I just find
this not-that-magic solution useful.

Thanks!

--=20
Antoine

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXjnUzAAoJEFxNi8it27zYzykP/jjMy3nldwAZaIu63xnvujyK
xPKrFToKzyKDDGv8OuqJJ3lHCeH0tb1KO8uSHl3wtUKgbdh9nRcgWWOraR239ysJ
Dxpnlynqd5LXpoEEWXYZk+KJXrtMyyGfiqFSHJDbSbnMSgEHchpxXISd80KVgOOO
xKb/GshsKB3tuJHuG6qK42EUS5yX9IZvC8nXVkaBYamgDnxR0nSwiPetg+WyRoII
L9vb8KPI4UWtC7horkkm4DiD0lj8kTVZpZc5dFsNQW1o6r6tgSXVjL0goag1oGVS
SiikhbjaKFEqsBm9l+tLat4rFlF2mu5y6MIRyB20gGE6Jir4cw6cuE/MswQ5zDe5
2nQ9E6SvfMDLeXZAMAnC5FWC/1EtLJKf/IHzF9gEAljfcyktv58VWf+vRfIo4Sip
BV+ki43dj+CmQ9iLY+KNo/7rOLHmd1uk5SVLCbZc0Br8cx088mdyJMXOZLwtppKl
5JaPeB0G0ntSNQf28pkOeDROZDEdHqJUoj56LJSFmDExyZ8SNSK5J5zwlayBUOeW
XIVRlwO+Vq8gvOHd86p2U9pOH5/ayTEGYB3Jeh4dG+fvYvuBRQJrwXDATgn1Ywww
+y8fkry31V5wxMhwyq5Ey4Wh2I4yI5yJQ9OPriukfFD5wmbhLOWPE5U1CJ/QSHYb
GIkZRfKuXVNbjhNF5XJU
=zR4C
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
