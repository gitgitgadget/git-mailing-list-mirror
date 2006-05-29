From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix section slicing so help options are not misplaced in cg-commit(1)
Date: Mon, 29 May 2006 02:13:34 +0200
Message-ID: <20060529001334.GD2061@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 29 02:13:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkVOF-0008EA-Tn
	for gcvg-git@gmane.org; Mon, 29 May 2006 02:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWE2ANp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 20:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWE2ANp
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 20:13:45 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:59559 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751071AbWE2ANo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 20:13:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id BDF3477002D;
	Mon, 29 May 2006 02:13:43 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08615-06; Mon, 29 May 2006 02:13:34 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 5D073770026;
	Mon, 29 May 2006 02:13:34 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 8D2656DF84F; Mon, 29 May 2006 02:10:26 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 36CC66253D; Mon, 29 May 2006 02:13:34 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20912>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

95724a5a97ca466e6eaccc7f46833a015dde2f24
 Documentation/make-cg-asciidoc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

95724a5a97ca466e6eaccc7f46833a015dde2f24
diff --git a/Documentation/make-cg-asciidoc b/Documentation/make-cg-asciidoc
index 45fc981..3873618 100755
--- a/Documentation/make-cg-asciidoc
+++ b/Documentation/make-cg-asciidoc
@@ -48,7 +48,7 @@ DESCRIPTION=
 OPTIONS=
 MISC=
 
-section=$(echo "$BODY" | sed -n '1,/^[-~][-~]*[-~]$/p')
+section=$(echo "$BODY" | sed -n '1,/^[-][-]*[-]$/p')
 section_lines=$(echo "$section" | wc -l)
 lines=$(echo "$BODY" | wc -l)
 
-- 
1.3.3.gd882-dirty

-- 
Jonas Fonseca
