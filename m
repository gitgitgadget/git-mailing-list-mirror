From: Timur Tabi <timur@freescale.com>
Subject: Re: Did I miss something? git-clone doesn't grab all branches????
Date: Fri, 30 Mar 2007 12:03:58 -0500
Organization: Freescale
Message-ID: <460D42FE.1080703@freescale.com>
References: <460D336E.9040708@freescale.com> <AF0367BA48C55940A43CCF08DF35553C0114148C@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Loeliger Jon-LOELIGER <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 19:04:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXKWH-0000NV-T5
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 19:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbXC3REG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 13:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbXC3REF
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 13:04:05 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:44732 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbXC3REE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 13:04:04 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l2UH3xbA019620
	for <git@vger.kernel.org>; Fri, 30 Mar 2007 10:04:00 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l2UH3wPF008285;
	Fri, 30 Mar 2007 12:03:58 -0500 (CDT)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; it; rv:1.8.1) Gecko/20061010 Firefox/2.0 
In-Reply-To: <AF0367BA48C55940A43CCF08DF35553C0114148C@az33exm24.fsl.freescale.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Loeliger Jon-LOELIGER wrote:
> Timur,
> 
> You missed something. :-) You didn't read the Release
> Notes for 1.5 that I forwarded. 

I didn't get that email.  However, I did read the release notes for 1.5 on the web, and it 
didn't help.  It's as if I'm on a different planet then everyone else who uses git, and so 
no one understands what I'm trying to do.

I hate branches.  I never use them.  I create a whole new tree for each commit that I work 
on.  So I like to have a clone of all of the main external repositories on my hard drive. 
  Then I just clone these local repos into other trees on my hard drive.

In the past, my clone of paulus/powerpc.git contained everything.  Every time I did a 
git-pull, it would grab everything.  Then I could do a local clone/checkout if I ever 
wanted to work on a branch (like for-2.6.22).  I didn't have to know the names of the 
branches when I did git-clone.

Because of the changes to git-clone, this process got a whole lot more complicated.  Now I 
need to issue multiple commands for each branch.  Ugh.

 > As a start, do this:
> 
>     git branch -a

I think I figured it out, but I'm not sure it's working:

git-clone http://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git powerpc.git
cd powerpc.git
git-checkout origin/for-2.6.22
git-checkout -b for-2.6.22

When I do this, git-branch -l shows:

* for-2.6.22
   master

So I think I'm okay.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
