From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 1/7] glossary: mention 'treeish' as an alternative to 'tree-ish'
Date: Mon,  2 Sep 2013 01:34:20 -0400
Message-ID: <1378100066-31889-2-git-send-email-rhansen@bbn.com>
References: <1378100066-31889-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 02 07:47:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGMyu-000679-9a
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 07:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627Ab3IBFrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 01:47:16 -0400
Received: from smtp.bbn.com ([128.33.1.81]:62261 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001Ab3IBFrP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 01:47:15 -0400
Received: from socket.bbn.com ([192.1.120.102]:59474)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VGMmg-0009Wx-BM; Mon, 02 Sep 2013 01:34:42 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id B73CB401B7
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1378100066-31889-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233600>

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
