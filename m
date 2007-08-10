From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Fri, 10 Aug 2007 13:14:20 +0200
Message-ID: <66F583A1-0F11-4917-B674-C38F7C2E31B8@zib.de>
References: <f99cem$4a4$1@sea.gmane.org> <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com> <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de> <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com> <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de> <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com> <Pine.LNX.4.64.0708081810130.14781@racer.site> <75EB313E-807D-44FB-A186-A151F182B47B@zib.de> <Pine.LNX.4.64.0708082228520.21857@racer.site> <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de> <e7bda7770708092307g49fa9976l5f9972592129fc8e@mail.gmail.com> <2383328F-300E-459C-A299-90242DA230F7@zib.de> <Pine.LNX.4.64.0708101121240.21857@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Torgil Svensson <torgil.svensson@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 13:13:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJSRA-0006JV-BJ
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 13:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757541AbXHJLNf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 07:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757078AbXHJLNf
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 07:13:35 -0400
Received: from mailer.zib.de ([130.73.108.11]:33004 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbXHJLNe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 07:13:34 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7ABDVZE003651;
	Fri, 10 Aug 2007 13:13:31 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7ABDUSG010436
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 10 Aug 2007 13:13:30 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0708101121240.21857@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55529>


On Aug 10, 2007, at 12:30 PM, Johannes Schindelin wrote:

> Hi,
>
> On Fri, 10 Aug 2007, Steffen Prohaska wrote:
>
>> On Aug 10, 2007, at 8:07 AM, Torgil Svensson wrote:
>>
>>> On 8/9/07, Steffen Prohaska <prohaska@zib.de> wrote:
>>>
>>>> Will all this run on Windows XP 64 bit and Windows Vista 64 bit?
>>>
>>> How fast can you type?
>>
>> I don't see your point. The question is if git runs flawlessly
>> on 64 bit systems, which we use for development. I have no experience
>> with mingw. Maybe there are some issues with 64 bit Windows, maybe
>> not. But its a reasonable question?
>
> It would be, if
>
> - more people had 64-bit platforms to run on, and
> - more people had Windows 64-bit.
>
> Both cost money, so I suggest just trying it for yourself if you  
> are one
> of the few lucky ones being actually _able_ to test.
>
> And no, I will not buy a Windows 64-bit just to test it for you.

I'll try. I only asked if there is any experience on this. I didn't
ask you to test it for me.


>>> Why does it have to be the _official_ repo? Git have submodule
>>> support, so you could do a repo called
>>> "my_excellent_git_environment_for_windows.git" and have the official
>>> repo as submodule (msysgit is done this way).
>>
>> The official repo would indicate a real commitment to me that
>> Windows support if officially maintained.
>
> I cannot speak for others, of course, but this is a freeloader  
> mentality I
> do not want to support.
>
> If you want first class Windows support, you'll have to pay for that,
> methinks.  And seeing all those less-than-even-lousy SCMs getting  
> major
> financial contributions to support their mediocrity, I do not see a  
> reason
> to get small amounts from private people, but rather substantial
> money-flow from big companies.
>
> Git is an excellent tool.  If people want it badly enough, they  
> should do
> something for it.

You may have noticed that I'm willing to put some time into
it. I can't offer money. Time should be fine, too as you
state on msysgit's homepage

"Testing and reporting bugs is really already a big help.
Of course, it is even better if you get involved, for example
by hacking on mingw.git."

That is what I'm doing. You get bug reports and you get
patches. I don't understand your point about freeloader
mentality. In the long run it's just easier to keep functionality
in sync if it is maintained in a single repo, and this is what
you're basically also saying below.


>> I agree that there may be more tools group around core git. But
>> core git itself should be the master from the official repo.
>> This seems to be a reasonable goal to me. At least that is what
>> we do. The head must compile on all supported platforms
>> out-of-the-box.
>
> Guess why mingw.git is called a "fork"?  It is _not good enough_  
> yet to be
> included.  Not necessarily function-wise, but definitely code- 
> wise.  We
> have quite strict coding rules, being an Open Source project where
> everybody can see your mess, should there be one.

Well and here, again, is my point of one single repo that officially
supports Windows. If the official support is part of the 'quite
strict coding' rules then I'm more convinced that Windows is
supported with appropriate quality. This is the point I want to make.
It has nothing to do with freeloader mentality.


> It has _never_ been the plan to maintain mingw.git independently for
> eternity.  But the progress has been slow, and the _only_ reason that
> there was any progress _at all_ was that Hannes stepped up, and did  
> some
> actual work instead of talking.
>
> So yes, mingw.git's target destination is git.git.

Good to hear. Again, I prefer to put work into pushing the merge
with git.git forward, than putting work into any fancy gui stuff,
as you proposed recently.

So if there's a list of todos that hinder a merge back to git.git,
I'd happy to learn about it.

	Steffen
