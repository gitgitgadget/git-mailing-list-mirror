From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Fri, 10 Aug 2007 09:19:41 +0200
Message-ID: <2383328F-300E-459C-A299-90242DA230F7@zib.de>
References: <f99cem$4a4$1@sea.gmane.org> <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com> <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de> <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com> <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de> <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com> <Pine.LNX.4.64.0708081810130.14781@racer.site> <75EB313E-807D-44FB-A186-A151F182B47B@zib.de> <Pine.LNX.4.64.0708082228520.21857@racer.site> <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de> <e7bda7770708092307g49fa9976l5f9972592129fc8e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: Torgil Svensson <torgil.svensson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 09:20:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJOn3-0005mc-0v
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 09:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbXHJHTv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 03:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753974AbXHJHTv
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 03:19:51 -0400
Received: from mailer.zib.de ([130.73.108.11]:43209 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbXHJHTu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 03:19:50 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7A7IqXj013264;
	Fri, 10 Aug 2007 09:19:47 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1103e.pool.einsundeins.de [77.177.16.62])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7A7Ipwf026415
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 10 Aug 2007 09:18:51 +0200 (MEST)
In-Reply-To: <e7bda7770708092307g49fa9976l5f9972592129fc8e@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55512>


On Aug 10, 2007, at 8:07 AM, Torgil Svensson wrote:

> On 8/9/07, Steffen Prohaska <prohaska@zib.de> wrote:
>
>> The next would be a good integration with
>> useful tools on Windows, for example git-mergetool should launch
>> Windows three-way merge tools.
>
> Do you mean tools included in Windows or tools using the Windows API?

I think both. I'm currently conducting a survey what the Windows
users I'm working with are using. Up to now I have no idea what these
tools do. Note, I'm not working on Windows. But I would like to see
git starting the tools that users prefer to use.

Git would just feel more like a useful Windows tool if it interacted
with other useful Windows tools.

Here is what I have on my list (not yet prioritized):

- WinMerge (http://winmerge.org/)

- Visual Comparer (http://www.nikeware.com/vc-features.htm)

- Araxis Merge, http://www.araxis.com/merge/ (expensive!)

- Beyond Compare, http://www.scootersoftware.com/file-comparison.php  
(will support 3-way  with upcoming version 3; reasonable price)

- KDiff3, http://kdiff3.sourceforge.net/ (comes with Windows- 
installer from SF)

- ECMerge, http://www.elliecomputing.com/Products/merge_overview.asp  
(OSS developer can get a "Pro" license for free upon request)

A complete list at
http://en.wikipedia.org/wiki/Comparison_of_file_comparison_tools


>
>> My goal would be to type 'make windist' in the official repo and
>> get a very basic installer (maybe just a zip archive) that contains
>> everything needed to run git on Windows. Unpacking this self- 
>> contained
>> installer on a freshly installed Windows should get you going. There
>> should be no need to install Cygwin or something else.
>>
>> Is this realistic?
>> What is needed to get there?
>> What would be an estimated timeframe to achieve this goal?
>>
>> Will all this run on Windows XP 64 bit and Windows Vista 64 bit?
>
> How fast can you type?

I don't see your point. The question is if git runs flawlessly
on 64 bit systems, which we use for development. I have no experience
with mingw. Maybe there are some issues with 64 bit Windows, maybe
not. But its a reasonable question?


> Why does it have to be the _official_ repo? Git have submodule
> support, so you could do a repo called
> "my_excellent_git_environment_for_windows.git" and have the official
> repo as submodule (msysgit is done this way).

The official repo would indicate a real commitment to me that
Windows support if officially maintained.

I agree that there may be more tools group around core git. But
core git itself should be the master from the official repo.
This seems to be a reasonable goal to me. At least that is what
we do. The head must compile on all supported platforms
out-of-the-box.


> You could even start with cloning the TortoiseSVN repo using git. Or
> maybe even better, since KDE4 will compile on Windows [take on wood],
> do it as a kioslave (or whatever mechanism) to have an environment
> that works in both Windows and Linux and most OtherOs:es. Aiming for
> environments that works on several OSes is a good thing for future
> migrations.

I work for years now on cross platform code. I never needed a whole
environment. I need Qt and the native development environment, like
Visual Studio, gcc, Xcode. I don't need KDE on Windows, I don't need
KDE on Mac. Everything's there already.

	Steffen
