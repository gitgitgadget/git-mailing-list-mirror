From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 3/5] git-p4: clarify comment
Date: Wed, 11 Jan 2012 18:31:08 -0500
Message-ID: <1326324670-15967-4-git-send-email-pw@padd.com>
References: <1326324670-15967-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 00:32:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl7ea-0006Nn-0v
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 00:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab2AKXcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 18:32:19 -0500
Received: from honk.padd.com ([74.3.171.149]:34119 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2AKXcT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 18:32:19 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id 14D4820D2;
	Wed, 11 Jan 2012 15:32:15 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 5334A31442; Wed, 11 Jan 2012 18:32:11 -0500 (EST)
X-Mailer: git-send-email 1.7.9.rc0.47.gc9457
In-Reply-To: <1326324670-15967-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188401>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index e267f31..e11e15b 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1363,7 +1363,8 @@ class View(object):
             else:
                 # This mapping matched; no need to search any further.
                 # But, the mapping could be rejected if the client path
-                # has already been claimed by an earlier mapping.
+                # has already been claimed by an earlier mapping (i.e.
+                # one later in the list, which we are walking backwards).
                 already_mapped_in_client = False
                 for f in paths_filled:
                     # this is View.Path.match
-- 
1.7.8.1.409.g3e338.dirty
