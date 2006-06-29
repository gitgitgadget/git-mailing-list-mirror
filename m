From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] cogito: selftests need bash
Date: Thu, 29 Jun 2006 08:58:31 +0000
Message-ID: <20060629085831.1415.qmail@f03e02b18ad091.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 29 10:58:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvsLp-0006b5-5M
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 10:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbWF2I6M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 04:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbWF2I6M
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 04:58:12 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:27032 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S932677AbWF2I6L (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 04:58:11 -0400
Received: (qmail 1416 invoked by uid 1000); 29 Jun 2006 08:58:31 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22849>

Force bash for selftest scripts, as they fail with posix sh.

Signed-off-by: Gerrit Pape <pape@smarden.org>

---

 t/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

0f3a68d543ebb55564bb4edca8a26722f6de8da8
diff --git a/t/Makefile b/t/Makefile
index 6882e23..b8e6eec 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -8,7 +8,7 @@ #GIT_TEST_OPTS=--verbose --debug
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 
 all:
-	@$(foreach t,$T,echo "*** $t ***"; sh $t $(GIT_TEST_OPTS) || exit; )
+	@$(foreach t,$T,echo "*** $t ***"; bash $t $(GIT_TEST_OPTS) || exit; )
 	@rm -fr trash
 
 clean:
-- 
1.3.3
