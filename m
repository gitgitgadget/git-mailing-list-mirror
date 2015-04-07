From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] gitk: Use translated version of "Command line" in getcommitlines.
Date: Tue,  7 Apr 2015 11:53:37 -0400
Message-ID: <1428422017-20645-1-git-send-email-marcnarc@xiplink.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 17:53:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfVoX-0005M1-L1
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 17:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbbDGPxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 11:53:17 -0400
Received: from domain.not.configured ([192.252.130.194]:33901 "EHLO
	cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754465AbbDGPxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 11:53:16 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id 00D32601AD;
	Tue,  7 Apr 2015 11:53:14 -0400 (EDT)
X-Mailer: git-send-email 2.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266924>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

I noticed this today.  I think this change is needed for getcommitlines to
work properly with translated gitk's.

		M.

 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 90419e3..fd5b50a 100755
--- a/gitk
+++ b/gitk
@@ -1442,7 +1442,7 @@ proc getcommitlines {fd inst view updating}  {
 	    if {[string range $err 0 4] == "usage"} {
 		set err "Gitk: error reading commits$fv:\
 			bad arguments to git log."
-		if {$viewname($view) eq "Command line"} {
+		if {$viewname($view) eq [mc "Command line"]} {
 		    append err \
 			"  (Note: arguments to gitk are passed to git log\
 			 to allow selection of commits to be displayed.)"
-- 
2.3.5
