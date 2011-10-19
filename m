From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/t3000-ls-files-others.sh: use $SHELL_PATH to run git-new-workdir script
Date: Wed, 19 Oct 2011 09:26:02 -0700
Message-ID: <jKc1nei6yQLMU5upFxa60klqkQwEDsUHt5jcsbbnbL-TuvERAV3NOSvVH9yzlpgnPdDi0-5rPkBeDx7SQF7CEqlyj9UX6NqKccGu9kUyq1SFu2oCzI2xkRSoDmDBH66WbRZaTWHtj8ubURHpkyEvMA@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 19 18:26:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGYya-00089m-Jp
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 18:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab1JSQ0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 12:26:40 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:46519 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752240Ab1JSQ0k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 12:26:40 -0400
Received: by mail3.nrlssc.navy.mil id p9JGQOf4029178; Wed, 19 Oct 2011 11:26:24 -0500
X-OriginalArrivalTime: 19 Oct 2011 16:26:23.0414 (UTC) FILETIME=[D77A4D60:01CC8E7B]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183934>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t3000-ls-files-others.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index e9160df..88be904 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -77,7 +77,7 @@ test_expect_success SYMLINKS 'ls-files --others with symlinked submodule' '
 	) &&
 	(
 		cd super &&
-		"$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" ../sub sub
+		"$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" ../sub sub
 		git ls-files --others --exclude-standard >../actual
 	) &&
 	echo sub/ >expect &&
-- 
1.7.7
