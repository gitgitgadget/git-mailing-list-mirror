From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v2 21/22] git-remote-mediawiki: Fix a typo ("mediwiki" instead of "mediawiki")
Date: Fri,  7 Jun 2013 23:42:22 +0200
Message-ID: <1370641344-4253-22-git-send-email-celestin.matte@ensimag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 23:43:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4Ra-0008G4-Jv
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756796Ab3FGVnZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 17:43:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55317 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756762Ab3FGVnW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 17:43:22 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r57LhD19003322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 23:43:13 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57LhGRT029641;
	Fri, 7 Jun 2013 23:43:16 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57LgqRw019409;
	Fri, 7 Jun 2013 23:43:16 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 23:43:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57LhD19003322
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371246198.03466@5ltE3aaOAg16uh+h6YqHbg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226724>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 94a0411..be860c8 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -1093,14 +1093,14 @@ sub mw_push_file {
 				# edit conflicts, considered as non-fast-forward
 				print {*STDERR} 'Warning: Error ' .
 				    $mediawiki->{error}->{code} .
-				    ' from mediwiki: ' . $mediawiki->{error}->{details} .
+				    ' from mediawiki: ' . $mediawiki->{error}->{details} .
 				    ".\n";
 				return ($oldrevid, 'non-fast-forward');
 			} else {
 				# Other errors. Shouldn't happen =3D> just die()
 				die 'Fatal: Error ' .
 				    $mediawiki->{error}->{code} .
-				    ' from mediwiki: ' . $mediawiki->{error}->{details} . "\n";
+				    ' from mediawiki: ' . $mediawiki->{error}->{details} . "\n";
 			}
 		}
 		$newrevid =3D $result->{edit}->{newrevid};
--=20
1.7.9.5
