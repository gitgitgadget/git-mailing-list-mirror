From: Bryan Drewery <bryan@shatow.net>
Subject: [PATCH] Fix misleading wording for git-cherry-pick
Date: Wed, 19 Nov 2008 23:11:42 -0600
Message-ID: <4924F18E.5070100@shatow.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 20 06:50:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L32Qr-0006TZ-Jp
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 06:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbYKTFtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 00:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbYKTFtJ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 00:49:09 -0500
Received: from data.xzibition.com ([64.18.130.122]:50100 "EHLO
	data.xzibition.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbYKTFtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 00:49:09 -0500
X-Greylist: delayed 2238 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Nov 2008 00:49:08 EST
Received: from 209-240-91-84.static.iphouse.net
	([209.240.91.84] helo=[10.10.0.2] ident=bryan)
	by data.xzibition.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <bryan@shatow.net>)
	id 1L31pg-0000mE-Sa; Thu, 20 Nov 2008 00:12:00 -0500
User-Agent: Thunderbird 2.0.0.17 (X11/20081015)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - data.xzibition.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [26 6] / [26 6]
X-AntiAbuse: Sender Address Domain - shatow.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation for -n implies that -x is normally
used, however this is no longer true.

Signed-off-by: Bryan Drewery <bryan@shatow.net>
---
 Documentation/git-cherry-pick.txt |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt
b/Documentation/git-cherry-pick.txt
index 837fb08..b764130 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -55,13 +55,12 @@ OPTIONS

 -n::
 --no-commit::
-	Usually the command automatically creates a commit with
-	a commit log message stating which commit was
-	cherry-picked.  This flag applies the change necessary
-	to cherry-pick the named commit to your working tree
-	and the index, but does not make the commit.  In addition,
-	when this option is used, your index does not have to match
-	the HEAD commit.  The cherry-pick is done against the
+	Usually the command automatically creates a commit.
+	This flag applies the change necessary to cherry-pick
+	the named commit to your working tree and the index,
+	but does not make the commit.  In addition, when this
+	option is used, your index does not have to match the
+	HEAD commit.  The cherry-pick is done against the
 	beginning state of your index.
 +
 This is useful when cherry-picking more than one commits'
-- 
1.5.6.4
