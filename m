From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Wed, 11 Apr 2007 10:57:55 +0200
Message-ID: <20070411085755.GI21701@admingilde.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org> <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com> <20070411083236.GG21701@admingilde.org> <81b0412b0704110142l377231d7j85285a87ef73ce41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 12:49:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbYeQ-0000Hh-V4
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 10:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbXDKI57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 04:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbXDKI57
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 04:57:59 -0400
Received: from mail.admingilde.org ([213.95.32.147]:37152 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbXDKI56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 04:57:58 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HbYeJ-0007cb-QT; Wed, 11 Apr 2007 10:57:55 +0200
Content-Disposition: inline
In-Reply-To: <81b0412b0704110142l377231d7j85285a87ef73ce41@mail.gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44208>


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Apr 11, 2007 at 10:42:57AM +0200, Alex Riesen wrote:
> On 4/11/07, Martin Waitz <tali@admingilde.org> wrote:
> >> The other thing which will be missed a lot (I miss it that much)
> >> is a subproject-recursive git-commit and git-status.
> >
> >git-status should really point out if a subproject has any changes,
>=20
> Only if I want it to. HEAD change check (which is cheap enough
> to be done unconditionally) can be done always.

Yes, that's the equivalent of checking normal files.
The recursive check for dirty files/index should be configurable.

> >But for commit it really does not make any sense.  The commit in the
> >submodule is totally independent to the commit in the supermodule.
>=20
> Right. Perhaps not a commit in submodule but a recursive check
> for working directory changes in submodules. So that you can
> make that you don't make a superproject commit which cannot
> be resolved to what you had in all the working directories:
>=20
>  git commit -a --check-clean-subprojects

For -a such a check may even make sense unconditionally.
And without -a I don't see any value in such a check.
So we can just add that check to -a if we see that dirty submodules
are a problem for users.

--=20
Martin Waitz

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGHKMTj/Eaxd/oD7IRAj6WAJ4vElliDRnuZt3wGBmjDKOF+UBXLwCeJo+M
W9iZxEiCbs6uMlAbTazswqw=
=R/iD
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--
