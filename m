From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] doc: show usage of branch description
Date: Sat, 12 Sep 2015 23:51:28 +0100
Message-ID: <1442098288-3316-1-git-send-email-philipoakley@iee.org>
References: <74514591d4cd502eee06cde3e099e656@dscho.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 13 00:50:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZatdH-0004Ak-DT
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 00:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbbILWuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 18:50:39 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:2121 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751767AbbILWuj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2015 18:50:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2A5BADhq/RVPJiZLFBdGQEBgjZSgT2CXIN9tlQBDYdrBAICgR45FAEBAQEBAQEGAQEBAUABP4QkAQEEViMQCEk5ChQGE4gyygwBAQEHIoZziScRAVEHhCwFhzGOJY5HjGaIXYNsHwEBhEQ9M4k+gT8BAQE
X-IPAS-Result: A2A5BADhq/RVPJiZLFBdGQEBgjZSgT2CXIN9tlQBDYdrBAICgR45FAEBAQEBAQEGAQEBAUABP4QkAQEEViMQCEk5ChQGE4gyygwBAQEHIoZziScRAVEHhCwFhzGOJY5HjGaIXYNsHwEBhEQ9M4k+gT8BAQE
X-IronPort-AV: E=Sophos;i="5.17,519,1437433200"; 
   d="scan'208";a="42539896"
Received: from 80-44-153-152.dynamic.dsl.as9105.com (HELO localhost) ([80.44.153.152])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 12 Sep 2015 23:50:37 +0100
X-Mailer: git-send-email 1.9.5
In-Reply-To: <74514591d4cd502eee06cde3e099e656@dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277738>

The branch description will be included in 'git format-patch
--cover-letter' and in 'git pull-request' emails. Tell the reader.

While here, clarify that the description may be a multi-line
explanation of the purpose of the branch's patch series.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

This is a short doc patch to follow up $gmane/277628 where Johannes
Schindelin noted this otherwise undocumented feature.


 Documentation/git-branch.txt       | 3 ++-
 Documentation/git-format-patch.txt | 2 +-
 Documentation/git-request-pull.txt | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index a67138a..79ad1c7 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -197,7 +197,8 @@ start-point is either a local or remote-tracking branch.
 
 --edit-description::
 	Open an editor and edit the text to explain what the branch is
-	for, to be used by various other commands (e.g. `request-pull`).
+	for, to be used by various other commands (e.g. `format-patch`
+	and `request-pull`). Multi-line explanations may be used.
 
 --contains [<commit>]::
 	Only list branches which contain the specified commit (HEAD
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 0dac4e9..4035649 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -213,7 +213,7 @@ feeding the result to `git send-email`.
 
 --[no-]cover-letter::
 	In addition to the patches, generate a cover letter file
-	containing the shortlog and the overall diffstat.  You can
+	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
 --notes[=<ref>]::
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index 283577b..c32cb0b 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -14,7 +14,8 @@ DESCRIPTION
 -----------
 
 Generate a request asking your upstream project to pull changes into
-their tree.  The request, printed to the standard output, summarizes
+their tree.  The request, printed to the standard output,
+begins with the branch description, summarizes
 the changes and indicates from where they can be pulled.
 
 The upstream project is expected to have the commit named by
-- 
2.4.2.windows.1.5.gd32afb6
