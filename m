From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 04/15] user-manual: Use git branch --merged
Date: Sun, 10 Feb 2013 10:10:30 -0500
Message-ID: <c8abf7a75a59302e6bdc66eee13eb2ec53b26b46.1360508415.git.wking@tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:11:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4YZI-0000Zz-Ok
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759412Ab3BJPLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:11:19 -0500
Received: from vms173015pub.verizon.net ([206.46.173.15]:46983 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759010Ab3BJPLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:16 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000AC7FIC6410@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:01 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id ED25D879277; Sun,
 10 Feb 2013 10:10:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509059; bh=57Hz0M4i6rOR+aSD9uWkWJq9s8g2FMGFgxPVxdPrpe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=EPGcHo1UpmdsRU48imfH+zCRtsdflzsEHhXFu5r4O/wng3G3RQzFpnwb6V6X+U38g
 HDwWZHLOVpaX3VTnJfbqmYQh7S0Jz8CCBPxVoWM5YXv0LUZcxT7RCU1rtqDWQsuISM
 NWEwj7vXr091eQcE8aczSDRg6uWp59tkihFlUDMQ=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1360508415.git.wking@tremily.us>
In-reply-to: <cover.1360508415.git.wking@tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215907>

From: "W. Trevor King" <wking@tremily.us>

Use 'git branch --merged origin'.  This feature was introduced by
049716b (branch --merged/--no-merged: allow specifying arbitrary
commit, 2008-07-08), after the documentation that's being replaced
moved into the manual with 9e2163ea (user-manual: move
howto/using-topic-branches into manual, 2007-05-13).

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 53f73c3..a8f792d 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2267,10 +2267,10 @@ then pulled by Linus, and finally coming back into your local
 You detect this when the output from:
 
 -------------------------------------------------
-$ git log origin..branchname
+$ git branch --merged origin
 -------------------------------------------------
 
-is empty.  At this point the branch can be deleted:
+lists the branch.  At this point the branch can be deleted:
 
 -------------------------------------------------
 $ git branch -d branchname
-- 
1.8.1.336.g94702dd
