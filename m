From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Wed, 11 Feb 2009 01:11:38 +0100
Message-ID: <20090211001138.GU21473@genesis.frugalware.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <20090130023040.GR21473@genesis.frugalware.org> <alpine.DEB.1.00.0901301426150.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U4NVc4IQnsXgIEHQ"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 11 01:13:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX2iz-00038m-DI
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 01:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398AbZBKALm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 19:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754187AbZBKALm
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 19:11:42 -0500
Received: from virgo.iok.hu ([212.40.97.103]:53492 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755389AbZBKALm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 19:11:42 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B76C6580D2;
	Wed, 11 Feb 2009 01:11:39 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 235494465E;
	Wed, 11 Feb 2009 01:11:38 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8642C11B87AC; Wed, 11 Feb 2009 01:11:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901301426150.3586@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109359>


--U4NVc4IQnsXgIEHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[ Sorry for the late reply, I did not read my mail recently. ]

On Fri, Jan 30, 2009 at 02:28:39PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > Shouldn't this be
> >=20
> > git config receive.denyCurrentBranch ignore
> >=20
> > instead of "true"?
>=20
> Right.
>=20
> However, as Junio pointed out, we do not want to give this resolution in=
=20
> the error message.  I am now leaning more to something like
>=20
> 	refusing to update checked out branch '%s' in non-bare repository
>=20
> Hmm?
>=20
> Old-timers will know "oh, what the hell, I did not mark my repository as=
=20
> bare!", and new-timers will no longer be confused.

So in an "I know what I'm doing" mode, is "git config core.bare true" in
a non-bare repo considered as a better workaround than using "git config
receive.denyCurrentBranch ignore"?

--U4NVc4IQnsXgIEHQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmSF7oACgkQe81tAgORUJYHCwCcDcbs4E/8pBF5G7uJ2oouBvZf
WKMAoIlgy08Sd7Fhn5IAfSVoj21LBAYc
=qqS1
-----END PGP SIGNATURE-----

--U4NVc4IQnsXgIEHQ--
