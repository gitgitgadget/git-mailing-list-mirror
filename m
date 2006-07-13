From: Robert Shearman <rob@codeweavers.com>
Subject: Re: [PATCH] format-patch: Generate a newline between the subject
 header and the message body.
Date: Thu, 13 Jul 2006 22:55:30 +0100
Organization: CodeWeavers
Message-ID: <44B6C152.8000204@codeweavers.com>
References: <44B6369D.6070602@codeweavers.com>	<7vbqrtur8q.fsf@assigned-by-dhcp.cox.net> <7v7j2huqfj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 23:56:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G19AL-0003nI-C7
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 23:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWGMV4K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 17:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWGMV4K
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 17:56:10 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:5565 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1030419AbWGMV4J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 17:56:09 -0400
Received: from host86-141-83-116.range86-141.btcentralplus.com ([86.141.83.116] helo=[172.16.0.10])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G19AG-0000Yt-6K; Thu, 13 Jul 2006 16:56:08 -0500
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j2huqfj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23859>

Junio C Hamano wrote:

>Junio C Hamano <junkio@cox.net> writes:
>
>  
>
>>Robert Shearman <rob@codeweavers.com> writes:
>>
>>    
>>
>>>This patch inserts a newline in two places - once in the loop to
>>>separate the subject part of the commit message from the body part of
>>>the commit message and another after the loop to counteract the eating
>>>of whitespace at the end of the message.
>>>      
>>>
>>Thanks.
>>
>> * Please sign your patch.
>>
>> * This breaks a handful t4013 tests, but all in a good way (in
>>   other words, the expected output files were wrong).
>>
>>I'll fix up the t/t4013/diff.* files myself.
>>    
>>
>
>Actually, I take that back.  This breaks normal commit log
>messages by adding extra blank lines.  The extra LF is needed
>when the commit log does not have any message (just title).
>  
>

Ok, I'll resend with that fixed.

>I'll be tweaking a few tests in t4013 to catch future breakage
>of this kind.
>

Thanks.

-- 
Rob Shearman
