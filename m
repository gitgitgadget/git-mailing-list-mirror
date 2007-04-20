From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: History cleanup/rewriting script for git
Date: Fri, 20 Apr 2007 20:39:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704202037140.8822@racer.site>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704191118050.8822@racer.site>
 <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
 <20070420155446.GA11506@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jan Harkes <jaharkes@cs.cmu.edu>
X-From: git-owner@vger.kernel.org Fri Apr 20 20:39:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hey18-0000Hu-CS
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 20:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767185AbXDTSjb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 14:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767188AbXDTSjb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 14:39:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:59582 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1767185AbXDTSja (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 14:39:30 -0400
Received: (qmail invoked by alias); 20 Apr 2007 18:39:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 20 Apr 2007 20:39:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pqjlz9KppOuFz0/OA6+jxYbH3S+sJq0bZy1v1mu
	v0wCMLgQrrSTxa
X-X-Sender: gene099@racer.site
In-Reply-To: <20070420155446.GA11506@delft.aura.cs.cmu.edu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45121>

Hi,

On Fri, 20 Apr 2007, Jan Harkes wrote:

> On Thu, Apr 19, 2007 at 09:43:50AM -0700, Linus Torvalds wrote:
> > On Thu, 19 Apr 2007, Johannes Schindelin wrote:
> >
> > > Hmm. However, I have to say that cogito serves/d another purpose 
> > > quite well: Look at what came from cogito into git. Loads of useful 
> > > enhancements. So, I really have to point to "at this stage", because 
> > > that sure was not true 18 months ago.
> > 
> > Absolutely. I think there are still some pieces of cogito that we 
> > might want to migrate into git too, although they're fairly esoteric 
> > (ie the whole history rewriting thing). And I think we still have some 
> > places
> 
> I actually have a fairly simple history rewriting script (written in 
> python) that I used when I converted some CVS archives to git.

Telling by your description, cg-admin-rewrite-hist is more capable. And I 
think it should not be too complicated to rewrite the cogito specific 
parts, what with the parts we added to Git with cogito as a model. And it 
is in Perl... which makes it more portable than Python in my part of the 
world.

Ciao,
Dscho
