From: Pierre Habouzit <madcoder@debian.org>
Subject: [bug] git-clean
Date: Wed, 05 Mar 2008 10:40:58 +0100
Message-ID: <20080305094058.GF4793@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Zi0sgQQBxRFxMTsj";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 10:41:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWq85-0005di-Qy
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 10:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758903AbYCEJlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 04:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758546AbYCEJlB
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 04:41:01 -0500
Received: from pan.madism.org ([88.191.52.104]:57974 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758539AbYCEJlA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 04:41:00 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 7A75831D49
	for <git@vger.kernel.org>; Wed,  5 Mar 2008 10:40:59 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id CA3906ECE; Wed,  5 Mar 2008 10:40:58 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76205>


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Sorry I just don't have the time to track it right now, I just experienced
that on the current next, but it seems to be the same in master.

$ git st
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	../a.diff
nothing added to commit but untracked files present (use "git add" to track)
$ git clean ..
Removing ff

I assume something is wrong in in the display only, because a.diff was actu=
ally
removed.  It's probably a ridiculously easy bug to find.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHzmqqvGr7W6HudhwRAnI8AJwNpVRBMEu7S18feL2TJIB9SnePCgCfdl2P
AAkKHXtPCDASFkCdAPSjOv0=
=ammv
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--
