From: Pierre Habouzit <madcoder@debian.org>
Subject: git-stash segfaults ...
Date: Mon, 20 Aug 2007 19:44:27 +0200
Message-ID: <20070820174427.GC7206@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ncSAzJYg3Aa9+CRW";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 19:44:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INBIm-0002dw-PH
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 19:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbXHTRo3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 13:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbXHTRo3
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 13:44:29 -0400
Received: from pan.madism.org ([88.191.52.104]:37162 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbXHTRo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 13:44:29 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 229C712812
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 19:44:28 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id BF60AA9CF; Mon, 20 Aug 2007 19:44:27 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56229>


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  When you don't use it from the root of the tree: I was in a subdir of
my git tree, trying to do:

  git stash apply

  and I had:

  $ git stash apply
  error: missing object referenced by
  '0ca54c1fba7fea7dca8a1cc59bce2b2849f26d20' Segmentation fault

  going in the root of the repository (where .git is), all went fine.

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGydL7vGr7W6HudhwRArbUAKCGbmLpcI+vtNuSVZwueVizuhqRQwCdE1ny
IUmnaEMGKU+h3JikFdxrPeM=
=zpUE
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
