From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Sun, 14 Oct 2007 00:36:27 +0200
Message-ID: <4711486B.1050301@op5.se>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv> <470DC05A.8020209@viscovery.net> <92879AC5-2927-439B-8EB0-AC20AAEE412E@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 00:37:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igpbo-00047p-R7
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 00:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762716AbXJMWgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 18:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762684AbXJMWgf
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 18:36:35 -0400
Received: from mail.op5.se ([193.201.96.20]:42071 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762392AbXJMWgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 18:36:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 23219173065D;
	Sun, 14 Oct 2007 00:36:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g5QmB0liqspM; Sun, 14 Oct 2007 00:36:29 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id BF5C6173064A;
	Sun, 14 Oct 2007 00:36:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <92879AC5-2927-439B-8EB0-AC20AAEE412E@steelskies.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60784>

Jonathan del Strother wrote:
> On 11 Oct 2007, at 07:19, Johannes Sixt wrote:
> 
>>> -     git-commit -F msg -m amending ."
>>> +    git-commit -F msg -m amending ."
>>
>> You fix whitespace...
>>
>>>  test_expect_success \
>>> -    "using message from other commit" \
>>> -    "git-commit -C HEAD^ ."
>>> +     "using message from other commit" \
>>> +     "git-commit -C HEAD^ ."
>>
>> ... and you break it. More of these follow. Don't do that, it makes 
>> patch review unnecessarily hard.
> 
> 
> I'm just preparing to release this patch... was that "don't break 
> whitespace", or "don't try to fix whitespace in a patch that's has 
> nothing to do with whitespacing-fixing" ?
> 

Both, I think ;-)

> And while I'm here - tabs are preferred, are they?  There seem to be a 
> mixture of tabs & 4 space indentation.

1 hard tab / level of indent, but use spaces for continuation alignment.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
