From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] rebase -m: Fix incorrect short-logs of already applied commits.
Date: Sat, 1 Sep 2007 14:11:10 +0200
Message-ID: <200709011411.10915.robin.rosenberg.lists@dewire.com>
References: <200709010925.27926.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Sep 01 14:09:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRRnL-0005mi-L7
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 14:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbXIAMJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 08:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbXIAMJh
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 08:09:37 -0400
Received: from [83.140.172.130] ([83.140.172.130]:5281 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbXIAMJh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Sep 2007 08:09:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1C8D0802849;
	Sat,  1 Sep 2007 14:01:44 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17464-06; Sat,  1 Sep 2007 14:01:43 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id C095380264D;
	Sat,  1 Sep 2007 14:01:43 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <200709010925.27926.johannes.sixt@telecom.at>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57273>


Just so we know what the '-m' is from the documentation.

-- robin

>From b4fd5fca1aa45183c04327a29ee98d01a4e76e59 Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Sat, 1 Sep 2007 13:52:26 +0200
Subject: [PATCH] Mention -m as an abbreviation for --merge

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 Documentation/git-rebase.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a1b6dce..cb87b03 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,7 +8,7 @@ git-rebase - Forward-port local commits to the updated upstream head
 SYNOPSIS
 --------
 [verse]
-'git-rebase' [-i | --interactive] [-v | --verbose] [--merge] [-C<n>]
+'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge] [-C<n>]
 	[-p | --preserve-merges] [--onto <newbase>] <upstream> [<branch>]
 'git-rebase' --continue | --skip | --abort
 
@@ -188,7 +188,7 @@ OPTIONS
 --skip::
 	Restart the rebasing process by skipping the current patch.
 
---merge::
+-m, \--merge::
 	Use merging strategies to rebase.  When the recursive (default) merge
 	strategy is used, this allows rebase to be aware of renames on the
 	upstream side.
-- 
1.5.3.rc7.844.gfd3c5
