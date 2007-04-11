From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 10:36:42 +0200
Message-ID: <20070411083642.GH21701@admingilde.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org> <20070411080641.GF21701@admingilde.org> <81b0412b0704110129q56ee0628jafe8fca808ef9ef8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:11:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbYJr-0004iX-TY
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 10:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbXDKIgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 04:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbXDKIgp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 04:36:45 -0400
Received: from mail.admingilde.org ([213.95.32.147]:32836 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbXDKIgo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 04:36:44 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HbYJm-0007RX-GL; Wed, 11 Apr 2007 10:36:42 +0200
Content-Disposition: inline
In-Reply-To: <81b0412b0704110129q56ee0628jafe8fca808ef9ef8@mail.gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44223>


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Apr 11, 2007 at 10:29:24AM +0200, Alex Riesen wrote:
> On 4/11/07, Martin Waitz <tali@admingilde.org> wrote:
> >So my advice is:
> >Always read and write one dedicated branch (hardcoded "master" or
> >configurable) when the supermodule wants to access a submodule.
>=20
> In this case it does not correspond to the working tree anymore.
> HEAD is the "closest" to working tree of submodule.

yes.

This has been discussed in length already.
Please have a look at the archives.

Your working tree now contains a complete git repository which has
features which are not available for normal files.  Notable, you
have the possibility to create branches in the submodule.
If you insist in using HEAD you throw away those submodule capabilities.

--=20
Martin Waitz

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGHJ4aj/Eaxd/oD7IRAnyLAJ4wdjT4PX7OO35iPmMaI3roOSOkmwCeOhpa
1NZ2YO/QY/qqgi46oql3UnQ=
=4lzX
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
