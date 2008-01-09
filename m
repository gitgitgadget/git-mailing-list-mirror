From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] gitk: Fix typo in user message.
Date: Wed, 9 Jan 2008 22:23:18 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200801092223.18903.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 22:25:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCiQY-0001Lm-1m
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 22:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478AbYAIVZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 16:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756398AbYAIVZG
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 16:25:06 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:40009 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756004AbYAIVZE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 16:25:04 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m09LOx90002108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 9 Jan 2008 22:24:59 +0100
Received: from [192.168.2.102] (p54900E53.dip0.t-ipconnect.de [84.144.14.83])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m09LOv4E018998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 Jan 2008 22:24:58 +0100
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70016>

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
 gitk |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 801a5a9..b3cb8e8 100755
--- a/gitk
+++ b/gitk
@@ -2629,12 +2629,12 @@ proc askrelhighlight {row id} {
 
     if {![info exists selectedline]} return
     set isbold 0
-    if {$highlight_related eq [mc "Descendent"] ||
-	$highlight_related eq [mc "Not descendent"]} {
+    if {$highlight_related eq [mc "Descendant"] ||
+	$highlight_related eq [mc "Not descendant"]} {
 	if {![info exists descendent($id)]} {
 	    is_descendent $id
 	}
-	if {$descendent($id) == ($highlight_related eq [mc "Descendent"])} {
+	if {$descendent($id) == ($highlight_related eq [mc "Descendant"])} {
 	    set isbold 1
 	}
     } elseif {$highlight_related eq [mc "Ancestor"] ||
-- 
1.5.3.4.206.g58ba4
