From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-format-patch Date header
Date: Sun, 08 Jan 2006 16:44:41 +0100
Message-ID: <43C13369.4090809@op5.se>
References: <20060108141457.8C4E85BE8F@nox.op5.se>	<20060108164038.89e4439f.tihirvon@gmail.com>	<43C12DE9.8010906@op5.se> <20060108173736.199df297.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 16:44:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evcir-0008Ph-It
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 16:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbWAHPon (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 10:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbWAHPon
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 10:44:43 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:11652 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1752642AbWAHPom
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 10:44:42 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 5743F6BCBE; Sun,  8 Jan 2006 16:44:41 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060108173736.199df297.tihirvon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14324>

Timo Hirvonen wrote:
> On Sun, 08 Jan 2006 16:21:13 +0100
> Andreas Ericsson <ae@op5.se> wrote:
> 
> 
>>Timo Hirvonen wrote:
>>
>>>git-format-patch uses "date '+%s %z'" format for the Date header.
>>>Sylpheed does not understand this format.  How common this convention
>>>is?  Should we change git-format-patch to use more standard date format?
>>>
>>>OTOH, I like the %s format because it is so simple and easy to parse :)
>>>
>>
>>Actually, that's what's printed in the commit message, so any change 
>>would have to be put there and that would break backwards compatibility 
>>for new tools that might want to use it.
> 
> 
> So fixing Sylpheed (and maybe other email clients too) is the right
> solution...
> 

Nopes. In this case fixing my home-hacked git-send-patch script is the 
right thing to do. git-format-patch has always printed that format, 
though, so the error lies with me and the patch I sent. I shall have to 
re-visit it after reading rfc 822 a bit more closely.

> 
>>On an unrelated note, please don't start a new thread by replying to an 
>>old message. It's very confusing to follow and people may not see your 
>>message. This time it was doubly so because the next mail in my inbox is 
>>a patch for git-format-patch, to which I thought you replied.
> 
> 
> Sorry.  I replied to your message because it was the message having Date
> header in the "%s %z" format.
> 

I just noticed. Thanks, and sorry.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
