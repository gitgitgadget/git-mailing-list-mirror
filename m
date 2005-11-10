From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: Problems with .gitignore
Date: Thu, 10 Nov 2005 16:10:18 +0100
Message-ID: <20051110151018.GJ22064@schottelius.org>
References: <20051019081625.GK22986@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLfjTIIQuAzj8yil"
X-From: git-owner@vger.kernel.org Thu Nov 10 16:15:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaE65-0001c7-Ku
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 16:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVKJPMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 10:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVKJPMO
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 10:12:14 -0500
Received: from [217.14.64.54] ([217.14.64.54]:61313 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1750772AbVKJPMN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 10:12:13 -0500
Received: (qmail 28041 invoked by uid 1000); 10 Nov 2005 15:10:18 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051019081625.GK22986@schottelius.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11487>


--SLfjTIIQuAzj8yil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Copy and Paste killed me, the file was full of trailing spaces!

Nico

Nico -telmich- Schottelius [Wed, Oct 19, 2005 at 10:16:25AM +0200]:
> It looks like cg-status does not really use .gitignore:
>=20
> [10:14] srsyg01:walderlift% cat .gitignore=20
> *.~*                                                                     =
          =20
> *.aux                                                                    =
          =20
> Design/Programmieredoku/kapitel.lof                                      =
          =20
> Design/Programmieredoku/kapitel.log                                      =
          =20
> Design/Programmieredoku/kapitel.lot                                      =
         =20
> Design/Programmieredoku/kapitel.out                                      =
          =20
> Design/Programmieredoku/kapitel.pdf                                      =
          =20
> Design/Programmieredoku/kapitel.toc                         =20
> *.conf                                     =20
> *.dcp                                                                  =
=20
> *.dcu                                               =20
> *.ddp                                                                    =
          =20
> *.dpu                                                                    =
          =20
> *.kof                                                                    =
          =20
> *.res                                                                    =
          =20
> *.so                                                                     =
          =20
> Code/Components/Utilities/lw1tools                                       =
          =20
> Code/lw1/Client/lw1.log
> Code/lw1/Client/lw1client
> Code/lw1/lw1SyTestsystem
>=20
> [10:15] srsyg01:walderlift% cg-status| grep -e '.so$' -e '.dcu$' -e '.dcp=
$'
> ? Code/Components/ColoredDBComponents/ColDB.dcp
> ? Code/Components/ColoredDBComponents/bplColDB.~so
> ? Code/Components/Planner/QPlanPkgK3.dcp
> ? Code/Components/Planner/bplQPlanPkgK3.so
> ? Code/Components/Utilities/LW1Tools.dcp
> ? Code/Components/Utilities/Utilities.dcp
> ? Code/Components/Utilities/bplLW1Tools.so
> ? Code/Components/Utilities/bplUtilities.so
> ? Code/Components/rpman21d/bplrppack.~so
> ? Code/Components/rpman21d/bplrppackv.~so
> ? Code/Components/rpman21d/rppack.dcp
> ? Code/Components/rpman21d/rppackv.dcp
> ? Code/Components/zeosdbo/packages/kylix3/bplZComponent.~so
> ? Code/Components/zeosdbo/packages/kylix3/bplZCore.~so
> ? Code/Components/zeosdbo/packages/kylix3/bplZDbc.~so
> ? Code/Components/zeosdbo/packages/kylix3/bplZParseSql.~so
> ? Code/Components/zeosdbo/packages/kylix3/bplZPlain.~so
>=20
> Why does that happen?
>=20
> Nico
>=20
> --=20
> Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
> Open Source nutures open minds and free, creative developers.



--=20
Latest project: cinit-0.2.1 (http://linux.schottelius.org/cinit/)
Open Source nutures open minds and free, creative developers.

--SLfjTIIQuAzj8yil
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ3Ni2bOTBMvCUbrlAQKPcA/7BO+4Y8/hIOJPuCT0NmClu0FXJWqb00tf
oPxC1ZjCk1SRIYFpRfcQ0Ab8c1bxEwz3Vh/nWoGfikhENpT/1wWT1EogNQgk0Oeq
Q/mBAaZAxhlnHWQuk0KXme8QPDD61hOCYBXMe9itjAUWka7YcpzT8vz4puP3wrME
GFMOHqH0k2h1X8u9udvNpswF1yWrlqlYxdqI877qUruuCG2zC8joN2G0Ewf32fR0
D3iC7w2fBujGkYuqLKnHLGPmRxi3Se1jLiS45UkXFcbuw8MIps4td0EBpwDiO8zM
Lzg0x5qrUUVNa0raW7m5Oh8jGjATcgEIv4Tf8AeDDisswv2x2vCojg6fQRb6Tmex
zIIjmT42ar7Hrh1pNoZEuTllfbpzW8J+pxErgkczxf372qvINQbdayanebk9gn94
sJg67hyRDO77yXxXzFZo++xLCJChVajqsIGSLHir1a6N348+hq/YJMTnODX+ifiJ
gFA0jX3I2CPyt/UGoecZgcbgYc7PYMzAB8gjmVlt86cledgB+tZpZnsSSz58nbve
/ba3P4Z8Uw5CUDpokUoCpwbBdovWaYdZLLNf805foT3tI3+b8zHD57ZX8xk1Xgq3
krKChaXx2FMjz10m1ytgCoGb4TEHo5hrRWrf2GZ67a9bxRi5hLEvZCALBscoctau
wysfgRw6iMc=
=7AqH
-----END PGP SIGNATURE-----

--SLfjTIIQuAzj8yil--
