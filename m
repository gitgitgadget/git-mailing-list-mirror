From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: git merge --no-commit <branch>; does commit
Date: Sat, 15 Dec 2007 19:14:48 +0100 (CET)
Message-ID: <alpine.LSU.0.99999.0712151905280.4341@castor.milkiway.cos>
References: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos> <81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com> <alpine.LSU.0.99999.0712132224280.5606@castor.milkiway.cos> <20071214074925.GA3525@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 19:15:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3bXo-0001kc-FB
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 19:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbXLOSPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 13:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754017AbXLOSPA
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 13:15:00 -0500
Received: from mailout09.sul.t-online.de ([194.25.134.84]:48185 "EHLO
	mailout09.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751933AbXLOSO7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Dec 2007 13:14:59 -0500
Received: from fwd26.aul.t-online.de 
	by mailout09.sul.t-online.com with smtp 
	id 1J3bXN-0004e8-01; Sat, 15 Dec 2007 19:14:57 +0100
Received: from [192.168.2.100] (ZeN-FgZpghm7t9h6ZilTh8YfltlRw-TL5rkWFILCrQxAziL5l4Wc75fuQOtWP7GwMl@[84.163.225.74]) by fwd26.t-online.de
	with esmtp id 1J3bXE-07JAbA0; Sat, 15 Dec 2007 19:14:48 +0100
X-X-Sender: michael@castor.milkiway.cos
In-Reply-To: <20071214074925.GA3525@steel.home>
User-Agent: Alpine 0.99999 (LSU 796 2007-11-08)
X-ID: ZeN-FgZpghm7t9h6ZilTh8YfltlRw-TL5rkWFILCrQxAziL5l4Wc75fuQOtWP7GwMl
X-TOI-MSGID: 3a03e54e-bac9-4576-85da-b84395363f99
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68403>



On Fri, 14 Dec 2007, Alex Riesen wrote:

> Michael Dressel, Thu, Dec 13, 2007 22:28:30 +0100:
>> On Thu, 13 Dec 2007, Alex Riesen wrote:
>>> On 13/12/2007, Michael Dressel wrote:
>>>> git merge --no-commit <branch> does "create" a commit. At lesat the
>>>> head and index are moved to the new commit fetched from <branch>. Maybe
>>>> that is because git was able to do a fast forward?
>>>
>>> Yes. Because fast-forward is what it called: fast-forward.
>>> It does not do any commits at all.
>>>
>>
>> It looks like I misunderstood the meaning of --no-commit. I have to use
>> --squash in this case.
>>
>
> Maybe. Or maybe you misunderstood the meaning of --squash, which also
> is not a merge.

Since "git merge --squash <branch>" does a merge of <branch> into the 
working tree why would you not call it a merge?
Anyway that was what I wanted. Merging <branch> (a topic branch) into my 
current branch (the main branch) but being able to create commits that are
more suitable for keeping in the history of the current branch than the
commits I created during developing on <branch>.
Would you recommend a different way of doing this?

Thank you,
Michael
