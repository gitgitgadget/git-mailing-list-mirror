From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 12:33:09 +0200
Message-ID: <472070E5.4090303@op5.se>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site> <47204297.5050109@op5.se> <Pine.LNX.4.64.0710251112390.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:33:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il022-0000xU-3A
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 12:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756769AbXJYKdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 06:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755290AbXJYKdO
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 06:33:14 -0400
Received: from mail.op5.se ([193.201.96.20]:37579 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756766AbXJYKdN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 06:33:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B819B1730709;
	Thu, 25 Oct 2007 12:33:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GCLgZWMZlK7K; Thu, 25 Oct 2007 12:32:59 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 9AD5717306ED;
	Thu, 25 Oct 2007 12:32:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710251112390.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62306>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 25 Oct 2007, Andreas Ericsson wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> On Thu, 25 Oct 2007, Steffen Prohaska wrote:
>>>
>>>> On Oct 25, 2007, at 12:14 AM, Johannes Schindelin wrote:
>>>>
>>>>> But I think I have to drive my message home again: if what you 
>>>>> desire becomes reality, you take away the clear distinction 
>>>>> between local and remote branches.  In fact, those branches are 
>>>>> neither local (because the next pull will automatically update 
>>>>> them with remote changes, but _only_ if they fast-forward) nor 
>>>>> remote (because you plan to work on them locally).
>>>> Exactly, because I do not work on those branches alone. These are 
>>>> _shared_ branches. I can work on such a branch with a group of 
>>>> developers. I'm willing to accept this bit of chaos.
>>> It is not just a chaos.  I see a serious problem here.  On _your_ 
>>> computer, you do _not_ have a shared branch.  Which is visible _even_ 
>>> in your modified work flow when you have unpushed changes.
>> Ofcourse it is. People might pull from it. That's the whole point of a 
>> distributed model.
> 
> By that reasoning, left is right.  Because your "left" is my "right".
> 
>>> So your desired illusion that your local branches are anything but 
>>> local branches will never be perfect enough.
>>>
>>>> Your rebase workflow is not possible if more than one dev wants to 
>>>> work on the topic branch together.
>>> Why not?  I do it all the time.  CVS users do it all the time, for 
>>> that matter.
>> For 200 branches at a time, where any of them might have changed?
> 
> I slowly start to understand why your users are confused.  _Nobody_ works 
> on 200 branches at the same time.  (No, maintainers don't count: they do 
> not work _on_ the branches, but _with_; they merge them.)
> 
> When you're done with a topic, why do you leave it around?  Cluttering up 
> your "git branch" output?
> 

We have 91 repositories at work. Roughly 60 of those are in active use.
The active repos are organized pretty much like the git repo with
'master', 'next' and 'maint'. We *do* work on all branches, but not
every day, ofcourse. They're NOT topic branches. We implement features
on topic-branches that we DO throw away, but those branches HAVE to be
there for us to be able to handle supporting of old versions as well as
implementing new features in a sane way. Throwing them away locally would
mean having to re-create them very frequently, and since they have to
exist in the upstream repo, "git fetch" would fetch and re-create them
every single time anyway.

So please, pretty please just drop the entire "use topic branches" argument.
We do that, but still have this problem, and it *is* a problem.

>>> The problem I see here: you know git quite well.  Others don't, and 
>>> will be mightily confused why pull updates local branches sometimes, 
>>> and sometimes not.
>> Do you know this, or are you just guessing? I'm getting the exact same
>> confusion with the current behaviour. "Why the hell doesn't git update
>> all the branches I told the damn stupid tool to auto-merge when I pull?"
> 
> That's easy.  A merge can have conflicts.  Conflicts need a working 
> directory.  You cannot have multiple working directories.  (Actually, you 
> can, with git-new-workdir, which would break down _horribly_ with your 
> desired change.)
> 
> Oh?  You don't have local changes?  Then why _on earth_ do you have a 
> local branch?
> 

Because it's convenient, ofcourse. Don't you have 'maint', 'next' and 'master'
in your clone of git.git? I'm guessing at least 99% of the people on this
list have those branches lying around in their clones, even if they only
ever use 'next' and/or 'master'.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
