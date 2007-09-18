From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Fix lapsus in builtin-apply.c
Date: Tue, 18 Sep 2007 12:12:58 +0200
Message-ID: <20070918101258.GA304@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="jI8keyz6grp/JLjh";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 12:13:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXa50-0000e6-8J
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 12:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbXIRKNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 06:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbXIRKNE
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 06:13:04 -0400
Received: from pan.madism.org ([88.191.52.104]:44832 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240AbXIRKND (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 06:13:03 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9FE5A20767;
	Tue, 18 Sep 2007 12:12:59 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A36C81A3A5; Tue, 18 Sep 2007 12:12:58 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58567>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  I found this issue trying to refactor the "quote" module. It's
definitely worth to push this in maint.

 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 05ce220..86d89a4 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -254,7 +254,7 @@ static char *find_name(const char *line, char *def, int=
 p_value, int terminate)
 		if (name) {
 			char *cp =3D name;
 			while (p_value) {
-				cp =3D strchr(name, '/');
+				cp =3D strchr(cp, '/');
 				if (!cp)
 					break;
 				cp++;
--=20
1.5.3.1


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG76SqvGr7W6HudhwRAsygAJ96WDOGDFuq/xfzof+RC6KukOA0qgCgno8P
bIfOPVScAbnIA99W08TwVGY=
=2AW1
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
