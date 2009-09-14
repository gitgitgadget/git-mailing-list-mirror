From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] remove logical typo in documentation of sample update hook
Date: Mon, 14 Sep 2009 10:47:06 +0200
Message-ID: <20090914084417.GA29641@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 10:53:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mn7Jq-0007De-P7
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 10:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbZINIxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 04:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbZINIxp
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 04:53:45 -0400
Received: from darksea.de ([83.133.111.250]:48911 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750815AbZINIxp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 04:53:45 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Sep 2009 04:53:44 EDT
Received: (qmail 6424 invoked from network); 14 Sep 2009 10:47:06 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Sep 2009 10:47:06 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128441>

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/githooks.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 79f633e..06e0f31 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -245,7 +245,7 @@ Both standard output and standard error output are forwarded to
 for the user.
 
 The default 'update' hook, when enabled--and with
-`hooks.allowunannotated` config option turned on--prevents
+`hooks.allowunannotated` config option unset or set to false--prevents
 unannotated tags to be pushed.
 
 [[post-receive]]
-- 
1.6.5.rc1.dirty
