From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC/PATCH 1/2] Doc rebase: Describe rebase as excluding merge commits
Date: Sun, 19 May 2013 12:52:08 +0100
Message-ID: <1368964329-1600-2-git-send-email-philipoakley@iee.org>
References: <1368964329-1600-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 19 13:52:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue29k-0005Zj-Vw
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab3ESLwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:52:00 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:30994 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754429Ab3ESLv6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:51:58 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah8MAMa7mFFZ8YNG/2dsb2JhbABbgwgwglK+ZAQBfRd0giABBVYzCEk5HgYKCYgRCLtujgSBJINUA5hhkBeDEDs
X-IronPort-AV: E=Sophos;i="4.87,703,1363132800"; 
   d="scan'208";a="424434978"
Received: from host-89-241-131-70.as13285.net (HELO localhost) ([89.241.131.70])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 19 May 2013 12:51:57 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1368964329-1600-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224865>

Describe rebase in the description section.

Include a softer paraphrased version from the crytic, well-loved,
but sometimes parodied, Name description, and tell users that merge
commits are excluded by default.

Signed-off-by: Philip Oakley <philipoakley@iee.org>

---

http://article.gmane.org/gmane.comp.version-control.git/217410
http://article.gmane.org/gmane.comp.version-control.git/217495
---
 Documentation/git-rebase.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index aca8405..87a8095 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -16,6 +16,10 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+'git rebase' will transfer local commits, excluding merge commits
+by default, to the head of the branch's upstream, or onto a new base
+if given.
+
 If <branch> is specified, 'git rebase' will perform an automatic
 `git checkout <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
-- 
1.8.1.msysgit.1
