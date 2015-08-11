From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 1/4] notes: document cat_sort_uniq rewriteMode
Date: Tue, 11 Aug 2015 13:57:18 -0700
Message-ID: <1439326641-9447-2-git-send-email-jacob.e.keller@intel.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 22:57:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPGc1-0003pT-Nh
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 22:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805AbbHKU53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 16:57:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:9837 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932447AbbHKU52 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 16:57:28 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP; 11 Aug 2015 13:57:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,655,1432623600"; 
   d="scan'208";a="782214955"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by orsmga002.jf.intel.com with ESMTP; 11 Aug 2015 13:57:29 -0700
X-Mailer: git-send-email 2.5.0.482.gfcd5645
In-Reply-To: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275724>

From: Jacob Keller <jacob.keller@gmail.com>

Teach documentation about the cat_sort_uniq rewriteMode that got added
at the same time as the equivalent merge strategy.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/config.txt    | 4 ++--
 Documentation/git-notes.txt | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index da74ad0d0aca..b3df1b16491c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1933,8 +1933,8 @@ notes.rewriteMode::
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
