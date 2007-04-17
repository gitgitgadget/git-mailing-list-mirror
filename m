From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 12:45:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz>
References: <200704171041.46176.andyparkins@gmail.com><200704171803.58940.an
 dyparkins@gmail.com><Pine.LNX.4.64.0704171107510.5473@woody.linux-foundatio
 n.org><200704172012.31280.andyparkins@gmail.com> <alpine.LFD.0.98.0704171530220.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 22:18:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdu8B-00048u-Cr
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 22:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161274AbXDQUSX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 16:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161282AbXDQUSX
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 16:18:23 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:36432 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1161274AbXDQUSW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 16:18:22 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 17 Apr 2007 13:18:22 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 17 Apr 2007 13:17:59 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <alpine.LFD.0.98.0704171530220.4504@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44815>

On Tue, 17 Apr 2007, Nicolas Pitre wrote:

> 
> On Tue, 17 Apr 2007, Andy Parkins wrote:
>
>> On Tuesday 2007, April 17, Linus Torvalds wrote:
>>
>>> Trust me. There's NO WAY IN HELL it will "work" in any other sense
>>> than "limp along and not be usable".
>>
>> Well I'm making progress, "limp along" is a significant step up from
>> impossible.  :-)
>>
>> Look, my primary objection to this is the SHOUTING about how impossible
>> it is even though I've tried to address every problem you've thrown at
>> me - I'm finding it really difficult to figure out why you're trying so
>> hard to dissuade me from even _trying_.  If it all goes wrong (as I
>> fully accept it might), so be it, I can live with that; I'll even be
>> happy to tell you you're right and I'm wrong.  Why is this such a
>> problem?
>>
>> Keywords are so hated by everyone that I doubt they would ever be
>> accepted into git - it's an intellectual exercise for me at this stage
>> really.
>
> I cannot do otherwise than ask at this point in the debate: why isn't
> the makefile rule sufficient for your needs?  Why going through a
> complicated path that no one else will support due to its numerous
> pitfalls?

not all uses of VCS's involve useing make

>>> Yes, you can make your "print it out" example work, but as alreadyt
>>> mentioned, you could have done that some other way, with a simple
>>> makefile rule, quite independently (and much better) than the SCM
>>> ever did.
>>
>> That's just being obtuse - no other tool cares in the slightest about
>> the keywords, there are more "tools" in the world than just the VCS.
>
> ... which reinforces my question: why force a task on the VCS if it
> doesn't fit well with its fundamental design?

becouse the VCS can do the job better then anything else? even if there are 
limits to what the VCS can do.

David Lang
