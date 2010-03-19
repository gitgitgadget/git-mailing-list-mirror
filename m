From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/3] t5505: add missing &&
Date: Fri, 19 Mar 2010 18:36:35 -0500
Message-ID: <CxNG4R6Vr07DvPgqJe5msbiN0-7URObSdLhedqTJLYFpvj_BbRYts-mzQj8AH3AhwPzM5USx71g@cipher.nrlssc.navy.mil>
References: <CxNG4R6Vr07DvPgqJe5msRW43WBM-kHscjWMfuzYM-XxJsVlLbOmNz_AdlMU4gEIvpsxQfdo7fc@cipher.nrlssc.navy.mil>
Cc: ilari.liusvaara@elisanet.fi, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 20 00:39:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nslmb-0005cs-0o
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 00:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab0CSXjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 19:39:07 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37917 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab0CSXjG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 19:39:06 -0400
Received: by mail.nrlssc.navy.mil id o2JNaqOI010282; Fri, 19 Mar 2010 18:36:52 -0500
In-Reply-To: <CxNG4R6Vr07DvPgqJe5msRW43WBM-kHscjWMfuzYM-XxJsVlLbOmNz_AdlMU4gEIvpsxQfdo7fc@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 19 Mar 2010 23:36:52.0434 (UTC) FILETIME=[0D98BB20:01CAC7BD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142661>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t5505-remote.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 7291230..e7afe9e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -121,7 +121,7 @@ Note: Non-remote branches were not removed; to delete them, use:
   git branch -d master
 EOF
 	} &&
-	git tag footag
+	git tag footag &&
 	git config --add remote.oops.fetch "+refs/*:refs/*" &&
 	git remote rm oops 2>actual1 &&
 	git branch foobranch &&
-- 
1.6.6.2
