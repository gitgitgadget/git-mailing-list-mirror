From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH 1/2] gitk: Rearrange window title to be more conventional.
Date: Tue,  6 Jan 2015 12:51:59 -0500
Message-ID: <1420566720-25238-2-git-send-email-marcnarc@xiplink.com>
References: <1420566720-25238-1-git-send-email-marcnarc@xiplink.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 19:01:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8YQS-0007oL-Sl
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 19:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbbAFSAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 13:00:09 -0500
Received: from domain.not.configured ([192.252.130.194]:59029 "EHLO
	cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932279AbbAFSAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 13:00:08 -0500
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id A6B1D604A7;
	Tue,  6 Jan 2015 12:52:12 -0500 (EST)
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1420566720-25238-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262079>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

I did a bit of googling but couldn't find some standard that says the
application name goes at the end of the title bar.  But this is how all the
browsers and other apps I use regularly do things.

		M.

 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 78358a7..03de545 100755
--- a/gitk
+++ b/gitk
@@ -12293,7 +12293,7 @@ catch {
 }
 # wait for the window to become visible
 tkwait visibility .
-wm title . "$appname: [reponame]"
+wm title . "[reponame] - $appname"
 update
 readrefs
 
-- 
2.2.1
