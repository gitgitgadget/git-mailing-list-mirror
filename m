From: Nicolas Pitre <nico@cam.org>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 09:31:00 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701310923010.3021@xanadu.home>
References: <87odognuhl.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0701301853300.20138@iabervon.org>
 <Pine.LNX.4.64.0701302052230.3021@xanadu.home>
 <Pine.LNX.4.64.0701302331440.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 15:31:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCGUV-0006te-3l
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 15:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933300AbXAaObL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 09:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933298AbXAaObL
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 09:31:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:14922 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933294AbXAaObK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 09:31:10 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCQ00CW0LNOQFC0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 31 Jan 2007 09:31:01 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0701302331440.20138@iabervon.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38251>

On Wed, 31 Jan 2007, Daniel Barkalow wrote:

> On Tue, 30 Jan 2007, Nicolas Pitre wrote:
> 
> > On Tue, 30 Jan 2007, Daniel Barkalow wrote:
> > 
> > >   warning: you are now browsing the history without a local branch. You 
> > >   will not be able to commit changes unless you create a new local branch 
> > >   with "git checkout -b <new_branch_name>".
> > 
> > This isn't true.  You can commit on top of a detached head.  In fact you 
> > can do almost anything.
> 
> "Commits you make will not be attached to permanent state unless you 
> create a local branch"? I'm not sure how the feature turned out to work, 
> but I know that (a) you're fine if you don't make any commits and (b) the 
> behavior is more like what happens with anonymous checkouts of other 
> people's repositories in non-distributed SCMs, so people will tend to
> underestimate what they can do with this, rather than overestimating it 
> and getting into trouble.
> 
> I suppose it's reasonable to warn at commit time, if we ended up going 
> with allowing commits like normal.

I disagree.

It is not the commit which is dangerous when the head is detached.  It 
is the checkout of another branch.  And this case is covered already 
such that the checkout is refused unless you actually create a branch 
for your detached head or you give -f to checkout to override the 
protection.

Giving a warning at commit time is not the place where the user has to 
be aware of the issue since it is indeed not the place where there is 
any issue to worry about.


Nicolas
