From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Unable to push remote branches
Date: Fri, 6 May 2011 10:30:03 +0200
Message-ID: <20110506083003.GA6866@bee.lab.cmartin.tk>
References: <BANLkTimd887k0D=OL9rSuq6Z3FkhNAFAbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Cc: git@vger.kernel.org
To: Srinidhi K V <srinidhikv@yahoo.co.in>
X-From: git-owner@vger.kernel.org Fri May 06 10:30:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIGQP-0007dT-E2
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 10:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab1EFIaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 04:30:06 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:35472 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221Ab1EFIaF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 04:30:05 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id AD35C46138;
	Fri,  6 May 2011 10:29:43 +0200 (CEST)
Received: (nullmailer pid 6976 invoked by uid 1000);
	Fri, 06 May 2011 08:30:03 -0000
Content-Disposition: inline
In-Reply-To: <BANLkTimd887k0D=OL9rSuq6Z3FkhNAFAbQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172957>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 06, 2011 at 10:17:37AM +0530, Srinidhi K V wrote:
> Hi All,
>=20
> I have a GIT repository in which there are lot of remote branches, I
> have created a bare git repository in my server. When I push my local
> repository to the bare repository in server using "git push --all"
> only local branches get pushed.

This is exactly what the man page says --all does. Remote branches are
under refs/remotes/<remote>/heads. You might want to use --mirror or
specify refs/remotes/* as the branches to push (I haven't tested this
refspec, but I think it should work).

   cmn

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNw7GLAAoJEHKRP1jG7ZzTFEMH/1joRzgVElTotman0IS4WBZT
+LV3m6OgATXAmwDuEVYsH7gQeLBNmsu0yaNdEtuE7iRlyVWO/Re2b6to42YyAFon
8XT/v5zyGwboe197YV+jQUkVuFN511hkyirssGMVUW8LoptzbshWzYumHJYcCgS3
t/KIsTqgGAy72rtiqS0csIjLsGNKGYAYI2eprcQxG2zPaqOQTXW0F8S8ul7vP7ll
XxAIYXZ5R2WwoWa9/nNBpFFgzdI17oTtwBy3JkHRkrr2XLEH82hM6u8ZmCTBAH8r
XW4g0YcXI10vCCyKS98/004dK2hZ8Nv3m711jpADHF8B7xJoE9faoq1y0kNfnxw=
=xvPJ
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
