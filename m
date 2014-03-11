From: Henri GEIST <geist.henri@laposte.net>
Subject: Re: [PATCH/RFC] git-gui: Add a 'recursive' checkbox in the clone
 menu.
Date: Tue, 11 Mar 2014 12:07:18 +0100
Message-ID: <1394536038.7891.59.camel@Naugrim>
References: <1393974076.7891.27.camel@Naugrim> <5317662C.6010404@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Bk2OYth4b0UM9/Iaiz55"
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 12:07:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNKWx-0002Yr-Ug
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 12:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbaCKLH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 07:07:26 -0400
Received: from smtpout7.laposte.net ([193.253.67.232]:25277 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbaCKLHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 07:07:25 -0400
Received: from [192.168.0.8] ([82.242.149.125])
	by mwinf8513-out with ME
	id cB7J1n0042iaXuy03B7J2g; Tue, 11 Mar 2014 12:07:20 +0100
In-Reply-To: <5317662C.6010404@web.de>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243856>


--=-Bk2OYth4b0UM9/Iaiz55
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 05 mars 2014 =C3=A0 19:00 +0100, Jens Lehmann a =C3=A9crit :
> Am 05.03.2014 00:01, schrieb Henri GEIST:
> > Permit to do a 'git clone --recursive' through git-gui.
>=20
> I really like where this is heading!
>=20
> Some minor issues:
>=20
> - I think we should be more verbose in the commit message,
>   including that and why the default should be "on". Maybe
>   like this?
>=20
>   "Permit to do a 'git clone --recursive' through git-gui.
>   Add a 'recursive' checkbox in the clone menu which allows
>   users to clone a repository and all its submodules in one
>   go (unless the 'update' flag is set to "none" in the
>   .gitmodules file for a submodule, in that case that
>   specific submodule is not cloned automatically).
>=20
>   Enable this new option per default, as most users want to
>   clone all submodules too when cloning the superproject
>   (This is currently not possible without leaving git gui
>   or adding a custom tool entry for that)."
>=20
>=20
> - I'd rather change the button text from "Recursive (For
>   submodules)" to something like "Recursively clone
>   submodules too" or such.
>=20
>

Perfect.
Would you like me to send the new version of the patch in this thread
Or to make a new thread [patch v2] ?



--=-Bk2OYth4b0UM9/Iaiz55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iF0EABEKAAYFAlMe7mYACgkQkKuHPdwEGdRB0gD3USzPWTHuAqYx/1qeXtJAJ+Np
vvT+lR6DFIqMEAWj1gD/QY8eEWbxzZ4/shrwv/mj3BDsm13VynDn5VevShKdyK0=
=wzPL
-----END PGP SIGNATURE-----

--=-Bk2OYth4b0UM9/Iaiz55--
