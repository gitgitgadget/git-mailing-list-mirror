From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 8 Aug 2007 21:37:50 +0200
Message-ID: <75EB313E-807D-44FB-A186-A151F182B47B@zib.de>
References: <f99cem$4a4$1@sea.gmane.org> <f99nm6$9vi$1@sea.gmane.org>  <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org>  <20070807145825.GO21692@lavos.net>  <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de> <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>  <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>  <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com>  <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de> <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com> <Pine.LNX.4.64.0708081810130.14781@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:39:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIrNW-0002rR-MT
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 21:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762608AbXHHTjb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 15:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763588AbXHHTjb
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 15:39:31 -0400
Received: from mailer.zib.de ([130.73.108.11]:45272 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762483AbXHHTj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 15:39:29 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l78Jb4cl021918;
	Wed, 8 Aug 2007 21:37:04 +0200 (CEST)
Received: from [192.168.178.32] ([77.177.245.231])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l78Jb3tH023457
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 8 Aug 2007 21:37:03 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0708081810130.14781@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55346>


On Aug 8, 2007, at 7:20 PM, Johannes Schindelin wrote:

> On Wed, 8 Aug 2007, Mark Levedahl wrote:
>
>> On 8/8/07, Steffen Prohaska <prohaska@zib.de> wrote:
>>>
>>> The bottom line for me is, git does not yet support Windows in a
>>> usable way for the organizations that I need to convince.
>>>
>>>         Steffen
>>>
>>
>> Have you considered jumping in to help on the msys git port Johannes
>> Schindelin is working? He has very generously offered to do
>> essentially everything except find bugs, the latter because he does
>> not actually use Windows so can't, and is clearly putting a great  
>> deal
>> of effort into this. A stable and complete Windows port may be much
>> closer than you think.
>

I'll look into it. However, my situation is similar to Johannes'. I do
not regularly work on Windows. I use my Mac for all office work and
typically code on Linux. However, I do use Windows from time to time
because the majority of the people I work with use Windows.

I have a real Windows running in a Virtual Machine and I consider
switching to it for a while, to see if things run smoothly. Here is
what I plan to do: I will set cygwin to textmode (!), although I know
better. But this is what most of the people I work with have. I'll
uninstall cygwin's git and install msysgit instead. I'll try to do
all the integration work, that is import from cvs on Linux, pull to
Windows and do coding and merges on Windows. I'll push back to Linux
and Mac for testing.

After the basic stuff, like pull, push, merge, commit, gitk, and
git gui, here's my first more difficult task: Will git-mergetool
launch something useful for me on Windows? I heard that WinDiff
would be useful. On Mac I use FileMerge.

> To be fair, we are already a team of five working on it.  The 3rd
> generation of the net installer works as flawlessly as the first, but
> msysgit.git is a superproject now, containing the complete build
> environment you need, and has git/mingw/4msysgit.git as a submodule  
> (yes,
> that is a fork of a fork; they work now on repo.or.cz).
>
> Please find it on
>
> 	http://msysgit.googlecode.com/
>
> (It's a meager 1.4 MB, so the whole rest is git-cloned natively!) It
> already passes all tests, is able to start gitk and git-gui, and  
> more is
> to come!
>
> And no, I did not agree to do _everything_.  I agreed to do things  
> _when I
> get something in return_.

I read this before. At the time you wrote about this on the mailing list
I thought that cygwin would be fine. I wasn't aware of the binmode/ 
textmode
magic and all the problems caused by it.

> For example, we have a functional script sitting in msysgit.git which
> builds a complete WinGit installer (WinGit being the code name for  
> "Git on
> MSys without the whole build environment").
>
> It is incomplete in only a few issues:
>
> 	- it does not install anything in the start menu
>
> 	- it does not install any short cut on the Desktop
>
> 	- it does not install anything in the Quick Launch bar
>
> 	- it does not include a nice WelcomeToGit.html, to be launched
> 	  after a successful install
>
> 	- it does not contain a nice way to start git-gui (you have to
> 	  start it by hand from the command line inside bash)
>
> 	- etc.
>
> So go for it, everybody, or alternatively do not even bother to whine.

I don't care about these things. I typically start the Explorer by  
typing
explorer into the 'Run ...' box of the start meny. So don't expect  
anything
from me that makes git more beautiful.

The only thing I want to achieve is a flawlessly running git that works
out-of-the box in the presence of a cygwin in textmode (!). If possible
git should have the same version number that I have on Linux and Mac,
which means the master branch of Junio's repo on my Mac. Lagging a bit
behind for a while is ok, but in general I'd prefer to have the same
version on Linux, Mac, and Windows. What I described means Windows  
support
for me. Having a nice installer is not important.

> Ciao,
> Dscho
>
> P.S.: I'll be not really available for a few days, starting from  
> tomorrow,
> so do use the mailing list to keep in touch with others working on  
> msysgit
> or 4msysgit, and do use the mob branch (you can bug the project  
> members
> listed on the homepage to cherry-pick, sign off and push if need be).
>

ok. I'll be available for one more week and will then be offline
for three weeks.

	Steffen
