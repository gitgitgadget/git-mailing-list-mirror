From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Fri, 4 Jan 2008 10:36:01 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0801041030420.31161@torch.nrlssc.navy.mil>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 18:10:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAq3n-0004lN-3l
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 18:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbYADRJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 12:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753467AbYADRJv
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 12:09:51 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37105 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbYADRJu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 12:09:50 -0500
X-Greylist: delayed 1984 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jan 2008 12:09:50 EST
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m04Ga22x019794;
	Fri, 4 Jan 2008 10:36:02 -0600
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 4 Jan 2008 10:36:02 -0600
In-Reply-To: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
X-OriginalArrivalTime: 04 Jan 2008 16:36:02.0563 (UTC) FILETIME=[E4F76D30:01C84EEF]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15638001
X-TM-AS-Result: : Yes--3.094000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAzNzMxLTcwOTU4NC03MDkxMzctNzA4MzM5LTcwMzQ1NC03?=
	=?us-ascii?B?MDc0NTEtMTEzMjMwLTcwMDM5OC0xMDY0MjAtNzA4MTc5LTE0ODAz?=
	=?us-ascii?B?OS0xNDgwNTAtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69584>

On Fri, 4 Jan 2008, Marco Costalba wrote:

> Currently git-stash writes to stderr also if there is nothing to error
> out, also it would be very nice ;-) if git 'stash clear command' would
> support deleting of only one patch, so as example to write
>
> stg stash clear stash@{0}
>
> To remove only the last added.

Maybe it should be named 'drop'. 'drop' sounds better than
'clear' for this usage.

   git stash drop [<stash>]

Not sure how often such a command would be used though, so
it may not be worth it.

-brandon
