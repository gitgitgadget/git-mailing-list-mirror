From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: [PATCH 4/5 v2] tests: update porcelain expected message
Date: Tue, 15 Jun 2010 14:22:55 +0200
Message-ID: <1276604576-28092-5-git-send-email-diane.gasselin@ensimag.imag.fr>
References: <1276604576-28092-1-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276604576-28092-2-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276604576-28092-3-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276604576-28092-4-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 14:23:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOVAs-0006TW-SF
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 14:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955Ab0FOMXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 08:23:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50263 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680Ab0FOMXO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 08:23:14 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o5FCF8F3018691
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 15 Jun 2010 14:15:08 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o5FCNBrD021139;
	Tue, 15 Jun 2010 14:23:11 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o5FCNBPT028326;
	Tue, 15 Jun 2010 14:23:11 +0200
Received: (from gasselid@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o5FCNBlu028325;
	Tue, 15 Jun 2010 14:23:11 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276604576-28092-4-git-send-email-diane.gasselin@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 15 Jun 2010 14:15:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FCF8F3018691
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: diane.gasselin@ensimag.imag.fr
MailScanner-NULL-Check: 1277208909.1633@qMFiCH3ZtNTeb/PksG08jg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149178>

As porcelain messages have been changed, the expected porcelain message=
s
tested in t3030 and t3400 need to be changed.

Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
---
 t/t3030-merge-recursive.sh |    4 ++--
 t/t3400-rebase.sh          |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 7ef8dd4..77bf0f0 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -269,7 +269,7 @@ test_expect_success 'merge-recursive result' '
=20
 '
=20
-test_expect_failure 'fail if the index has unresolved entries' '
+test_expect_success 'fail if the index has unresolved entries' '
=20
 	rm -fr [abcd] &&
 	git checkout -f "$c1" &&
@@ -282,7 +282,7 @@ test_expect_failure 'fail if the index has unresolv=
ed entries' '
 	grep "You have not concluded your merge" out &&
 	rm -f .git/MERGE_HEAD &&
 	test_must_fail git merge "$c5" 2> out &&
-	grep "Your local changes to .* would be overwritten by merge." out
+	grep "Your local changes to the following files would be overwritten =
by merge:" out
 '
=20
 test_expect_success 'merge-recursive remove conflict' '
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index cbf160d..55be0c2 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -121,10 +121,10 @@ test_expect_success 'rebase a single mode change'=
 '
      GIT_TRACE=3D1 git rebase master
 '
=20
-test_expect_failure 'Show verbose error when HEAD could not be detache=
d' '
+test_expect_success 'Show verbose error when HEAD could not be detache=
d' '
      : > B &&
      test_must_fail git rebase topic 2> output.err > output.out &&
-     grep "Untracked working tree file .B. would be overwritten" outpu=
t.err
+     grep "The following untracked working tree files would be overwri=
tten by checkout:" output.err
 '
=20
 test_expect_success 'rebase -q is quiet' '
--=20
1.6.6.7.ga5fe3
