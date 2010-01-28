From: The Anarcat <anarcat@koumbit.org>
Subject: "archive on tag" hook
Date: Thu, 28 Jan 2010 00:39:06 -0500
Message-ID: <20100128053906.GH28798@anarcat.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 06:47:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaNEA-0002R4-VR
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 06:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136Ab0A1Fr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 00:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045Ab0A1Fr1
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 00:47:27 -0500
Received: from H144.C72.B0.tor.eicat.ca ([72.0.72.144]:42471 "EHLO
	anarcat.ath.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab0A1Fr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 00:47:26 -0500
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2010 00:47:26 EST
Received: by anarcat.ath.cx (Postfix, from userid 1000)
	id D7658240E7; Thu, 28 Jan 2010 00:39:06 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138224>


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

After looking in a few places for a tool to create an archive when
pushing tags to a central repository, I have given up and wrote my own.

It's grown into a fairly complete perl script that runs either as a
post-receive or update hook and creates a tarball (or zip file) using
git-archive in a specific directory. It can also optionnally generate an
MD5 sum of the tarball.

Part of this work was sponsored by Koumbit[1] and done for the Aegir
project[2].

The code itself is available on our git repository[3]. I will also write
a small subsection in the tools page of the wiki[4].

Comments and improvements welcome.

Enjoy!

A.

[1] http://www.koumbit.org/
[2] http://groups.drupal.org/aegir
[3] http://git.koumbit.net/?p=3Dtools/git-hooks/.git;a=3Dblob;f=3Darchive-t=
ag
[4] http://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#Hooks

--=20
Antoine Beaupr=E9
R=E9seau Koumbit Networks
+1.514.387.6262

--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkthIvoACgkQWGBzs0AjcC+zrACfSLV2wtE79sVyPgqn5lA/Ba8L
qbUAnAm0QVqr2Ri6pfkF+e72RymVKITj
=RCfa
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--
