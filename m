From: Kevin Geiss <kevin@desertsol.com>
Subject: [PATCH 2/4] git-cvsexportcommit.perl: use getopts to get binary flags
Date: Mon, 14 Nov 2005 09:41:43 -0700
Message-ID: <20051114164143.GC9131@raven.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 14 17:45:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhOs-0006W9-CJ
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVKNQlo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVKNQln
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:41:43 -0500
Received: from 12-219-167-192.client.mchsi.com ([12.219.167.192]:43985 "EHLO
	desertsol.com") by vger.kernel.org with ESMTP id S1751181AbVKNQln
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 11:41:43 -0500
Received: from kevin by desertsol.com with local (Exim 4.50)
	id 1EbhOp-00083b-As; Mon, 14 Nov 2005 09:41:43 -0700
To: martin.langhoff@gmail.com, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11817>

---

 git-cvsexportcommit.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: c13592c92fc8bf74afc39ee6d40cb51814cb3e24
26c7c4b051fb251cbf88eb1d6eff63e539255cf5
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 5bce39c..da7dcda 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -12,7 +12,7 @@ unless ($ENV{GIT_DIR} && -r $ENV{GIT_DIR
 
 our ($opt_h, $opt_p, $opt_v, $opt_c );
 
-getopt('hpvc');
+getopts('hpvc');
 
 $opt_h && usage();
 
---
0.99.9.GIT
