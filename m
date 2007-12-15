From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: git merge --no-commit <branch>; does commit
Date: Sat, 15 Dec 2007 21:33:20 +0100 (CET)
Message-ID: <alpine.LSU.0.99999.0712152124220.5151@castor.milkiway.cos>
References: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos> <81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com> <alpine.LSU.0.99999.0712132224280.5606@castor.milkiway.cos> <20071214074925.GA3525@steel.home>
 <alpine.LSU.0.99999.0712151905280.4341@castor.milkiway.cos> <20071215193741.GB3021@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: B.Steinbrink@gmx.de, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 21:34:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3diH-0000u5-TZ
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 21:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757798AbXLOUdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 15:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757831AbXLOUdf
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 15:33:35 -0500
Received: from mailout09.sul.t-online.de ([194.25.134.84]:48534 "EHLO
	mailout09.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757610AbXLOUde (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Dec 2007 15:33:34 -0500
Received: from fwd33.aul.t-online.de 
	by mailout09.sul.t-online.com with smtp 
	id 1J3dhU-0002sP-00; Sat, 15 Dec 2007 21:33:32 +0100
Received: from [192.168.2.100] (Th9IuBZVghpTxqiLg0Q+ahz82UH1xYJr3q+gczEFbEqIEnElOlEZX+U4dFWZ-xKgzU@[84.163.243.66]) by fwd33.t-online.de
	with esmtp id 1J3dhJ-1kn2eG0; Sat, 15 Dec 2007 21:33:21 +0100
X-X-Sender: michael@castor.milkiway.cos
In-Reply-To: <20071215193741.GB3021@steel.home>
User-Agent: Alpine 0.99999 (LSU 796 2007-11-08)
X-ID: Th9IuBZVghpTxqiLg0Q+ahz82UH1xYJr3q+gczEFbEqIEnElOlEZX+U4dFWZ-xKgzU
X-TOI-MSGID: b016c00b-1b43-4836-94a3-3623e4855716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68414>



On Sat, 15 Dec 2007, Alex Riesen wrote:

> Michael Dressel, Sat, Dec 15, 2007 19:14:48 +0100:
>>> Maybe. Or maybe you misunderstood the meaning of --squash, which also
>>> is not a merge.
>>
>> Since "git merge --squash <branch>" does a merge of <branch> into the
>> working tree why would you not call it a merge?
>
> Because merge, in Git language, means connection histories. That one
> just mixes the text. That's different operation, kind of editing a
> file.

That's a nice clarification. In my case I wanted that "just mixes the 
text" thing because I did aggressively do commits during development 
trying out slightly different approaches and being able to go back to compare 
them. These different games are not interesting to keep in the history 
once a good solution has been found.

>
>> Anyway that was what I wanted. Merging <branch> (a topic branch) into my
>> current branch (the main branch) but being able to create commits that are
>> more suitable for keeping in the history of the current branch than the
>> commits I created during developing on <branch>.
>> Would you recommend a different way of doing this?
>
> I would not recommend doing it at all. If I must, I'd rather use
> git-rebase -i (interactive rebase).
>
>

Yes I didn't use rebase sofar. I should consider it sometimes.

Cheers,
Michael
