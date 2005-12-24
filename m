From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/4] git.c: extra #include for dietlibc (and possibly other C libraries)
Date: Sat, 24 Dec 2005 04:11:17 -0800
Message-ID: <20051224121117.GB19136@mail.yhbt.net>
References: <20051224121007.GA19136@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 24 13:11:24 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq8F7-00085R-6E
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 13:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVLXMLS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 07:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbVLXMLS
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 07:11:18 -0500
Received: from hand.yhbt.net ([66.150.188.102]:27011 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932446AbVLXMLS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2005 07:11:18 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id ECCB47DC005; Sat, 24 Dec 2005 04:11:17 -0800 (PST)
To: git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051224121007.GA19136@mail.yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14019>

struct winsize is defined in <termios.h>, and that's not pulled
in by other #includes in that file

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

ae5641fcbc58509572d080c33a20c829b82ae9b0
diff --git a/git.c b/git.c
index e795ddb..434a3d9 100644
--- a/git.c
+++ b/git.c
@@ -9,6 +9,7 @@
 #include <limits.h>
 #include <stdarg.h>
 #include <sys/ioctl.h>
+#include <termios.h>
 #include "git-compat-util.h"
 
 #ifndef PATH_MAX
-- 
1.0.GIT
