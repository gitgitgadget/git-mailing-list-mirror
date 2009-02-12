From: Joey Hess <joey@kitenet.net>
Subject: pushing from a shallow repo allowed?
Date: Thu, 12 Feb 2009 17:02:54 -0500
Message-ID: <20090212220254.GA1517@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 01:28:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYrLv-0004L8-Tn
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 01:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbZBPA1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 19:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbZBPA1K
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 19:27:10 -0500
Received: from wren.kitenet.net ([80.68.85.49]:48783 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174AbZBPA1J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 19:27:09 -0500
Received: from gnu.kitenet.net (unknown [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 81C1B314393
	for <git@vger.kernel.org>; Thu, 12 Feb 2009 17:02:57 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 6A089A8D30; Thu, 12 Feb 2009 17:02:54 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110100>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

git-clone(1):
	A shallow repository has a number of
        limitations (you cannot clone or fetch from it, nor push from nor
        into it)

This and other documentation (shallow.txt, RelNotes-1.5.0.txt) says you
can't push from a shallow repo. But in a simple test of making a commit
to a shallow repo and pushing it out, it seems to work. AFAICS, git only
guards against pushes *into* a shallow repo, and fetching/cloning from a
shallow repository.

Are the docs out of date, or is there really still some problem
with pushing from a shallow repo?


BTW, --depth seems to be ignored when making a local clone.
This seems to have been fixed in the old shell git-clone in
d4110a9726c7cd5cda35b7dd03dc8f85fe3dff0c, was it accidentially lost
in the C version?

joey@gnu:~/src/other> git clone --depth 2 git git.shallow
Initialized empty Git repository in /home/joey/src/other/git.shallow/.git/
joey@gnu:~/src/other> cd git.shallow=20
joey@gnu:~/src/other/git.shallow> git-log --pretty=3Doneline|wc -l
17009

git version 1.5.6.5

--=20
see shy jo

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJlJyLd8HHehbQuO8RAlTOAJ9+WoCooBR29UPsdIik11aG8tdKlACeMs2/
qqicuvSK7EigJRJmEvU/gvk=
=dHl8
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
