From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH MISC 1/1] Make gcc warning about empty if body go away.
Date: Thu, 08 Nov 2007 16:47:26 +0100
Message-ID: <47332F8E.8080309@op5.se>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org>	<1194430832-6224-2-git-send-email-madcoder@debian.org> <7vode57awg.fsf@gitster.siamese.dyndns.org> <4732CBD3.503@op5.se> <47332957.5050308@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:48:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq9c1-0003B3-Gd
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 16:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759454AbXKHPrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 10:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759478AbXKHPrg
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 10:47:36 -0500
Received: from mail.op5.se ([193.201.96.20]:36839 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756322AbXKHPrf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 10:47:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6037D1F08710;
	Thu,  8 Nov 2007 16:46:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5GM-HLQ+Su+k; Thu,  8 Nov 2007 16:46:56 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 5F0081F0870A;
	Thu,  8 Nov 2007 16:46:54 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <47332957.5050308@freescale.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64047>

Jon Loeliger wrote:
> Andreas Ericsson wrote:
> 
>>> +    if (active_cache_changed &&
>>> +        !write_cache(fd, active_cache, active_nr) && !close(fd))
>>> +        commit_locked_index(lock_file);
>>>      rollback_lock_file(lock_file);
>>>  }
>>>  
>>
>> Ack, obviously, as it no longer requires a comment to explain it, 
>> although
>> I'd prefer an empty line after commit_locked_index(lock_file); so as 
>> to not
>> confuse the rollback_lock_file() statement as being part of the 
>> conditional
>> path.
>>
>> First I thought the rollback_lock_file() was the *only* statement to the
>> condition, and everyone who uses 4 for tabsize) will have double trouble
>> since commit_locked_index(lock_file) aligns with the second line of the
>> condition.
>>
> 
> It's too bad this was confusing due to the lack of braces. :-)
> 

I found that slightly ironic too, since I really don't like overly bracey
code either. Just goes to show there are no rules without exceptions, I
guess.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
