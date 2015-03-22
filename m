From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: [PATCH 3/5] Update documentations for git-log to include the new --merges option and also its corresponding config option.
Date: Sun, 22 Mar 2015 19:28:39 +0100
Message-ID: <1427048921-28677-3-git-send-email-koosha@posteo.de>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>
Cc: Koosha Khajehmoogahi <koosha@posteo.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 19:30:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZkdn-0003PJ-Sc
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 19:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbbCVSaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 14:30:14 -0400
Received: from mx02.posteo.de ([89.146.194.165]:41306 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826AbbCVSaL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 14:30:11 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id 8DA2A1F5E884;
	Sun, 22 Mar 2015 19:30:09 +0100 (CET)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3l96p92cQwz5vNK;
	Sun, 22 Mar 2015 19:30:09 +0100 (CET)
X-Mailer: git-send-email 2.3.3.263.g095251d.dirty
In-Reply-To: <1427048921-28677-1-git-send-email-koosha@posteo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266078>

Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
---
 Documentation/git-log.txt          | 3 +++
 Documentation/rev-list-options.txt | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 1f7bc67..506125a 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -190,6 +190,9 @@ log.showroot::
 	`git log -p` output would be shown without a diff attached.
 	The default is `true`.
 
+log.merges::
+    Default for `--merges` option. Defaults to `show`.
+
 mailmap.*::
 	See linkgit:git-shortlog[1].
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4ed8587..398e657 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -99,6 +99,12 @@ if it is part of the log message.
 --merges::
 	Print only merge commits. This is exactly the same as `--min-parents=2`.
 
+--merges=show|hide|only::
+	If show is specified, merge commits will be shown in conjunction with
+	other commits. If hide is specified, it will work like `--no-merges`.
+	If only is specified, it will work like `--merges`. The default option
+	is show.
+
 --no-merges::
 	Do not print commits with more than one parent. This is
 	exactly the same as `--max-parents=1`.
-- 
2.3.3.263.g095251d.dirty
