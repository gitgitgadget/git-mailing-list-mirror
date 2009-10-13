From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: quote in help code example
Date: Tue, 13 Oct 2009 12:19:16 +0200
Message-ID: <20091013101916.GV23777@genesis.frugalware.org>
References: <20091012102926.GA3937@debian.b2j>
 <20091012194016.GS23777@genesis.frugalware.org>
 <20091013021616.GA10554@debian.b2j>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 12:30:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxeYI-0003Yh-RM
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 12:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759331AbZJMKT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 06:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759324AbZJMKT4
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 06:19:56 -0400
Received: from virgo.iok.hu ([212.40.97.103]:48001 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759322AbZJMKTz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 06:19:55 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 94E9D580B5;
	Tue, 13 Oct 2009 12:19:16 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 85F9B44906;
	Tue, 13 Oct 2009 12:19:16 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C2FAE11F0028; Tue, 13 Oct 2009 12:19:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20091013021616.GA10554@debian.b2j>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130153>


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2009 at 10:16:17AM +0800, bill lam <cbill.lam@gmail.com> wr=
ote:
> > Just a guess: do you have docbook-xsl >=3D1.73.0 and you did not set
> > ASCIIDOC_NO_ROFF?
> >=20
> > Try rebuilding the documentation using 'make ASCIIDOC_NO_ROFF=3DYesPlea=
se'.
>=20
> I'm not familiar with how to twist git makefile.  By adding a line to ./M=
akefile
>=20
> # Platform specific tweaks
> #
>=20
> # We choose to avoid "if .. else if .. else .. endif endif"
> # because maintaining the nesting to match is a pain.  If
> # we had "elif" things would have been much nicer...
>=20
> ASCIIDOC_NO_ROFF =3D YesPlease       # <--- this line added
> ifeq ($(uname_S),Linux)
>=20
> However, the man page still display the same

Don't edit the Makefile, just use the command 'make
ASCIIDOC_NO_ROFF=3DYesPlease'. Also make sure to do a 'make clean' in the
Documentation dir to get the manpages rebuilt.

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrUVCQACgkQe81tAgORUJaqtQCeIbbUQmDuyQSJ3Hm0faQdfjhc
WZQAn2Lvu/k6rgVMxgUU0RrM4edVj9Cc
=UgBc
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--
