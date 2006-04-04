From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Solaris needs strings.h when using index().
Date: Tue, 4 Apr 2006 14:36:03 +0200
Message-ID: <20060404123603.GA14071@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 04 14:36:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQklU-0006U3-Vu
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 14:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWDDMgG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 08:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWDDMgG
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 08:36:06 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:52966 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932417AbWDDMgF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 08:36:05 -0400
Received: (qmail 6677 invoked by uid 5842); 4 Apr 2006 14:36:03 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18391>

From: Peter Eriksen <s022018@student.dtu.dk>
Date: Tue Apr 4 14:33:14 2006 +0200
Subject: [PATCH] Solaris needs strings.h when using index().

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---


 blame.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

832067e6e16ae6c1ac3bd043ddeb56daa993e682
diff --git a/blame.c b/blame.c
index 396defc..1a08434 100644
--- a/blame.c
+++ b/blame.c
@@ -6,6 +6,7 @@ #include <assert.h>
 #include <time.h>
 #include <sys/time.h>
 #include <math.h>
+#include <strings.h>
 
 #include "cache.h"
 #include "refs.h"
-- 
1.3.0.rc1.gfc99-dirty
