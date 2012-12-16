From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 1/3] SubmittingPatches: add convention of prefixing commit messages
Date: Sun, 16 Dec 2012 19:35:59 +0000
Message-ID: <1355686561-1057-2-git-send-email-git@adamspiers.org>
References: <1355686561-1057-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 20:36:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkK0s-0000fB-30
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 20:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab2LPTgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 14:36:05 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41238 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab2LPTgE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 14:36:04 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 852AD2E5E3
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 19:36:02 +0000 (GMT)
X-Mailer: git-send-email 1.7.12.1.396.g53b3ea9
In-Reply-To: <1355686561-1057-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211605>

Conscientious newcomers to git development will read SubmittingPatches
and CodingGuidelines, but could easily miss the convention of
prefixing commit messages with a single word identifying the file
or area the commit touches.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Documentation/SubmittingPatches | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 0dbf2c9..c107cb1 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -9,6 +9,14 @@ Checklist (and a short version for the impatient):
 	- the first line of the commit message should be a short
 	  description (50 characters is the soft limit, see DISCUSSION
 	  in git-commit(1)), and should skip the full stop
+	- it is also conventional in most cases to prefix the
+	  first line with "area: " where the area is a filename
+	  or identifier for the general area of the code being
+	  modified, e.g.
+	  . archive: ustar header checksum is computed unsigned
+	  . git-cherry-pick.txt: clarify the use of revision range notation
+	  (if in doubt which identifier to use, run "git log --no-merges"
+	  on the files you are modifying to see the current conventions)
 	- the body should provide a meaningful commit message, which:
 	  . explains the problem the change tries to solve, iow, what
 	    is wrong with the current code without the change.
-- 
1.7.12.1.396.g53b3ea9
