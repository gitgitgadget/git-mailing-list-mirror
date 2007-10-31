From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Recording merges after repo conversion
Date: Wed, 31 Oct 2007 12:32:01 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710311229560.4362@racer.site>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
 <13D1D3DD-9652-4097-8364-DEF4F26540D3@lrde.epita.fr>
 <Pine.LNX.4.62.0710301433150.652@perkele.intern.softwolves.pp.se>
 <8c5c35580710300729t4a7b375dud01253d9b4ef7196@mail.gmail.com>
 <Pine.LNX.4.62.0710302204590.6976@perkele.intern.softwolves.pp.se>
 <Pine.LNX.4.64.0710310227340.4362@racer.site>
 <Pine.LNX.4.62.0710311048450.13264@perkele.intern.softwolves.pp.se>
 <Pine.LNX.4.64.0710311059020.4362@racer.site> <Pine.LNX.4.64.0710311305290.16298@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Oct 31 13:33:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InCkl-00049e-Up
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 13:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbXJaMcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 08:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754908AbXJaMcq
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 08:32:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:60866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754521AbXJaMcp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 08:32:45 -0400
Received: (qmail invoked by alias); 31 Oct 2007 12:32:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 31 Oct 2007 13:32:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3ZJxuBhv3wBNud3iX4swPMTJWrzuv6uRngF+Lia
	gfTcbLsIB4dTp/
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0710311305290.16298@ds9.cixit.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62823>

Hi,

On Wed, 31 Oct 2007, Peter Karlsson wrote:

> > Yes!  Of course!  If what you want becomes possible, I could make an 
> > evil change in history long gone, and slip it by you. You could not 
> > even see the history which changed.
> 
> I would see the grafts file being changed, which would alert me (the 
> problem I have with graft is that it *replaces* history information for 
> an element, not just *add* to it, which threw me off at my first attempt 
> at creating one).

The thing is: it is too easy to overlook a tiny change like this.  And it 
is very, very difficult to see what it _really_ changed.

Therefore I am _strongly_ opposed to changing the current behaviour.

> > You can do that already.  But you have to ask the people at the other 
> > end to actually apply the graft.
> 
> Last time I tried, git would not add files that was in the ".git" 
> subdirectory to version control. I might have done something 
> incorrectly, though, so I'll see if it works now.

Well, I was not explicit enough.  You can check in the grafts file _under 
a different name_.  Outside of .git/.

Hth,
Dscho
