From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Move bundle specific stuff into bundle.[ch]
Date: Wed, 18 Jul 2007 17:33:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707181731140.14781@racer.site>
References: <Pine.LNX.4.64.0707172346450.14781@racer.site>
 <Pine.LNX.4.64.0707172216420.14596@iabervon.org> <Pine.LNX.4.64.0707181053130.14781@racer.site>
 <Pine.LNX.4.64.0707181140450.14596@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 18:33:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBCTK-0000RH-6z
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 18:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933079AbXGRQdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 12:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932924AbXGRQdv
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 12:33:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:36434 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932931AbXGRQdu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 12:33:50 -0400
Received: (qmail invoked by alias); 18 Jul 2007 16:33:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 18 Jul 2007 18:33:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PNIdXcBtPAERVnmx1kQuUGD0m3uTNPBAJX2FUAW
	Y70S3gigAF2B9k
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707181140450.14596@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52877>

Hi,

On Wed, 18 Jul 2007, Daniel Barkalow wrote:

> On Wed, 18 Jul 2007, Johannes Schindelin wrote:
> 
> > On Tue, 17 Jul 2007, Daniel Barkalow wrote:
> > 
> > > You should use -C on this sort of thing, so that the interesting aspects 
> > > of the patch are easier to see. (It actually comes out longer in this 
> > > case, but it's far easier to tell that the code in the new file is the 
> > > same as the old code.)
> > 
> > Okay, I wanted it to be kept short, since I really get lost easily in 
> > hundreds of "-" lines, with possibly one in the midst being a "+".
> 
> Actually, putting the functions in the original order made the -C diff 
> shorter than without -C.

True enough!

> > > Aside from presentation, it looks good to me. Shall I stick the 
> > > bundle changes into my series? I'd like to have them come before the 
> > > patch to switch to builtin-fetch, so that there aren't any revisions 
> > > where "git fetch" doesn't have bundle support.
> > 
> > Looks fine to me.  Seems like you should add a SOB line, too.
> 
> Ah, yes. I'll have to see if I'll be the first person in git development 
> to have a SOB line that's neither first nor last. :)

We have 28 commits ATM in next's history, having 3 SOB lines: 
1e76b702c1e754c7e6df1ced9ce6f1863cb7e092 is the most recent one.

> > > And I think it would be best to take part 3 as a review fix to my 
> > > final patch.
> > 
> > Yes, definitely.  This shows again (to me, at least), that just 
> > looking at the code is not enough, you have to run it, too, to review 
> > patches.
> 
> You caught that by running it? I've been running this code, and I've never 
> done anything with it which caused fetch_refs to fail and then checked the 
> result. I thought you must have found it by looking for missing checks of 
> return values. Or did you find it when you'd implemented half of bundle 
> support and it didn't complain?

Exactly.  It is the "bundle 1" test that failed.

Ciao,
Dscho
