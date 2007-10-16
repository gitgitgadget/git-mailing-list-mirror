From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 14:15:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161414270.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <471448D0.6080200@op5.se> <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
 <Pine.LNX.4.64.0710161324490.25221@racer.site> <E1IhlvV-0002qv-1K@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: ae@op5.se, barkalow@iabervon.org, raa.lkml@gmail.com,
	tsuna@lrde.epita.fr, git@vger.kernel.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 15:16:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhmHS-0004Hk-1X
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 15:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbXJPNQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 09:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755203AbXJPNQG
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 09:16:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:41784 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754302AbXJPNQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 09:16:05 -0400
Received: (qmail invoked by alias); 16 Oct 2007 13:16:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 16 Oct 2007 15:16:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188iZVUGZQ8vayXDInhLn/w73B0Y0OUT0dUZ6h0XR
	H4PExX54+qA8gD
X-X-Sender: gene099@racer.site
In-Reply-To: <E1IhlvV-0002qv-1K@fencepost.gnu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61165>

Hi,

On Tue, 16 Oct 2007, Eli Zaretskii wrote:

> > Date: Tue, 16 Oct 2007 13:29:41 +0100 (BST)
> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > cc: Andreas Ericsson <ae@op5.se>, barkalow@iabervon.org, raa.lkml@gmail.com, 
> >     tsuna@lrde.epita.fr, git@vger.kernel.org
> > 
> > > > 	removed: README
> > > > 	untracked: readme
> > > 
> > > This is a non-issue, then: Windows filesystems are case-preserving, so 
> > > if `README' became `readme', someone deliberately renamed it, in which 
> > > case it's okay for git to react as above.
> > 
> > No, it is not.  On FAT filesystems, for example, I experienced Windows 
> > happily naming a file "head" which was created under then name "HEAD".
> 
> What program did that, and how did you see that the file was named
> "head" instead of "HEAD"?

Git and ... Git.

> > > Something for Windows users to decide, I guess.  It's not hard to 
> > > refactor this, it just needs a motivated volunteer.
> > 
> > You?
> 
> Maybe some day.

Cool.

> > > Unless that 10K is a typo and you really meant 100K, I don't think 
> > > 10K files should take several seconds to scan on Windows.  I just 
> > > tried "find -print" on a directory with 32K files in 4K 
> > > subdirectories, and it took 8 sec elapsed with a hot cache.  So 10K 
> > > files should take at most 2 seconds, even without optimizing file 
> > > traversal code.  Doing the same with native Windows system calls 
> > > ("dir /s") brings that down to 4 seconds for 32K files.
> > 
> > On Linux, I would have hit Control-C already.  Such an operation 
> > typically takes less than 0.1 seconds.
> 
> We were not comparing Linux with Windows, we were talking about Windows 
> user experience.  On Windows 4 seconds is not too long.

Well, I was talking about user experience.  In this case of a user who 
happens to be on Windows, but knows Linux' speed.

Ciao,
Dscho
