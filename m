From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Thu, 08 Nov 2007 10:33:42 +0100
Message-ID: <4732D7F6.7040006@op5.se>
References: <20071104112302.GA2119@ins.uni-bonn.de> <11944722214046-git-send-email-prohaska@zib.de> <4732B899.6000908@viscovery.net> <6E62E205-0951-4CCB-A807-AC107E40ACE1@zib.de> <4732D2CC.1010008@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>, gitster@pobox.com,
	Ralf.Wildenhues@gmx.de, tsuna@lrde.epita.fr, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:34:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3m7-0003BA-7f
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbXKHJdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbXKHJdr
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:33:47 -0500
Received: from mail.op5.se ([193.201.96.20]:56350 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbXKHJdq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:33:46 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 563801F0870E;
	Thu,  8 Nov 2007 10:33:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vgu+Y8HE+7k1; Thu,  8 Nov 2007 10:33:20 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 250BC1F0870D;
	Thu,  8 Nov 2007 10:33:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <4732D2CC.1010008@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63977>

Johannes Sixt wrote:
> Steffen Prohaska schrieb:
>>
>> On Nov 8, 2007, at 8:19 AM, Johannes Sixt wrote:
>>
>>> Steffen Prohaska schrieb:
>>>> +If you linearize the history by rebasing the lower branch on
>>>> +top of the upper, instead of merging, the bug becomes much easier to
>>>> +find and understand.  Your history would instead be:
>>>
>>> At this point I'm missing the words
>>>
>>>     The solution is ...
>>>
>>> I.e.:
>>>
>>> The solution is to linearize the history by rebasing the lower branch on
>>> top of the upper, instead of merging. Now the bug becomes much easier to
>>> find and understand.  Your history would instead be:
>>
>> Hmm. It might be a solution if you did not publish history.
> 
> This is about finding the commit that introduced a bug. Once you found 
> it, better: you know how to fix the bug, you are expected to throw away 
> the rebased branch, not to publish it! Maybe a note along these lines 
> could be appended:
> 
> Now that you know what caused the error (and how to fix it), throw away 
> the rebased branch, and commit a fix on top of D.
> 

Well, if rebasing becomes the standard for normal development, it's hardly
right to throw it away, is it? I like Steffen's suggestion better.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
