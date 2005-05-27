From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 04/12] Remove unused rank field from diff_core structure.
Date: Fri, 27 May 2005 15:52:55 -0700
Message-ID: <7vsm0846yg.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:51:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbnfJ-000208-4K
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVE0Ww7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbVE0Ww7
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:52:59 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38884 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262642AbVE0Ww5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 18:52:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527225257.SCTK8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 18:52:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 15:43:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This removes a field that is no longer used from diff_score
structure.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diffcore-rename.c |    1 -
1 files changed, 1 deletion(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -113,7 +113,6 @@ struct diff_score {
 	int src; /* index in rename_src */
 	int dst; /* index in rename_dst */
 	int score;
-	int rank;
 };
 
 static int estimate_similarity(struct diff_filespec *src,
------------------------------------------------

