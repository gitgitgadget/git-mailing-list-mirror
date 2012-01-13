From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: fetch for bare repository
Date: Fri, 13 Jan 2012 16:18:45 +0100
Message-ID: <20120113151845.GD2850@centaur.lab.cmartin.tk>
References: <4F100A7B.3030001@gmail.com>
 <20120113134058.GB2850@centaur.lab.cmartin.tk>
 <4F103797.7060906@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Cc: git@vger.kernel.org
To: "Dmitry A. Ashkadov" <dmitry.ashkadov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 16:18:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rliu1-0007EJ-1v
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 16:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758291Ab2AMPSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 10:18:44 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:41069 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758276Ab2AMPSn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 10:18:43 -0500
Received: from centaur.lab.cmartin.tk (brln-4db9f5ad.pool.mediaWays.net [77.185.245.173])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 81B07461BE;
	Fri, 13 Jan 2012 16:18:30 +0100 (CET)
Received: (nullmailer pid 17438 invoked by uid 1000);
	Fri, 13 Jan 2012 15:18:45 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	"Dmitry A. Ashkadov" <dmitry.ashkadov@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4F103797.7060906@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188515>


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2012 at 05:54:31PM +0400, Dmitry A. Ashkadov wrote:
> 13.01.2012 17:40, Carlos Mart=C3=ADn Nieto =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >On Fri, Jan 13, 2012 at 02:42:03PM +0400, Dmitry A. Ashkadov wrote:
> >>Hello!
> >>
> >>I can't understand how to fetch branches from external repository
> >>for bare repository.
> >What you probably want is a mirror (git clone --mirror). Unless you
> >tell git that you want a mirror, it's going to assume that you want a
> >bare repo to push your own changes up to it. Such a repo has no need
> >to be kept up to date, so clone doesn't set up any fetch refspecs.
>=20
> I don't have access to an origin repository. So, I need bare
> repository and push changes up to it. So, I think the word "mirror"
> isn't applicable to private repository.

When you say access here, do you mean that you can't push to it? When
I say access later on, it means being able to fetch from it.
Otherwise I don't see how you could have cloned from it. If your
private repository's braches to reflect what's upstream, I'd call that
a mirror.

>=20
> >Stepping back, do you need to fetch those branches into the private
> >repo? If you still have access to the main repo and that's where the
> >main project development is happening, why not use upstream's repo to
> >get those changes to your local repo (as in the one you use to work)?
> >It sounds like you're trying to replicate a centralised VCS'
> >workflow. Git works like a network and you can merge a branch from
> >upstream if you need to and then push to the private repo.
>=20
> Yes, I can add one more remote to my local repository, then fetch
> changes from it and push it to private repository. But I thought
> that update private repository is the best way.

Best way to achieve what? If you want your private repo to reflect
what's upstream, doing the inital clone with --mirror (or setting the
remote.origin.fetch config variable to "+refs/*:refs/*", which is the
main difference) will let you run 'git fetch' on that repo and get the
changes.

But what I was asking was whether you actually need to bother with
that operation. If you need to merge or rebase from upstream, a push
will include those new changes, as they're now in your branch, so what
advantage do you get from copying those branches from upstream if
they're just the same?

   cmn

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPEEtVAAoJEHKRP1jG7ZzTBWMH/2H8iHbfiFmdhvzsqsiwyqd8
ig+OV6KqbHPSzbjm5fEOSlXKwlilbNICmPNUVRSbBklcxuvOvwxI14sQW8yRsMbZ
CoowL4L4CoEMl0zBvyXieKCYUHlYG3xPJb5eAcOH77lvleqKWd091e7J1Ohkys59
wusMtcllUpog10VfT7jU+5SWzQdWayPgdcHGmHyzCvcDY3GKW9N8YjrX6gQFVKp2
W17O6wrJseRAxOCc6gadupzvJDWeSiKlBncHc2SX8r8mu/8x8HCWuNnFCllz5c/3
KnDLnI18hqmlaEC3M6n77ek0W6ObgxIxDvP646Da4ICM49v5u6BPHGCS725bVBM=
=4irK
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
