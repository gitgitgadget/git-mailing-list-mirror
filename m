From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Big project, slow access!
Date: Fri, 18 Sep 2009 15:02:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909181455580.24133@xanadu.home>
References: <ffb2c0280909181138r7fde8722n80be4bdf95864c37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Toan Pham <tpham3783@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 21:03:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoijY-0001oL-Mv
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 21:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbZIRTC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 15:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbZIRTCz
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 15:02:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25025 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbZIRTCy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 15:02:54 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQ6003I9KWXMGS0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 18 Sep 2009 15:02:57 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <ffb2c0280909181138r7fde8722n80be4bdf95864c37@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128804>

On Fri, 18 Sep 2009, Toan Pham wrote:

> Hi,
> 
> I use git to maintain a project that is at least 8 gigs in size.
> The project is a Linux from Scratch repository that includes source
> codes to approximately 2000 open source projects,
> gcc tool-chain, 1000+ configurations for different software packages,
> source code for different kernel versions,
> and many linux distributions/flavors resulted from this LFS build environment.

How did you organize things in your repository?

> The git's object repository is now 4.6 gigs and consists of approx.
> 610,000 files and folders.
> The speed of git is now terribly slow.  Each time I use basic commands
> like 'git status' or 'git diff',
> it would take at least 5 minutes for git to give me back a result.

Did you repack your repository?  If so, what parameter did you use?

> Again, the machine that i run git on is a P4 3.2 gig-hertz with HT.

If so you'll have problems repacking your repository.  You'd need a 
64-bit machine with enough RAM to be able to make the repository fully 
packed, so it might then be tight enough to fit more confortably on a 
32-bit machine afterwards.

> would  someone please recommend on how i can optimize git's performance?
> Git is so slow, are there better ways to manage a project like this?

You could have a look at submodule support.


Nicolas
