From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: [PATCH 01/02/RFC] implement a stat cache
Date: Sun, 20 Apr 2008 12:18:47 +0100
Message-ID: <20080420111847.GC13411@bit.office.eurotux.com>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org> <20080420111346.GA13411@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 13:19:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnXa6-0004e5-LM
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 13:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbYDTLSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 07:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752562AbYDTLSx
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 07:18:53 -0400
Received: from os.eurotux.com ([216.75.63.6]:59118 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbYDTLSw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 07:18:52 -0400
Received: (qmail 11704 invoked from network); 20 Apr 2008 11:18:51 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 20 Apr 2008 11:18:51 -0000
Content-Disposition: inline
In-Reply-To: <20080420111346.GA13411@bit.office.eurotux.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79955>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2008 at 12:13:46PM +0100, Luciano Rocha wrote:
> An implementation of stat(2) and lstat(2) caching. Both the return code
> and returned information are cached.
>=20
> Signed-off-by: Luciano Rocha <strange@nsk.no-ip.org>
> ---
> On Sat, Apr 19, 2008 at 03:39:37PM -0700, Linus Torvalds wrote:
> > Yeah. I didn't look any further, but we do a total of *nine* 'lstat()'=
=20
> > calls for each file we know about that is dirty, and *seven* when they =
are=20
> > clean. Plus maybe a few more.
>=20
> That's a lot. Why not use a stat cache?
>=20
> With these changes, my git status . in WebKit changes from 28.215s to
> 15.414s.

git status . in git changes from 0.477s to 0.412s.

All tests under OS X.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFICyaXinSul6a7oB8RAieSAJ9MAzZAmw8N2BBQVd9Jz0GxMkPlfwCfXWcQ
Y6IbkypKliTWOflDGAfNkLM=
=Ah4T
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
