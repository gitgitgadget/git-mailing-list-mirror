From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Wed, 11 Apr 2007 10:32:36 +0200
Message-ID: <20070411083236.GG21701@admingilde.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org> <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:11:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbYFt-0003uJ-UQ
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 10:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbXDKIcj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 04:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbXDKIcj
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 04:32:39 -0400
Received: from mail.admingilde.org ([213.95.32.147]:41164 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbXDKIci (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 04:32:38 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HbYFo-0007P2-Dg; Wed, 11 Apr 2007 10:32:36 +0200
Content-Disposition: inline
In-Reply-To: <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44222>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Apr 10, 2007 at 03:04:33PM +0200, Alex Riesen wrote:
> The other thing which will be missed a lot (I miss it that much)
> is a subproject-recursive git-commit and git-status.

git-status should really point out if a subproject has any changes,
as it does for files.  Only that a submodule may have more types of
possible changes: has new commits which are not yet in the supermodule
index, has an dirty index of its own, dirty working directory.

But for commit it really does not make any sense.  The commit in the
submodule is totally independent to the commit in the supermodule.
You'd want the the submodule commit message to not refer to any
supermodule stuff (as you likely want to reuse the submodule in other
supermodules), while the supermodule commit is much more high-level and
only records that the submodule got changed.

When viewed from the supermodule, a submodule is just part of its tree,
just as normal files.  So a submodule commit is conceptually similiar to
changing a file, and you don't change files while you commit, also ;-).

--=20
Martin Waitz

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGHJ0kj/Eaxd/oD7IRAlOIAJ42RToIveYMtreosH1Rm9gSzkxzfgCfYWOw
X1Q6sB7VUCrjvTi2rbqEjik=
=REoM
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
