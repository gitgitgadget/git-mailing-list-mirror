From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Define a few built-in attribute rules.
Date: Sat, 14 Apr 2007 18:03:39 -0700
Message-ID: <7vvefy5tzo.fsf@assigned-by-dhcp.cox.net>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
	<200704131033.15751.andyparkins@gmail.com>
	<7vejmm78qp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 03:03:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hct9b-0004r1-OQ
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 03:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbXDOBDl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 21:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbXDOBDl
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 21:03:41 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59383 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbXDOBDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 21:03:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415010340.YLBS1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 14 Apr 2007 21:03:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id nD3f1W00H1kojtg0000000; Sat, 14 Apr 2007 21:03:39 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44478>

This adds an obviously sane pair of default attribute rules as built-ins.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 attr.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/attr.c b/attr.c
index 3a14df1..9068c2e 100644
--- a/attr.c
+++ b/attr.c
@@ -194,6 +194,8 @@ static void free_attr_elem(struct attr_stack *e)
 }
 
 static const char *builtin_attr[] = {
+	"[attr]binary !diff !crlf",
+	"* diff crlf",
 	NULL,
 };
 
-- 
1.5.1.1.810.gac3a
