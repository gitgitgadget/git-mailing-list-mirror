From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git svn fetch segfaults
Date: Wed, 9 Jan 2008 01:33:07 +0100
Message-ID: <20080109003307.GS29972@genesis.frugalware.org>
References: <200801082325.45756.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iIq+KTIB+xWY0FJy"
Cc: git@vger.kernel.org
To: Dennis Schridde <devurandom@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jan 09 01:33:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCOt1-00018Q-5u
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 01:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbYAIAdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 19:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbYAIAdM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 19:33:12 -0500
Received: from virgo.iok.hu ([193.202.89.103]:53292 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbYAIAdK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 19:33:10 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 359D91B24FA;
	Wed,  9 Jan 2008 01:33:09 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D23584466A;
	Wed,  9 Jan 2008 01:31:29 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0AEAA1190499; Wed,  9 Jan 2008 01:33:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200801082325.45756.devurandom@gmx.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69939>


--iIq+KTIB+xWY0FJy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2008 at 11:25:45PM +0100, Dennis Schridde <devurandom@gmx.n=
et> wrote:
> mkdir org.gna.warzone2100.git
> cd org.gna.warzone2100.git
> git --bare init
> git --bare svn init --use-svnsync-props --stdlayout=20
> file:///var/svn/warzone2100/
> git --bare svn fetch

wget http://svn.kynes.de/warzone2100.bz2

svnadmin create warzone2100 && bzcat warzone2100.bz2 | svnadmin load warzon=
e2100

the rest is the same i get a segfault at the very same place.

> If I do not specify --use-svnsync-prop to "git svn init", it gets past r1=
3 in=20
> tags/1.10a.

same.

> I am using these versions:
> svn, version 1.4.6 (r28521)
> git version 1.5.4.rc2

$ svn --version
svn, version 1.4.5 (r25188)

$ git --version
git version 1.5.4.rc2.38.gd6da3

thanks,
- VMiklos

--iIq+KTIB+xWY0FJy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHhBZDe81tAgORUJYRAqJAAJ9V8DhTR7iN1/UTVh3BAMGRt5mmAQCfd3vz
h+ChI8LycX3Jb3UxsbkmLFI=
=QpMv
-----END PGP SIGNATURE-----

--iIq+KTIB+xWY0FJy--
