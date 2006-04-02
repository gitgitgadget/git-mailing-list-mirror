From: Keith Packard <keithp@keithp.com>
Subject: parsecvs tool now creates git repositories
Date: Sat, 01 Apr 2006 21:36:28 -0800
Message-ID: <1143956188.2303.39.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-R8AzE/4NpWydfdeXDBxX"
Cc: keithp@keithp.com
X-From: git-owner@vger.kernel.org Sun Apr 02 07:37:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPvHN-0001xK-JO
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 07:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWDBFhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 00:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWDBFhY
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 00:37:24 -0500
Received: from home.keithp.com ([63.227.221.253]:51208 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750815AbWDBFhX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 00:37:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id E98D9130022;
	Sat,  1 Apr 2006 21:36:52 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28176-07; Sat, 1 Apr 2006 21:36:52 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id 56FF813001F; Sat,  1 Apr 2006 21:36:52 -0800 (PST)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 4182C14001;
	Sat,  1 Apr 2006 21:36:52 -0800 (PST)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id ACAA354330; Sat,  1 Apr 2006 21:36:29 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18259>


--=-R8AzE/4NpWydfdeXDBxX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've hacked in cheesy system(3) calls to invoke various git tools to
create a git repository from a parsed cvs repository. It's about the
same speed as git-cvsimport now.

The UI is a total disaster, sufficient for testing. You must create an
Authors file in the current directory which looks like the git-cvsimport
authors file. You must also have a edit-change-log program in your path
which edits the commit message in place. /bin/true will work if you
don't need to edit the messages.

I should clearly steal the existing git-cvsimport command line arguments
and use those.

This tool successfully, and usefully, imports the X.org xserver CVS
repository, along with correctly importing several other repositories
I've tried. It doesn't quite manage to compute correct branch points for
the postgresql CVS repository, so there is clearly work remaining to be
done.

CVS - your code's worst nightmare.

--=20
keith.packard@intel.com

--=-R8AzE/4NpWydfdeXDBxX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEL2LcQp8BWwlsTdMRAhBfAJ9LWlcatxeFvfJWKaazNejIcVThEACbBdkV
Gv8oW+TUDjVjiQDdqMO1QvI=
=q1H0
-----END PGP SIGNATURE-----

--=-R8AzE/4NpWydfdeXDBxX--
