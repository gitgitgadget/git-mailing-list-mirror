From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: [report] cvsimport, gitweb
Date: Wed, 12 Oct 2005 16:08:28 +0200
Message-ID: <20051012140828.GD30826@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
X-From: git-owner@vger.kernel.org Wed Oct 12 16:10:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPhHd-0006Au-0T
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 16:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVJLOIh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 10:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVJLOIh
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 10:08:37 -0400
Received: from wg.technophil.ch ([213.189.149.230]:4025 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S964787AbVJLOIg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 10:08:36 -0400
Received: (qmail 1471 invoked by uid 1000); 12 Oct 2005 14:08:28 -0000
To: Git ML <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10026>


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Guys!

Just wanted to tell you that a merge from cvs/pserver to git with ssh and g=
itweb
works pretty fine here. Converting to git took about 15 minutes, which is p=
retty
okay for a two years old project.

We even saved some space:

srsyg01:~# du -sh /home/server/git/walderlift.git/ /home/cvs/walderlift/
152M    /home/server/git/walderlift.git/
194M    /home/cvs/walderlift/

Greetings,

Nico

P.S.: Just a small thing one of our developers found: In gitweb there's a s=
mall
redundacy when viewing the tree;

   drwxr-xr-x  Code  tree

"tree" and "Code" link to the same thing, why is 'tree' used additionally?
[just cosmetic thing, nothing really to care about]

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ00Y3LOTBMvCUbrlAQLaxg//eU/HKl6ZWQQIXEBNEauX/3I8uu//qTJz
HVdPFTIl+bGVsBQ8mviFhyT1FYsOo/bdaNKHSd59NbU/MXmHf71K4pCV+KHQJbWH
K2766H0MCqKeOdpLXKBUVFFS+iiAc3nFaHTait7Usu+rC5fSBuerQ3vi/+vy0qyV
3ADuu7RVBjloUg+eTMWkN1bYw+OngMXUFUsb5Ji3yCxjcm1p5Wn7ePGQcf6GDHFV
iemCA5nuj1kM6qsEM30X1nQ2c1DHsE092Tft4owxsIHeHC8hvINzlNOZSwoMqlVf
tz4DLSq/VLIqhSjE7mECBq293lfKMfgRJcgNhaTpkyAoHXRo5ePeQjuexsppEd33
FjBO4/ktfZGQo1DPgH4e+p1UCwJDsXzj5YPtQifDkak5jMOeFBz4HmvVhyaRirmB
J6bZ05ZnDLAqulUzBmqmaqoPQB+wX/KKCMKXCuwBDtdm2lECpDBvuMtkifC91Vx+
YGAcL5IKKjkqp96wODLVfqX/rs8NJaHdvzjwLAN/u8BuxgdH8j5UsKZO2mycjWii
5IUFOt38mGvwQ74wlC0oG8YS/sMTJ6XSbxpYCoNf6GfKrS+EZbmW3VnbYj6BXbBz
3TQxBdh5GTYBBNXW5P4umogtz/Q8qpUs1EMVMh4Jt+gQPEpXFdGeB5yC6SXAqm7M
jduhyTRoxno=
=MZpF
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--
