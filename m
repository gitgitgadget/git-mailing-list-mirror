From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: bare --init Vs --init bare
Date: Mon, 19 May 2008 21:10:49 +0100
Message-ID: <20080519201049.GA20981@bit.office.eurotux.com>
References: <20080519175313.GA17305@bit.office.eurotux.com> <8aa486160805191232m76bbc7detdcd2d459c8e572cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Cc: git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 22:12:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyBi1-0003AO-3K
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 22:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759167AbYESUK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 16:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758672AbYESUK5
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 16:10:57 -0400
Received: from os.eurotux.com ([216.75.63.6]:46889 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757998AbYESUK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 16:10:56 -0400
Received: (qmail 10742 invoked from network); 19 May 2008 20:10:54 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 19 May 2008 20:10:54 -0000
Content-Disposition: inline
In-Reply-To: <8aa486160805191232m76bbc7detdcd2d459c8e572cd@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82445>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2008 at 09:32:21PM +0200, Santi B=E9jar wrote:
> On Mon, May 19, 2008 at 7:53 PM, Luciano Rocha <luciano@eurotux.com> wrot=
e:
> >
> > Hello,
> >
>=20
> > This is odd:
> > $ git init --bare
> > usage: git-init [-q | --quiet] [--template=3D<template-directory>] [--s=
hared]
> > $ git --bare init
> > Initialized empty Git repository in /tmp/1/
>=20
> The first is a flag to the init subcommand (man git-init), and the
> other is a flag to git (man git).
>=20
> See also:
>=20
> http://www.google.com/search?q=3D%22git+init+--bare%22+%22git+--bare+init=
%22
>=20
> or equivalent
>=20
> http://kerneltrap.org/mailarchive/git/2007/10/15/344050
> "should git command and git-command be equivalent?"
>=20

Ok, I understand.

Still, there's a --bare command to git clone, and I had only tried
git init --bare, not the other form, and it always failed. Only today
did I learn I could do a git --bare init, from a colleague of mine.

I'd suggest allowing git init --bare, or documenting the --bare init
option.

Regards,
Luciano Rocha

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkgx3skACgkQinSul6a7oB9oqgCeIWWIaRmGJW2m3EkqfMaToe80
W7IAn1YWXpqtNOWbuKScdbh+BEWXFMuR
=ceA9
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
