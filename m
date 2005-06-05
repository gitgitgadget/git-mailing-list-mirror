From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix apply.c to match rename extended header to the
 document.
Date: Sun, 05 Jun 2005 15:27:16 -0700
Message-ID: <7v8y1o1ltn.fsf_-_@assigned-by-dhcp.cox.net>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 00:24:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df3X5-0001sA-5w
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 00:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVFEW1V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 18:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVFEW1V
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 18:27:21 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:35477 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261554AbVFEW1S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 18:27:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050605222715.SVEC19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 18:27:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 5 Jun 2005 15:11:26 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This matches the git extended header git-apply expects to what
is documented.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
# - linus: git-apply: fix rename header parsing
# + (working tree)
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -435,8 +435,8 @@ static int parse_git_header(char *line, 
 			{ "new file mode ", gitdiff_newfile },
 			{ "copy from ", gitdiff_copysrc },
 			{ "copy to ", gitdiff_copydst },
-			{ "rename old ", gitdiff_renamesrc },
-			{ "rename new ", gitdiff_renamedst },
+			{ "rename from ", gitdiff_renamesrc },
+			{ "rename to ", gitdiff_renamedst },
 			{ "similarity index ", gitdiff_similarity },
 			{ "dissimilarity index ", gitdiff_dissimilarity },
 			{ "", gitdiff_unrecognized },

