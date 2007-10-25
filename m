From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 14:46:54 +0200
Message-ID: <4720903E.1070103@op5.se>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <471FBF29.8030802@op5.se> <Pine.LNX.4.64.0710242315310.25221@racer.site> <47204ECA.7040309@op5.se> <Pine.LNX.4.64.0710251108330.25221@racer.site> <47206EC3.5000002@op5.se> <Pine.LNX.4.64.0710251232370.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 14:47:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il27R-0000FS-QR
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 14:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbXJYMrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 08:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbXJYMrE
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 08:47:04 -0400
Received: from mail.op5.se ([193.201.96.20]:45398 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021AbXJYMrB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 08:47:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 026341730718;
	Thu, 25 Oct 2007 14:46:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q8j8z-kwKxZZ; Thu, 25 Oct 2007 14:46:55 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id E433B1730714;
	Thu, 25 Oct 2007 14:46:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710251232370.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62314>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 25 Oct 2007, Andreas Ericsson wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> On Thu, 25 Oct 2007, Andreas Ericsson wrote:
>>>
>>>> Johannes Schindelin wrote:
>>>>
>>>>> On Wed, 24 Oct 2007, Andreas Ericsson wrote:
>>>>>
>>>>>> Conceptually, I don't think it'll be any problem what so ever 
>>>>>> telling anyone that the branches that aren't currently checked 
>>>>>> out get merged automatically only if they result in a 
>>>>>> fast-forward.
>>>>> It would be a matter of seconds until someone asks "why only 
>>>>> fast-forwards? Would it not be _much_ better to merge _always_?  
>>>>> Stupid git."
>>>>>
>>>>> And all because the concept of "local" vs "remote" was blurred.
>>>> It's already blurred, since we have git-pull instead of just 
>>>> git-fetch.
>>> Huh?  How is "I ask git pull to fetch the remote branch, and merge it 
>>> into my local branch" a blurring of local vs remote branch?
>>>
>>> The local branch is still the local branch where it is _my_ 
>>> responsibility to update or change anything.
>> True. So git pull saves you exactly one command. The various 
>> fetch-all-git- repos-and-update-all-fast-forward-branches in circulation 
>> at the office save us ~500 commands each time they're run. Or rather, 
>> they *could* do that, but you can't know until you've run it.
> 
> As I pointed out, there is no way to sensibly have 500 _local_ branches 
> lying around.
> 
> It is ridiculous to assume that you have to have local branches for all 
> the stable, maintenance, whatever branches.
> 
> When you have to change something, you branch, hack, develop, commit, 
> push, and then _clean up_ after yourself.  No need to clutter your 
> local branch space with unused branches.
> 

error: The branch 'next' is not a strict subset of your current HEAD.
If you are sure you want to delete it, run 'git branch -D next'.

So you want me to tell all the developers they should use "git branch
-D maint" instead, so they can bypass the built-in security checks? No
thanks.

>> So what should I do to make what I want possible, without having 
>> git-pull muddy the waters of local vs remote? There's clearly a user 
>> desire for it, besides that of my eight co-workers and myself. Introduce 
>> git-<cmd-156>?
> 
> If you _insist_ on your workflow, hey, git is a free program, and you can 
> do what you want to do with an alias easily enough.

With a git alias? No. There aren't even any switches in git to make it do
what I want. With a shell alias? Sure, it's doable, but cumbersome. With a
shell-script I can get it done, but it's ugly, inefficient and has to parse
everything twice. It's also a time-sink, and time is something I don't have
very much of right now.

>  You can even make 
> that alias part of the templates, so you can force your desires down the 
> throat of every of your coworkers.
> 

They're the ones that requested I hack it into git, but the result would
remain the same, ofcourse.

> However, that does not mean that you can insist on support for your 
> workflow in upstream git.
> 

I'm not. We're currently discussing the pros and the cons, and I'm spending
my free 20 minutes every night working on a patch-series to make git-pull
a built-in and then implementing the switch/config-option/whatever that
makes it do what I want it to do. Apart from Junio, that's how everyone
that wants a feature implemented has to do it, so I'd hardly call that
insisting. If Junio decides the patch does something evil, I'll have to
settle for cherry-picking it into whatever branch I want to build from.

On a side note; I'd *love* for it to have a rebase option as well. Perhaps
I'll do that next. In the mean-time, I'd settle for just updating locally
modifiable copies of tracking branches that I've already configured git to
merge with a tracking branch when it happens to be a fast-forward.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
