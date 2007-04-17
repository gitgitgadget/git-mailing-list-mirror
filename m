From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 13:53:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704171352280.1696@qynat.qvtvafvgr.pbz>
References: <200704171041.46176.andyparkins@gmail.com><"200704171803.58940.a
  n   dyparkins"@gmail.com><200704172012.31280.andyparkins@gmail.com><alpine.LFD.
 0.98.0704171530220.4504@xanadu.home><Pine.LNX.4.63.0704171244450.1696@qynat
 .qvtvafvgr.pbz><alpine.LFD.0.98.0704171624190.4504@xanadu.home><Pine.LNX.4.
 63.0704171302200.1696@qynat.qvtvafvgr.pbz> <alpine.LFD.0.98.0704171708360.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 23:25:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdvBN-0000n8-FN
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 23:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbXDQVZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 17:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbXDQVZp
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 17:25:45 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:41879 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751576AbXDQVZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 17:25:44 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 17 Apr 2007 14:25:44 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 17 Apr 2007 14:25:16 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <alpine.LFD.0.98.0704171708360.4504@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44832>

On Tue, 17 Apr 2007, Nicolas Pitre wrote:

> Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
> 
> On Tue, 17 Apr 2007, David Lang wrote:
>
>> On Tue, 17 Apr 2007, Nicolas Pitre wrote:
>>
>>> On Tue, 17 Apr 2007, David Lang wrote:
>>>
>>>> On Tue, 17 Apr 2007, Nicolas Pitre wrote:
>>>>
>>>>> I cannot do otherwise than ask at this point in the debate: why isn't
>>>>> the makefile rule sufficient for your needs?  Why going through a
>>>>> complicated path that no one else will support due to its numerous
>>>>> pitfalls?
>>>>
>>>> not all uses of VCS's involve useing make
>>>
>>> Use perl then.  Or a shell script.  Or even a command.com batch script.
>>> Or your own tool.
>>
>> I would like to, however this doesn't currently integrate well with git. I've
>> been told in the past that once .gitattributes is in place then the hooks for
>> the crlf stuff can be generalized to allow for calls out to custom code to do
>> this sort of thing.
>
> And I agree that this is a perfectly sensible thing to do.  The facility
> should be there for you to apply any kind of transformation with
> external tools on data going in or out from Git.  There are good and bad
> things you can do with such a facility, but at least it becomes your
> responsibility to screw^H^H^H^Hfilter your data and not something that
> is enforced by Git itself.

I'm pretty sure that hooks for an external helper would satisfy Andy with his 
keyword expanstion as well.

David Lang
