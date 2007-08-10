From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Fri, 10 Aug 2007 11:30:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708101121240.21857@racer.site>
References: <f99cem$4a4$1@sea.gmane.org> <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>
 <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>
 <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com>
 <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de>
 <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com>
 <Pine.LNX.4.64.0708081810130.14781@racer.site> <75EB313E-807D-44FB-A186-A151F182B47B@zib.de>
 <Pine.LNX.4.64.0708082228520.21857@racer.site> <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de>
 <e7bda7770708092307g49fa9976l5f9972592129fc8e@mail.gmail.com>
 <2383328F-300E-459C-A299-90242DA230F7@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Torgil Svensson <torgil.svensson@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 12:31:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJRm7-0002kG-S8
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 12:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199AbXHJKbT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 06:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755559AbXHJKbT
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 06:31:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:51095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753687AbXHJKbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 06:31:18 -0400
Received: (qmail invoked by alias); 10 Aug 2007 10:31:17 -0000
Received: from ppp-82-135-7-57.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.7.57]
  by mail.gmx.net (mp046) with SMTP; 10 Aug 2007 12:31:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bu8JKmDwb54jsSKwb+gkF3I1ainn6L3nze+3G44
	BN2W4sG2atLulI
X-X-Sender: gene099@racer.site
In-Reply-To: <2383328F-300E-459C-A299-90242DA230F7@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55527>

Hi,

On Fri, 10 Aug 2007, Steffen Prohaska wrote:

> On Aug 10, 2007, at 8:07 AM, Torgil Svensson wrote:
> 
> > On 8/9/07, Steffen Prohaska <prohaska@zib.de> wrote:
> > 
> > > Will all this run on Windows XP 64 bit and Windows Vista 64 bit?
> > 
> > How fast can you type?
> 
> I don't see your point. The question is if git runs flawlessly
> on 64 bit systems, which we use for development. I have no experience
> with mingw. Maybe there are some issues with 64 bit Windows, maybe
> not. But its a reasonable question?

It would be, if

- more people had 64-bit platforms to run on, and
- more people had Windows 64-bit.

Both cost money, so I suggest just trying it for yourself if you are one 
of the few lucky ones being actually _able_ to test.

And no, I will not buy a Windows 64-bit just to test it for you.

> > Why does it have to be the _official_ repo? Git have submodule
> > support, so you could do a repo called
> > "my_excellent_git_environment_for_windows.git" and have the official
> > repo as submodule (msysgit is done this way).
> 
> The official repo would indicate a real commitment to me that
> Windows support if officially maintained.

I cannot speak for others, of course, but this is a freeloader mentality I 
do not want to support.

If you want first class Windows support, you'll have to pay for that, 
methinks.  And seeing all those less-than-even-lousy SCMs getting major 
financial contributions to support their mediocrity, I do not see a reason 
to get small amounts from private people, but rather substantial 
money-flow from big companies.

Git is an excellent tool.  If people want it badly enough, they should do 
something for it.

> I agree that there may be more tools group around core git. But
> core git itself should be the master from the official repo.
> This seems to be a reasonable goal to me. At least that is what
> we do. The head must compile on all supported platforms
> out-of-the-box.

Guess why mingw.git is called a "fork"?  It is _not good enough_ yet to be 
included.  Not necessarily function-wise, but definitely code-wise.  We 
have quite strict coding rules, being an Open Source project where 
everybody can see your mess, should there be one.

It has _never_ been the plan to maintain mingw.git independently for 
eternity.  But the progress has been slow, and the _only_ reason that 
there was any progress _at all_ was that Hannes stepped up, and did some 
actual work instead of talking.

So yes, mingw.git's target destination is git.git.

Ciao,
Dscho
