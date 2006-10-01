From: Sebastian Harl <sh@tokkee.org>
Subject: [BUG] "git cat-file tree <sha1>" prints garbage
Date: Sun, 1 Oct 2006 22:26:02 +0200
Message-ID: <20061001202602.GD32373@albany.tokkee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vr1sEM+RgL05fCrX"
X-From: git-owner@vger.kernel.org Sun Oct 01 22:26:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU7t3-0004OG-Fq
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 22:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWJAU0G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 16:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWJAU0G
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 16:26:06 -0400
Received: from mail.tokkee.org ([212.114.247.92]:3727 "EHLO albany.tokkee.org")
	by vger.kernel.org with ESMTP id S932315AbWJAU0D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 16:26:03 -0400
Received: by albany.tokkee.org (Postfix, from userid 1000)
	id DC9F7364001; Sun,  1 Oct 2006 22:26:02 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28201>


--vr1sEM+RgL05fCrX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

When using "git cat-file tree <sha1>" to print a tree's content, it produces
garbage output like the following:

  $ git cat-file -t c0cd1e4e1888be6a70d44476996ece8be1ab52a2
  tree
  $ git cat-file tree c0cd1e4e1888be6a70d44476996ece8be1ab52a2
  100644 .gitignore%=EBF7=A6=F9q=A4=A2=90=AB=82:=93y=97=C7=BD100644
  COPYINGo=F8|Fd=98C=97bW=91=C8=EA;=BB_"y=A340000 Documentation=8A>=DD=A2=
=DE=C0=9F=E7=9C $=EB#=BA=E2=90=FC100755
  GIT-VERSION-GEN
  [...]

Using "git cat-file -p <sha1>" works fine.
(The above example uses one of the latest commits of the git.git repository)

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl
GnuPG-ID: 0x8501C7FC
http://tokkee.org/


--vr1sEM+RgL05fCrX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFICRaEFEKc4UBx/wRAkPoAKCHcHvLE7vWQ8zuRI2+nu/LnS2WnwCgkKfK
fcjz76rt9b9eaj6w2UTDu6s=
=Ae7Y
-----END PGP SIGNATURE-----

--vr1sEM+RgL05fCrX--
