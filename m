From: david@lang.hm
Subject: Re: What's cooking in git.git (Sep 2008, #03; Fri, 19)
Date: Fri, 19 Sep 2008 16:43:13 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0809191636380.26104@asgard.lang.hm>
References: <7vprmzrh7w.fsf@gitster.siamese.dyndns.org> <200809200020.32285.trast@student.ethz.ch> <7vk5d7pxep.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 01:44:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgpe1-0006RH-W2
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 01:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbYISXnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 19:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbYISXnE
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 19:43:04 -0400
Received: from mail.lang.hm ([64.81.33.126]:38590 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbYISXnD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 19:43:03 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m8JNgKjw023562;
	Fri, 19 Sep 2008 16:42:20 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7vk5d7pxep.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96325>

On Fri, 19 Sep 2008, Junio C Hamano wrote:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Regarding _the_ recommended workflow, I can think of a few possible
>> approaches:
>>
>> a) Authoritative: either because we really believe it's the One True
>>    Workflow, or just because we want to sound so.
>>
>> b) Descriptive: describe it as the workflow "we" use (presumably this
>>    includes linux.git which may be worth mentioning; I haven't touched
>>    the kernel though).
>>
>> c) Encyclopedic: describe and classify as many recipes (building
>>    blocks) and workflows as possible in an attempt to build a
>>    complete reference of sorts.
>>
>> d) Blind eye: we're just the tool.  Others can devise workflows.
>>
>> I certainly aimed the patch at (a), since I wanted to be able to point
>> people at it (mostly on #git).  The resources I learned Git with,
>> except for the videos, just show simple examples of pull/push usage,
>> which I found both unsatisfactory (e.g. I want to know _why_ it's a
>> good idea to make topic branches) and incomplete.  This list is an
>> excellent place to learn, but I doubt that's an effort the average
>> user is willing to put in.
>
> I think we should be honest and not try to do (a) nor (c).  And as I
> already said, as (b) your description looked fine, but it wasn't very
> encouraging that not many people commented on it (nor said "Yeah, that's
> what I was missing, thanks").

there is no workflow that is right for every situation, so only describing 
one (A or B) is very limiting (even if you don't claim that it's the One 
True way)

We've seen that D doesn't work well (people are confused and create 
horribly bad workflows, decide that git is too confusing and too limited, 
and tell everyone they know)

I think C is best. this doesn't mean that we need to imagine and create 
every possible workflow, but including the workflows that we are sent (and 
commenting on advantages/disadvantages of them) would be very helpful for 
people just getting started with a project. Having a catagory of 'how not 
to use git' with some of the worst examples would be very educational.

In almost all cases where people have spoken up and described their 
workflow (and the pains involved with it) the git experts here have been 
able to simplify things for the user (either by pointing out better ways 
to do the same thing, or in some cases by tweaking git to better support 
the different class of workflow)

David Lang
