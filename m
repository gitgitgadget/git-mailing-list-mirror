From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 1/2] notes: document cat_sort_uniq rewriteMode
Date: Fri, 31 Jul 2015 12:21:35 -0700
Message-ID: <1438370496-26433-2-git-send-email-jacob.e.keller@intel.com>
References: <1438370496-26433-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 21:21:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLFsI-0001u6-4A
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 21:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbbGaTVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 15:21:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:32814 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbbGaTVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 15:21:39 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP; 31 Jul 2015 12:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,586,1432623600"; 
   d="scan'208";a="533864122"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2015 12:21:38 -0700
X-Mailer: git-send-email 2.5.0.482.gfcd5645
In-Reply-To: <1438370496-26433-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275069>

From: Jacob Keller <jacob.keller@gmail.com>

Teach documentation about the cat_sort_uniq rewriteMode that got added
at the same time as the equivalent merge strategy.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/config.txt    | 4 ++--
 Documentation/git-notes.txt | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6562c6ab09b9..3c1e4df09beb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1965,8 +1965,8 @@ notes.rewriteMode::
 	When copying notes during a rewrite (see the
 	"notes.rewrite.<command>" option), determines what to do if
 	the target commit already has a note.  Must be one of
-	`overwrite`, `concatenate`, or `ignore`.  Defaults to
-	`concatenate`.
+	`overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
+	Defaults to `concatenate`.
 +
 This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
 environment variable.
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 851518d531b5..674682b34b83 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -331,7 +331,8 @@ environment variable.
 notes.rewriteMode::
 	When copying notes during a rewrite, what to do if the target
 	commit already has a note.  Must be one of `overwrite`,
-	`concatenate`, and `ignore`.  Defaults to `concatenate`.
+	`concatenate`, `cat_sort_uniq`, or `ignore`.  Defaults to
+	`concatenate`.
 +
 This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
 environment variable.
-- 
2.5.0.482.gfcd5645
