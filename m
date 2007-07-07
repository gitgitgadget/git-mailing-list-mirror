From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] stash: allow running from a subdirectory
Date: Sat, 7 Jul 2007 10:29:26 -0400
Message-ID: <20070707142925.GB19782@crux.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 07 16:29:42 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7BI5-0004Md-8E
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 16:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbXGGO33 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 10:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbXGGO32
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 10:29:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58279 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783AbXGGO32 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 10:29:28 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l67ETQWM012099;
	Sat, 7 Jul 2007 10:29:26 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l67ETQ0f021429;
	Sat, 7 Jul 2007 10:29:26 -0400
Received: from crux (crux.rdu.redhat.com [172.16.59.80])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l67ETQcL007936;
	Sat, 7 Jul 2007 10:29:26 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51816>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 git-stash.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 5c63ca5..eac5551 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -3,6 +3,7 @@
 
 USAGE='[ | list | show | apply | clear]'
 
+SUBDIRECTORY_OK=Yes
 . git-sh-setup
 require_work_tree
 
-- 
1.5.3.rc0.837.g4574c
