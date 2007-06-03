From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Use git-tag in git-cvsimport
Date: Mon, 4 Jun 2007 00:53:55 +0200
Message-ID: <20070603225354.GB16637@admingilde.org>
References: <11808537962798-git-send-email-el@prans.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Cc: git@vger.kernel.org
To: Elvis Pranskevichus <el@prans.net>
X-From: git-owner@vger.kernel.org Mon Jun 04 00:54:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuyxW-0003mU-K9
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 00:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbXFCWx5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 18:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbXFCWx5
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 18:53:57 -0400
Received: from mail.admingilde.org ([213.95.32.147]:55031 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbXFCWx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 18:53:56 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HuyxP-0005X8-29; Mon, 04 Jun 2007 00:53:55 +0200
Content-Disposition: inline
In-Reply-To: <11808537962798-git-send-email-el@prans.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49047>


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Jun 03, 2007 at 02:56:36AM -0400, Elvis Pranskevichus wrote:
> Fix this by calling git-tag instead. This also has a nice side effect of
> not creating the tag object but only the lightweight tag as that's the on=
ly
> thing CVS has anyways.

but lightweight tags are not fetched by default.
And only leaving them in the repository that actually did the cvsimport
makes them much less valuable.

> +
> +		system("git-tag $xtag $cid") =3D=3D 0

I suggest adding something like -m "import label from CVS".

--=20
Martin Waitz

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGY0aCj/Eaxd/oD7IRApsLAJ9j8rCVDLQQvi76pNel5/PKd1KueACfRdKm
zg8sx6XZOtwUbXfAn+exOLo=
=bd+h
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
