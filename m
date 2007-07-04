From: Pierre Habouzit <madcoder@debian.org>
Subject: [BUG (or misfeature?)] git checkout and symlinks
Date: Wed, 4 Jul 2007 22:35:41 +0200
Message-ID: <20070704203541.GA13286@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="lrZ03NoBR/3+SXJZ";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 22:35:50 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6BZi-00043h-UO
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 22:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759136AbXGDUfo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 16:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758860AbXGDUfo
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 16:35:44 -0400
Received: from pan.madism.org ([88.191.52.104]:46563 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758212AbXGDUfm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 16:35:42 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id F41154AE1
	for <git@vger.kernel.org>; Wed,  4 Jul 2007 22:35:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 4029D2D63; Wed,  4 Jul 2007 22:35:41 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51638>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  if in a branch [branch1] you track the file: dir1/file1.c
and in the branch [branch2] you track elsewhere/file1.c and dir1 be
symlink on elsewhere, then it's not possible to checkout the branch
[branch1] if your previous checkout was [branch2]. You have to manually
remove the symlink `dir1` else git complains that checkouting branch1
would overwrite dir1/file1.c.

  I'm not sure how to fix this, and it's quite painful actually :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjASdvGr7W6HudhwRAp8MAJ9SqEeHGuDimSZ3iLXSRCavxoxKrACfZrkg
NB9I5rCbbsTGBx1sxFcovPk=
=md2A
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
