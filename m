From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git push --track
Date: Fri, 15 Jan 2010 15:09:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001151508550.3106@intel-tinevez-2-302>
References: <op.u6g8jnixg402ra@nb-04> <20100114154154.6117@nanako3.lavabit.com> <alpine.DEB.1.00.1001141130210.4985@pacific.mpi-cbg.de> <20100115072741.6117@nanako3.lavabit.com> <20100115134425.GA30986@rm.endoftheinternet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Rudolf Polzer <divVerent@alientrap.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 15:09:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVmry-0002Do-Cx
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 15:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757627Ab0AOOJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 09:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755612Ab0AOOJm
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 09:09:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:42555 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932169Ab0AOOJl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 09:09:41 -0500
Received: (qmail invoked by alias); 15 Jan 2010 14:09:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 15 Jan 2010 15:09:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199uhZanhd9qpN7mBSOT+iePIazDWiNnqHRTurry0
	q0WqiFd+AcKFXY
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20100115134425.GA30986@rm.endoftheinternet.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137072>

Hi,

On Fri, 15 Jan 2010, Rudolf Polzer wrote:

> On Fri, Jan 15, 2010 at 07:27:41AM +0900, Nanako Shiraishi wrote:
> > 'git push --track' was suggested as a way to let users delay that decision.
> > 
> > 'git branch --configure' to update the same information for an existing
> > branch was suggested as an alternative UI. An added benefit is that this
> > approach will allow the same option to be used when creating a branch.
> > 
> > 'git pull --remember' that remembers the options used from the command line
> > was suggested as a solution in addition to 'git branch --reconfigure'. Users
> > can postpone the decision even more than 'git push --track', and it naturally
> > supports setting branch.topic.rebase with 'git pull --rebase --remember'.  It
> > also has two additional benefits. 'push --track' configures what happens when
> > you 'pull' (counter-intuitive), but 'pull --remember' makes 'pull' to change
> > the setting used by 'pull' (much more natural). Also it does not add the
> > confusing word 'track' to the interface (for a more detailed discussion on
> > 'track', see http://article.gmane.org/gmane.comp.version-control.git/136785).

Thanks for the very nice summary!

> Still requires you to specify the remote and the branch name twice.
> 
> So the workflow would be:
> 
> git push origin localbranch:remotebranch
> ...
> git pull --remember origin remotebranch:localbranch
> 
> instead of
> 
> git push --track origin localbranch:remotebranch
> ...
> git pull
> 
> The one thing I want to avoid, is specifying the "origin
> localbranch:remotebranch" stuff twice.
> 
> Doesn't make git pull --remember a bad idea, it's good in many other 
> cases. But in my specific use case, git push --track is the most useful 
> one.

The thing is: done right, the three can share the major part of the code.

Ciao,
Dscho
