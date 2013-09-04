From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 7/7] glossary: fix and clarify the definition of 'ref'
Date: Wed,  4 Sep 2013 15:04:34 -0400
Message-ID: <1378321474-7125-8-git-send-email-rhansen@bbn.com>
References: <xmqq1u55plqe.fsf@gitster.dls.corp.google.com>
 <1378321474-7125-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 04 21:05:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHIOL-0002Qc-Vm
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 21:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669Ab3IDTFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 15:05:17 -0400
Received: from smtp.bbn.com ([128.33.0.80]:41725 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932653Ab3IDTFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 15:05:16 -0400
Received: from socket.bbn.com ([192.1.120.102]:55424)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VHIO7-0008bH-FX; Wed, 04 Sep 2013 15:05:11 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 3A19F4004A
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1378321474-7125-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233863>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/glossary-content.txt | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 3466ce9..7ad13e1 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -395,10 +395,20 @@ should not be combined with other pathspec.
 	to the result.
 
 [[def_ref]]ref::
-	A 40-byte hex representation of a <<def_SHA1,SHA-1>> or a name that
-	denotes a particular <<def_object,object>>. They may be stored in
-	a file under `$GIT_DIR/refs/` directory, or
-	in the `$GIT_DIR/packed-refs` file.
+	A name that begins with `refs/` (e.g. `refs/heads/master`)
+	that points to an <<def_object_name,object name>> or another
+	ref (the latter is called a <<def_symref,symbolic ref>>).
+	For convenience, a ref can sometimes be abbreviated when used
+	as an argument to a Git command; see linkgit:gitrevisions[7]
+	for details.
+	Refs are stored in the <<def_repository,repository>>.
++
+The ref namespace is hierarchical.
+Different subhierarchies are used for different purposes (e.g. the
+`refs/heads/` hierarchy is used to represent local branches).
++
+There are a few special-purpose refs that do not begin with `refs/`.
+The most notable example is `HEAD`.
 
 [[def_reflog]]reflog::
 	A reflog shows the local "history" of a ref.  In other words,
-- 
1.8.4
