From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] Remove protoype for inline function so that forte12
	doesn't choke on it
Date: Sun, 13 May 2007 13:22:23 +0200
Message-ID: <20070513112223.GB24392@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 13 13:22:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnC9k-0004Ap-Tb
	for gcvg-git@gmane.org; Sun, 13 May 2007 13:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757232AbXEMLWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 07:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757397AbXEMLWZ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 07:22:25 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:37347 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757232AbXEMLWY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 07:22:24 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 90F563F376; Sun, 13 May 2007 13:22:23 +0200 (CEST)
Content-Disposition: inline
X-Mailer: git-send-email 1.5.2.rc1.9.g6644
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47142>


Signed-off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
---
 tree-walk.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/tree-walk.h b/tree-walk.h
index 43458cf..ee747ab 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -27,7 +27,6 @@ static inline int tree_entry_len(const char *name, const unsigned char *sha1)
 
 void update_tree_entry(struct tree_desc *);
 void init_tree_desc(struct tree_desc *desc, const void *buf, unsigned long size);
-const unsigned char *tree_entry_extract(struct tree_desc *, const char **, unsigned int *);
 
 /* Helper function that does both of the above and returns true for success */
 int tree_entry(struct tree_desc *, struct name_entry *);
-- 
1.5.2.rc1.9.g6644
