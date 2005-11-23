From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: files are disappearing in git
Date: Wed, 23 Nov 2005 15:23:03 +0100
Message-ID: <20051123142303.GJ22568@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iRjOs3ViPWHdlw/I"
X-From: git-owner@vger.kernel.org Wed Nov 23 15:25:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EevWw-0001lW-GA
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 15:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVKWOXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 09:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVKWOXJ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 09:23:09 -0500
Received: from wg.technophil.ch ([213.189.149.230]:34500 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1750817AbVKWOXH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 09:23:07 -0500
Received: (qmail 17289 invoked by uid 1000); 23 Nov 2005 14:23:03 -0000
To: Git ML <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12624>


--iRjOs3ViPWHdlw/I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I've the problem that some files (a directory with 3 files) is simply 'away=
':

- We added it once
- In current tree it's away
- pasky aided me in irc to find the commit where it is gone with git bisect
--> very nice tool
- the commit, after which the directory was gone did NOT modify this direct=
ory
- though the directory is gone

What should I do know to find out what's the reason git 'forgot' that direc=
tory?

Nico

P.S.: I cannot put the .git directory online, it's a closed source project
      for a special customer with customer data in it.

--=20
Latest project: cinit-0.2.1 (http://linux.schottelius.org/cinit/)
Open Source nutures open minds and free, creative developers.

--iRjOs3ViPWHdlw/I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ4R7RrOTBMvCUbrlAQJ+Vw/9FerkG9zZ1shGgWblYVgz5gQiXELyFFM3
JdM6J0DQEhSlwGn4+rCRJErBEbNV9bfw0NG1DqI9xNBFRgXbE8HL48zOhf4PDHEt
QL86mlHjT8rGAmX7MSkcHBPF1X0O24f4a2/hWlv98DO9qVcb+/EfIQHNcMflYqpZ
xX8gbNaPKRlp1XezXU+dR+Hyya9gXtzqOFXh3w8olZCfjnUUlLFYBb0w4HP5wT5h
U0TkIAzFqxRZocSnnJKnPovMw5LcmtNlKMNxHZnd0poCGY1OvFe1ewQZWud/Niep
dUOJtwMabYS1jX/fCI0KT3nefU/0raoSnOT+2xb1N167NjWPId4aY/auwMZqYGC5
L8T6td5dX1VALc0maZT2w61vhzxxFfIjqdAX8Hjz8C7gv8xXrUr+wi0g59qvdzEY
wVYUv60J3O+ELH6h6tB4nJdm8APByYmid6BRdRiqH+l4Bi/n2EdeNIJL78jaZitQ
mgF8sbbFAwXMZ4w0dSrvdFM6UQWnecs9pWB58QJ4Wvm0ujbDTuOnZZJLHwvowW+t
47ihuXPE4U83Qg3YKxE4u79zJWwNwRqbH7m7fiXKzpi0LZlfn9Tvy4O2hAouSlS6
+U60XfFC1jJNJwbGfhkla8gUBBheV7X5v7Dq8Cv0QbZ3QY2AII8jrbc6XYCwTPfa
pyHhWF4ylB0=
=JM7w
-----END PGP SIGNATURE-----

--iRjOs3ViPWHdlw/I--
