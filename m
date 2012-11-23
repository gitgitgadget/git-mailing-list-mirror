From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 5/6] git p4: fix labelDetails typo in exception
Date: Fri, 23 Nov 2012 17:35:38 -0500
Message-ID: <1353710139-16207-6-git-send-email-pw@padd.com>
References: <1353710139-16207-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 23:37:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc1sQ-00065a-Eo
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 23:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092Ab2KWWhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 17:37:23 -0500
Received: from honk.padd.com ([74.3.171.149]:35234 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932086Ab2KWWhW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 17:37:22 -0500
Received: from arf.padd.com (unknown [50.55.150.96])
	by honk.padd.com (Postfix) with ESMTPSA id 54561E9A;
	Fri, 23 Nov 2012 14:37:22 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0C39A27578; Fri, 23 Nov 2012 17:37:20 -0500 (EST)
X-Mailer: git-send-email 1.8.0.360.gc68af86
In-Reply-To: <1353710139-16207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210279>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index cb1ec8d..9712082 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2406,7 +2406,7 @@ class P4Sync(Command, P4UserMap):
                     try:
                         tmwhen = time.strptime(labelDetails['Update'], "%Y/%m/%d %H:%M:%S")
                     except ValueError:
-                        print "Could not convert label time %s" % labelDetail['Update']
+                        print "Could not convert label time %s" % labelDetails['Update']
                         tmwhen = 1
 
                     when = int(time.mktime(tmwhen))
-- 
1.8.0.276.gd9397fc
