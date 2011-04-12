From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] t2021: mark a test as fixed
Date: Tue, 12 Apr 2011 08:41:19 +0200
Message-ID: <4DA3F40F.10702@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 08:41:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9XIB-0007Au-4z
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 08:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756644Ab1DLGlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 02:41:23 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45497 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755359Ab1DLGlW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 02:41:22 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q9XHs-0000A5-B0; Tue, 12 Apr 2011 08:41:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 19C7D1660F;
	Tue, 12 Apr 2011 08:41:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171373>

From: Johannes Sixt <j6t@kdbg.org>

The failure was fixed by 1d718a51 (do not overwrite untracked symlinks).

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 You might want to place this onto topic js/checkout-untracked-symlink and
 rewrite the commit message to:

 The failure was fixed in the previous commit.

 -- Hannes

 t/t2021-checkout-overwrite.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite.sh
index 27db2ad..5da63e9 100755
--- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -39,7 +39,7 @@ test_expect_success SYMLINKS 'create a commit where dir a/b changed to symlink'
 	git commit -m "dir to symlink"
 '
 
-test_expect_failure SYMLINKS 'checkout commit with dir must not remove untracked a/b' '
+test_expect_success SYMLINKS 'checkout commit with dir must not remove untracked a/b' '
 
 	git rm --cached a/b &&
 	git commit -m "un-track the symlink" &&
-- 
1.7.4.1.317.g0b25
