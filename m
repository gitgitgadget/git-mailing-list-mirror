From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 1/7] glossary: mention 'treeish' as an alternative to 'tree-ish'
Date: Wed,  4 Sep 2013 15:04:28 -0400
Message-ID: <1378321474-7125-2-git-send-email-rhansen@bbn.com>
References: <xmqq1u55plqe.fsf@gitster.dls.corp.google.com>
 <1378321474-7125-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 04 21:04:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHINr-0002Az-C5
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 21:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760004Ab3IDTEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 15:04:50 -0400
Received: from smtp.bbn.com ([128.33.0.80]:57279 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759718Ab3IDTEt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 15:04:49 -0400
Received: from socket.bbn.com ([192.1.120.102]:55418)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VHINk-0008aO-LU; Wed, 04 Sep 2013 15:04:48 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 748644004A
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1378321474-7125-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233856>

The documentation contains a mix of the two spellings, so include both
in the glossary so that a search for either will lead to the
definition.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/glossary-content.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index dba5062..0273095 100644
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
1.8.4
