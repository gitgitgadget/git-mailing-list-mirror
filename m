From: Martin Waitz <tali@admingilde.org>
Subject: Re: .gitlink for Summer of Code
Date: Mon, 26 Mar 2007 20:35:23 +0200
Message-ID: <20070326183523.GG22773@admingilde.org>
References: <1174825838.12540.5.camel@localhost> <vpqvegpe4e1.fsf@olympe.imag.fr> <1174929374.5662.15.camel@localhost> <vpqr6rbex7g.fsf@olympe.imag.fr> <1174930688.5662.20.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVu2S-00034G-SU
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 20:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbXCZSf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 14:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753674AbXCZSf0
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 14:35:26 -0400
Received: from mail.admingilde.org ([213.95.32.147]:60883 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbXCZSfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 14:35:25 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HVu2N-0000Q9-Pn; Mon, 26 Mar 2007 20:35:23 +0200
Content-Disposition: inline
In-Reply-To: <1174930688.5662.20.camel@localhost>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43172>


--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Mar 26, 2007 at 10:38:08AM -0700, Eric Lesh wrote:
> > Light checkouts would have an almost empty .git (it still needs an
> > index, and its own head anyway) and use the .git of the main repo for
> > everything else.
> >=20
>=20
> Josef Weidendorfer tried to implement this before, and he concluded that
> having a _text file_ .git, instead of a directory, would be a good way
> to distinguish .gitlinked checkouts from normal checkouts.

but that does not allow for per-checkout HEAD and index.
I don't see any reason for providing any sort for "gitlink" which
also uses HEAD and index from the linked location -- then you could
use a simple symlink, too.  So having an almost empty .git directory
and reusing parts from another .git directory makes a lot of sense to
me.

--=20
Martin Waitz

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGCBJrj/Eaxd/oD7IRAqz/AJ4kMTSPBV+EWalXds7F6nO3UGpN4QCfT/G0
i1EafUa9lSmM6FcaY28rvPM=
=eWlD
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--
