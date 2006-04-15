From: Junio C Hamano <junkio@cox.net>
Subject: Re: Recent unresolved issues
Date: Fri, 14 Apr 2006 19:22:34 -0700
Message-ID: <7vsloflgr9.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141637230.3701@g5.osdl.org>
	<7vlku7n05x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141748070.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604141751270.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604141808480.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 04:23:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUaRB-0007z0-UZ
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 04:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWDOCWh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 22:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWDOCWg
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 22:22:36 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:53503 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750889AbWDOCWg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 22:22:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415022235.JVGJ8241.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 22:22:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604141808480.3701@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 14 Apr 2006 18:09:20 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18722>

Linus Torvalds <torvalds@osdl.org> writes:

> Ok, fourth time lucky?
>
> 		Linus

With this, perhaps.

---
diff --git a/revision.c b/revision.c
index 2061ca8..1d26e0d 100644
--- a/revision.c
+++ b/revision.c
@@ -792,6 +792,7 @@ int setup_revisions(int argc, const char
 	}
 	if (revs->diffopt.output_format == DIFF_FORMAT_PATCH)
 		revs->diffopt.recursive = 1;
+	revs->diffopt.abbrev = revs->abbrev;
 	diff_setup_done(&revs->diffopt);
 
 	return left;
