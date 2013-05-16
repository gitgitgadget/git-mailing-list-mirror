From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH] Documentation/merge-options.txt: restore `-e` option
Date: Thu, 16 May 2013 18:26:00 -0400
Message-ID: <1368743160-11866-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 17 01:12:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud7LG-00023v-UK
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 01:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab3EPXMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 19:12:06 -0400
Received: from smtp.bbn.com ([128.33.0.80]:17193 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001Ab3EPXMF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 19:12:05 -0400
X-Greylist: delayed 2720 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2013 19:12:05 EDT
Received: from socket.bbn.com ([192.1.120.102]:39890)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Ud6dG-0003gA-VH; Thu, 16 May 2013 18:26:43 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id A8CCE401AB
X-Mailer: git-send-email 1.8.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224630>

It looks like commit f8246281af9adb0fdddbcc90d2e19cb5cd5217e5
unintentionally removed the documentation for the `-e` option.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/merge-options.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 34a8445..f192cd2 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -8,12 +8,13 @@ failed and do not autocommit, to give the user a chance to
 inspect and further tweak the merge result before committing.
 
 --edit::
+-e::
 --no-edit::
 	Invoke an editor before committing successful mechanical merge to
 	further edit the auto-generated merge message, so that the user
 	can explain and justify the merge. The `--no-edit` option can be
 	used to accept the auto-generated message (this is generally
-	discouraged). The `--edit` option is still useful if you are
+	discouraged). The `--edit` (or `-e`) option is still useful if you are
 	giving a draft message with the `-m` option from the command line
 	and want to edit it in the editor.
 +
-- 
1.8.2.3
