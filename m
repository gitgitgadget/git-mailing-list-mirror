From: David Lang <david.lang@digitalinsight.com>
Subject: Re: git-index-pack really does suck..
Date: Fri, 6 Apr 2007 15:28:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704061526280.24050@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0704031413200.6730@woody.linux-foundation.org><alpine.LFD.0.
 98.  0704031836350.28181@xanadu.home><Pine.LNX.4.63.0704031532390.21680@qynat.qv
  tvafvgr.pbz><81b0412b0704040251j34b0bc5eh1518eadcfa2ed299@mail.gmail.com>
  <Pine.LNX.4.63.0704061455380.24050@qynat.qvtvafvgr.pbz><7vslbdi0hf.fsf@assi
 gn  ed-by-dhcp.cox.net><7vlkh5i0e7.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.63.
 0704061521320.24050@qynat.qvtvafvgr.pbz> <7vhcrti04x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Alex Riesen <raa.lkml@gmail.com>, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 02:45:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZxOi-0001yl-Au
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 00:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933298AbXDFW7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 18:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933297AbXDFW7I
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 18:59:08 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:53018 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S933298AbXDFW7H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 18:59:07 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Fri, 6 Apr 2007 15:59:06 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Fri, 06 Apr 2007 15:57:39 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7vhcrti04x.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43942>

On Fri, 6 Apr 2007, Junio C Hamano wrote:

> David Lang <david.lang@digitalinsight.com> writes:
>
>> On Fri, 6 Apr 2007, Junio C Hamano wrote:
>>
>>> Subject: Re: git-index-pack really does suck..
>>>
>>> Junio C Hamano <junkio@cox.net> writes:
>>>
>>>> David Lang <david.lang@digitalinsight.com> writes:
>>>>
>>>>> On Wed, 4 Apr 2007, Alex Riesen wrote:
>>>>> ...
>>>>>> You never know what pull is networked (or should I say: remote enough
>>>>>> to cause a collision).
>>>>>
>>>>> so leave it on for all pulls, but for other commands don't turn it on.
>>>>>
>>>>> remember that the command that linus ran into at the start of the
>>>>> thread wasn't a pull.
>>>>
>>>> Are you referring to this command
>>>>
>>>>  $ git index-pack --stdin --fix-thin new.pack < .git/objects/pack/pack-*.pack
>>>>
>>>> in this message?
>>>
>>>  From: Linus Torvalds <torvalds@linux-foundation.org>
>>>  Subject: git-index-pack really does suck..
>>>  Date: Tue, 3 Apr 2007 08:15:12 -0700 (PDT)
>>>  Message-ID: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
>>>
>>> (sorry, chomped the message).
>>
>> probably (I useually don't keep the mail after I read or reply to it)
>
> Well, then you should remember that the command linus ran into
> was pretty much about pull, nothing else.
>
> The quoted command was only to illustrate what 'git-pull'
> invokes internally.  I do not think of any reason to use that
> command for cases other than 'git-pull'.  What's the use case
> you have in mind to run that command outside of the context of
> git-pull?

I guess I'm not remembering the thread accurately then (and/or am mising it up 
with a different thread). I thought that Linus had identified other cases that 
were impacted (something about proving that the object doesn't exist)

David Lang
