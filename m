From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: relative objects/info/alternates
Date: Sat, 15 Dec 2007 07:39:40 +0000
Message-ID: <20071215073940.GA22118@bit.office.eurotux.com>
References: <20071214140613.GA13259@bit.office.eurotux.com> <m3bq8tqs9c.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 08:40:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Rd5-0004cg-BC
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 08:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbXLOHjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 02:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbXLOHjs
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 02:39:48 -0500
Received: from os.eurotux.com ([216.75.63.6]:35507 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbXLOHjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 02:39:48 -0500
Received: (qmail 29970 invoked from network); 15 Dec 2007 07:39:45 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 15 Dec 2007 07:39:45 -0000
Content-Disposition: inline
In-Reply-To: <m3bq8tqs9c.fsf@roke.D-201>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68379>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2007 at 06:13:09AM -0800, Jakub Narebski wrote:
> Luciano Rocha <luciano@eurotux.com> writes:
>=20
> > Can I use relative $GIT_DIR/objects/info/alternates? Will the git
> > commands work anywhere inside the working-copy despice the alternate
> > being relative to the root of it?
>=20
> From the information in repository layout documentation:
>=20
>   objects/info/alternates::
>         This file records paths to alternate object stores that
>         this object store borrows objects from, one pathname per
>         line. Note that not only native Git tools use it locally,
>         but the HTTP fetcher also tries to use it remotely; this
>         will usually work if you have relative paths (relative
>         to the object database, not to the repository!) in your
>         alternates file, but it will not work if you use absolute
>         paths unless the absolute path in filesystem and web URL
>         is the same. See also 'objects/info/http-alternates'.
>=20
> it looks like you can have relative paths in alternates.

It doesn't work too well, when a tree with relative alternat is used by
another:

error: ./objects/../../2.6.23.y.git/objects: ignoring relative
alternate object store ../../linus.git/objects

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHY4S7inSul6a7oB8RAhYnAJ4tmh38+K8UxHUDV4rOlow1HoVKkQCeJ2X4
g0pc9T2qGsFTf/2o9lwb+iQ=
=+PwN
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
