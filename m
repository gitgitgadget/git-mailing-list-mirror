From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [RFC PATCH] Allow cloning branches selectively
Date: Sun, 25 Dec 2011 17:43:22 +0000
Message-ID: <20111225174322.GB6361@beez.lab.cmartin.tk>
References: <1324671199-7074-1-git-send-email-cmn@elego.de>
 <m3hb0ofwem.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 25 18:43:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Res6a-0006cW-P0
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 18:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507Ab1LYRnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Dec 2011 12:43:25 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:52645 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753207Ab1LYRnY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2011 12:43:24 -0500
Received: from beez.lab.cmartin.tk (145.Red-81-38-112.dynamicIP.rima-tde.net [81.38.112.145])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 5D5A9461B9;
	Sun, 25 Dec 2011 18:43:16 +0100 (CET)
Received: (nullmailer pid 4449 invoked by uid 1000);
	Sun, 25 Dec 2011 17:43:22 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <m3hb0ofwem.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187684>


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 25, 2011 at 08:28:39AM -0800, Jakub Narebski wrote:
> Carlos Mart=EDn Nieto <cmn@elego.de> writes:
>=20
> > Sometimes it's useful to clone only a subset of branches from a remote
> > we're cloning. Teach clone the --fetch option to select which branches
> > should get fetched.
> >=20
> > Each --fetch sets up a fetch refspec for that branch. Previously this
> > was only possible by initializing a repo and manually setting up the
> > config.
>=20
> I haven't read the code, but I guess it should be possible to share
> code with "git remote add", which allows to select which branches to
> track, and which branch is to be 'main' on remote.
>=20
>   git remote add [-t <branch>] [-m <master>] [-f] ...

Ah, very nice. I didn't know about those options. Hopefully I can use
it. Thanks for pointing it out.

   cmn

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO92C6AAoJEHKRP1jG7ZzTe60H/3r0L96P0mSMj0mtekT0e8PK
wS5sFDLAcG1ITaQFgAJjGxmEuHMxgpdgUHwSWiUDNmVAknkbw82+V1ZlZ0iLXgDd
0Xb43dbif+myBAU5LUMr87XAh62YtWlpP86mHtowzH8i5TSClNMxxt9k+rx/EIyB
xavmfi4UV21UgaIKPfsNqqPlpFoClDHYrWEXGo0pHh22FGFZkFUbh6yLzwkK7nFB
qsyG6YJMTG+drD5yVylIxApgJIs6RkKUxI6OQB1t9zc5RyokRd21RWDurdQCKJl1
4/pN5RhEvaHkhWCZJC4OqJjqJhpxuQdoiAs/ornO0tVCzhdGeEEEd9mA3lEEQPQ=
=kf6y
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
