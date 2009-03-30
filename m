From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] gitk: Map KP_Divide to focus the search box
Date: Mon, 30 Mar 2009 14:55:21 +0200
Message-ID: <200903301455.21721.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Mar 30 21:21:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoN2R-0001L8-PR
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 21:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759778AbZC3TSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 15:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759765AbZC3TSq
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 15:18:46 -0400
Received: from smtp.katamail.com ([62.149.157.154]:57874 "HELO smtp2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1759748AbZC3TSp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 15:18:45 -0400
Received: (qmail 4824 invoked by uid 89); 30 Mar 2009 19:18:33 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host177-57-dynamic.104-80-r.retail.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.177)
  by smtp2-pc with SMTP; 30 Mar 2009 19:18:32 -0000
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115187>

Commit 97bed034 changed the behavior of the '/' key on the keyboard,
but the '/' on the keypad was left unused. They now both do the same
thing.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index a7294a1..3835a51 100755
--- a/gitk
+++ b/gitk
@@ -2313,6 +2313,7 @@ proc makewindow {} {
     bindkey d "$ctext yview scroll 18 units"
     bindkey u "$ctext yview scroll -18 units"
     bindkey / {focus $fstring}
+    bindkey <Key-KP_Divide> {focus $fstring}
     bindkey <Key-Return> {dofind 1 1}
     bindkey ? {dofind -1 1}
     bindkey f nextfile
-- 
1.6.2.22.gc2ac
