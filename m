From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 10:19:53 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711271013310.9605@xanadu.home>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com>
 <Pine.LNX.4.64.0711271109130.27959@racer.site>
 <alpine.LFD.0.99999.0711270917580.9605@xanadu.home>
 <20071127150829.GB3853@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-2022-JP?Q?=1B$B$i$$$7$J$J$3=1B=28J?= <nanako3@bluebottle.com>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 16:20:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix2EY-0006Zt-Ps
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 16:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567AbXK0PT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 10:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756664AbXK0PT4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 10:19:56 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54061 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756317AbXK0PTz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 10:19:55 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS600L0H7X5U1K0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Nov 2007 10:19:54 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071127150829.GB3853@fieldses.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66228>

On Tue, 27 Nov 2007, J. Bruce Fields wrote:

> On Tue, Nov 27, 2007 at 09:29:21AM -0500, Nicolas Pitre wrote:
> > Being much more involved in the maintenance of a published Git tree 
> > lately, I must disagree with the "wrong workflow" statement.  Until the 
> > stuff I maintain is finally merged upstream, I have to constantly 
> > amend/replace/fold/split random commits in my repo to follow the review 
> > cycles involved.  yet I have to publish the result to let others base 
> > their work on top of my latest tree.  A fetch+rebase is the only option 
> > for those following my tree, and I made it clear that they have to 
> > rebase after a fetch because I constantly rebase commits that I have 
> > already published myself.
> 
> Right.  But a rebase "merge strategy" doesn't work for those people,
> because it's not possible in general for their git to know exactly which
> part is their work (which needs to be rebased) and which is your old
> work (which should be discarded).  Manual inspection is required.

I don't follow.

Their work is always origin/master@{1}..HEAD after origin/master has 
been updated through a fetch, and it needs to be rebased on 
origin/master.

> > And in this case, constant rebasing is a perfectly fine work flow to me. 
> 
> Again, if you have people basing work on top of yours, I think the best
> option may really be to add a merge commit on top of each new version of
> the series with first parent the new series and second parent the
> previous history.
> 
> That way the history does have the information necessary to rebase their
> work automatically.

And my repo will then be full of clutter which no one upstream will ever 
accept to merge.  Can't do that.


Nicolas
