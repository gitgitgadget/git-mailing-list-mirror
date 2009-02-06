From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] Documentation: clarify commits affected by gitk --merge
Date: Fri, 6 Feb 2009 10:10:53 +0530
Message-ID: <20090206044053.GA6831@atcmail.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 06 06:15:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVJ3l-0005kf-16
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 06:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbZBFFNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 00:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbZBFFNi
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 00:13:38 -0500
Received: from atcmail.atc.tcs.co.in ([203.200.212.145]:59422 "EHLO
	atcmail.atc.tcs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbZBFFNi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 00:13:38 -0500
X-Greylist: delayed 1947 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Feb 2009 00:13:37 EST
Received: from atcmail.atc.tcs.com (atcmail.atc.tcs.com [127.0.0.1])
	by atcmail.atc.tcs.com (8.14.2/8.14.2) with ESMTP id n164etUu007274;
	Fri, 6 Feb 2009 10:10:55 +0530
Received: (from sitaram@localhost)
	by atcmail.atc.tcs.com (8.14.2/8.14.2/Submit) id n164erkU007273;
	Fri, 6 Feb 2009 10:10:53 +0530
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8928/Sat Jan 31 03:04:16 2009 on atcmail.atc.tcs.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on atcmail.atc.tcs.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108655>

Signed-off-by: Sitaram Chamarty <sitaramc@gmail.com>
---

I remember being confused by this some weeks ago and someone clarified, so I
thought I'd put it in.

 Documentation/gitk.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 4673a75..bd005bc 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -47,7 +47,8 @@ frequently used options.
 
 	After an attempt to merge stops with conflicts, show the commits on
 	the history between two branches (i.e. the HEAD and the MERGE_HEAD)
-	that modify the conflicted files.
+	that modify the conflicted files and do not exist on all the heads
+	being merged.
 
 --argscmd=<command>::
 	Command to be run each time gitk has to determine the list of
-- 
1.6.1
