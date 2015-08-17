From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v9 1/6] notes: document cat_sort_uniq rewriteMode
Date: Mon, 17 Aug 2015 14:33:29 -0700
Message-ID: <1439847214-2980-2-git-send-email-jacob.e.keller@intel.com>
References: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 23:33:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRS2K-0003SX-55
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 23:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbbHQVdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 17:33:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:43514 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910AbbHQVdh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 17:33:37 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 17 Aug 2015 14:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,697,1432623600"; 
   d="scan'208";a="785910986"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 14:33:36 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
In-Reply-To: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276093>

From: Jacob Keller <jacob.keller@gmail.com>

Teach documentation about the cat_sort_uniq rewriteMode that got added
at the same time as the equivalent merge strategy.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/config.txt    | 4 ++--
 Documentation/git-notes.txt | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

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
index 851518d531b5..00c84be33ca9 100644
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
@@ -368,7 +369,7 @@ does not match any refs is silently ignored.
 'GIT_NOTES_REWRITE_MODE'::
 	When copying notes during a rewrite, what to do if the target
 	commit already has a note.
-	Must be one of `overwrite`, `concatenate`, and `ignore`.
+	Must be one of `overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
 	This overrides the `core.rewriteMode` setting.
 
 'GIT_NOTES_REWRITE_REF'::
-- 
2.5.0.280.g4aaba03
