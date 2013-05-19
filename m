From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC/PATCH 2/2] Doc rebase: describe the priority of published work
Date: Sun, 19 May 2013 12:52:09 +0100
Message-ID: <1368964329-1600-3-git-send-email-philipoakley@iee.org>
References: <1368964329-1600-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 19 13:52:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue29l-0005Zj-H7
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453Ab3ESLwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:52:00 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:56289 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754413Ab3ESLv6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:51:58 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah8MAMa7mFFZ8YNG/2dsb2JhbABbgwgwglK+ZAQBfRd0giABBVYzCEk5HgYTiBEIu26OBIEkg1QDmGGQF4MQOw
X-IronPort-AV: E=Sophos;i="4.87,703,1363132800"; 
   d="scan'208";a="429336254"
Received: from host-89-241-131-70.as13285.net (HELO localhost) ([89.241.131.70])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 19 May 2013 12:51:57 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1368964329-1600-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224867>

Give details of the implied priority in the description section.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
wording based on:
http://article.gmane.org/gmane.comp.version-control.git/222581
http://article.gmane.org/gmane.comp.version-control.git/223816
http://article.gmane.org/gmane.comp.version-control.git/217410
http://article.gmane.org/gmane.comp.version-control.git/222763
---
 Documentation/git-rebase.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 87a8095..24d16ef 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -20,6 +20,12 @@ DESCRIPTION
 by default, to the head of the branch's upstream, or onto a new base
 if given.
 
+In its minimal form, having built locally on the (current) branch,
+use `git rebase` to catch up with its published upstream state to
+create a new linear history. Importantly, `git rebase` is a way to
+replay your work on top of the work of others. It is not about
+integrating other people's changes into your work.
+
 If <branch> is specified, 'git rebase' will perform an automatic
 `git checkout <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
-- 
1.8.1.msysgit.1
