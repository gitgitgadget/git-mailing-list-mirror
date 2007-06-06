From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: Re: [PATCH] cvsimport: add support for new style remote layout
Date: Wed, 06 Jun 2007 06:52:24 -0500
Message-ID: <1181130744.3661.7.camel@lt21223.campus.dmacc.edu>
References: <3a477a76f6c5396feee452678fb8110c@pinky>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HEFjRwOVUJ50nqBtH63/"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 13:51:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvu3I-00023V-Ib
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 13:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762895AbXFFLvY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 07:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762860AbXFFLvY
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 07:51:24 -0400
Received: from homer.isunet.net ([63.175.164.9]:55969 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762972AbXFFLvX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 07:51:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id 13A3C3882FB
	for <git@vger.kernel.org>; Wed,  6 Jun 2007 06:00:12 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 22796-06 for <git@vger.kernel.org>; Wed,  6 Jun 2007 06:00:11 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id 4BC083882FE
	for <git@vger.kernel.org>; Wed,  6 Jun 2007 06:00:11 -0500 (CDT)
Received: from [172.16.0.186]
	by max1.ocjtech.us with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1Hvu2x-0004GR-Fh
	for git@vger.kernel.org; Wed, 06 Jun 2007 06:51:27 -0500
In-Reply-To: <3a477a76f6c5396feee452678fb8110c@pinky>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49287>


--=-HEFjRwOVUJ50nqBtH63/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-30 at 01:56 +0100, Andy Whitcroft wrote:
> cvsimport creates any branches found in the remote CVS repository
> in the refs/heads namespace.  This makes sense for a repository
> conversion.  When using git as a sane interface to a remote CVS
> repository, that repository may well remain as the 'master'
> respository.  In this model it makes sense to import the CVS
> repository into the refs/remotes namespace.
>=20
> Add a new option '-r <remote>' to set the remote name for
> this import.  When this option is specified branches are named
> refs/remotes/<remote>/branch, with HEAD named as master matching
> git-clone separate remotes layout.  Without branches are placed
> ion refs/heads, with HEAD named origin as before.

I've run over 5GB of cvs imports through git-cvsimport with this patch
and it's worked very well for me...

Jeff


--=-HEFjRwOVUJ50nqBtH63/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGZp/zrtk7xyyIQRERAkXvAJ4nY4xBrysJVHwF+5Ppgs/vXgryeQCfXEr+
iM2lhCbSzwOBtyOCwogDvNs=
=tk/h
-----END PGP SIGNATURE-----

--=-HEFjRwOVUJ50nqBtH63/--
