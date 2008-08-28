From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 15:33:26 -0700
Message-ID: <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu>
References: <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net> <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu> <20080828215907.GE27867@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 00:36:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYq67-0005xI-4O
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 00:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081AbYH1WfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 18:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756200AbYH1WfF
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 18:35:05 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:57830 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756050AbYH1WfE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 18:35:04 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7SMXZpp010126;
	Thu, 28 Aug 2008 18:33:35 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7SMXSVt010118
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2008 18:33:32 -0400
In-Reply-To: <20080828215907.GE27867@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94194>


On Aug 28, 2008, at 2:59 PM, Jeff King wrote:

>> I now have to TEST to find those crazy backwards-incompatibility bugs
>> before I can upgrade us to 1.6.0.  To test, I have to try to  
>> imagine what
>> I and others were assuming about git.  And this episode means that  
>> I can't
>> make any assumptions about the sanity of any changes since March,  
>> which is
>> the version I'm thinking of upgrading.
>>
>> But note that THIS upward compatibility bug has been declared to  
>> not be a
>> bug.  Will any others receive the same stamp?
>>
>> So please put on your engineer hat, and stop talking about "specious
>> claims" and hurting feelings.
>
> My engineer hat _is_ on. Here is the logic that led to my use of the
> phrase "specious claims":

Cool.  Thanks!  (seriously)

>  - you are claiming that there are backwards incompatibility changes
>    lurking in git (or at least that is what I believe you to mean)

I'm saying that I don't know and will have to do complete exhaustive  
testing to be sure (my faith in git has been severely shaken).  I  
already tested every step for months, and to do it "right", I have to  
do that all over again.  I don't have the time, so I have to do severe  
approximations.  One of the fixes is to see if I can get people to  
stop making frivolous changes: "ooo!  we have to rename everything in  
the API because lists, I mean hashtables, with 143 entries in them are  
offensive!".  If there was more reasoning than that, it was not  
displayed in this thread.


>  - there has been _one_ such problem, and the person responsible for
>    vetting such changes has solicited suggestions for doing better in
>    the future. I don't think that is indicative of a pattern of such
>    changes.

Ok.  My suggestion is that it shouldn't have been done in the first  
place, and we should now revert.  But others are saying over and over  
"its done!  live with it!".  I came in late.  What did I miss in the  
last 6 months.  Sounds like people have lots of practice with these  
water-over-the-dam's, surely this isn't the first time?

>  - But let's say you have lost some faith in the git development
>    process due to _this_ bug. But let's look at the history of this
>    bug. It has been discussed several times for the past 2 years,  
> along
>    with a mention in the release notes several versions ago. It was  
> not
>    a surprise to anybody who has been developing git.

In March 2008, the sample git-hooks and git-web used git<DASH>  
commands.  That was the last I looked at git until Tuesday of this week.

>    So yes, maybe there _are_ other bugs just like it lurking. But
>    wouldn't it stand to reason that those bugs have _also_ been
>    discussed and mentioned in the release notes, or that the  
> developers
>    would know about them?

This is declared to not be a bug, even though it breaks existing  
scripts, even those published in the main branch of git itself.

>    In other words, I can see you losing enough faith to say "wow, the
>    git developers don't communicate very well and I need to vet their
>    changes and notes more carefully". I don't think it is reasonable  
> to
>    say that there are likely to be other, totally unknown backwards
>    incompatible changes.

I'm going by the reasoning shown in this thread.  Why not?  I'm  
looking for a way not to have to do exhaustive testing on those  
scripts, so would love to hear it.

> So
>
>  1. I find your claim that such bugs exist to have little evidence to
>     back it up.

Induction.  If it happened once, it probably happened more than once.   
This wasn't a show stopper problem.  It wasn't broke, but it was  
"fixed" anyway.

>  2. As an engineer, I have seen evidence of one problem (insufficient
>     communication) but not of another (introduction of
>     incompatibilities without on-list discussion). So I would choose  
> to
>     focus my resources on fixing the problem I have seen.

I don't know what I missed, and am not sure how to search for in in  
ten thousand messages or so since March.  My style is to anticipate  
problems.

But I'll figure it out.  Part of that figure out process is posting to  
this thread.

>> Heck, I even got Linus himself to ask if us people were on drugs, and
>> I didn't take it personally.  At least I'm saying something that can
>> be disputed, and not ad hominem like Linus.  8)
>
> Sorry, but I'm not impressed by your getting Linus to yell at you.  
> It's
> like shooting fish in a barrel. :)

Yeah, well, that was supposed to be both a joke and to indicate that  
I'm not sitting here with steam coming out my ears.

Linus has his solution, that doesn't work for me.  He hasn't listened  
to my several attempts to say why, and he's mad because he thinks I'm  
not listening.  But I expect he's a busy guy with 10,000 emails a day  
to respond to, so them's the breaks.

>> How to better notify them is to do it on a major release, like Git  
>> 2.0.
>> THEN, they expect upward compatibility to break.
>
> Now that _is_ a reasonable suggestion. This change _did_ wait until  
> the
> jump to 1.6.0, which we thought of as a major version jump (just as  
> 1.4
> to 1.5 introduced a few minor but documented changes). I don't think
> there is a plan for "git 2.0" short of serious incompatibilities in  
> the
> repo format (i.e., you can't use 2.x tools on 1.x repos and vice  
> versa).
> So perhaps our numbering should be more emphatic.

I think I hear you.  Since git is young, I should expect  
incompatibilities with minor version changes, and not demand that they  
be held off for major version changes.  That seems very plausible.

But I think I'll still remain wary because 1.6 introduced a nearly  
complete renaming of the API for what, in this thread anyway,  
completely silly reasons.  If there are good reasons, I haven't seen  
them.

-- Perry
