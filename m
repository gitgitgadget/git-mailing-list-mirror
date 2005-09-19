From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 0/2] Improve man pages formatting
Date: Mon, 19 Sep 2005 14:09:14 +0400
Message-ID: <20050919100914.GA28095@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 12:11:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHIah-0003YD-S8
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 12:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVISKJ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 06:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVISKJ1
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 06:09:27 -0400
Received: from mivlgu.ru ([81.18.140.87]:8663 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S932382AbVISKJ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 06:09:27 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id E2122180110; Mon, 19 Sep 2005 14:09:14 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8850>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Currently GIT man pages - especially git(7) - do not look good,
because the references to other man pages are represented as HTML file
names (like "git-cat-file: git-cat-file.html").  The standard
convention for such references in man pages is PAGE(SECTION), and some
man viewers (e.g., pinfo (pman), or KDE help) even treat such text in
man pages as hyperlinks.

This problem was fixed in cogito by adding the "gitlink:" asciidoc
macro which generates proper formatting for either HTML or man page
output.  I have adapted that patch for GIT.

--=20
Sergey Vlasov

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDLo5KW82GfkQfsqIRAoMtAJ9Sz3c7hgGlnOEg190CobZTXZKPJACeIKfQ
GnBF375C/I6mymF9trvdfqU=
=Rqpm
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
