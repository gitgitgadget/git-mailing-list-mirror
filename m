From: Alex Riesen <raa.lkml@gmail.com>
Subject: Fix permissions on test scripts
Date: Fri, 13 Apr 2007 22:13:51 +0200
Message-ID: <20070413201351.GB750@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 22:14:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcS9m-00051B-5z
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 22:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbXDMUNy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 16:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbXDMUNy
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 16:13:54 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:35148 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964989AbXDMUNx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 16:13:53 -0400
Received: from tigra.home (Fcab9.f.strato-dslnet.de [195.4.202.185])
	by post.webmailer.de (fruni mo49) (RZmta 5.5)
	with ESMTP id J03dc1j3DE5l2X ; Fri, 13 Apr 2007 22:13:51 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8C59D277B6;
	Fri, 13 Apr 2007 22:13:51 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 81D2CBE85; Fri, 13 Apr 2007 22:13:51 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTv+FXw=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44429>

Make every test executable. Remove exec-attribute from included shell files,
they can't used standalone anyway.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 t/diff-lib.sh
 mode change 100755 => 100644 t/lib-read-tree-m-3way.sh
 mode change 100644 => 100755 t/t4201-shortlog.sh
 mode change 100644 => 100755 t/t6023-merge-file.sh
 mode change 100644 => 100755 t/t6024-recursive-merge.sh
 mode change 100644 => 100755 t/t6025-merge-symlinks.sh
 mode change 100755 => 100644 t/test-lib.sh

diff --git a/t/diff-lib.sh b/t/diff-lib.sh
old mode 100755
new mode 100644
diff --git a/t/lib-read-tree-m-3way.sh b/t/lib-read-tree-m-3way.sh
old mode 100755
new mode 100644
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
old mode 100644
new mode 100755
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
old mode 100644
new mode 100755
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
old mode 100644
new mode 100755
diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
old mode 100644
new mode 100755
diff --git a/t/test-lib.sh b/t/test-lib.sh
old mode 100755
new mode 100644
-- 
1.5.1.130.g0ea6d
