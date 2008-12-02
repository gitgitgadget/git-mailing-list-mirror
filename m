From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Git as a BuildRequires (packaging)
Date: Tue, 2 Dec 2008 11:12:23 +0100
Message-ID: <20081202101223.GD19355@genesis.frugalware.org>
References: <20081202023004.GA30372@zod.rchland.ibm.com> <20081202030922.GC6804@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Cc: Josh Boyer <jwboyer@gmail.com>, git@vger.kernel.org,
	skvidal@fedoraproject.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 11:15:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7SIF-00069q-41
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 11:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbYLBKM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 05:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbYLBKM0
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 05:12:26 -0500
Received: from virgo.iok.hu ([212.40.97.103]:42448 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbYLBKM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 05:12:26 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C2ED3580CF;
	Tue,  2 Dec 2008 11:12:23 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8480C4465E;
	Tue,  2 Dec 2008 11:12:23 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 34E6A11901A1; Tue,  2 Dec 2008 11:12:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081202030922.GC6804@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102128>


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2008 at 10:09:23PM -0500, Jeff King <peff@peff.net> wrote:
> > So, what do the git gurus recommend?  I'm not sure if other
> > distros have tackled this problem before, but some kind of
> > commonality for the 'how do you package things that need to build
> > against git' question would be nice.
>=20
> AFAIK, cgit is the only program that behaves in this way, and it doesn't
> seem to be in Debian at all. So you might be the first to deal with it.
> :)

We have it in Frugalware[1], and it's not a that big problem: the cgit
Makefile clearly states the supported git version, you just have to
download it "manually" (specify it in the spec file in case of Fedora)
in case you want an offline build (what every distro wants).

1: http://git.frugalware.org/gitweb/gitweb.cgi?p=3Dfrugalware-current.git;a=
=3Dblob;f=3Dsource/network-extra/cgit/FrugalBuild;hb=3DHEAD

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk1CgcACgkQe81tAgORUJa/8gCeJnZt9qQXsdfssv0DqOfTWp7l
8X8AmgJ/ok4mgY3aI/EFeeroqs+3yRPP
=7Rgq
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--
