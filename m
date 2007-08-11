From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Sat, 11 Aug 2007 02:43:54 +0200
Message-ID: <EF7DFA5A-9C3A-4D0B-9533-D1D60AE4A44C@zib.de>
References: <f99cem$4a4$1@sea.gmane.org> <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com> <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de> <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com> <Pine.LNX.4.64.0708081810130.14781@racer.site> <75EB313E-807D-44FB-A186-A151F182B47B@zib.de> <Pine.LNX.4.64.0708082228520.21857@racer.site> <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de> <e7bda7770708092307g49fa9976l5f9972592129fc8e@mail.gmail.com> <2383328F-300E-459C-A299-90242DA230F7@zib.de> <e7bda7770708101531n782118e9qb9c6de4e934940ea@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Torgil Svensson <torgil.svensson@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 11 02:43:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJf4X-0004gt-RA
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 02:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386AbXHKAnO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 20:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755209AbXHKAnO
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 20:43:14 -0400
Received: from mailer.zib.de ([130.73.108.11]:64801 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537AbXHKAnN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 20:43:13 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7B0h89D009724;
	Sat, 11 Aug 2007 02:43:08 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1a312.pool.einsundeins.de [77.177.163.18])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7B0h6TB000473
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 11 Aug 2007 02:43:07 +0200 (MEST)
In-Reply-To: <e7bda7770708101531n782118e9qb9c6de4e934940ea@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55582>


On Aug 11, 2007, at 12:31 AM, Torgil Svensson wrote:

> On 8/10/07, Steffen Prohaska <prohaska@zib.de> wrote:
>
>>  [..list of tools and links]
>
> Thank you for the information!  i'll check those up.


I hope to have an improved list on monday, sorted by priority of
the developers I'm working with.

I thought I do some coding, to find out a bit more about the
stability of msysgit. So I started and added support for kdiff3
on Windows (see patches in separate mail).

I'm impressed. Pretty much everything I tried today worked for
me. After I got git gui running, and learned how to avoid pitfalls
of git submodule, development went smoothly. I pushed and pulled a
bit from linux and mac and did some coding. Thanks for the vim
setup!

I think you (and more people I don't yet know) did a great job
with msysgit. I'd recommend it over cygwin's git, which caused
some trouble for me.

Thanks!

>>>> My goal would be to type 'make windist' in the official repo and
>>>> get a very basic installer (maybe just a zip archive) that contains
>>>> everything needed to run git on Windows. Unpacking this self-
>>>> contained
>>>> installer on a freshly installed Windows should get you going.  
>>>> There
>>>> should be no need to install Cygwin or something else.
>>>>
>>>> Is this realistic?
>>>> What is needed to get there?
>>>> What would be an estimated timeframe to achieve this goal?
>>>>
>>>> Will all this run on Windows XP 64 bit and Windows Vista 64 bit?
>>>
>>> How fast can you type?
>>
>> I don't see your point. The question is if git runs flawlessly
>> on 64 bit systems, which we use for development. I have no experience
>> with mingw. Maybe there are some issues with 64 bit Windows, maybe
>> not. But its a reasonable question?
>>
>>> Why does it have to be the _official_ repo? Git have submodule
>>> support, so you could do a repo called
>>> "my_excellent_git_environment_for_windows.git" and have the official
>>> repo as submodule (msysgit is done this way).
>>
>> The official repo would indicate a real commitment to me that
>> Windows support if officially maintained.
>
> I agree it's reasonable questions. My point is that to get something,
> you have to be active (and you're a prime example of that I think).
>
> Quoted from http://git.or.cz/ : "Traditionally, the low-level part of
> Git is called plumbing and the interfaces and frontends are called
> porcelains. Git itself comes with a default porcelain bundled and that
> is actually what you will normally mean when you say you use Git."
>
>
> What do you include in the "make windist" installer and the "Windows
> support" ?  Are you talking porcelain or plumbing?

Hard to say. I believe now, from what I learned today, that the msysgit
approach is quite reasonable: Grouping all needed unix tools around a
submodule containing git. But the submodule should be git.git. I think
this is what I'd expect. I like the idea of bringing everything needed
along, and keeping it separate from the rest of the system. This avoids
conflicts with, for example, cygwin.

I don't think I would expect much more for a basic setup. All tests
should run, maybe some msysgit tests would be needed to test the  
pitfalls
we'll discover; maybe not. I'll test XP 64 bit and Vista 64 bit  
beginning
of next week. Getting started hacking msysgit could be a bit easier.
I didn't like the submodule problems I ran into and I still didn't find
out how to push to the git mob branch.

For me a next step would be do some polishing. For example tune
git to integrate with other Windows tools, like what I proposed for
git-mergetool. I really started to love git when it launched a
graphical mergetool automatically for me. After that point I never
edited merge markers again. Things I needed too much time before are
now running so smoothly. I think such a tight integration is really
useful to convince people. I'd also expect default choices to be
reasonable. I'm not yet 100% sure, but my feeling it that core.autocrlf
should be set to true by default on Windows, globally. A bit more
of msysgit specific documentation would also be good. Maybe we should
add a platform specific section to the user-manual. How could help
in msysgit be handled? By a Windows help document?

I could also think of a fail safe update, that allows to upgrade an
existing msysgit to a specific tag (maybe after stashing the current
installation and reverting in case of problems).

Maybe git gui could be integrated with the Windows Explorer and be
launched on a directory. Maybe this is one of your evil plans. But
this is already more than I need.

Back to the basic stuff.
What do you think is needed to merge changes back to git.git?
I counted approximately 20k diff lines (incl. context) between msysgit's
git master and git.git's master. At a first glance much of them seem to
be compatibility stuff.

	Steffen
