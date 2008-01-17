From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git fetch+rebase on a local tracking branch
Date: Thu, 17 Jan 2008 11:33:06 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0801171129430.31161@torch.nrlssc.navy.mil>
References: <6C0A045B-658F-4ECE-93DB-A61F77AAA1F8@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 18:33:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFYcX-0000Yp-1A
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 18:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbYAQRdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 12:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbYAQRdM
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 12:33:12 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42584 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbYAQRdL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 12:33:11 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0HHX63P008876;
	Thu, 17 Jan 2008 11:33:06 -0600
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 17 Jan 2008 11:33:06 -0600
In-Reply-To: <6C0A045B-658F-4ECE-93DB-A61F77AAA1F8@sb.org>
X-OriginalArrivalTime: 17 Jan 2008 17:33:06.0641 (UTC) FILETIME=[053F0410:01C8592F]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--10.792800-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDYyNi03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMzc4OC03MDY4OTEtNzA0ODg1LTcwOTU4NC03?=
	=?us-ascii?B?MDE1OTAtNzA0MjQwLTcwODMzOS03MDc0NTEtNzAxNDM3LTcwOTE4?=
	=?us-ascii?B?NS03MDM5NjktNzAxMjUzLTE4ODAxOS0xNDgwMzktMTQ4MDUwLTIw?=
	=?us-ascii?B?MDQw?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70878>

On Thu, 17 Jan 2008, Kevin Ballard wrote:

> When I'm working on a local tracking branch, is there an easier way to do 
> `git fetch && git rebase origin/branch`? I could imagine either a config 
> value like branch.master.rebase = remotes/origin/master (although it would be 
> nice to avoid duplicating the remote name, since we already have 
> branch.master.remote), or perhaps a --rebase command to git pull such that it 
> simply performs a rebase instead of a merge.
>
> Is there some reason there isn't already a solution like this, or am I simply 
> missing something?

It exists in master.

commit cd67e4d46b122b161f2ad7d943e4ae7aa8df6cf5
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Wed Nov 28 13:11:07 2007 +0000

     Teach 'git pull' about --rebase

...

-brandon
