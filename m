From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Sat, 12 Nov 2005 12:37:21 +0100
Message-ID: <4375D3F1.2070506@op5.se>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43730E39.6030601@pobox.com> <43737F9E.60703@zytor.com> <437392AD.20906@op5.se> <43750A53.9090602@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 12 12:38:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EathR-0005ZF-CN
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 12:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVKLLhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 06:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVKLLhX
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 06:37:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:60852 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932352AbVKLLhX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 06:37:23 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 1232E6BD02
	for <git@vger.kernel.org>; Sat, 12 Nov 2005 12:37:22 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <43750A53.9090602@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11671>

H. Peter Anvin wrote:
> Andreas Ericsson wrote:
> 
>>>
>>> It's nice in concept, but I think there are a lot of reasons why this 
>>> is a bad idea:
>>>
>>> - "man" doesn't handle it.  It would be another thing if "man" could 
>>> be taught to understand commands like "man cvs checkout" or "man git 
>>> fetch".
>>
>>
>> This is moot. man-pages can still be named git-fetch.
>>
> 
> Yes, of course, but that requires the user to be aware of yet another 
> program-specific convention.  I do believe that supporting hierarchial 
> man pages would be a good thing, but one has to start that in the proper 
> point.
> 

Someone sent in a (broken) patch that pulls up the proper man-page for
	git help <command>

It's a rather good idea, so I'll be working it into the C implementation 
of git as soon as the core of it is implemented.

>>> - There is no general way to teach shells etc about it, for tab 
>>> completion etc.
>>
>>
>> Add the lib directory to the path (for git-<tab><tab>) or have it 
>> auto-evaluate the result of a git command-listing.
> 
> 
> ... which means the end user has to do something specific to their 
> environment.
> 
> All in all, I think the negatives outweigh the positives.
> 

Perhaps, but allowing the possibility of splitting them can't be wrong. 
When that's in place we only have to decide if we're going to or not.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
