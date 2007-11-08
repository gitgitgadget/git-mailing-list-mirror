From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Thu, 8 Nov 2007 15:55:26 +0100
Message-ID: <217E7104-312D-4D0C-BC66-C4829779C216@zib.de>
References: <20071104112302.GA2119@ins.uni-bonn.de> <11944722214046-git-send-email-prohaska@zib.de> <4732B899.6000908@viscovery.net> <6E62E205-0951-4CCB-A807-AC107E40ACE1@zib.de> <4732D2CC.1010008@viscovery.net> <4732D7F6.7040006@op5.se> <4732DC98.70304@viscovery.net> <97F64156-A457-4BC1-84BE-108369FFD18C@zib.de> <47330D78.3040808@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, gitster@pobox.com,
	Ralf.Wildenhues@gmx.de, tsuna@lrde.epita.fr, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 08 15:56:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq8nR-0000R9-Ad
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 15:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758955AbXKHOzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 09:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758820AbXKHOzh
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 09:55:37 -0500
Received: from mailer.zib.de ([130.73.108.11]:35569 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758746AbXKHOzg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 09:55:36 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA8EsDFT029605;
	Thu, 8 Nov 2007 15:54:13 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA8Es8Rc003307
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 8 Nov 2007 15:54:08 +0100 (MET)
In-Reply-To: <47330D78.3040808@viscovery.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64033>


On Nov 8, 2007, at 2:22 PM, Johannes Sixt wrote:

> Steffen Prohaska schrieb:
>> On Nov 8, 2007, at 10:53 AM, Johannes Sixt wrote:
>>> The text that the patch amends is about bisecting history that  
>>> reveals that a merge commit breaks, which is not helpful, and  
>>> then how to find where and what and why the breakage really was  
>>> introduce.
>>>
>>> And the answer to "how to find" is to rebase and bisect in the  
>>> rebased history.
>> Do you use rebase like this in real life?
>
> Why is this relevant?

Well, I don't want to give recommendations that are not tested
in real life. Maybe the solution turns out to be less practical
than it should be theoretically.


> You've written a superb addendum to the user manual, but IT TALKS  
> ABOUT BISECTION, and is not a guideline when to use merges and when  
> to rebase.

BTW, I only took what Junio wrote during a recent discussion
on the list, polished it a bit and sent it as a patch. I'm
only the editor, not the original author. That doesn't mean
I wouldn't care about the text. I'm willing to improve the text.
But all the cheers really should go to Junio.


> It better not be meant as such. Consider an integrator who has just  
> merged two histories, both of which are available publically.  
> Pushing out a rebased history IS NOT AN OPTION. If the poor fellow  
> for the heck of it has no choice but to find the bogus commit, then  
> your instructions are worth a thousand bucks - even if the rebased  
> history is otherwise useless -, but any guidelines how to construct  
> histories are IRRELEVANT for his case.

Ok, I see your point. I'll mention these points.


>> But now I'm wondering if your suggestions of rebasing only for
>> locating the evil commit is feasible in reality. You may need
>> to solve a lot of merge conflicts if you rebase a larger part
>> of the history. If you do not have them in your rerere cache
>> this might be time consuming. ...
>
> During the rebase you will see the same conflicts that you also had  
> during the merge, even simpler ones (because they are - hopefully -  
> broken down into smaller pieces). If your merge was clean (as was  
> suggested in the patch), then you won't see a lot of conflicts  
> during the rebase, either.

Yeah. I'll try to mention this at an appropriate place.

	Steffen
