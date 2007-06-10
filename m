From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [ANNOUNCE] qgit-2.0rc1
Date: Sun, 10 Jun 2007 19:56:28 +0200
Message-ID: <20070610175628.GI4084@efreet.light.src>
References: <e5bfff550706100447g5d34adf2j92389cd193658738@mail.gmail.com> <200706101704.51374.ismail@pardus.org.tr> <e5bfff550706100736v110055acn8ecca19f5c3f5cff@mail.gmail.com> <200706101933.36760.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GBDnBH7+ZvLx8QD4"
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Pavel Roskin <proski@gnu.org>,
	Andy Parkins <andyparkins@gmail.com>
To: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Sun Jun 10 19:56:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxReY-0006jZ-Ue
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 19:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757718AbXFJR4d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 13:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760056AbXFJR4d
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 13:56:33 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:48878 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757953AbXFJR4c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 13:56:32 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 260D25767A;
	Sun, 10 Jun 2007 19:56:30 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HxReO-0003oP-Kw; Sun, 10 Jun 2007 19:56:28 +0200
Content-Disposition: inline
In-Reply-To: <200706101933.36760.ismail@pardus.org.tr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49751>


--GBDnBH7+ZvLx8QD4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 10, 2007 at 19:33:31 +0300, Ismail D=C3=B6nmez wrote:
> On Sunday 10 June 2007 17:36:42 you wrote:
> > On 6/10/07, Ismail D=C3=B6nmez <ismail@pardus.org.tr> wrote:
> > > Uploaded to http://cekirdek.pardus.org.tr/~ismail/tmp/qgit4-report.tx=
t .
> >
> > Ok. You seem to miss all the debug libraries  _and_ the whole
> > libQtUiTools library.
>=20
> Nope not a Qt problem. Removing -frepo from CXXFLAGS fixes the issue. Gcc=
=20
> 4.2.0 doesn't seem to like it for some reason.

I did a brief STFW and found problems with -frepo to be rather common. From
what I understood, it works by trying to link, parsing the errors,
instantiating the missing bits and compiling again. And the whole thing is
rather fragile.

What could be interesting for you is debian bug
http://lists.debian.org/debian-gcc/2007/05/msg00374.html

It says that -frepo only works with C locale, but it would actually be in a=
ny
locale where ld messages are not localized. On my system it has message
catalog in da, es, fr, ga, sv, tr, vi, zh_CN and zh_TW. Don't you have tr_TR
for LC_MESSAGES?

On another side, is there a measurable compilation time improvement with -f=
repo?

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--GBDnBH7+ZvLx8QD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGbDtMRel1vVwhjGURAk+5AJ4tIKvzRqj6q7dMAn4B/mb1XxI7QwCfS+z6
pH8RDxgbbQ2XTOv8/g9aCS4=
=KU1T
-----END PGP SIGNATURE-----

--GBDnBH7+ZvLx8QD4--
