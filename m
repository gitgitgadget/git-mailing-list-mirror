From: Johan Herland <johan@herland.net>
Subject: [PATCH] sample pre-commit hook: Use --bool when retrieving config var
Date: Tue, 24 Sep 2013 09:52:56 +0200
Message-ID: <1380009176-10490-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, johan@herland.net
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 24 09:53:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VONQl-0007M1-Cp
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 09:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798Ab3IXHxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 03:53:07 -0400
Received: from ams-iport-3.cisco.com ([144.254.224.146]:57585 "EHLO
	ams-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab3IXHxG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 03:53:06 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AicFAIpDQVKQ/khR/2dsb2JhbABagwetUpQHgSAWdIMlgVGIBb0IjgaBSx2ECAOpc4MmOoEs
X-IronPort-AV: E=Sophos;i="4.90,872,1371081600"; 
   d="scan'208";a="17761701"
Received: from ams-core-1.cisco.com ([144.254.72.81])
  by ams-iport-3.cisco.com with ESMTP; 24 Sep 2013 07:53:04 +0000
Received: from jherland.rd.tandberg.com ([10.47.13.105])
	by ams-core-1.cisco.com (8.14.5/8.14.5) with ESMTP id r8O7r2nU018835;
	Tue, 24 Sep 2013 07:53:02 GMT
X-Mailer: git-send-email 1.8.1.rc2.269.g5aaac94
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235283>

Signed-off-by: Johan Herland <johan@herland.net>
---

Resend/reminder...

...Johan

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
