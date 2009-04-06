From: Joerg Bornemann <joerg.bornemann@web.de>
Subject: [PATCH] git-gui: fix use of undeclared variable diff_empty_count
Date: Mon, 06 Apr 2009 21:59:28 +0200
Message-ID: <49DA5F20.4030800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 22:07:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqv0G-0006Af-JM
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 22:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbZDFT7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 15:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbZDFT7Y
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 15:59:24 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:37088 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbZDFT7X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 15:59:23 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id D62F6FC91549
	for <git@vger.kernel.org>; Mon,  6 Apr 2009 21:59:21 +0200 (CEST)
Received: from [92.225.83.154] (helo=[192.168.1.3])
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LquyW-0003nX-00
	for git@vger.kernel.org; Mon, 06 Apr 2009 21:59:20 +0200
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Sender: joerg.bornemann@web.de
X-Provags-ID: V01U2FsdGVkX1/mzuP0ToLh144AJDNriVZnnvieC9csrIPXWCK/
	ENV/fKcafAYWDMA8avFEIYLs4mkZfetnJAQGzDwGDhbF4LNR4Q
	VpeuKV6hGpRrpd3J5RwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115875>

Commit 584fa9cc introduced the global variable diff_empty_count, which
is used in diff.tcl. This variable wasn't declared anywhere which
resulted in an ugly error message box instead of the intended
informative message.

Signed-off-by: Joerg Bornemann <joerg.bornemann@web.de>
---
  git-gui.sh |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index e4a9230..46b056f 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1131,6 +1131,7 @@ set current_diff_path {}
  set is_3way_diff 0
  set is_conflict_diff 0
  set selected_commit_type new
+set diff_empty_count 0

  set nullid "0000000000000000000000000000000000000000"
  set nullid2 "0000000000000000000000000000000000000001"
--
1.6.0.2.1172.ga5ed0
