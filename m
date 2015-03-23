From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH 1/2] gitk: Rearrange window title to be more conventional.
Date: Mon, 23 Mar 2015 10:18:16 -0400
Message-ID: <1427120297-26314-1-git-send-email-marcnarc@xiplink.com>
References: <1420566720-25238-1-git-send-email-marcnarc@xiplink.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 15:27:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya3K8-0007tz-HR
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 15:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbbCWO1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 10:27:19 -0400
Received: from domain.not.configured ([192.252.130.194]:64229 "EHLO
	cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752143AbbCWO1S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 10:27:18 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Mar 2015 10:27:18 EDT
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id B1025601A3;
	Mon, 23 Mar 2015 10:17:56 -0400 (EDT)
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1420566720-25238-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266140>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

I did a bit of googling but couldn't find some standard that says the
application name goes at the end of the title bar.  But this is how all the
browsers and other apps I use regularly do things.

		M.

 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 9a2daf3..b859879 100755
--- a/gitk
+++ b/gitk
@@ -12393,7 +12393,7 @@ catch {
 }
 # wait for the window to become visible
 tkwait visibility .
-wm title . "$appname: [reponame]"
+wm title . "[reponame] - $appname"
 update
 readrefs
 
-- 
2.3.3
