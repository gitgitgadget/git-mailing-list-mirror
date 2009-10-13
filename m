From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: quote in help code example
Date: Tue, 13 Oct 2009 17:30:31 +0200
Message-ID: <20091013153031.GX23777@genesis.frugalware.org>
References: <20091012102926.GA3937@debian.b2j>
 <20091012194016.GS23777@genesis.frugalware.org>
 <20091013021616.GA10554@debian.b2j>
 <20091013101916.GV23777@genesis.frugalware.org>
 <20091013140622.GA3927@debian.b2j>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 17:33:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxjMj-000094-IN
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 17:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbZJMPbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 11:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbZJMPbL
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 11:31:11 -0400
Received: from virgo.iok.hu ([212.40.97.103]:48850 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196AbZJMPbK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 11:31:10 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A5FE2580B5;
	Tue, 13 Oct 2009 17:30:31 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6C50044906;
	Tue, 13 Oct 2009 17:30:31 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9BEDB11F0028; Tue, 13 Oct 2009 17:30:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20091013140622.GA3927@debian.b2j>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130167>


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2009 at 10:06:23PM +0800, bill lam <cbill.lam@gmail.com> wr=
ote:
> I run these commands=20
>=20
> make ASCIIDOC_NO_ROFF=3DYesPlease prefix=3D/usr all doc info
> sudo make ASCIIDOC_NO_ROFF=3DYesPlease prefix=3D/usr install install-doc =
install-html install-info
>=20
> 1. did I need to set ASCIIDOC_NO_ROFF in both lines?

In general, it's always a good idea, though I don't think it's necessary
for the second time.

> 2. now the .ft pair fixed but it still displayed incorrect quote.
>=20
>  git filter-branch --tree-filter =B4rm filename=B4 HEAD
>=20
> it should be 'rm filename' not =B4rm filename=B4

I can reproduce that here as well, that's how it is in the official
manpages as well (see the man branch), so that's not specific to your
system.

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrUnRcACgkQe81tAgORUJZRkgCfU2vAtu1uJhk7IKn4e1lORY4l
UVYAniukkqJBsaJ46gDIRqSx+8fYznxa
=lJ75
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
