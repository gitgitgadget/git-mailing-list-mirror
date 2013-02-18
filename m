From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3 3/9] user-manual: Give 'git push -f' as an alternative to
 +master
Date: Sun, 17 Feb 2013 19:15:55 -0500
Message-ID: <dadeb91c29bf6758cbe463b569146991d9eb455a.1361146398.git.wking@tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:17:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7EQ8-0000ml-6c
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 01:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757414Ab3BRAQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 19:16:38 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:53046 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322Ab3BRAQa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 19:16:30 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIE003Y53EVS890@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 17 Feb 2013 18:16:08 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 74F97885659; Sun,
 17 Feb 2013 19:16:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361146567; bh=ERLeQoGvajajUlwCzOlPtvQVNfO490XTVu2bvUeO7iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=D9wYnPdvSs0WB4gl57tjj3THhMEyl0JgpFkqbVNt7NJAcf3ZxsUj5nQsqhAYBWsJ/
 Fonr43eAo/wgWu2E8PXkqOSh3VkF6Zgk/OxQJSLq62O3D22hZ5f8/JlicOlWvgeZXq
 sL7zpDGdZOK4z0cXzNU3KJx0eEMcMW9LIgKa5WCU=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1361146398.git.wking@tremily.us>
In-reply-to: <cover.1361146398.git.wking@tremily.us>
References: <cover.1361146398.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216420>

From: "W. Trevor King" <wking@tremily.us>

This mirrors existing language in the description of 'git fetch'.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index dbffd0a..ba06b7e 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2051,6 +2051,13 @@ branch name with a plus sign:
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
