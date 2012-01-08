From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: SVN -> Git *but* with special changes
Date: Sun, 8 Jan 2012 13:08:07 +0100
Message-ID: <20120108120807.GA7360@angband.pl>
References: <1317227849979-6840904.post@n2.nabble.com>
 <20110928190445.GC1482@sigill.intra.peff.net>
 <1325999031923-7163706.post@n2.nabble.com>
 <20120108051051.GA10129@sigill.intra.peff.net>
 <1325999865995-7163737.post@n2.nabble.com>
 <1326000327637-7163752.post@n2.nabble.com>
 <20120108103303.GC2714@centaur.lab.cmartin.tk>
 <m2hb06mpwn.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Cc: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Abscissa <bus_nabble_git@semitwist.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Jan 08 13:09:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjrYb-0000DX-CZ
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 13:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408Ab2AHMIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 07:08:38 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:50210 "EHLO
	tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab2AHMIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 07:08:38 -0500
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.72)
	(envelope-from <kilobyte@tartarus.angband.pl>)
	id 1RjrXj-0001wY-GJ; Sun, 08 Jan 2012 13:08:07 +0100
Content-Disposition: inline
In-Reply-To: <m2hb06mpwn.fsf@linux-m68k.org>
X-Junkbait: adolf@angband.pl, zareba@angband.pl
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@tartarus.angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188105>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 08, 2012 at 11:47:52AM +0100, Andreas Schwab wrote:
> Carlos Mart=EDn Nieto <cmn@elego.de> writes:
> > On Sat, Jan 07, 2012 at 09:25:27PM -0800, Abscissa wrote:
> >> Well that's strange, it finished "upgrading", but now git is still just
> >> reporting 1.7.0.4, which is *exactly* the same version it said before.=
 The
> >> git-svn package should already be up-to-date because I just installed =
it=20
> >> today. So I don't know what's up with that.
> >
> > Nothing odd about that. apt-get upgrade means "upgrade my system". If
> > you want to get a newer version of package X, you do apt-get install X
> > and it will install the latest version of that package.
>=20
> If apt-get upgrade doesn't get you a newer version then apt-get install
> won't help you either.

No, this is true only if none of packages involved uses a new library
(including new sonames).  "apt-get upgrade" is forbidden to add or remove
packages, and thus will skip upgrades that need a new dependency.
The message at the end will mention "## not upgraded" though.

"apt-get install X" or "apt-get dist-upgrade" have no such restrictions.

--=20
1KB		// Yo momma uses IPv4!

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCgAGBQJPCYcnAAoJECw7Q2/qxoEB7mgH/0GEu+CmIsOUArOeeI+xFBVN
HvvKs4VQRfszTNcSmDai2Rc+tWcYbKXMsr5ApOAmRBi0BXvbdmO9v4W++OVJBiTv
jzXFVLXJNvYvlkwX3dwzXHdfcQIHKb+2SNDK8QRN2dr0YMNNLx3+Elq5PKnuyn+Q
tstsVwIwE/umyFfIjFrMLy1KnjK8nNn5y89KYYzkGC6l//bV7sgKvpZhL5pTVfqn
xOD7ob4mpkuuu2HSJUfGcGzrWishLGvSeXqem4oCD2FNWAu15IBDNyl3D88X9pIc
un4Y7YJYVhYnfBtIf4i3a3sG92f8ag5Z4kKn4WlB2Yew+xJJEMTJn9IQw8pdKfw=
=EF3K
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
