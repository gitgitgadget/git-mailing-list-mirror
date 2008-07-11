From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: Re: feature request: git-log should accept sth like v2.6.26-rc8-227
Date: Fri, 11 Jul 2008 15:39:04 +0200
Message-ID: <200807111539.06606.toralf.foerster@gmx.de>
References: <200807102057.15063.toralf.foerster@gmx.de> <alpine.DEB.1.00.0807102028420.18205@racer>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7199409.nOybBXZ8d8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 15:40:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHIr4-0006fb-Jv
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 15:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbYGKNjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 09:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755467AbYGKNjM
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 09:39:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:59216 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755221AbYGKNjL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 09:39:11 -0400
Received: (qmail invoked by alias); 11 Jul 2008 13:39:08 -0000
Received: from d036167.adsl.hansenet.de (EHLO d036167.adsl.hansenet.de) [80.171.36.167]
  by mail.gmx.net (mp058) with SMTP; 11 Jul 2008 15:39:08 +0200
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX19LKuIri9lLpo1fnLztSm41MoeauaPGcOnnC+z2Wp
	open2r9EbAMWZl
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0807102028420.18205@racer>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88119>

--nextPart7199409.nOybBXZ8d8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

At Thursday 10 July 2008 21:29:07 Johannes Schindelin wrote :
> Hi,
>=20
> On Thu, 10 Jul 2008, Toralf F=F6rster wrote:
>=20
> > I appended those strings to the names of my UML kernel executables.=20
> > Unfortunately I didn't used the commit id and now I'm wondering whether=
=20
> > git could accept v2.6.26-rc9-56 as well in future.
>=20
> If that were unambiguous, yes.  But it is not.
>=20
> Ciao,
> Dscho
>=20

Ok, following the thread I understand why this feature isn't wanted by all.=
 But
for the given example (where I only pulled from another git tree) this could
work, isn't it : ?

tfoerste@n22 ~/devel/linux-2.6 $ git-log v2.6.26-rc9.. | perl -e '@c =3D gr=
ep { /^commit/ } <>; print map { $#c - $i++ . "\t" . $_ } @c'


=2D-=20
MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

--nextPart7199409.nOybBXZ8d8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkh3YnoACgkQhyrlCH22naOQqwCeI6Rf6DFugqGaz1P1OO+0hhiR
+xAAn0SsXB19IIfqdRaHyWt/LMkjrJ4Z
=TEqu
-----END PGP SIGNATURE-----

--nextPart7199409.nOybBXZ8d8--
