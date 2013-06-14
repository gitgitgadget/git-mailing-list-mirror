From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v6 27/31] git-remote-mediawiki: Fix a typo ("mediwiki" instead of "mediawiki")
Date: Fri, 14 Jun 2013 15:50:35 +0200
Message-ID: <1371217839-23017-28-git-send-email-celestin.matte@ensimag.fr>
References: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 15:51:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUPb-0001Of-IZ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078Ab3FNNvV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:51:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44588 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012Ab3FNNvF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:51:05 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5EDp2ag020747
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Jun 2013 15:51:02 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5EDp3xn013448;
	Fri, 14 Jun 2013 15:51:03 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5EDoqgJ016142;
	Fri, 14 Jun 2013 15:51:03 +0200
X-Mailer: git-send-email 1.8.3.1.491.g8a51f1c
In-Reply-To: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 14 Jun 2013 15:51:02 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227845>

=46rom: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 1cedbee..3935b0d 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -1090,14 +1090,14 @@ sub mw_push_file {
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
1.8.3.rc3.49.g4e74807
