From: Nicolas Pitre <nico@cam.org>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 19:05:37 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803191856290.2947@xanadu.home>
References: <20080318180118.GC17940@kernel.dk>
 <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org>
 <20080318181948.GH17940@kernel.dk>
 <alpine.LFD.1.00.0803191629240.2947@xanadu.home>
 <20080319211733.GD17940@kernel.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 00:06:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc7Mo-0003U1-LQ
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 00:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766001AbYCSXFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 19:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162767AbYCSXFl
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 19:05:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36179 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766001AbYCSXFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 19:05:38 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JY000M8V2T1M9J0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Mar 2008 19:05:25 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080319211733.GD17940@kernel.dk>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77585>

On Wed, 19 Mar 2008, Jens Axboe wrote:

> On Wed, Mar 19 2008, Nicolas Pitre wrote:
> > On Tue, 18 Mar 2008, Jens Axboe wrote:
> > 
> > > But freshly pulled repo, git auto gc is enabled. And that is my main
> > > annoyance, I just don't think that type of policy should be in there.
> > 
> > Just do this once:
> > 
> > 	git config --global gc.auto 0
> > 	git config --global gc.autopacklimit 0
> > 
> > and be happy.
> 
> You don't get it. I did gc.auto 0. And know some other limit crops up, I
> have to do gc.autopacklimit 0. I have LOTS of git trees. On many
> machines. It's just annoying, period.

As suggested, gc.auto = 0 should probably be made to disable it 
entirely, regardless of any other parameters that might exist.

> > > Print the warning, include info on how to run git gc or even how to turn
> > > it on automatically. But I'll bet you that most users will NOT want auto
> > > gc. Ever.
> > 
> > Unfortunately, the harshest complaints about this whole issue were the 
> > opposite.
> 
> I just don't buy that, I have more faith in users.

We also did in the past... even for a long period...

Alas, it is the users who made us (and actually made Linus, who was the 
last to resist) change our minds.

> If they come around and complain it's slow, heck you told them it 
> would be.

But they don't.  They just presume that Git is crap and move on.

> But it's not a big deal, I'll just carry a local patch that disables
> this crap and forget the whole deal. I just worry that if this is where
> git 'usability' is heading, it wont be a good thing in the long run.

I wish the majority of users was thinking like you.  I, too, have some 
conceptual problems with this auto gc things.  With the experience 
we've gathered, the current state appears to be the 
lesser of all evils though.


Nicolas
