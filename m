From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 102/104] t7502-commit: fix spelling
Date: Wed, 26 May 2010 18:01:12 +1200
Message-ID: <1274853674-18521-102-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9mM-0005GU-5u
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934097Ab0EZGHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:07:33 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49306 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933727Ab0EZGGa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:30 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2010 02:06:22 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id DDD97338E8;
	Wed, 26 May 2010 18:02:11 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lmE+YTUIQJ0W; Wed, 26 May 2010 18:02:07 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 2BBEE338EE;
	Wed, 26 May 2010 18:01:41 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147771>

From: Tay Ray Chuan <rctay89@gmail.com>

s/subdirecotry/subdirectory/

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7502-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 844fb43..9504466 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -35,7 +35,7 @@ test_expect_success 'partial' '
 
 '
 
-test_expect_success 'partial modification in a subdirecotry' '
+test_expect_success 'partial modification in a subdirectory' '
 
 	test_tick &&
 	git commit -m "partial commit to subdirectory" not &&
-- 
1.7.1.rc2.333.gb2668
