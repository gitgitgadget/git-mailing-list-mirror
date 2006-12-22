From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (stable)
Date: Fri, 22 Dec 2006 21:44:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612222141060.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net> <86k60jsvh8.fsf@blue.stonehenge.com>
 <86fyb7sv9f.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0612221902490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <861wmrsstc.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0612221949490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7virg3zo1k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Fri Dec 22 21:44:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxrFv-00085L-U7
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 21:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbWLVUoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 15:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbWLVUoh
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 15:44:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:34571 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752647AbWLVUoh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 15:44:37 -0500
Received: (qmail invoked by alias); 22 Dec 2006 20:44:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 22 Dec 2006 21:44:35 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virg3zo1k.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35214>

Hi,

On Fri, 22 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > HOWEVER, it has been in "What's cooking in git (topics)".
> >
> > Having said that, we could (at least for some time) print a big red 
> > warning for the specific case of "git pull" meaning "git pull origin 
> > <whateveristhefirstfetchedhead>" that this will GO AWAY SOON.
> >
> > Of course, you would not see it. Only your script.
> >
> > BTW I would _never_ allow a script to rely on such a DWIM feature.
> 
> That's too strong a statement.  It is not DWIM but has been a
> longstanding rule to use "the first set of branches" for the
> merge.  We've merged the first set of branches since day one,
> and even after branch.*.merge we've done so unless you do not
> have such configuration.

Okay, I have been wrong. My sincere apologies.

So, if I understand your option (2) correctly, it complains _only_ if 
there is at least one branch.*.merge in the config, but not for the 
current branch?

I think that would safeguard the existing repositories _and_ the new ones, 
because git-clone sets them up with such an entry to begin with.

If that behaviour was meant by (2), I am all for it.

Ciao,
Dscho
