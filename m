From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Thu, 22 Oct 2009 23:43:05 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910222334040.14365@iabervon.org>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch> <alpine.LNX.2.00.0910202044150.14365@iabervon.org> <20091021031528.GB18997@atjola.homenet> <200910211005.29053.trast@student.ethz.ch>
 <20091023025434.GA29908@sigio.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 23 05:43:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1B3e-0007zD-DO
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 05:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbZJWDnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 23:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbZJWDnD
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 23:43:03 -0400
Received: from iabervon.org ([66.92.72.58]:37744 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbZJWDnC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 23:43:02 -0400
Received: (qmail 19957 invoked by uid 1000); 23 Oct 2009 03:43:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Oct 2009 03:43:05 -0000
In-Reply-To: <20091023025434.GA29908@sigio.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131084>

On Thu, 22 Oct 2009, Jeff King wrote:

> On Wed, Oct 21, 2009 at 10:05:27AM +0200, Thomas Rast wrote:
> 
> > What if any combination of fetch and merge always gave you the long
> > form?  After all, even if you do have a tracking branch for whatever
> > you are merging, that information is probably useless and it would be
> > nicer if all of the following resulted in the long form:
> > 
> > * git fetch git://git.kernel.org/pub/scm/git/git pu
> >   git merge FETCH_HEAD
> > 
> > * git remote add origin git://git.kernel.org/pub/scm/git/git
> >   git fetch origin
> >   git merge origin/pu
> > 
> > * git fetch git://git.kernel.org/pub/scm/git/git pu:tmp
> >   git merge tmp
> 
> Maybe it's just me, but I actually prefer the shorthand names. Five
> years from now when I browse the history and see that I merged
> remote branch "mike/topic", I'll know exactly what that means: developer
> Mike's version of a certain topic branch. But I am not likely to care
> about exactly where we were storing developer repos at that time.
> 
> But probably that is an artifact of the workflow. The scenario I am
> describing above implies a somewhat centralized workflow, where the
> shorthand contains all of the interesting information. In a totally
> distributed, we-don't-share-anything-except-the-url-namespace setup of
> an open source repo, the full URL makes more sense.
> 
> So maybe it is something that should be optional.

Surely you ought to be able to get the short form with "pull", though, if 
you happen to like short forms. So it would make sense to decide how to 
format the merge message based entirely on an option, not at all on 
whether you use pull or fetch+merge.

	-Daniel
*This .sig left intentionally blank*
