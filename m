From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH 2/4] gitk: Remove unused $cdate array
Date: Fri, 19 Nov 2010 02:38:18 -0500
Message-ID: <1290152300-21393-2-git-send-email-andersk@mit.edu>
References: <1290152300-21393-1-git-send-email-andersk@mit.edu>
Cc: git@vger.kernel.org, Anders Kaseorg <andersk@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 08:38:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJLYE-0002kB-H9
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 08:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab0KSHiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 02:38:25 -0500
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:44086 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751442Ab0KSHiY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 02:38:24 -0500
X-AuditID: 12074425-b7c98ae000000a04-d7-4ce6296f90c1
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Brightmail Gateway) with SMTP id 2A.BF.02564.F6926EC4; Fri, 19 Nov 2010 02:38:23 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id oAJ7cNbP014060;
	Fri, 19 Nov 2010 02:38:23 -0500
Received: from localhost (ET-TWENTY-THREE.MIT.EDU [18.208.1.23])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id oAJ7cMfO019336;
	Fri, 19 Nov 2010 02:38:22 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1290152300-21393-1-git-send-email-andersk@mit.edu>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161725>

It was unused since commit 9f1afe05c3ab7228e21ba3666c6e35d693149b37.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 gitk-git/gitk |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index dbc8f86..61f2e95 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1606,7 +1606,7 @@ proc readcommit {id} {
 }
 
 proc parsecommit {id contents listed} {
-    global commitinfo cdate
+    global commitinfo
 
     set inhdr 1
     set comment {}
@@ -1656,9 +1656,6 @@ proc parsecommit {id contents listed} {
 	}
 	set comment $newcomment
     }
-    if {$comdate != {}} {
-	set cdate($id) $comdate
-    }
     set commitinfo($id) [list $headline $auname $audate \
 			     $comname $comdate $comment]
 }
-- 
1.7.3.2
