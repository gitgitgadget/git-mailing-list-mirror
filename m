From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH nd/init-gitdir] t0001: guard a new test with SYMLINKS prerequisite
Date: Tue, 12 Apr 2011 08:30:49 +0200
Message-ID: <4DA3F199.7020202@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 08:30:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9X7p-0001qR-Cr
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 08:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068Ab1DLGav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 02:30:51 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35422 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753122Ab1DLGav (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 02:30:51 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q9X7h-0008AN-Md; Tue, 12 Apr 2011 08:30:50 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5C1DC1660F;
	Tue, 12 Apr 2011 08:30:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171372>

From: Johannes Sixt <j6t@kdbg.org>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0001-init.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index a5816d0..54520f6 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -402,7 +402,7 @@ test_expect_success 're-init to move gitdir' '
 	test -d realgitdir/refs
 '
 
-test_expect_success 're-init to move gitdir symlink' '
+test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 	rm -rf newdir realgitdir &&
 	git init newdir &&
 	(
-- 
1.7.5.rc1.1127.g94456
