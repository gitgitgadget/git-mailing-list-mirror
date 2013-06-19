From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Tue, 18 Jun 2013 22:09:38 -0400
Message-ID: <1371607780-2966-3-git-send-email-rhansen@bbn.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 19 04:10:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up7qc-0008F5-0S
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 04:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934055Ab3FSCKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 22:10:05 -0400
Received: from smtp.bbn.com ([128.33.0.80]:57469 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933836Ab3FSCKD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 22:10:03 -0400
Received: from socket.bbn.com ([192.1.120.102]:40564)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Up7qT-000OQR-2Y; Tue, 18 Jun 2013 22:10:01 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id BBD90408FE
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228324>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/glossary-content.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 01365d9..a3cc003 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -82,6 +82,17 @@ to point at the new commit.
 	to the top <<def_directory,directory>> of the stored
 	revision.
 
+[[def_committish]]committish (also commit-ish)::
+	A <<def_ref,ref>> pointing to an <<def_object,object>> that
+	can be recursively dereferenced to a
+	<<def_commit_object,commit object>>.
+	The following are all committishes:
+	a ref pointing to a commit object,
+	a ref pointing to a <<def_tag_object,tag object>> that points
+	to a commit object,
+	a ref pointing to a tag object that points to a tag object
+	that points to a commit object, etc.
+
 [[def_core_git]]core Git::
 	Fundamental data structures and utilities of Git. Exposes only limited
 	source code management tools.
-- 
1.8.3.1
