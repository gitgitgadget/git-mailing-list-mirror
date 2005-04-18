From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 7/6] show-diff: Remove stale comments
Date: Mon, 18 Apr 2005 16:33:46 -0700
Message-ID: <7vk6mzslr9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 01:30:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNfga-0007RT-6A
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 01:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVDRXdt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 19:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVDRXdt
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 19:33:49 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:43145 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261202AbVDRXds (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 19:33:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050418233347.BYFQ1282.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Apr 2005 19:33:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Patch 1/6 in the series has already cleaned the interface to
call sq_expand(), but the comment before that function still
carries the stale interface warning.  Remove it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 show-diff.c |    3 ---
 1 files changed, 3 deletions(-)

show-diff.c: b592fb131fc3949e1197bed461b8eb143f8e73ff
--- a/show-diff.c
+++ b/show-diff.c
@@ -34,9 +34,6 @@ static void prepare_diff_cmd(void)
  *  name     ==> name      ==> 'name'
  *  a b      ==> a b       ==> 'a b'
  *  a'b      ==> a'\''b    ==> 'a'\''b'
- *
- * NOTE! The returned memory belongs to this function so
- * do not free it.
  */
 static char *sq_expand(char *src)
 {

