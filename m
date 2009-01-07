From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] gitweb: support the rel=vcs microformat
Date: Wed, 7 Jan 2009 10:50:23 -0500
Message-ID: <20090107155023.GA16540@gnu.kitenet.net>
References: <20090107042518.GB24735@gnu.kitenet.net> <gk2794$djn$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 16:52:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKahI-00065f-6f
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 16:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982AbZAGPub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 10:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755779AbZAGPua
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 10:50:30 -0500
Received: from wren.kitenet.net ([80.68.85.49]:34520 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755516AbZAGPua (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 10:50:30 -0500
Received: from gnu.kitenet.net (fttu-67-223-5-142.btes.tv [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 03A483142F2;
	Wed,  7 Jan 2009 10:50:26 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id E063DA8A16; Wed,  7 Jan 2009 10:50:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <gk2794$djn$1@ger.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8842/Wed Jan  7 09:06:50 2009 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104806>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Giuseppe Bilotta wrote:
> In this patch you do NOT add titles to the rel=3Dvcs links, which means t=
hat
> everything works fine only if there is a single URL for each project. If a
> project has different URLs, it's going to appear multiple times as _diffe=
rent_
> projects to a spec-compliant reader.
>=20
> A possible solution would be to make @git_url_list into a map keyed by the
> project name and having the description and repo URL(s) as values.

Yes. I considered doing that, but didn't immediatly see a way to get the
project description w/o additional overhead (of looking it up a second
time).

> > This changes git_get_project_description() to not check wantarray, and =
only
> > return in list context -- the only way it is used AFAICS.
>=20
> I assume you mean git_get_project_url_list()?

In fact yes.
=20

Thanks for the feedback. There are some changes happening to the
microformat that should make gitweb's job slightly easier, I'll respin
the patch soon.

--=20
see shy jo

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJZM88d8HHehbQuO8RAg2iAJ98e8EqO5Ere3PeLGDDSrNkvIq/+QCdEgst
DAaIGQqMdcF3/Ny1nrHvd9s=
=eSvn
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
