From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 7/8] fetch.c: Clean up object flag definitions
Date: Wed, 21 Sep 2005 20:19:07 +0400 (MSD)
Message-ID: <20050921161907.BC297E010FC@center4.mivlgu.local>
References: <20050921161829.GA20944@master.mivlgu.local>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 18:23:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI7Je-0006Ia-1d
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 18:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVIUQTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 12:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVIUQTJ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 12:19:09 -0400
Received: from mivlgu.ru ([81.18.140.87]:3718 "EHLO center4.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751118AbVIUQTI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 12:19:08 -0400
Received: by center4.mivlgu.local (Postfix, from userid 500)
	id BC297E010FC; Wed, 21 Sep 2005 20:19:07 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050921161829.GA20944@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9060>

Remove holes left after deleting flags, and use shifts to emphasize
that flags are single bits.

---

 fetch.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

42e3d6ef7c0a4eda60032815a36039240dc5cd0b
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -54,9 +54,9 @@ static int process_tree(struct tree *tre
 	return 0;
 }
 
-#define COMPLETE	1U
-#define TO_SCAN		4U
-#define SEEN		16U
+#define COMPLETE	(1U << 0)
+#define SEEN		(1U << 1)
+#define TO_SCAN		(1U << 2)
 
 static struct commit_list *complete = NULL;
 
