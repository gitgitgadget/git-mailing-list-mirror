From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: Invalid path on new Git installation
Date: Tue, 27 May 2008 16:14:06 +0100
Message-ID: <20080527151406.GA16378@bit.office.eurotux.com>
References: <8345bd80805270758j1315234bwf3b16607c95c9620@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Cc: git@vger.kernel.org
To: Marcus <prima@wordit.com>
X-From: git-owner@vger.kernel.org Tue May 27 17:15:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K10tG-00067S-Nm
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 17:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756510AbYE0POO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 11:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756361AbYE0POO
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 11:14:14 -0400
Received: from os.eurotux.com ([216.75.63.6]:47772 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756191AbYE0PON (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 11:14:13 -0400
Received: (qmail 4434 invoked from network); 27 May 2008 15:14:11 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 27 May 2008 15:14:11 -0000
Content-Disposition: inline
In-Reply-To: <8345bd80805270758j1315234bwf3b16607c95c9620@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83024>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2008 at 03:58:05PM +0100, Marcus wrote:
> Can anybody help me with defining a valid path to a Git repo on a new
> installation?
> I just built Git on a webserver (a VPS so I have root access). When I
> try clone or push I get this error:
>=20
> fatal: '/git/watchsite.git': unable to chdir or not a git archive
> fatal: The remote end hung up unexpectedly
> fetch-pack from 'ssh://me@mydomain.com/git/projectname.git' failed.
>=20
> Why this when I can use wget on this path:
> wget mydomain.com/git/projectname.git/file.html
> The above successfully downloads the file, so the path is valid, right?

ssh://me@mydomain.com/git/projectname.git means the folder
/git/projectname.git in host mydomain.com

http://mydomain.com/git/projectname.git/file.html means whatever folder
your webserver is mapping /git/projectname.git to. Usually,
/var/www/html/git/projectname.git.

> I also did "git init" on the remote repo (not sure if that's necessary?).

What is the correct path on the remote? Note that ssh://host/dir isn't
the same as host:dir (both are acceptable), as the latter means ~me/dir,
while the former means /dir.

You could switch to the me@host:path location, or add a ~/:
ssh://me@host/~/dir

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkg8JT4ACgkQinSul6a7oB+MMACglNsZ+6q73echKNqiuvBF0Z8W
fYcAnjKLCMbB8JOM1BLR0//iIPpX5RfC
=/vhd
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
