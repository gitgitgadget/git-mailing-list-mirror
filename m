From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH 07/18] Rename a variable ($last) so that it does not have the name of a keyword
Date: Thu,  6 Jun 2013 21:34:12 +0200
Message-ID: <1370547263-13558-8-git-send-email-celestin.matte@ensimag.fr>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 21:37:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkfzZ-0002m4-NH
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab3FFTgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 15:36:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44280 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313Ab3FFTfH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 15:35:07 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r56JYqqv005271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Jun 2013 21:34:52 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r56JYsaY021410;
	Thu, 6 Jun 2013 21:34:54 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r56JYTou023108;
	Thu, 6 Jun 2013 21:34:54 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 06 Jun 2013 21:34:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r56JYqqv005271
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371152095.23881@ni2pPtQ5BRyFcfSy5cjNAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226551>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index cf8dfc8..7fbc998 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -215,11 +215,11 @@ sub get_mw_page_list {
 	my $pages =3D shift;
 	my @some_pages =3D @$page_list;
 	while (@some_pages) {
-		my $last =3D 50;
-		if ($#some_pages < $last) {
-			$last =3D $#some_pages;
+		my $last_page =3D 50;
+		if ($#some_pages < $last_page) {
+			$last_page =3D $#some_pages;
 		}
-		my @slice =3D @some_pages[0..$last];
+		my @slice =3D @some_pages[0..$last_page];
 		get_mw_first_pages(\@slice, $pages);
 		@some_pages =3D @some_pages[51..$#some_pages];
 	}
--=20
1.7.9.5
