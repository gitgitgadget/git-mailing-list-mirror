From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Problems with .gitignore
Date: Wed, 19 Oct 2005 10:16:25 +0200
Message-ID: <20051019081625.GK22986@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aqWxf8ydqYKP8htK"
X-From: git-owner@vger.kernel.org Wed Oct 19 10:19:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES97x-0004nM-89
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 10:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVJSIQq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 04:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVJSIQq
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 04:16:46 -0400
Received: from wg.technophil.ch ([213.189.149.230]:9397 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932451AbVJSIQq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 04:16:46 -0400
Received: (qmail 23854 invoked by uid 1000); 19 Oct 2005 08:16:25 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10272>


--aqWxf8ydqYKP8htK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It looks like cg-status does not really use .gitignore:

[10:14] srsyg01:walderlift% cat .gitignore=20
*.~*                                                                       =
        =20
*.aux                                                                      =
        =20
Design/Programmieredoku/kapitel.lof                                        =
        =20
Design/Programmieredoku/kapitel.log                                        =
        =20
Design/Programmieredoku/kapitel.lot                                        =
       =20
Design/Programmieredoku/kapitel.out                                        =
        =20
Design/Programmieredoku/kapitel.pdf                                        =
        =20
Design/Programmieredoku/kapitel.toc                         =20
*.conf                                     =20
*.dcp                                                                  =20
*.dcu                                               =20
*.ddp                                                                      =
        =20
*.dpu                                                                      =
        =20
*.kof                                                                      =
        =20
*.res                                                                      =
        =20
*.so                                                                       =
        =20
Code/Components/Utilities/lw1tools                                         =
        =20
Code/lw1/Client/lw1.log
Code/lw1/Client/lw1client
Code/lw1/lw1SyTestsystem

[10:15] srsyg01:walderlift% cg-status| grep -e '.so$' -e '.dcu$' -e '.dcp$'
? Code/Components/ColoredDBComponents/ColDB.dcp
? Code/Components/ColoredDBComponents/bplColDB.~so
? Code/Components/Planner/QPlanPkgK3.dcp
? Code/Components/Planner/bplQPlanPkgK3.so
? Code/Components/Utilities/LW1Tools.dcp
? Code/Components/Utilities/Utilities.dcp
? Code/Components/Utilities/bplLW1Tools.so
? Code/Components/Utilities/bplUtilities.so
? Code/Components/rpman21d/bplrppack.~so
? Code/Components/rpman21d/bplrppackv.~so
? Code/Components/rpman21d/rppack.dcp
? Code/Components/rpman21d/rppackv.dcp
? Code/Components/zeosdbo/packages/kylix3/bplZComponent.~so
? Code/Components/zeosdbo/packages/kylix3/bplZCore.~so
? Code/Components/zeosdbo/packages/kylix3/bplZDbc.~so
? Code/Components/zeosdbo/packages/kylix3/bplZParseSql.~so
? Code/Components/zeosdbo/packages/kylix3/bplZPlain.~so

Why does that happen?

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--aqWxf8ydqYKP8htK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1YA2LOTBMvCUbrlAQII1A/5AculUhCB3u2OkemUPfOlIjGgJdwp8p0f
mZLQ1dOEkmymFRnOb8ZcCT7OYB6ITPyvNHtHmTyQ6pyCj/Henh9RgGOa0L24OV3K
Fu/w1kncDYVk2o1EuXn2kURhiv+/8Of+GFCaXi2Gcv6oL/CzPAnYWTgyaszuMdbm
k3qj/NaM/rBcpoFRQs6jJjPyGtrPPIHXOzq8kdc2XeJEJcYnZfTfcPxyfveXkekS
FiTd4bSFLk48ZMGXNLIm4sBHJyIve1QwSbZxoYbKSGC9nOdl8ihUIQjs6xi3pXW/
u4mBdCrBh4gfcGJNs3DZGKeyDmCqor+TqjnhLfH5orilDVoF2UlCLOS87ac5UszB
svAHVC6x9kdHUO5LyeLvSJ6QbMBcQQWNFJRDObliZwURr4x8s62jCccSG7vhFefC
nGn6NivvqQ8UesW8BpnKi11UjPpK+HfXaE0QI7guMXb+ewEj5yNJGUT0mFMlhfDR
WB994bveVeq+RcwS/ClHoGiWdXNXg9UuhT3d86XBiXW6aCFKif0aLzmRoZ3TXoYy
IjJGhzlz+NO5oM4iCW5klyOo+jTVtyTXvnt/J3J7S+Lom8ZHhpVjqzvGx8BfsWOv
I9Z24iY6/RL52BniiYNarvXA3Nhmdf/wnks9ay6AuOpeX51fsfEolc6kjVnED5Vw
5D5LqIWR23g=
=11Vn
-----END PGP SIGNATURE-----

--aqWxf8ydqYKP8htK--
