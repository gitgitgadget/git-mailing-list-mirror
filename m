From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Thu, 08 Nov 2007 10:11:40 +0100
Message-ID: <4732D2CC.1010008@viscovery.net>
References: <20071104112302.GA2119@ins.uni-bonn.de> <11944722214046-git-send-email-prohaska@zib.de> <4732B899.6000908@viscovery.net> <6E62E205-0951-4CCB-A807-AC107E40ACE1@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Ralf.Wildenhues@gmx.de, tsuna@lrde.epita.fr,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:12:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3Qi-0005YS-BP
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760609AbXKHJLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760607AbXKHJLr
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:11:47 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:60736 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760466AbXKHJLp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:11:45 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iq3Ps-0005nd-P7; Thu, 08 Nov 2007 10:11:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 707A06B7; Thu,  8 Nov 2007 10:11:40 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <6E62E205-0951-4CCB-A807-AC107E40ACE1@zib.de>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63970>

Steffen Prohaska schrieb:
> 
> On Nov 8, 2007, at 8:19 AM, Johannes Sixt wrote:
> 
>> Steffen Prohaska schrieb:
>>> +If you linearize the history by rebasing the lower branch on
>>> +top of the upper, instead of merging, the bug becomes much easier to
>>> +find and understand.  Your history would instead be:
>>
>> At this point I'm missing the words
>>
>>     The solution is ...
>>
>> I.e.:
>>
>> The solution is to linearize the history by rebasing the lower branch on
>> top of the upper, instead of merging. Now the bug becomes much easier to
>> find and understand.  Your history would instead be:
> 
> Hmm. It might be a solution if you did not publish history.

This is about finding the commit that introduced a bug. Once you found it, 
better: you know how to fix the bug, you are expected to throw away the 
rebased branch, not to publish it! Maybe a note along these lines could be 
appended:

Now that you know what caused the error (and how to fix it), throw away the 
rebased branch, and commit a fix on top of D.

-- Hannes
