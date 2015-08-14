From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v7 1/4] notes: document cat_sort_uniq rewriteMode
Date: Fri, 14 Aug 2015 14:13:52 -0700
Message-ID: <1439586835-15712-2-git-send-email-jacob.e.keller@intel.com>
References: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 23:14:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQMIw-0005z1-Cl
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 23:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbbHNVOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 17:14:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:14107 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbbHNVOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 17:14:16 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 14 Aug 2015 14:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,680,1432623600"; 
   d="scan'208";a="784359581"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by orsmga002.jf.intel.com with ESMTP; 14 Aug 2015 14:13:57 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
In-Reply-To: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275956>

From: Jacob Keller <jacob.keller@gmail.com>

Teach documentation about the cat_sort_uniq rewriteMode that got added
at the same time as the equivalent merge strategy.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/config.txt    | 4 ++--
 Documentation/git-notes.txt | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 75ec02e8e90a..de67ad1fdedf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1947,8 +1947,8 @@ notes.rewriteMode::
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
2.5.0.280.g4aaba03
