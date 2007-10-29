From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Bisect: add "skip" to the short usage string.
Date: Mon, 29 Oct 2007 05:31:52 +0100
Message-ID: <20071029053153.fe400886.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 05:25:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImMBm-0005eF-2s
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 05:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbXJ2EZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 00:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbXJ2EZF
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 00:25:05 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:40306 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbXJ2EZD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 00:25:03 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B63741AB2BA;
	Mon, 29 Oct 2007 05:24:58 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 7BBA51AB2B2;
	Mon, 29 Oct 2007 05:24:58 +0100 (CET)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62597>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 180c6c2..f2bae53 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[start|bad|good|next|reset|visualize|replay|log|run]'
+USAGE='[start|bad|good|next|reset|visualize|replay|log|skip|run]'
 LONG_USAGE='git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
         reset bisect state and start bisection.
 git bisect bad [<rev>]
-- 
1.5.3.4.1406.g1369
