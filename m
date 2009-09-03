From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: jgit diff, was Re: [JGIT] Request for help
Date: Thu, 3 Sep 2009 08:55:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909030846230.8306@pacific.mpi-cbg.de>
References: <4A9EFFB1.9090501@codeaurora.org> <alpine.DEB.1.00.0909030157090.8306@pacific.mpi-cbg.de> <20090903012207.GF1033@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nasser Grainawi <nasser@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 08:54:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj6DN-000312-73
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 08:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670AbZICGy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 02:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754559AbZICGy1
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 02:54:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:36485 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754384AbZICGy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 02:54:26 -0400
Received: (qmail invoked by alias); 03 Sep 2009 06:54:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 03 Sep 2009 08:54:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19JI8BannxJ04JYzNpQIpk7CltNwJ0qffNKnktAzF
	YtJieE12OLXReO
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090903012207.GF1033@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127640>

Hi,

On Wed, 2 Sep 2009, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Wed, 2 Sep 2009, Nasser Grainawi wrote:
> > 
> > > I'm looking to add 'git patch-id' to JGit and I could use a few 
> > > pointers. I'm not very familiar with the JGit code base or Java, so 
> > > please excuse any blatant oversights or unintelligent questions.
> > > 
> > > First off, is there a "hacking JGit" document anywhere? One of those 
> > > would be great right now.
> > 
> > There have been some mails with details about JGit from Shawn (IIRC) 
> > to this very list.
> 
> Yea, for the most part I think we use Eclipse, and you just have to 
> import JGit's top level directory into Eclipse as it comes with Eclipse 
> project files.  But I know some folks only use our Maven build (under 
> jgit-maven/jgit) or use NetBeans.  I have no idea how to import the 
> project into the latter or configure its unit tests to run.

FWIW I use vim & shell most of the time (yes, even for JGit).

> > This is not really difficult in Java, however, it relies on a working 
> > diff implementation (and IIRC my implementation has not yet been 
> > integrated into JGit).
> 
> Speaking of... where does that stand?

Same as where I left off.  IOW it is a working implementation that saw 
some testing, but I simply lack the time for performance tuning.

It should not be all that bad, though.

***goes looking at 
http://repo.or.cz/w/jgit/dscho.git?a=shortlog;h=refs/heads/diff
***

Seems I misremembered a bit.  Christian provided a patch to make it 
compileable, but I think that I ran the script to verify that the diffs 
are correct on jgit.git and IIRC it completed fine.

There is a project in my day-job, however, which eats all my time at the 
moment (it is actually wrapping up a "succeeded" GSoC project where the 
student -- *sigh* -- has gone away).  So all I can do is to rebase to 
current jgit.git's 's master, to run the script, and submit the current 
patch series (valuing correctness over speed).

Ciao,
Dscho
