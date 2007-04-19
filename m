From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 10:37:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704191033290.8822@racer.site>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> 
 <20070417104520.GB4946@moonlight.home>  <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
  <200704171818.28256.andyparkins@gmail.com>  <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl>  <Pine.LNX.4.64.0704181130150.12094@racer.site>
  <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <8b65902a0704181308i41c878ebi88c03a929769ba39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 10:38:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeS9e-0000zZ-TO
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 10:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993196AbXDSIiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 04:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993200AbXDSIiG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 04:38:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:58177 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2993196AbXDSIiC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 04:38:02 -0400
Received: (qmail invoked by alias); 19 Apr 2007 08:38:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 19 Apr 2007 10:38:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18fhfc8HEAfOUe3rNpkIUCGbeqymcRZj0TS3KpKXM
	k8X1GbBgode0i2
X-X-Sender: gene099@racer.site
In-Reply-To: <8b65902a0704181308i41c878ebi88c03a929769ba39@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44994>

Hi,

On Wed, 18 Apr 2007, Guilhem Bonnefille wrote:

> I don't know lot of corporate teams, but here, our developers are
> REALLY not motivated by VCS. It's only a way to share work. And I'm
> not talking about concurrent modification: lot of people in my office
> really think that the better model is the locked one.
> These people won't be the guy who set up the repo. These people only
> expect a system to:
> - retrieve and merge the job done by other people
> - archive their job for other people.

How is that not concurrent? If it really was not, there would be no need 
to merge.

And let's face it: merging with CVS is cumbersome. Why? Exactly because 
CVS pretends (and tries to make you, too!) that there is just one branch.

Guess what. There are two branches. And they are conflicting. So, once you 
really looked at the problem you really should agree that branches are the 
natural mental model to deal with conflicts.

> So for such people, I really think raw Git is much more complicated than 
> CVS/SVN.

I imagine that somebody dedicated enough -- i.e. not me -- could set up 
some standard aliases which do the CVS/SVN equivalent; we'd probably need 
to support something like

	[alias]
		ci = commit -a && push origin

which should not be all that hard.

Ciao,
Dscho
