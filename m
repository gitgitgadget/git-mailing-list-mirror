From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git-branch -m interprets first argument differently when two
 are   supplied
Date: Thu, 14 Feb 2008 11:17:44 -0600
Message-ID: <47B477B8.5030209@nrlssc.navy.mil>
References: <47B3497A.9050703@nrlssc.navy.mil> <47B3EFC4.1020808@viscovery.net> <47B46C8E.5030905@nrlssc.navy.mil> <alpine.LSU.1.00.0802141648120.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:20:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPhkd-00022b-JE
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 18:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbYBNRTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 12:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbYBNRTZ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 12:19:25 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:32989 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbYBNRTY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 12:19:24 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1EHHuuQ032718;
	Thu, 14 Feb 2008 11:17:56 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 Feb 2008 11:17:44 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0802141648120.30505@racer.site>
X-OriginalArrivalTime: 14 Feb 2008 17:17:44.0483 (UTC) FILETIME=[8329DF30:01C86F2D]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15722001
X-TM-AS-Result: : Yes--11.172100-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDU5OC03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMjExMy03MDUxMDItNzAxNjE4LTcxMDk4OS03?=
	=?us-ascii?B?MDI3MjYtNzAyMDUwLTcwODE3OS03MDE1MDAtMTA2NjQwLTcwNDk4?=
	=?us-ascii?B?MC03MDM3MTItNzA1OTI3LTcxMTM4NS03MDA0NTQtNzAxNDU1LTcw?=
	=?us-ascii?B?MDQ3Ni03MDU5MDEtNzAyMzU4LTcwMzA4OC03MDc0NTEtNzA2ODkx?=
	=?us-ascii?B?LTcwNzIyNS03MDkwNjUtNzAwMTA3LTE0ODAzOS0xNDgwNTEtMjAw?=
	=?us-ascii?B?NDM=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73895>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 14 Feb 2008, Brandon Casey wrote:
> 
>> Johannes Sixt wrote:
>>> Brandon Casey schrieb:
>>>> The first non-option argument is interpreted differently depending on
>>>> whether one argument or two arguments have been supplied.
>>>>
>>>> 	git-branch -m [<oldbranch>] <newbranch>
>>>>
>>>> Has anyone considered whether this is inconsistent with how other
>>>> commands operate?
>>> Funny, I fell into this trap just yesterday and accidentally renamed
>>> my master branch to something else. IMO git-branch -m should take two
>>> arguments. Full stop.
>> Actually, I think the single argument case is unambiguous and I would
>> rather not give it up.
>>
>> It's the two argument case that both expects its arguments in a 
>> different order than other commands _and_ is dangerous in the case of 
>> -M.
> 
> The order was specifically requested, as "mv" also has that order.

Did you even read the original message? You point this out like it hasn't
already been mentioned.

The _point_ is that the order is _different_ than the order that other _git_
commands use. I give more weight to the relationship with other git commands
than to the relationship between the '-M' option and the 'mv' command. A
subcommand named 'mv' could have been used if a strong relationship was
supposed to be implied, something like 'git-branch mv <src> <dst>'. I'm not
sure the single argument case would have retained its intuitiveness in this case.

> And "-M" is always dangerous.

>Don't use it, if you don't know what you're
> doing.

Gee, thanks for the advice.

-brandon
