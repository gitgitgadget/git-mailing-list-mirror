From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 06/15] user-manual: Give 'git push -f' as an alternative to
 +master
Date: Sun, 10 Feb 2013 10:10:32 -0500
Message-ID: <f0f8b77a3487be30ee4c492899fe73af05e20413.1360508415.git.wking@tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:11:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4YZJ-0000Zz-Oe
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760536Ab3BJPLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:11:22 -0500
Received: from vms173015pub.verizon.net ([206.46.173.15]:46983 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759223Ab3BJPLR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:17 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000CO7FICJ100@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:02 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 64786879281; Sun,
 10 Feb 2013 10:11:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509060; bh=wZmAv6ng8ZlE6ML1rCVjoNXJgS2PNm1cu783BHh/wkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=n/psmDRPD2UOCTCyOKezwesRoHBO0A8tNOiPuQ9OU9+6YA+wnm6kD+ylgW5Iue6VC
 8+k42a5XUBxsfLLBSg+1UTCeeqrGlL7IMxJG+Vo2THDyXF7ECyAk+i7aiWhnRpoNkX
 bUGEaiyNwErsI/9LBKsqyFcGf9V7LTUZWM9Ye8YE=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1360508415.git.wking@tremily.us>
In-reply-to: <cover.1360508415.git.wking@tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215910>

From: "W. Trevor King" <wking@tremily.us>

This mirrors existing language in the description of 'git fetch'.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 5d80b40..a68d6b9 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2045,6 +2045,13 @@ branch name with a plus sign:
 $ git push ssh://yourserver.com/~you/proj.git +master
 -------------------------------------------------
 
+Note the addition of the `+` sign.  Alternatively, you can use the
+`-f` flag to force the remote update, as in:
+
+-------------------------------------------------
+$ git push -f ssh://yourserver.com/~you/proj.git master
+-------------------------------------------------
+
 Normally whenever a branch head in a public repository is modified, it
 is modified to point to a descendant of the commit that it pointed to
 before.  By forcing a push in this situation, you break that convention.
-- 
1.8.1.336.g94702dd
