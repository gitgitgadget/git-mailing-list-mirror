From: Martin Waitz <tali@admingilde.org>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 01:27:46 +0200
Message-ID: <20070326232744.GK22773@admingilde.org>
References: <1174825838.12540.5.camel@localhost> <200703262133.44520.Josef.Weidendorfer@gmx.de> <20070326220302.GH22773@admingilde.org> <200703270100.12920.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ublo+h3cBgJ33ahC"
Cc: Eric Lesh <eclesh@ucla.edu>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:27:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVybQ-0005z4-BO
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 01:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932853AbXCZX1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 19:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933699AbXCZX1t
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 19:27:49 -0400
Received: from mail.admingilde.org ([213.95.32.147]:46358 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853AbXCZX1s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 19:27:48 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HVybK-0003CY-Sh; Tue, 27 Mar 2007 01:27:47 +0200
Content-Disposition: inline
In-Reply-To: <200703270100.12920.Josef.Weidendorfer@gmx.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43204>


--Ublo+h3cBgJ33ahC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Mar 27, 2007 at 01:00:12AM +0200, Josef Weidendorfer wrote:
> On Tuesday 27 March 2007, Martin Waitz wrote:
> > For submodules I currently use <parent>/.git/objects/module/<submodule>/
> > to store the objects belonging to the submodule.
> > Perhaps it makes sense to extend this to a full .git directory per
> > submodule, I'm not yet decided on that.
>=20
> IMHO this would be a nice property. As the submodule could exist
> independently with its own remote heads/tags, you probably would want
> to at least track these, even if it is a submodule in your
> superproject.  And then it makes sense to move it directly to
> .git/module/...

I am not sure that all the other submodule heads and tags really belong
into the superproject.  Perhaps they should simply be handled in some
other way -- after all the submodule is a normal git repository and can
handle heads and tags on its own quite well.
But I haven't thought tag-handling for submodules through yet.

> There also was a use case where one library project is used in >10
> superprojects. It would be nice to be able to make the submodule git dir
> be outside of the supermodules git dir. However, this also can be done
> with symlinks without any special support (aside from sharing the
> head namespace).

Of course you can always have a normal library.git repository with all
the tags and stuff somewhere and just fetch from there if you need
some central location for it.  You could even add alternate entries
pointing there to the libraries object store inside the supermodule.

--=20
Martin Waitz

--Ublo+h3cBgJ33ahC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGCFbwj/Eaxd/oD7IRAirrAJwJCluV0WKu7DLPXnfJyCQGA1bhbACfRNRi
qDp1JerV/8ccAM0lGlP1V/Y=
=81La
-----END PGP SIGNATURE-----

--Ublo+h3cBgJ33ahC--
