From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 2/7] glossary: define committish (a.k.a. commit-ish)
Date: Mon,  2 Sep 2013 01:34:21 -0400
Message-ID: <1378100066-31889-3-git-send-email-rhansen@bbn.com>
References: <1378100066-31889-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 02 07:47:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGMyu-000679-QU
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 07:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403Ab3IBFrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 01:47:18 -0400
Received: from smtp.bbn.com ([128.33.1.81]:51127 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753684Ab3IBFrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 01:47:16 -0400
Received: from socket.bbn.com ([192.1.120.102]:59475)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VGMmh-0009Wz-1t; Mon, 02 Sep 2013 01:34:43 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 755EE4015A
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1378100066-31889-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233599>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/glossary-content.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 0273095..b1993e0 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -82,6 +82,18 @@ to point at the new commit.
 	to the top <<def_directory,directory>> of the stored
 	revision.
 
+[[def_committish]]committish (also commit-ish)::
+	A <<def_commit_object,commit object>> or an
+	<<def_object,object>> that can be recursively dereferenced to
+	a commit object.
+	The following are all committishes:
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
