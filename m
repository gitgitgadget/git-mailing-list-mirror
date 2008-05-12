From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: multiple files for the same hook
Date: Mon, 12 May 2008 22:44:45 +0200
Message-ID: <20080512204445.GT27724@genesis.frugalware.org>
References: <200805122039.49779.hto@arcor.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOmQO3H5Qmmwdmk8"
Cc: git@vger.kernel.org
To: Thomas Hunger <hto@arcor.de>
X-From: git-owner@vger.kernel.org Mon May 12 22:45:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvett-00033F-2o
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204AbYELUor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753703AbYELUor
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:44:47 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50023 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631AbYELUoq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:44:46 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A5D611B2560;
	Mon, 12 May 2008 22:44:45 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id AC5F64465E;
	Mon, 12 May 2008 22:37:01 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 83A0A178801F; Mon, 12 May 2008 22:44:45 +0200 (CEST)
Mail-Followup-To: Thomas Hunger <hto@arcor.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200805122039.49779.hto@arcor.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81947>


--hOmQO3H5Qmmwdmk8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2008 at 08:39:49PM +0000, Thomas Hunger <hto@arcor.de> wrot=
e:
> we use hooks a lot for various cleanup tasks, tests and warnings. It=20
> would be wonderful if we could keep the hook logic in separate files.=20
>=20
> Something like
>=20
>     hooks/post-commit.d/
>=20
> where all executable files in the dir are executed in alphanumeric=20
> order. Is there a possibility of this going into git (I could try a=20
> patch)?

why would you want so? just create a script named hooks/post-commit,
like:

----
#!/bin/sh
/path/to/first/script
/path/to/second/script
----

or so.

it's not something git should do for you.

--hOmQO3H5Qmmwdmk8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkgorD0ACgkQe81tAgORUJYsrwCeJxlfT4x2u/n3bM8C/nLmQYE2
1nQAnjlNhZajHhXSwlShZdLWbXuKxqIg
=fEBS
-----END PGP SIGNATURE-----

--hOmQO3H5Qmmwdmk8--
