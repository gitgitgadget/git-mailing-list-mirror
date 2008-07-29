From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: git-svn and svn:externals, was Re: Hackontest ideas?
Date: Tue, 29 Jul 2008 14:08:23 +0100
Message-ID: <20080729130823.GB30334@bit.office.eurotux.com>
References: <20080729000103.GH32184@machine.or.cz> <m3myk1t54c.fsf@localhost.localdomain> <alpine.DEB.1.00.0807291354130.4631@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 15:16:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNp3i-0007kF-3B
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 15:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbYG2NPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 09:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbYG2NPJ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 09:15:09 -0400
Received: from os.eurotux.com ([216.75.63.6]:56458 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753342AbYG2NPI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 09:15:08 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jul 2008 09:15:08 EDT
Received: (qmail 15029 invoked from network); 29 Jul 2008 13:08:27 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@213.205.93.24)
  by 0 with AES256-SHA encrypted SMTP; 29 Jul 2008 13:08:27 -0000
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807291354130.4631@eeepc-johanness>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90635>


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2008 at 01:56:37PM +0200, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 29 Jul 2008, Jakub Narebski wrote:
>=20
> >  * handling of svn:externals using submodules
>=20
> I doubt that this is easy.  Otherwise, Eric would have done it a long tim=
e=20
> ago.
>=20
> The main concern I have is to get the semantics right: AFAICT=20
> svn:externals has _no notion_ of "what is current".  It just _always_=20
> fetches the HEAD.  Even if you check out an ancient revision in the=20
> "superproject".

Usually, yes. But you could specify a specific revision with -r <rev>.

Or, for branches/tags, as they're paths, a correct url would suffice.

With the new 1.5, it is also possible to specify pegged revisions. Much
better, because otherwise subversion would require that the path existed
in the server in HEAD.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiPFkcACgkQinSul6a7oB8mqwCfbdNTU41eMN14SdIOethxTVMn
nC0AoIjG9gvb0/YGvNlJYt/ExtdJwC/O
=5+68
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
