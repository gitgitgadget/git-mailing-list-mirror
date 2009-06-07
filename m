From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH v2] symlinks.c: small style cleanup
Date: Sun, 07 Jun 2009 16:43:56 +0200
Message-ID: <1244385836-8540-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 16:45:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDJcc-0006dE-2u
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 16:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbZFGOpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 10:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbZFGOpG
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 10:45:06 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:60570 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267AbZFGOpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 10:45:06 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KKV00D16IB76320@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 07 Jun 2009 16:45:07 +0200 (CEST)
Received: from localhost.localdomain ([80.202.166.56])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KKV00B1DIB6PX50@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 07 Jun 2009 16:45:07 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.277.gd10543
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120976>

Remove some unnecessary "return;"-statements at the end of "void
foo()"-functions.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 7 Jun 2009, Kjetil Barvik wrote:
>
>> Add {}-braces around an else-part, where the if-part already has
>> {}-braces.
>
> This is the wrong way round.  We prefer _not_ to add unnecessary
> braces, but do tolerate them from time to time.

  OK.  Have taken away that part of the patch in this verson (v2).

  -- kjetil


 symlinks.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 1d6b35b..64c8cd3 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -263,7 +263,6 @@ static void do_remove_scheduled_dirs(int new_len)
 			 removal.path[removal.len] != '/');
 	}
 	removal.len = new_len;
-	return;
 }
 
 void schedule_dir_for_removal(const char *name, int len)
@@ -296,11 +295,9 @@ void schedule_dir_for_removal(const char *name, int len)
 		       last_slash - match_len);
 		removal.len = last_slash;
 	}
-	return;
 }
 
 void remove_scheduled_dirs(void)
 {
 	do_remove_scheduled_dirs(0);
-	return;
 }
-- 
1.6.3.2.277.gd10543
