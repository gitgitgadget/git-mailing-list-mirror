From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 2/3] Prepare testsuite for a "git clone" that packs refs
Date: Sat, 22 Mar 2008 02:13:06 +0100
Message-ID: <200803220213.06359.johan@herland.net>
References: <200803220210.30957.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 02:14:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcsJD-0005Xk-48
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 02:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbYCVBN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 21:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbYCVBN0
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 21:13:26 -0400
Received: from smtp.getmail.no ([84.208.20.33]:36106 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754107AbYCVBNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 21:13:25 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JY300701Y2CU700@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 22 Mar 2008 02:13:24 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY3000TJY1U8Q30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 22 Mar 2008 02:13:06 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY3001JCY1UJ930@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 22 Mar 2008 02:13:06 +0100 (CET)
In-reply-to: <200803220210.30957.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77782>

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t5515-fetch-merge-logic.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 31c1081..4569a13 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -143,6 +143,7 @@ do
 			rm -f .git/refs/heads/*
 			rm -f .git/refs/remotes/rem/*
 			rm -f .git/refs/tags/*
+			rm -f .git/packed-refs
 			git fetch "$@" >/dev/null
 			cat .git/FETCH_HEAD
 		} >"$actual" &&
-- 
1.5.5.rc0.117.ga5237
