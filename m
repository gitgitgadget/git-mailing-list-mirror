From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/5] git-p4: fix verbose comment typo
Date: Wed, 11 Jan 2012 18:31:07 -0500
Message-ID: <1326324670-15967-3-git-send-email-pw@padd.com>
References: <1326324670-15967-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 00:32:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl7eC-0006CX-TP
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 00:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab2AKXb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 18:31:56 -0500
Received: from honk.padd.com ([74.3.171.149]:34116 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2AKXb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 18:31:56 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id BCB4120D2;
	Wed, 11 Jan 2012 15:31:55 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3075F31442; Wed, 11 Jan 2012 18:31:51 -0500 (EST)
X-Mailer: git-send-email 1.7.9.rc0.47.gc9457
In-Reply-To: <1326324670-15967-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188400>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 20208bf..e267f31 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1263,7 +1263,7 @@ class View(object):
             if self.exclude:
                 c = "-"
             return "View.Mapping: %s%s -> %s" % \
-                   (c, self.depot_side, self.client_side)
+                   (c, self.depot_side.path, self.client_side.path)
 
         def map_depot_to_client(self, depot_path):
             """Calculate the client path if using this mapping on the
-- 
1.7.8.1.409.g3e338.dirty
