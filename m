From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git-gui: Fix switch statement in lib/merge.tcl
Date: Wed, 08 Oct 2008 10:03:54 +0200
Message-ID: <48EC696A.1000300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Alexander Gavrilov <angavrilov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 08 10:07:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnU3L-000772-PA
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 10:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbYJHID7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 04:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbYJHID6
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 04:03:58 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:40367 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbYJHID5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 04:03:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KnU1S-0001p6-Mi; Wed, 08 Oct 2008 10:03:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 70A576B7; Wed,  8 Oct 2008 10:03:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97784>

From: Johannes Sixt <johannes.sixt@telecom.at>

0aea2842 (Make Ctrl-T safe to use for conflicting files) introduced a new
case, but forgot the '-' to indicate that it shares the body with the
subsequent case label.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 lib/merge.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/merge.tcl b/lib/merge.tcl
index ac4c7de..283e491 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -40,7 +40,7 @@ The rescan will be automatically started now.
 		_O {
 			continue; # and pray it works!
 		}
-		_U
+		_U -
 		U? {
 			error_popup [mc "You are in the middle of a conflicted merge.

-- 
1.6.0.2.1596.g729fb
