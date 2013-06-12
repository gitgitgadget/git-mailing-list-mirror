From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v5 11/31] git-remote-mediawiki: Change style in a regexp
Date: Wed, 12 Jun 2013 17:43:28 +0200
Message-ID: <1371051828-12866-12-git-send-email-celestin.matte@ensimag.fr>
References: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 17:46:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmnFg-0008WJ-IH
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 17:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757181Ab3FLPp5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 11:45:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47533 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756824Ab3FLPoP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 11:44:15 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5CFiBtl015647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 17:44:11 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CFiDnJ015016;
	Wed, 12 Jun 2013 17:44:13 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5CFhu5u014096;
	Wed, 12 Jun 2013 17:44:13 +0200
X-Mailer: git-send-email 1.8.3.rc3.18.g21a7b2c
In-Reply-To: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 17:44:11 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227650>

In this regexp, ' |\n' is used, whereas its equivalent '[ \n]', which i=
s
clearer, is used elsewhere. Make the style coherent.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index b01d402..267c164 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -1192,7 +1192,7 @@ sub mw_push_revision {
 		my @history =3D split(/\n/, $history);
 		@history =3D @history[1..$#history];
 		foreach my $line (reverse @history) {
-			my @commit_info_split =3D split(/ |\n/, $line);
+			my @commit_info_split =3D split(/[ \n]/, $line);
 			push(@commit_pairs, \@commit_info_split);
 		}
 	}
--=20
1.8.3.rc3.18.g21a7b2c
