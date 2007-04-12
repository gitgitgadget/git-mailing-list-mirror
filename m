From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Thu, 12 Apr 2007 02:35:41 +0200
Message-ID: <20070412003539.GP21701@admingilde.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <200704101828.37453.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org> <200704102004.08329.andyparkins@gmail.com> <Pine.LNX.4.64.0704101219280.6730@woody.linux-foundation.org> <7vwt0kugmy.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704101325580.6730@woody.linux-foundation.org> <461D798B.3040008@vilain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9JSHP372f+2dzJ8X"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:35:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbnHy-000070-FD
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbXDLAfp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbXDLAfp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:35:45 -0400
Received: from mail.admingilde.org ([213.95.32.147]:54144 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724AbXDLAfp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:35:45 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HbnHp-00022W-R3; Thu, 12 Apr 2007 02:35:41 +0200
Content-Disposition: inline
In-Reply-To: <461D798B.3040008@vilain.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44294>


--9JSHP372f+2dzJ8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Apr 12, 2007 at 12:12:59PM +1200, Sam Vilain wrote:
> Linus Torvalds wrote:
> > So there's a very real issue where a repository with submodules still=
=20
> > "works", even with a .gitmodules file that is totally scrogged and does=
n't=20
> > have the right information (yet), it's just that it may simply not be a=
ble=20
> > to do all the operations because it cannot figure out where to pull=20
> > missing subproject data from etc..
> >  =20
>=20
> Whoa... "missing" subproject data?
>=20
> Surely, unless you're doing lightweight/shallow clones, if you have a
> gitlink you've also got the dependent repository? Otherwise the
> reachability rule will be broken.

With submodules you actually have a natural cutting point where
you can say: no, I don't want to get that.
So for submodules the reachability rule is a little bit more relaxed.

And when you fetch the superproject you now need some way to fetch
the new submodule objects.  They may be in the same upstream repository
but it may make sense to have this configurable.

--=20
Martin Waitz

--9JSHP372f+2dzJ8X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGHX7aj/Eaxd/oD7IRAs4oAJ9Fdx279Ahel3spX0iYSE0Eu5hlIQCfac+5
d0jCgh2cw3xfS+Yi5vlo3yI=
=cPlW
-----END PGP SIGNATURE-----

--9JSHP372f+2dzJ8X--
