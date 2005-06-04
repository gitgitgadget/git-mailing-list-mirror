From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 6/10] Remove the catch all rule
Date: Sat, 4 Jun 2005 16:41:31 +0200
Message-ID: <20050604144131.GJ12615@diku.dk>
References: <20050604143831.GD12615@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 16:38:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeZmv-0005YM-Rp
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 16:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVFDOlf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 10:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVFDOlf
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 10:41:35 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:23807 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261360AbVFDOlc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 10:41:32 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 248426E2477; Sat,  4 Jun 2005 16:40:51 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 27AE76E235E; Sat,  4 Jun 2005 16:40:51 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 450B961FE0; Sat,  4 Jun 2005 16:41:31 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050604143831.GD12615@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

All commit header entries are already be handled so no need for a default
case pattern.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-log |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -219,11 +219,7 @@ $revls | $revsort | while read time comm
 					s/./    &/
 				'
 				;;
-			*)
-				echo $colheader$key $rest $coldefault
-				;;
 			esac
-
 		done
 	echo
 done | pager
-- 
Jonas Fonseca
