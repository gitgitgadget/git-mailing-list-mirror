From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Prefer $EMAIL over auto-generated user@hostname.
Date: Fri, 06 Jul 2007 10:51:21 -0500
Message-ID: <468E64F9.9080805@nrlssc.navy.mil>
References: <468E59B3.7080007@nrlssc.navy.mil> <20070706151145.GA15341@informatik.uni-freiburg.de> <468E5E31.8040504@nrlssc.navy.mil> <Pine.LNX.4.64.0707061631560.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	torvalds@linux-foundation.org, gitster@pobox.com,
	mkraai@beckman.com, madcoder@debian.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 17:53:13 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6q7J-00038L-K0
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 17:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761590AbXGFPw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 11:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbXGFPw6
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 11:52:58 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40760 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761325AbXGFPw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 11:52:57 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l66FndiB027693;
	Fri, 6 Jul 2007 10:49:42 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Jul 2007 10:51:22 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <Pine.LNX.4.64.0707061631560.4093@racer.site>
X-OriginalArrivalTime: 06 Jul 2007 15:51:22.0105 (UTC) FILETIME=[801B7E90:01C7BFE5]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15280000
X-TM-AS-Result: : Yes--11.400500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY3MC03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDU1NS03MDAzMjQtNzAwNjE4LTcwMTQ2MS03?=
	=?us-ascii?B?MDM4MjktNzAxNzE3LTE4ODAxOS03MDE1NzYtNzAzNzg4LTcwMDE1?=
	=?us-ascii?B?My03MDgyNTctNzAyNzI2LTcwNjczNy03MDI4NjUtMTEzMjU2LTcw?=
	=?us-ascii?B?NDMzOS0xMDY2NDAtNzExNjA4LTcwMDY0OC0xNDgwNTEtMjAwNDM=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51767>

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 6 Jul 2007, Brandon Casey wrote:
> 
>> Uwe Kleine-K?nig wrote:
>>> Hello Brandon,
>>>
>>> Brandon Casey wrote:
>>>>  	struct passwd *pw = NULL;
>>>> +        char *email;
>>> Indention error. Otherwise it looks good (just from reading the patch).
>> huh. It doesn't look like that in my mail reader.
>> I have
>>         struct passwd...
>> +        char *email;
>>
>> and the patch applied cleanly when I saved the email and applied it
>> using git-am
>>
>>   cat git_email.patch | git-am
> 
> Yes, it applies cleanly. But it has 8 spaces before "char *email", not a 
> tab (otherwise it would be lined up with "struct passwd").

Ahh. I have expandtab set in .vimrc
This wouldn't happen to be part of the war on white space? converting
spaces to tabs where applicable?

Is the recommended tab stop 8 characters as it is for linux? or 4?

-brandon
