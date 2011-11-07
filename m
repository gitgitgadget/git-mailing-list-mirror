From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: How to take dump and import to new git repository
Date: Mon, 7 Nov 2011 12:46:48 +0100
Message-ID: <20111107114648.GC10936@beez.lab.cmartin.tk>
References: <1320666117862-6970049.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Cc: git@vger.kernel.org
To: redhat1981 <redhat1981@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 12:47:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNNfL-0001mS-CB
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 12:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab1KGLq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 06:46:58 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:40152 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752418Ab1KGLq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 06:46:58 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 4AF8446196;
	Mon,  7 Nov 2011 12:46:23 +0100 (CET)
Received: (nullmailer pid 15153 invoked by uid 1000);
	Mon, 07 Nov 2011 11:46:48 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	redhat1981 <redhat1981@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1320666117862-6970049.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184979>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2011 at 03:41:57AM -0800, redhat1981 wrote:
> Hi,
>=20
> I am SVN admin, Fluent with SVN, Git I am a new user, Please let me know,
> How to take dump of one git repository and then import that Dump to new
> Repo.

This is what cloning a repository does. You're probably looking for
the --mirror option.

   git clone --mirror somerepo.git newrepo.git

will give you a repository in newrepo.git that has all the branches
and tags from somerepo.git.

   cmn



--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOt8UoAAoJEHKRP1jG7ZzTjcUH+wT6u1XkdjUX+dkg/grnmIO9
qjdJ4gIUhXj9Vs8nBu7uPosrix7ZEdFRnBPSfgzQhVRb9Mm1dO4ICmJxRsJrsMrx
kO+E5SAfgmYPwYamR/ClOe2gFfXsYAfiuk48LvQZJyuleVfvz1NT+KEh7zBiuVXE
JZ9k263Oh5oloOZVbpcKc6K0RoiraIC4NbbtK8ahnbFNU8FjKCEKTYEKV/haz9pI
XQUhG4UckEbg5R/i69Dmf1BUpoWPRinDuxETKKZDFyicB7JAdBChmDZlbPSnuRYM
duwA3fNFWqJaGRkxnEYeuHor2XJOiXe4jHuB1Ahl3ITxLjSmtaLYtkeUcD09NFU=
=5Ygi
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
