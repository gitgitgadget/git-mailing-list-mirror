From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH 1/3] gitk: Remove unused $cdate array
Date: Wed, 19 Jan 2011 14:46:59 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 19 20:47:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfdzp-0000DK-3V
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081Ab1ASTrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 14:47:03 -0500
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:52348 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754012Ab1ASTrB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jan 2011 14:47:01 -0500
X-AuditID: 1209190f-b7c1dae000000a2b-a9-4d373fb4141a
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id C0.FE.02603.4BF373D4; Wed, 19 Jan 2011 14:47:00 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id p0JJl0tE027028;
	Wed, 19 Jan 2011 14:47:00 -0500
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p0JJkxOJ020279
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 19 Jan 2011 14:47:00 -0500 (EST)
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165286>

It was unused since commit 9f1afe05c3ab7228e21ba3666c6e35d693149b37.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 gitk |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index a0f7816..bf68959 100755
--- a/gitk
+++ b/gitk
@@ -1621,7 +1621,7 @@ proc readcommit {id} {
 }
 
 proc parsecommit {id contents listed} {
-    global commitinfo cdate
+    global commitinfo
 
     set inhdr 1
     set comment {}
@@ -1671,9 +1671,6 @@ proc parsecommit {id contents listed} {
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
1.7.4.rc1
