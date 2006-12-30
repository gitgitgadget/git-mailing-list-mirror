From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 30 Dec 2006 12:22:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612301217010.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vtzzfp86x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612291853210.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612292219280.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 30 12:22:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0cHz-0005i2-6b
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 12:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWL3LWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 06:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbWL3LWH
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 06:22:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:59630 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751665AbWL3LWG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 06:22:06 -0500
Received: (qmail invoked by alias); 30 Dec 2006 11:22:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 30 Dec 2006 12:22:04 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0612292219280.18171@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35615>

Hi,

On Fri, 29 Dec 2006, Nicolas Pitre wrote:

> On Fri, 29 Dec 2006, Johannes Schindelin wrote:
> 
> > On Thu, 28 Dec 2006, Junio C Hamano wrote:
> > 
> > > * jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
> > >  + git-merge: preserve and merge local changes when doing fast
> > >    forward
> > 
> > I'd like this, but behind a command line switch. And in addition to 
> > saying "cannot merge, blabla needs update", git could spit out "if you 
> > want to risk a 3way merge, go ahead and add the --preserve-local flag 
> > to git-merge".
> > 
> > Comments?
> 
> Is there really a point for not always doing it?
> 
> IOW, if you really want a command line switch, maybe it should be used 
> to prevent the above not to allow it?

There is a drawback to enabling this all the time. If the merge screws up 
with gazillions of conflicts, because I pulled the wrong branch, I am so 
used to "git reset --hard". Bummer. All my changes lost.

That is why we encourage commit-before-pull, to have a saved state.

(Of course, the correct thing would not be "git reset --hard", but rather 
"git diff --ours | git apply -R; git reset", but that's a tad long, no?)

Ciao,
Dscho
