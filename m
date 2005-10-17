From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: git-snapshot.sh
Date: Tue, 18 Oct 2005 00:06:15 +0200
Message-ID: <20051017220615.GG12774@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nCRcqX7cEx7rr7Pe"
X-From: git-owner@vger.kernel.org Tue Oct 18 00:06:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERd7t-0003YT-0p
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 00:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbVJQWGd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 18:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVJQWGd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 18:06:33 -0400
Received: from wg.technophil.ch ([213.189.149.230]:2699 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751357AbVJQWGd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 18:06:33 -0400
Received: (qmail 616 invoked by uid 1000); 17 Oct 2005 22:06:15 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10193>


--nCRcqX7cEx7rr7Pe
Content-Type: multipart/mixed; boundary="gJgGjUUWrnN4mpen"
Content-Disposition: inline


--gJgGjUUWrnN4mpen
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I really like to have a snapshot available from my sources in VCS.

Therefore I wrote the attached script.

Just wanted to send it, perhaps someone can use it.

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--gJgGjUUWrnN4mpen
Content-Type: application/x-sh
Content-Disposition: attachment; filename="git-snapshot.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A# Nico Schottelius=0A# Date: Di Okt 18 00:02:17 CEST 2005=0A# L=
ast Changed: -=0A=0AGIT_DIR=3D~/git/cinit=0AOUTPUT=3D/home/user/nico/www/or=
g/schottelius/linux/cinit/archives/cinit-snapshot.tar.bz2=0A=0Aset -e=0A=0A=
cd "$GIT_DIR"=0Agit-tar-tree $(git-log | head -n1 | awk '{ print $2 }') | b=
zip2 -9 -c > "$OUTPUT"=0A
--gJgGjUUWrnN4mpen--

--nCRcqX7cEx7rr7Pe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1QgVrOTBMvCUbrlAQL3uQ/9HCBShMwjovU32gV9xz7WaOSSVNo14slY
A5qZpk9Y+/j38tjsAjXo1o3/qmxzUPv2z6y/kUshwJt/hdIrk5TmXYehpgYTygi9
jTUvsUmyary4o8yRYa1JdSdyrJKe7Yn3FTVcvlEUw+hU8D5z290u7tfWWO3mjTG+
zUY5LjMkh0wVgbP5YEJiftPIf5NfNei/NGAMqTtaOb56u2jQ5Ij0dy88EOF1SJbN
JEW2yyCzTcBeLEYzLBW8ySgKAKTkNblpfaIMLqfbB7+aa3Pdh4pZ8Nc0T4O/8dR2
eIJckSA/TfZTrM0JB3PgtdASv++9XdXfawqQz5Lc2FEg/fS16SKAF5p68a/ccsEU
YLlG/FtQsIfRbMMcjzGkz2cVBv1xJi7lrzLTiiMKgPbyQ6qhCTMKbNvScZSFn8br
Z0+pP7WG9xBsxa+jYsQpJ+tA+ZabEVesnF4GDejLbD76jt0shhTiZppgc+M/szy4
ys0DOUBWUX7fpJXZDVJfCijUSt2WNdpZk5KMTZRlAlhacxxZo9c+D/1Hes+JcChi
UabfSGMeTgBQNsygwi4Eyl5IWIhJ93Ye2YIebWfRDlIZXdQjBy4AQP7T1SPJeqhe
4bAWVz6O5jYhGHHi48d/cE1Wy+ZVQ2RadFI0NeGHyauxnW4yAljyEVWHhZ4Pqqm6
OH0wwKc/IPM=
=e136
-----END PGP SIGNATURE-----

--nCRcqX7cEx7rr7Pe--
