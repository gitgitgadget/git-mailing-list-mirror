From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: ssh removed?
Date: Tue, 6 Dec 2005 22:19:18 +0100
Message-ID: <20051206211918.GP21705@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NwG7NuG0/W8LcLh"
X-From: git-owner@vger.kernel.org Tue Dec 06 22:24:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjkEZ-0005A4-7f
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 22:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbVLFVT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 16:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbVLFVT0
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 16:19:26 -0500
Received: from wg.technophil.ch ([213.189.149.230]:10933 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1030245AbVLFVTY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 16:19:24 -0500
Received: (qmail 16203 invoked by uid 1000); 6 Dec 2005 21:19:18 -0000
To: git list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13291>


--/NwG7NuG0/W8LcLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin!

Did somebody remove git+ssh in git? If I search for ssh in cg-log
in the git source I do not see any hint. But I see that when trying to
use it:

[22:15] hydrogenium:ccollect.sh% git-init-db
defaulting to local storage area
[22:15] hydrogenium:ccollect.sh% cg-branch-add creme git+ssh://creme.schott=
elius.org/home/server/git/cLinux/ccollect.git
[22:15] hydrogenium:ccollect.sh% cg-fetch creme
Fetching pack (head and objects)...
fatal: I don't handle protocol 'git+ssh'
cg-fetch: fetching pack failed
[22:16] hydrogenium:ccollect.sh% cg-version
cogito-0.17pre.GIT (c10cc1d2a99b01ed3bf45d5f2ad6157940a22365)
[22:17] hydrogenium:ccollect.sh% git --version
git version 0.99.8.GIT

Just a little bit confused,

Nico

--=20
Latest project: cinit-0.2.1 (http://linux.schottelius.org/cinit/)
Open Source nutures open minds and free, creative developers.

--/NwG7NuG0/W8LcLh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ5YAVbOTBMvCUbrlAQLEcRAAk+Rx47Nb7T3+ZMKugO7Y8IgnpMwEm3+f
fXI6l31zYXWU1rbWAl63HyxNadqu/TeohKS+57cJOtPEE+KW7w4lzsQEaIYKxHk0
o7bPL0+HZsTEqS0sz0IcLDfCYyH5z9wdGsJ5i459cqS0FgngwLLWVYXHMh4YElTy
Mzr790EP+v6ZuFLOKvbkl+G4m59VKKsM2K08LIO0nJmHpYJISRJqyQFyYOdP6HgE
TD3ihWiwGa7WTTGcBm36VOAbBDwZ4HZgXCvrCyS5qo6cQ5llFKJxYH3jqL+u2GiQ
+ORFAXSBKA6HMd8V0Sz/U/pkJEH656s1oPZFhadDkn4Pdf+2CZ3lLhINMEpmWaZS
30m1IbtEx1tF0f+UpTF7AWavCmAwc8sjzkagsoJCDmteJBA3sSTzDjLR15/S6phL
RQA3XQl8N69DJ/cYt+Zwxr1C7nTCbz4CWJJonYpunW9+i8KCqfQ/LKU+zscvl5f9
WO+6eRw8Qd7kkyAMVww3Ix4BxdhiVjCMHZDAMTMKuY6nIJY4u5jF6mAetgfL4vD/
OWlr1SakfzVR53VMJOVPAnqBIy6mEV0MSITU/DR+yJzjDfnQAob4stR5jm3sFwk9
H0RR1hmkUwR08KIFgSAlnuHuJRN5Dpv+p1x8UjCtUxZrpe8UNuThArFjTdHQMSvD
qZRsYdL9AR0=
=r56j
-----END PGP SIGNATURE-----

--/NwG7NuG0/W8LcLh--
