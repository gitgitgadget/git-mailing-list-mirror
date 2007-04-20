From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: cherry-pick --since ?
Date: Fri, 20 Apr 2007 11:20:32 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0704201100050.4667@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 18:20:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hevql-0005Os-M4
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 18:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030891AbXDTQUi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 12:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030924AbXDTQUi
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 12:20:38 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48140 "EHLO
	mail1.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030891AbXDTQUh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 12:20:37 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail1.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l3KGKd5D007717
	for <git@vger.kernel.org>; Fri, 20 Apr 2007 11:20:42 -0500
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Apr 2007 11:20:32 -0500
X-OriginalArrivalTime: 20 Apr 2007 16:20:32.0678 (UTC) FILETIME=[D1B8FC60:01C78367]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15126001
X-TM-AS-Result: : Yes--5.608600-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjY4LTE0NzAxOC03MDk1?=
	=?us-ascii?B?ODQtNzA0NzgyLTEwNTA0MC03MDE1NzYtNzAyOTAwLTE4ODAxOS03?=
	=?us-ascii?B?MDUzODgtNzAwNDgxLTcwMjM1OC03MDM3MTItNzA0NDMwLTcwNTE3?=
	=?us-ascii?B?OC03MDM1MjktNzAxNjE4LTcwMTQzNy03MDU1ODQtNzAxMjM2LTcw?=
	=?us-ascii?B?Mzc4OC03MTAyMDctNzAzMDYxLTcwODMzOS0xODcwNjctMTA2MjMw?=
	=?us-ascii?B?LTcwMjA2Ny0xMjE4MjgtNzAwODgxLTE0ODA1MA==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45113>



Is there functionality to allow something akin to
a
    git cherry-pick --since <commit>

or maybe syntax similar to git cherry where the upstream, head,
and limit can be specified. Or the .. syntax would work.


Here's my use case:

Two branches, 'A' and 'B'.
'A' is the master branch.
'B' was forked some time ago and is in bug fix only mode.
Much of 'A' and 'B' are still the same, but there have been
   some intrusive changes made to 'A' that should not go into 'B'.
   This is also why I can't just pull from 'B'. rebase may work,
   but then of course all of the commit id's change.

When changes are made in 'B' I currently cherry-pick each commit
into 'A' (where possible). This can be tedious when there are many
commits. I can use git cherry to show me which commits should be
cherry-picked, it would be nice if I could cherry-pick a range of
commits.

I am not subscribed to the list so please cc me. I hope this is ok,
if not let me know and I will subscribe. I am only a casual read of
the list.

-brandon
