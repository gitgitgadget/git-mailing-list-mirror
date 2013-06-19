From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 1/4] glossary: add 'treeish' as a synonym for 'tree-ish'
Date: Tue, 18 Jun 2013 22:09:37 -0400
Message-ID: <1371607780-2966-2-git-send-email-rhansen@bbn.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 19 04:43:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up8Mn-0006RU-Qf
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 04:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934079Ab3FSCnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 22:43:22 -0400
Received: from smtp.bbn.com ([128.33.1.81]:23315 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933836Ab3FSCnV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 22:43:21 -0400
X-Greylist: delayed 1998 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jun 2013 22:43:21 EDT
Received: from socket.bbn.com ([192.1.120.102]:39093)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Up7qS-000I83-Tt; Tue, 18 Jun 2013 22:10:01 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id A3362408FA
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228327>

The documentation contains a mix of the two spellings, and including
both makes it possible for users to search the glossary with their
spelling of choice.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/glossary-content.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index db2a74d..01365d9 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -486,7 +486,7 @@ should not be combined with other pathspec.
 	with refs to the associated blob and/or tree objects. A
 	<<def_tree,tree>> is equivalent to a <<def_directory,directory>>.
 
-[[def_tree-ish]]tree-ish::
+[[def_tree-ish]]tree-ish (also treeish)::
 	A <<def_ref,ref>> pointing to either a <<def_commit_object,commit
 	object>>, a <<def_tree_object,tree object>>, or a <<def_tag_object,tag
 	object>> pointing to a tag or commit or tree object.
-- 
1.8.3.1
