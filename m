From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 13:05:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz>
References: <200704171041.46176.andyparkins@gmail.com><"200704171803.58940.a
 n  dyparkins"@gmail.com><200704172012.31280.andyparkins@gmail.com><alpine.LFD.
 0.98.0704171530220.4504@xanadu.home><Pine.LNX.4.63.0704171244450.1696@qynat
 .qvtvafvgr.pbz> <alpine.LFD.0.98.0704171624190.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 22:37:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HduQe-0001tN-ES
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 22:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbXDQUh2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 16:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbXDQUh2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 16:37:28 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:42692 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752277AbXDQUh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 16:37:27 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 17 Apr 2007 13:37:26 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 17 Apr 2007 13:37:08 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <alpine.LFD.0.98.0704171624190.4504@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44819>

On Tue, 17 Apr 2007, Nicolas Pitre wrote:

> On Tue, 17 Apr 2007, David Lang wrote:
>
>> On Tue, 17 Apr 2007, Nicolas Pitre wrote:
>>
>>> I cannot do otherwise than ask at this point in the debate: why isn't
>>> the makefile rule sufficient for your needs?  Why going through a
>>> complicated path that no one else will support due to its numerous
>>> pitfalls?
>>
>> not all uses of VCS's involve useing make
>
> Use perl then.  Or a shell script.  Or even a command.com batch script.
> Or your own tool.

I would like to, however this doesn't currently integrate well with git. I've 
been told in the past that once .gitattributes is in place then the hooks for 
the crlf stuff can be generalized to allow for calls out to custom code to do 
this sort of thing.

however now it sounds as if people are saying that doing this is so evil that it 
shouldn't ever be allowed.

>>>> That's just being obtuse - no other tool cares in the slightest about
>>>> the keywords, there are more "tools" in the world than just the VCS.
>>>
>>> ... which reinforces my question: why force a task on the VCS if it
>>> doesn't fit well with its fundamental design?
>>
>> becouse the VCS can do the job better then anything else?
>
> On what basis?
>
>> even if there are
>> limits to what the VCS can do.
>
> In the context of keyword expansion I don't agree at all with this
> statement.  Git can *not* do better than an external tool and it has
> been demonstrated a few times already.

the VCS can make sure that the appropriate external code is always run when 
things are checked in/out. external tools (unless they are a complete set of 
wrappers for git) can't do that.

David Lang
