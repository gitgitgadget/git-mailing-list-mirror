From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v4 12/31] git-remote-mediawiki: Change style in a regexp
Date: Wed, 12 Jun 2013 00:18:03 +0200
Message-ID: <1370989102-24942-13-git-send-email-celestin.matte@ensimag.fr>
References: <1370989102-24942-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 00:19:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWu0-00073u-R2
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 00:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834Ab3FKWSq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 18:18:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46233 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756769Ab3FKWSn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 18:18:43 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5BMIcWq026037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 00:18:38 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5BMIfB7024031;
	Wed, 12 Jun 2013 00:18:41 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5BMIb2W018360;
	Wed, 12 Jun 2013 00:18:41 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370989102-24942-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 00:18:38 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227538>

Change '[\n]' to '\n': brackets are useless here.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 267c164..86229a1 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -1271,7 +1271,7 @@ sub get_mw_namespace_id {
 		# Look at configuration file, if the record for that namespace is
 		# already cached. Namespaces are stored in form:
 		# "Name_of_namespace:Id_namespace", ex.: "File:6".
-		my @temp =3D split(/[\n]/, run_git("config --get-all remote."
+		my @temp =3D split(/\n/, run_git("config --get-all remote."
 						. $remotename .".namespaceCache"));
 		chomp(@temp);
 		foreach my $ns (@temp) {
--=20
1.7.9.5
