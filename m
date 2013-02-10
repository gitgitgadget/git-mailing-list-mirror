From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 01/15] user-manual: Rewrite git-gc section for automatic
 packing
Date: Sun, 10 Feb 2013 10:10:27 -0500
Message-ID: <dbf573abc8507311e1b3321683fa6bce671a7867.1360508415.git.wking@tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:12:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4YZT-0000h4-Uv
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760542Ab3BJPLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:11:38 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:36322 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758942Ab3BJPLT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:19 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000FCJFIBJY50@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:00 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 5499C879268; Sun,
 10 Feb 2013 10:10:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509059; bh=khhXnty0IWJEwvpWrBEmYg745RCnbrvTvVsleJ/gtDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=Xf/3tVBrSKIYZFMenI2fm+Jx87DgCgR4AGhmRkB0s75VIksW2u7C9gpY1EZmbaKCw
 MWBPYzcE3Gu6aIZZj7y+sfVjU0RLjRimwCvJeJNRdHPWryY75xQ6k7EZXtkIC/MN2o
 Msgen3j1bN/Y/tVU03UFQghhYgQ1nkTY1DJX61+c=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1360508415.git.wking@tremily.us>
In-reply-to: <cover.1360508415.git.wking@tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215912>

From: "W. Trevor King" <wking@tremily.us>

This should have happened back in 2007, when `git gc` learned about
auto (e9831e8, git-gc --auto: add documentation, 2007-09-17).

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 5077e7c..222545b 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1562,17 +1562,11 @@ Ensuring good performance
 -------------------------
 
 On large repositories, Git depends on compression to keep the history
-information from taking up too much space on disk or in memory.
-
-This compression is not performed automatically.  Therefore you
-should occasionally run linkgit:git-gc[1]:
-
--------------------------------------------------
-$ git gc
--------------------------------------------------
-
-to recompress the archive.  This can be very time-consuming, so
-you may prefer to run `git gc` when you are not doing other work.
+information from taking up too much space on disk or in memory.  Some
+git commands may automatically run linkgit:git-gc[1], so you don't
+have to worry about running it manually.  However, compressing a large
+repository may take a while, so you may want to call `gc` explicitly
+to avoid automatic compression kicking in when it is not convenient.
 
 
 [[ensuring-reliability]]
-- 
1.8.1.336.g94702dd
