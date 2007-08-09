From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Thu, 9 Aug 2007 08:20:54 +0200
Message-ID: <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de>
References: <f99cem$4a4$1@sea.gmane.org> <f99nm6$9vi$1@sea.gmane.org>  <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org>  <20070807145825.GO21692@lavos.net>  <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de> <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>  <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>  <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com>  <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de> <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com> <Pine.LNX.4.64.0708081810130.14781@racer.site> <75EB313E-807D-44FB-A186-A151F182B47B@zib.de> <Pine.LNX.4.64.0708082228520.21857@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 09 08:20:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ1No-0004au-Jv
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 08:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757636AbXHIGUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 02:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbXHIGUP
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 02:20:15 -0400
Received: from mailer.zib.de ([130.73.108.11]:53640 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297AbXHIGUO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 02:20:14 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l796KBIP006170;
	Thu, 9 Aug 2007 08:20:11 +0200 (CEST)
Received: from [192.168.178.32] ([77.177.247.82])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l796KAkF018998
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 9 Aug 2007 08:20:11 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0708082228520.21857@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55412>


On Aug 8, 2007, at 11:30 PM, Johannes Schindelin wrote:

> Hi,
>
> On Wed, 8 Aug 2007, Steffen Prohaska wrote:
>
>> On Aug 8, 2007, at 7:20 PM, Johannes Schindelin wrote:
>>
>>> So go for it, everybody, or alternatively do not even bother to  
>>> whine.
>>
>> I don't care about these things. I typically start the Explorer by
>> typing explorer into the 'Run ...' box of the start meny. So don't
>> expect anything from me that makes git more beautiful.
>
> That's nice to hear.  Finally somebody honest.  I'll return the  
> favour: I
> have no time to work on the bugs you sent in a reply.

That's fine. I don't expect anything, except for being honest about
the level of Windows support that is currently available. In retrospect,
I relied on the claim that git works in Cygwin without problems (not
made by you but on the mailing list in general). This claim turns out
to be wrong for me, because it highly depends on the details of how you
configure your Cygwin, which makes it impossible to run git in Cygwin
that is configured according to the 'wrong' policy.

Any hint how I can start debugging? I saw mingw for the
first time in my life, yesterday. I only worked with cygwin and various
Visual Studio versions, before.

[ btw, my point was that I'm mostly interested in getting the basic
stuff going first. That is git with the same functionality that
I have on Linux and Mac. The next would be a good integration with
useful tools on Windows, for example git-mergetool should launch
Windows three-way merge tools. The thing I'm least interested is
a beautiful installer, which clutters my Desktop with icons, which
I never use and need to cleanup later anyway.

Bottom line: if you have points on your list that better fit the
described priorities, there would be a good chance that I can look
into one or two of them, for example

Is anything needed to get mingw changes merged to the official repo?
Is anything needed to get changes from the official repo to mingw?

My goal would be to type 'make windist' in the official repo and
get a very basic installer (maybe just a zip archive) that contains
everything needed to run git on Windows. Unpacking this self-contained
installer on a freshly installed Windows should get you going. There
should be no need to install Cygwin or something else.

Is this realistic?
What is needed to get there?
What would be an estimated timeframe to achieve this goal?

Will all this run on Windows XP 64 bit and Windows Vista 64 bit?

After I'm convinced that the level of support for Windows is
sufficient, I will recommend using it, which means that approximately
30 developers will start using git in the way I describe to them.
This will generate a lot of real-world testing. But it should not
generate too many critical issues. People will blame me for
recommending them the tool. ]


Back to debugging...

I tried the following (is this the right way to go?)

- double click on c:\msysgit\msys.bat to start a shell.
- cd git
- make
compiles with some warnings ..., and crashed with a popup...
The popup says (translated to english):
"NTVDM-CPU detected an invalid instruction.
CS:0000 IP:0077 OP: f0 37 05 0c 02 click to close the application."

the last lines I see in the shell are

LINK test-match-trees.exe
SUBDIR git-gui
INDEX lib/

I clicked and the compilation stops. My shell remains alive.
So, I started to run tests.

t0000-basic fails on creation of symlinks. Apparently mingw
doesn't support symlinks to files that do not exist. I reports
'ln: creating symbolic link 'path0sym' to 'hello path0' fails'.

I tried with 'export no_symlinks=1' (is this the right thing
to do? Who should set no_symlinks=1? Should it be set by the
makefile or in some global architecture configuration?).

Now t0000-basic runs except for some noise created by failing
ln, which is not detected as a failure by the test script.

so I ran all tests and they look good. Only t7004
reported 'gpg: error loading iconv.dll'.

I tried 'make install' which yields another crash popup.
Then I tried 'make -k install'

Wow... this crashed my virtual machine. Maybe Parallels should
add msysgit to their test cases. If I read their automatically
generated bugreport correctly it's again related to an invalid
instruction. Maybe mingw uses some op codes it shouldn't?

Hmm... I planned to upgrade to the newest release of Parallels
anyway. Hopefully it's more stable in this regards.

I set NO_TCLTK=1 in the Makefile to skip git-gui during installation.
The installation finished without reporting any problem. Maybe
I have a working git now ...

	Steffen
