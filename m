From: Nicolas Pitre <nico@cam.org>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 11:46:48 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711281141150.9605@xanadu.home>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
 <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
 <BAYC1-PASMTP02DBA3FB25E09FE45F0BF2AE770@CEZ.ICE>
 <9e4733910711272037r2ce3ed01y31ec8531f5803efe@mail.gmail.com>
 <alpine.LFD.0.99999.0711280951150.9605@xanadu.home>
 <9e4733910711280758x38ca3cdau4e62bfe8776e5c0d@mail.gmail.com>
 <alpine.LFD.0.99999.0711281125320.9605@xanadu.home>
 <9e4733910711280837o43003e93p470bb403e6bdd3bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sean <seanlkml@sympatico.ca>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:47:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQ4O-0002cg-H1
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761171AbXK1Qqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 11:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761082AbXK1Qqv
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:46:51 -0500
Received: from relais.videotron.ca ([24.201.245.36]:23204 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757238AbXK1Qqu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 11:46:50 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS8000RG6M0TF30@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 28 Nov 2007 11:46:49 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910711280837o43003e93p470bb403e6bdd3bb@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66378>

On Wed, 28 Nov 2007, Jon Smirl wrote:

> On 11/28/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Wed, 28 Nov 2007, Jon Smirl wrote:
> >
> > > On 11/28/07, Nicolas Pitre <nico@cam.org> wrote:
> > > > On Tue, 27 Nov 2007, Jon Smirl wrote:
> > > >
> > > > > Of course you've never screwed up a repository using git commands,
> > > > > right? I've messed up plenty. A good way to mess up a repo is to get
> > > > > the data in .git/* out of sync with what is in the repo. I'm getting
> > > > > good enough with git that I can fix most mess up with a few edits, but
> > > > > it took me two years to get to that point. Rolling back to a check
> > > > > point is way easier. User error and a command failing are both equally
> > > > > valid ways to mess up a repo.
> > > >
> > > > The reflog contains all your check points, for every modifications you
> > > > make, even the stupid ones.  You should look at it.
> > >
> > > The state contained in the other config files in .git/* is not getting
> > > check pointed. I can use reflog to move my branch heads around. But
> > > doing that does not undo the changes to the state recorded in .git/*.
> > > After the error I encountered  I moved my branch head back, but the
> > > state stgit had stored in .git/* was out of sync with where the branch
> > > had been moved to.
> >
> > It's up to stgit to version control its state then.  It may even use a
> > reflog for it.  All the machinery is there already.
> 
> Git has state in .git/* too, shouldn't it be version controlling it
> too? If git was version controlling the state in .git/* you'd have
> checkpoints with the ability to roll back.

Well, the .git directory contains data to identify what is actually 
version controlled.  If you start versioning the data used to implement 
the versioning, don't you get into endless recursion here?


Nicolas




> 
> 
> >
> >
> > Nicolas
> > -
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com
> 


Nicolas
