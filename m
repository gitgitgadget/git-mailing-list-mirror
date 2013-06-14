From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v6 30/31] git-remote-mediawiki: add a perlcritic rule in Makefile
Date: Fri, 14 Jun 2013 15:50:38 +0200
Message-ID: <1371217839-23017-31-git-send-email-celestin.matte@ensimag.fr>
References: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 15:51:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUPJ-0001Cw-2n
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab3FNNvH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:51:07 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33309 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941Ab3FNNvG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:51:06 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5EDp3Cn011336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Jun 2013 15:51:03 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5EDp46s013465;
	Fri, 14 Jun 2013 15:51:04 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5EDoqgM016142;
	Fri, 14 Jun 2013 15:51:04 +0200
X-Mailer: git-send-email 1.8.3.1.491.g8a51f1c
In-Reply-To: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 14 Jun 2013 15:51:03 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227839>

=46rom: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>

Option "-2" launches perlcritic with level 2. Levels go from 5 (most pe=
rtinent)
to 1. Rules of level 1 are mostly a question of style, and are therefor=
e
ignored.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index f149719..1fb2424 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -15,3 +15,5 @@ all: build
 build install clean:
 	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=3D$(SCRIPT_PERL_FULL) \
                 $@-perl-script
+perlcritic:
+	perlcritic -2 *.perl
--=20
1.8.3.rc3.49.g4e74807
