From: Johan Herland <johan@herland.net>
Subject: [PATCH] sample pre-commit hook: Use --bool when retrieving config var
Date: Fri, 20 Sep 2013 15:53:50 +0200
Message-ID: <1379685230-30239-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 20 16:03:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN1JM-0005Vi-1M
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 16:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab3ITODw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 10:03:52 -0400
Received: from ams-iport-4.cisco.com ([144.254.224.147]:11477 "EHLO
	ams-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab3ITODv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 10:03:51 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Sep 2013 10:03:51 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuwFANVSPFKQ/khM/2dsb2JhbABagweuOpQJgRoWdIMlgVGIBbp+jhqBSx2ECAOpcoMmOoEs
X-IronPort-AV: E=Sophos;i="4.90,944,1371081600"; 
   d="scan'208";a="18157985"
Received: from ams-core-3.cisco.com ([144.254.72.76])
  by ams-iport-4.cisco.com with ESMTP; 20 Sep 2013 13:53:59 +0000
Received: from jherland.rd.tandberg.com ([10.47.13.105])
	by ams-core-3.cisco.com (8.14.5/8.14.5) with ESMTP id r8KDrvd9000976;
	Fri, 20 Sep 2013 13:53:57 GMT
X-Mailer: git-send-email 1.8.1.rc2.269.g5aaac94
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235069>

Signed-off-by: Johan Herland <johan@herland.net>
---
 templates/hooks--pre-commit.sample | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 586e3bf..68d62d5 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -16,7 +16,7 @@ else
 fi
 
 # If you want to allow non-ASCII filenames set this variable to true.
-allownonascii=$(git config hooks.allownonascii)
+allownonascii=$(git config --bool hooks.allownonascii)
 
 # Redirect output to stderr.
 exec 1>&2
-- 
1.8.1.rc2.269.g5aaac94
