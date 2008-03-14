From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 5/5] git-status: Mention status.submodulesummary config in the documentation
Date: Fri, 14 Mar 2008 23:28:41 +0800
Message-ID: <1205508521-7407-6-git-send-email-pkufranky@gmail.com>
References: <1205508521-7407-1-git-send-email-pkufranky@gmail.com>
 <1205508521-7407-2-git-send-email-pkufranky@gmail.com>
 <1205508521-7407-3-git-send-email-pkufranky@gmail.com>
 <1205508521-7407-4-git-send-email-pkufranky@gmail.com>
 <1205508521-7407-5-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 14 16:30:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaBrH-0003kn-MY
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 16:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbYCNP2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 11:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753845AbYCNP2y
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 11:28:54 -0400
Received: from mail.qikoo.org ([60.28.205.235]:50531 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753546AbYCNP2s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 11:28:48 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 9EC68470B2; Fri, 14 Mar 2008 23:28:41 +0800 (CST)
X-Mailer: git-send-email 1.5.4.4.653.g7cf1e
In-Reply-To: <1205508521-7407-5-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77243>

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 Documentation/git-status.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 3ea269a..32b6660 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -52,6 +52,10 @@ If the config variable `status.relativePaths` is set to false, then all
 paths shown are relative to the repository root, not to the current
 directory.
 
+If 'status.submodulesummary' is set to a non zero number, the submodule
+summary will be enabled and a summary of commits for modified submodules
+will be shown (see --summary-limit option of linkgit:git-submodule[1]).
+
 See Also
 --------
 linkgit:gitignore[5]
-- 
1.5.4.4.653.g7cf1e
