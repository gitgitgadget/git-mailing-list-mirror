From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] stupid typo in git-checkout.sh
Date: Tue, 11 Dec 2007 17:09:25 +0100
Message-ID: <20071211160925.GF15448@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="EXKGNeO8l0xGFBjy";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 17:10:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J27gH-0002xW-VM
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 17:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbXLKQJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 11:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbXLKQJ1
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 11:09:27 -0500
Received: from pan.madism.org ([88.191.52.104]:54198 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752228AbXLKQJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 11:09:26 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 0D00B2E8FA;
	Tue, 11 Dec 2007 17:09:26 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 700DC49ED68; Tue, 11 Dec 2007 17:09:25 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67877>


--EXKGNeO8l0xGFBjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  thanks to Ingo Molnar that made me spot this one while answering to
  him eagerly that git-checkout had a fancy usage now ...

 git-checkout.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index f6d58ac..200f9bc 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -2,7 +2,7 @@
=20
 OPTIONS_KEEPDASHDASH=3Dt
 OPTIONS_SPEC=3D"\
-git-branch [options] [<branch>] [<paths>...]
+git-checkout [options] [<branch>] [<paths>...]
 --
 b=3D          create a new branch started at <branch>
 l           create the new branchs reflog
--=20
1.5.3.7.2248.g93a2


--EXKGNeO8l0xGFBjy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXrY1vGr7W6HudhwRAly2AKCmzVTlnX3eQWang36zKFe67ZfBfwCfToZQ
U5moHZXS0P3cjokfYM95bp8=
=n4Qp
-----END PGP SIGNATURE-----

--EXKGNeO8l0xGFBjy--
