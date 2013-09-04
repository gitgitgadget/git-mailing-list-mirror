From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 2/7] glossary: define commit-ish (a.k.a. committish)
Date: Wed,  4 Sep 2013 15:04:29 -0400
Message-ID: <1378321474-7125-3-git-send-email-rhansen@bbn.com>
References: <xmqq1u55plqe.fsf@gitster.dls.corp.google.com>
 <1378321474-7125-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 04 21:05:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHIO4-0002I5-Hc
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 21:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760048Ab3IDTE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 15:04:59 -0400
Received: from smtp.bbn.com ([128.33.1.81]:13123 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932631Ab3IDTE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 15:04:58 -0400
Received: from socket.bbn.com ([192.1.120.102]:59577)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VHINo-000338-C9; Wed, 04 Sep 2013 15:04:52 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 362A04004A
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1378321474-7125-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233859>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/glossary-content.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 0273095..47e901e 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -82,6 +82,18 @@ to point at the new commit.
 	to the top <<def_directory,directory>> of the stored
 	revision.
 
+[[def_commit-ish]]commit-ish (also committish)::
+	A <<def_commit_object,commit object>> or an
+	<<def_object,object>> that can be recursively dereferenced to
+	a commit object.
+	The following are all commit-ishes:
+	a commit object,
+	a <<def_tag_object,tag object>> that points to a commit
+	object,
+	a tag object that points to a tag object that points to a
+	commit object,
+	etc.
+
 [[def_core_git]]core Git::
 	Fundamental data structures and utilities of Git. Exposes only limited
 	source code management tools.
-- 
1.8.4
