From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 11/15] user-manual: Fix 'http' -> 'HTTP' typos
Date: Sun, 10 Feb 2013 10:10:37 -0500
Message-ID: <9a46edb449eed4834336887e1827749767a69cb1.1360508415.git.wking@tremily.us>
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
	id 1U4YZJ-0000Zz-7w
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760522Ab3BJPLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:11:21 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:49287 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759119Ab3BJPLR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:17 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI0000TYFIDJT30@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:03 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 9AEEF87929B; Sun,
 10 Feb 2013 10:11:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509061; bh=uZrWBXt0d94HjLQRccxBtEtCSXU4eM5NwgNc87zBE14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=XmnZ1pRBg+KBuQTih+1Y6+YeZflred6U+CyYPMylOKQfN44xKfrimjp3nrDgm97Ig
 +9D/1c+K68Wgoqi94vdQE/nbRXJ2SKBJo2nEMItFL9V5/2B5aHgH7ty3wIaVBJPKam
 GMpK+XJ9Y5aplIYTkXsx1vyxfuVocLCAEIzviJRc=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1360508415.git.wking@tremily.us>
In-reply-to: <cover.1360508415.git.wking@tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215908>

From: "W. Trevor King" <wking@tremily.us>

HTTP is an acronym which has not (yet) made the transition to word
status (unlike "laser", probably because lasers are inherently cooler
than HTTP ;).

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 07e07c1..31054a2 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1938,7 +1938,7 @@ Exporting a Git repository via http
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The Git protocol gives better performance and reliability, but on a
-host with a web server set up, http exports may be simpler to set up.
+host with a web server set up, HTTP exports may be simpler to set up.
 
 All you need to do is place the newly created bare Git repository in
 a directory that is exported by the web server, and make some
@@ -1964,7 +1964,7 @@ $ git clone http://yourserver.com/~you/proj.git
 (See also
 link:howto/setup-git-server-over-http.txt[setup-git-server-over-http]
 for a slightly more sophisticated setup using WebDAV which also
-allows pushing over http.)
+allows pushing over HTTP.)
 
 [[pushing-changes-to-a-public-repository]]
 Pushing changes to a public repository
-- 
1.8.1.336.g94702dd
