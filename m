From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Thu, 08 Nov 2007 14:22:00 +0100
Message-ID: <47330D78.3040808@viscovery.net>
References: <20071104112302.GA2119@ins.uni-bonn.de> <11944722214046-git-send-email-prohaska@zib.de> <4732B899.6000908@viscovery.net> <6E62E205-0951-4CCB-A807-AC107E40ACE1@zib.de> <4732D2CC.1010008@viscovery.net> <4732D7F6.7040006@op5.se> <4732DC98.70304@viscovery.net> <97F64156-A457-4BC1-84BE-108369FFD18C@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, gitster@pobox.com,
	Ralf.Wildenhues@gmx.de, tsuna@lrde.epita.fr, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 14:22:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq7L5-0001uN-LI
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 14:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492AbXKHNWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 08:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755339AbXKHNWL
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 08:22:11 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:9233 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755082AbXKHNWK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 08:22:10 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iq7K9-00062U-Eg; Thu, 08 Nov 2007 14:21:33 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C3EDA6B7; Thu,  8 Nov 2007 14:22:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <97F64156-A457-4BC1-84BE-108369FFD18C@zib.de>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64018>

Steffen Prohaska schrieb:
> 
> On Nov 8, 2007, at 10:53 AM, Johannes Sixt wrote:
>> The text that the patch amends is 
>> about bisecting history that reveals that a merge commit breaks, which 
>> is not helpful, and then how to find where and what and why the 
>> breakage really was introduce.
>>
>> And the answer to "how to find" is to rebase and bisect in the rebased 
>> history.
> 
> Do you use rebase like this in real life?

Why is this relevant?

You've written a superb addendum to the user manual, but IT TALKS ABOUT 
BISECTION, and is not a guideline when to use merges and when to rebase.

It better not be meant as such. Consider an integrator who has just merged 
two histories, both of which are available publically. Pushing out a rebased 
history IS NOT AN OPTION. If the poor fellow for the heck of it has no 
choice but to find the bogus commit, then your instructions are worth a 
thousand bucks - even if the rebased history is otherwise useless -, but any 
guidelines how to construct histories are IRRELEVANT for his case.

> But now I'm wondering if your suggestions of rebasing only for
> locating the evil commit is feasible in reality. You may need
> to solve a lot of merge conflicts if you rebase a larger part
> of the history. If you do not have them in your rerere cache
> this might be time consuming. ...

During the rebase you will see the same conflicts that you also had during 
the merge, even simpler ones (because they are - hopefully - broken down 
into smaller pieces). If your merge was clean (as was suggested in the 
patch), then you won't see a lot of conflicts during the rebase, either.

-- Hannes
