From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v4 30/31] git-remote-mediawiki: add a perlcritic rule in Makefile
Date: Wed, 12 Jun 2013 00:18:21 +0200
Message-ID: <1370989102-24942-31-git-send-email-celestin.matte@ensimag.fr>
References: <1370989102-24942-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 00:18:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWu1-00073u-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 00:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920Ab3FKWSy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 18:18:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46272 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756851Ab3FKWSu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 18:18:50 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5BMIkuO026121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 00:18:46 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5BMImMO024126;
	Wed, 12 Jun 2013 00:18:48 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5BMIb2o018360;
	Wed, 12 Jun 2013 00:18:48 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370989102-24942-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 00:18:46 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227535>

Option "-2" launches perlcritic with level 2. Levels go from 5 (most pe=
rtinent)
to 1. Rules of level 1 are mostly a question of style, and are therefor=
e
ignored.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/Makefile |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index 8976aa3..e08b19f 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -18,4 +18,7 @@ build install clean:
 	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=3D$(SCRIPT_PERL_FULL) \
                 $@-perl-script
 	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=3D$(SCRIPT_PERL_PREVIEW_FULL) =
\
-                $@-perl-script
\ No newline at end of file
+                $@-perl-script
+
+perlcritic:
+	perlcritic -2 *.perl
\ No newline at end of file
--=20
1.7.9.5
