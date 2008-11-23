From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [BUGFIX PATCH 2/2] fast-export: use an unsorted string list
	for extra_refs
Date: Sun, 23 Nov 2008 19:03:53 +0100
Message-ID: <20081123180353.GM4746@genesis.frugalware.org>
References: <1227378168-14992-1-git-send-email-vmiklos@frugalware.org> <alpine.DEB.1.00.0811231254580.30769@pacific.mpi-cbg.de> <alpine.DEB.1.00.0811231255380.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 23 19:06:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4JKd-0000Xe-Ff
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 19:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbYKWSD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 13:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbYKWSD6
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 13:03:58 -0500
Received: from [193.202.89.103] ([193.202.89.103]:33780 "EHLO virgo.iok.hu"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbYKWSD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 13:03:58 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0A1305809F;
	Sun, 23 Nov 2008 19:03:56 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7CC8A4465E;
	Sun, 23 Nov 2008 19:03:53 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5E46B119019E; Sun, 23 Nov 2008 19:03:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811231255380.30769@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101571>


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2008 at 12:55:54PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
>=20
> The list extra_refs contains tags and the objects referenced by them,
> so that they can be handled at the end.  When a tag references a
> commit, that commit is added to the list using the same name.
>=20
> Also, the function handle_tags_and_duplicates() relies on the order
> the items were added to extra_refs, so clearly we do not want to
> use a sorted list here.

Tested-by: Miklos Vajna <vmiklos@frugalware.org>

Thanks!

--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkpmwkACgkQe81tAgORUJY60gCeJtE02C5b6m9SeTfen337HI9r
1wcAn1WTTYmCaB/tHXu5GIKyquIIYJq1
=oLBw
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--
