From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 01:19:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807170105280.4318@eeepc-johanness>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <20080716214849.GF2925@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 01:20:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJGI1-0007bH-Pi
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 01:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759818AbYGPXTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 19:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759811AbYGPXTG
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 19:19:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:43688 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759805AbYGPXTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 19:19:05 -0400
Received: (qmail invoked by alias); 16 Jul 2008 23:19:03 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp008) with SMTP; 17 Jul 2008 01:19:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mSbARMqSmvdoambIegu2q5PuE6Pq92cehff9ADx
	vdLWigkFpf5GJv
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080716214849.GF2925@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88781>

Hi,

On Thu, 17 Jul 2008, Dmitry Potapov wrote:

> On Wed, Jul 16, 2008 at 06:21:02PM +0100, Johannes Schindelin wrote:
> > 
> > I had the pleasure of introducing Git to a few users in the last 
> > months and in my opinion, restricting myself to teaching them these 
> > commands first helped tremendously:
> > 
> > - clone, pull, status, add, commit, push, log
> 
> Yes, it is a good list, and I think it is very important at the 
> beginning to limit the number commands to 7-8, otherwise many users may 
> be confused. And, of course, it is better to stay away from all 
> command-line options at first...

Thanks.

> > All of these were presented without options, to keep things simple.
> > 
> > In particular, I refrained from giving them the "-a" option to commit.  
> > That seemed to help incredibly with their embracing the index as a 
> > natural concept (which it is).
> 
> Most things that we call as "natural" is those that we got used.

In this case, I have to add that it is natural because it is the way you 
_have_ to do it.  Even if the other SCMs hide it.

You almost never commit a full revision.  You usually update just a couple 
of files.  Now, even CVS has an extra command to add a file, so it accepts 
the fact that staging and committing are two different operations, even if 
"cvs add" does not stage the changes of a tracked file.

Of course, it is easier for us: we can use all the lessons learnt from 
CVS.

> > Now, it makes me really, really sad that Git has a reputation of being 
> > complicated, but I regularly hear from _my_ users that they do not 
> > understand how that came about.
> 
> I think this reputation is largely due to people who open Git user
> manual, read about >100 commands, were horrified and stopped learning.

Heh.  I catually would be delighted if one outcome of this discussion 
would be that the user manual starts with a nice big chapter describing 
just my first set of commands, without options.

Another nice outcome could be if all the plumbing man pages were moved 
into a different section, and all the porcelain's man pages would be 
changed to avoid referring to plumbing.

It could be a good idea, too, to explain advanced topics not by command, 
but by scenario.

> > Am I the only one who deems teaching plumbing to users ("I like it 
> > raw!  So I teach it the same way!") harmful?
> 
> There is only one thing that seems to be true about teaching Git (or
> anything else) -- there is no single method that works equally well
> for anyone.

I disagree.  I think that the first steps are the same for everyone.

Ciao,
Dscho
