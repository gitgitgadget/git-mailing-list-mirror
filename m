From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 11:31:37 -0500
Message-ID: <E5A7E6A8-45FF-4A7A-A31E-DFEBAD48DF1C@silverinsanity.com>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <7virfct737.fsf@assigned-by-dhcp.cox.net> <slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx> <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net> <B641F998-7DC1-404E-BDB8-7377F8516AB9@silverinsanity.com> <slrneqha0g.5sa.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 17:31:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5lnE-0001Kw-OW
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 17:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbXAMQbm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 11:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422706AbXAMQbm
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 11:31:42 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:55539 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422716AbXAMQbl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 11:31:41 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 3A4E11FFC02B;
	Sat, 13 Jan 2007 16:31:40 +0000 (UTC)
In-Reply-To: <slrneqha0g.5sa.Peter.B.Baumann@xp.machine.xx>
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36757>


On Jan 13, 2007, at 4:36 AM, Peter Baumann wrote:

> On 2007-01-13, Brian Gernhardt <benji@silverinsanity.com> wrote:
>>
>> On Jan 12, 2007, at 2:43 PM, Junio C Hamano wrote:
>>
>>> Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
>>> writes:
>>>
>>>> Me doesn't really like the new semantics of "git-add", because it
>>>> does
>>>> two seperate things - it adds new files and it refreshes the
>>>> content of
>>>> previously known files.
>>>
>>> http://thread.gmane.org/gmane.comp.version-control.git/32452/
>>> focus=32792
>>
>> Should this be added to Documentation/rants/filename-
>> braindamage.txt?  ;-)
>>
>> ~~ Brian
>
> Ok. Obviously I should't have said that it add "files" (gr, silly me).
> What I meant was it adds the content of files. But there is a  
> difference
> in adding and replacing content.

I was referring to adding Linus' rant...  And maybe several others.   
I tend to find his rants at least slightly amusing, highly  
informative, and I tend to end up agreeing.  I have very little  
opinion on your complaint so long as the system works consistently.   
"git commit -a" is still my most common workflow.  I've used git-add  
(and prior to that git-update-index) from time to time when I fix  
bugs that need to be separate from my current work, but far far more  
common is "I finished this chunk of functionality, add all the  
changes I did to make it happen".

~~ Brian
