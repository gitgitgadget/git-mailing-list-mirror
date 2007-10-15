From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 11:23:37 +0200
Message-ID: <E45D25D3-F37A-49BE-8B83-B4567322D41D@zib.de>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>  <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>  <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net> <Pine.LNX.4.64.0710150217120.25221@racer.site> <Pine.LNX.4.64.0710150223230.25221@racer.site> <E1IhJ4K-00086x-5U@fencepost.gnu.org> <AD60F584-7AAD-4083-9BA6-21F0D00D6D1D@zib.de> <E1IhLBW-0006uw-19@fencepost.gnu.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	raa.lkml@gmail.com, ae@op5.se, tsuna@lrde.epita.fr,
	make-w32@gnu.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 11:22:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhM9b-000106-PY
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 11:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756923AbXJOJWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 05:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756697AbXJOJWN
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 05:22:13 -0400
Received: from mailer.zib.de ([130.73.108.11]:52323 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756100AbXJOJWM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 05:22:12 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9F9M6sP028967;
	Mon, 15 Oct 2007 11:22:06 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9F9M5rc011118
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 15 Oct 2007 11:22:06 +0200 (MEST)
In-Reply-To: <E1IhLBW-0006uw-19@fencepost.gnu.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60968>


On Oct 15, 2007, at 10:20 AM, Eli Zaretskii wrote:

>> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  
>> git@vger.kernel.org,
>>         raa.lkml@gmail.com, ae@op5.se, tsuna@lrde.epita.fr, make- 
>> w32@gnu.org
>> From: Steffen Prohaska <prohaska@zib.de>
>> Date: Mon, 15 Oct 2007 09:56:40 +0200
>>
>>> While we are at that: can you (or someone else) point me to
>>> instructions on how to build the MinGW port of GIT?  I found a  
>>> tarball
>>> of the MinGW-ported GIT (v1.5.3, I think), but what I don't seem  
>>> to be
>>> able to find is some kind of HOWTO: what tools I need to have
>>> installed, how to configure them (if there are any special issues
>>> there), what command(s) to type, etc.  Is there anything like  
>>> that out
>>> there, or can someone post such instructions?
>>
>> If you want to have a full working development environment, such that
>> you can start contributing to msysgit right away, and have no  
>> firewall
>> issues, go to
>>
>> 	http://code.google.com/p/msysgit/
>>
>> and install GitMe, currently
>>
>> 	http://msysgit.googlecode.com/files/GitMe-0.4.2.exe
>>
>> If you only care about an end-user setup, which contains only the git
>> binaries on your system, but no tools to compile them, stay tuned for
>> one or two days. We'll release an updated installer soon.
>
> Sorry I wasn't clear: I want neither.  I don't think I will have
> enough free time to become an active contributor to GIT any time
> soon.  OTOH, since binaries are not available (and I'd prefer a
> tarball as opposed to an installer, to be more in control of what's
> being installed and where),

Ok, so I uploaded the most recent preview of the installer to

http://msysgit.googlecode.com/files/WinGit-1.5.3-preview20071010.exe

Note, we're about to release an updated version soon. Personally,
I don't plan to put work in providing tar balls. A working installer
has higher priority for me.


> I asked about the development tools
> (compiler and Binutils, obviously, but what else?) required to build
> the source tarball with MinGW tools.
>
> Do I understand correctly that building GIT currently requires MSYS?
> That'd be unfortunate, at least for me.

msysgit's GitMe contains all tools from MSYS required to build git.
It also clones the git source and compiles it. It doesn't install
anything outside the folder that you chose upon installation.

I strongly believe it is the easiest way to compile git from source.

	Steffen
