From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sat, 29 Sep 2007 18:06:21 +0200
Message-ID: <A835C8E8-8EC5-43B7-9252-8709214DE7AD@zib.de>
References: <87ir5us82a.wl%cworth@cworth.org> <20070929000056.GZ3099@spearce.org> <Pine.LNX.4.64.0709290144310.28395@racer.site> <4D958F04-D531-416A-9FB4-E4119BEC6905@zib.de> <Pine.LNX.4.64.0709291606010.28395@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 29 18:05:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbeoO-0007cI-6R
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 18:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986AbXI2QEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 12:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbXI2QEx
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 12:04:53 -0400
Received: from mailer.zib.de ([130.73.108.11]:62188 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754968AbXI2QEw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 12:04:52 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8TG4mfE008916;
	Sat, 29 Sep 2007 18:04:48 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db15bd8.pool.einsundeins.de [77.177.91.216])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8TG4k8Q010012
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 29 Sep 2007 18:04:47 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0709291606010.28395@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59473>


On Sep 29, 2007, at 5:06 PM, Johannes Schindelin wrote:

> Hi,
>
> On Sat, 29 Sep 2007, Steffen Prohaska wrote:
>
>> On Sep 29, 2007, at 2:49 AM, Johannes Schindelin wrote:
>>
>>>
>>> On Fri, 28 Sep 2007, Shawn O. Pearce wrote:
>>>
>>>> On Cygwin we have man, so `git help init` (or `git init --help`)
>>>> work just fine to display the manual entry.  No idea about the MSYS
>>>> port.
>>>
>>> We open the html pages.  That is, we don't yet, since we do not
>>> generate the html pages just yet; asciidoc is a Python program, and
>>> Python is not available as an MSys program as far as I know (and
>>> asciidoc insists on finding files in a Unix-like file structure,  
>>> so we
>>> _do_ need an MSys Python).
>>
>> I propose to clone the html pages from git.git's html branch and  
>> include
>> them in the installer. I continue to believe that this is the  
>> simplest
>> and fastest solution for providing html pages.
>
> I'm hesitant... The html branch is synced with the master branch.   
> And we
> deviate from the master branch quite a lot ATM.

We could choose a specific commit from the html branch for the WinGit
release. I don't think we'll need modifications to the documentation
in msysgit. Selecting an older version that matches the state of msysgit
should be sufficient.

Fixes to the documentation could be committed directly to git.git.


>> I'll provide a patch (hopefully next week).
>
> This will be a good temporary workaround.

The patch following soon will assume that html is available. Maybe
we could add it as a submodule of msysgit?

I haven't looked into the submodule mechanisms and therefore will
not include it in the patch. I just manually cloned the html branch.
For now, this may be sufficient to create a WinGit installer.

	Steffen
