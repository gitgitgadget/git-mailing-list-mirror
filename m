From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push bug?
Date: Thu, 18 Oct 2007 23:00:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710182259190.25221@racer.site>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se> 
 <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de>  <1192723269.9433.21.camel@gentoo-jocke.transmode.se>
  <Pine.LNX.4.64.0710181720010.25221@racer.site> <1192725116.4954.7.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, git <git@vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Fri Oct 19 00:01:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IidQG-0001EO-Gq
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 00:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758065AbXJRWAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 18:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757135AbXJRWAq
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 18:00:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:48279 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756593AbXJRWAp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 18:00:45 -0400
Received: (qmail invoked by alias); 18 Oct 2007 22:00:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 19 Oct 2007 00:00:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18IDFEVJqEILKuYv9wjM+fF/SirtlI1ToOMWk8Elt
	OYMlfC/wJvsPi3
X-X-Sender: gene099@racer.site
In-Reply-To: <1192725116.4954.7.camel@gentoo-jocke.transmode.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61563>

Hi,

On Thu, 18 Oct 2007, Joakim Tjernlund wrote:

> On Thu, 2007-10-18 at 17:21 +0100, Johannes Schindelin wrote:
> 
> > On Thu, 18 Oct 2007, Joakim Tjernlund wrote:
> > 
> > > Seems like it is a bit too easy to make mistakes here. Why can I 
> > > delete a branch with :linus but not create one with linus:linus?
> > 
> > I wonder why you bother with the colon at all.  Just
> > 
> > 	git push <remote> linus
> > 
> > and be done with it.  The colon is only there to play interesting 
> > games, not something as simple as "push this branch" or "push this 
> > tag".
> 
> First, I didn't know that I could do that. Secondly, I was also looking 
> do v2.6.23:linus refspecs


First, then our documentation could be better.  How?

Second, why not "git checkout -b linus v2.6.23 && git push origin linus"?

Ciao,
Dscho
