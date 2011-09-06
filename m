From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: user permission / authority
Date: Tue, 06 Sep 2011 12:45:40 +0200
Message-ID: <1315305949.9839.3.camel@bee.lab.cmartin.tk>
References: <1315303980991-6763296.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-jMVkK4mmwLWvYSrh1ueV"
Cc: git@vger.kernel.org
To: ian <ian.attard@methode-eur.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 12:46:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0tAC-0007pa-N1
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 12:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab1IFKpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 06:45:52 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:40509 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753846Ab1IFKpv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 06:45:51 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 187F246170;
	Tue,  6 Sep 2011 12:45:34 +0200 (CEST)
In-Reply-To: <1315303980991-6763296.post@n2.nabble.com>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180794>


--=-jMVkK4mmwLWvYSrh1ueV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-09-06 at 03:13 -0700, ian wrote:
> I could not find user permission or authority level. Thatis, I can restri=
ct a
> user not to use the 'commit' function for example. Seems that everyone
> having GIT & TortoiseGIT can do any of the functions. Is there a way (or =
any
> other GUI)that enables these restrictions by user?

Not as far as I know, but this isn't necessary. Git is a distributed
system, so any changes that an user does only exist in their local
repository until they push the changes out to some other repository, and
with gitolite[0] you can restrict who can push to which branches.

If you just want people to be able to browse the repository, maybe
installing gitweb or cgit would fit your needs better.


[0] https://github.com/sitaramc/gitolite

--=-jMVkK4mmwLWvYSrh1ueV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOZfnUAAoJEHKRP1jG7ZzTvcQIAJ7OmBEfpJtCnU5ir2w2lLqH
A5S/Kq1P90yJkNcpsgPoywsrhGgqdIOo3TG/09YJcUcPEq5pt+yWs5MPciZ+qVJ9
p04MadC3XBzzW0iUc+NpRz2xqtcex3k/4EcslPP4quJEbDm+zXfT5Ughmk9KFDn9
k1+5gQ6jgkaorxy8v71tM3Nx5o2f01MBL7G7c76N2N0i/7mMCknmvvw46UABR/yO
v7cfiNeH+fQXHLcidYpJjnngzK1BfpieIg7H3lcxNUqA22lNxIR/mvR4W1MpHMgA
pdcutcveY6MJ+b2hivovBkcqUi7WVSwIAurS3nkS0VEixYzrvC80JkDoU5O452s=
=ls5v
-----END PGP SIGNATURE-----

--=-jMVkK4mmwLWvYSrh1ueV--
