From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 11:20:47 +0200
Message-ID: <20070411092047.GJ21701@admingilde.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org> <20070411080641.GF21701@admingilde.org> <81b0412b0704110129q56ee0628jafe8fca808ef9ef8@mail.gmail.com> <20070411083642.GH21701@admingilde.org> <81b0412b0704110149g50426a5fh149fe8607f9c163a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:21:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbZ0W-0004Ut-33
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 11:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbXDKJUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 05:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbXDKJUt
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 05:20:49 -0400
Received: from mail.admingilde.org ([213.95.32.147]:43968 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbXDKJUs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 05:20:48 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HbZ0R-0008Ho-5e; Wed, 11 Apr 2007 11:20:47 +0200
Content-Disposition: inline
In-Reply-To: <81b0412b0704110149g50426a5fh149fe8607f9c163a@mail.gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44226>


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Apr 11, 2007 at 10:49:18AM +0200, Alex Riesen wrote:
> On 4/11/07, Martin Waitz <tali@admingilde.org> wrote:
> >> >Always read and write one dedicated branch (hardcoded "master" or
> >> >configurable) when the supermodule wants to access a submodule.
> >>
> >> In this case it does not correspond to the working tree anymore.
> >> HEAD is the "closest" to working tree of submodule.
> >
> >yes.
>=20
> "Yes" what? It should _not_ correspond to HEAD?

Not neccessarily, yes.

Branches in the submodule make no sense unless they are independent
=66rom supermodule branches.  And then changing to another branch in
the submodule automatically means that your current submodule working
directory should be independent to the supermodule.

git-status in the supermodule should of course warn when a submodule
is on a different branch, so that you don't accidently loose submodule
commits which did not get committed to the supermodule.

> >Your working tree now contains a complete git repository which has
> >features which are not available for normal files.  Notable, you
> >have the possibility to create branches in the submodule.
> >If you insist in using HEAD you throw away those submodule capabilities.
> >
>=20
> In this (a very special, I believe) case, why not use git update-index
> --cacheinfo?

I think misunderstood each other.
For me branching is not special case.

--=20
Martin Waitz

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGHKhvj/Eaxd/oD7IRAsIIAJ9118uZqHzThgtvF42YYYfUZ5x1CACcDG6e
CH5/FHlg97DeeHO9+H4nSBI=
=Quvk
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--
