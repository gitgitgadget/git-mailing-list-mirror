From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 14:24:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161422110.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <Pine.LNX.4.64.0710160032020.7638@iabervon.org> <E1IhgT2-0000bg-O6@fencepost.gnu.org>
 <Pine.LNX.4.64.0710161335260.25221@racer.site> <E1IhmHM-0002hB-HR@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: barkalow@iabervon.org, raa.lkml@gmail.com, ae@op5.se,
	tsuna@lrde.epita.fr, git@vger.kernel.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 15:24:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhmPl-0006PZ-R1
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 15:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000AbXJPNYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 09:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbXJPNYm
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 09:24:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:41392 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757638AbXJPNYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 09:24:41 -0400
Received: (qmail invoked by alias); 16 Oct 2007 13:24:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 16 Oct 2007 15:24:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qD28soq0qO4cedG1ZoeTcdeAuwWWQ/jnBO36/OJ
	0OUM2eY0CczSTY
X-X-Sender: gene099@racer.site
In-Reply-To: <E1IhmHM-0002hB-HR@fencepost.gnu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61171>

Hi,

On Tue, 16 Oct 2007, Eli Zaretskii wrote:

> > Date: Tue, 16 Oct 2007 13:39:12 +0100 (BST)
> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > cc: Daniel Barkalow <barkalow@iabervon.org>, raa.lkml@gmail.com, ae@op5.se, 
> >     tsuna@lrde.epita.fr, git@vger.kernel.org
> > 
> > > As I wrote in my other message, using native APIs improves 
> > > performance by at least a factor of two.
> > 
> > Somehow this does not appeal to my "portability is good" side.  You 
> > know, if we had to do such trickeries for every platform we support, 
> > we'd soon be as big as Subversion *cough*.
> 
> You have to decide whether you care about performance enough to do
> that or not.

Yes, I know that we'll have to use more special casing of Windows for 
performance reasons.  I was only lamenting that it would not need to be 
that way.  Just ignore me.

> > For me, this is the most annoying part about programming Win32.  They 
> > went out of their way to make it incompatible with everything else, 
> > and as a consequence it is a PITA to maintain crossplatform programs.
> 
> Portability is a two-way street.  A program that wasn't designed to be 
> portable will by definition be hard to port.  To me, what's annoying is 
> a program that was designed around a single-OS model of APIs.

You're obviously not talking about git here.

> > Explorer often accesses files it should not lock.  On the machine I 
> > test msysGit on, this is the most common reason for a test case to 
> > fail: it cannot delete the temporary directory, which _should_ be 
> > unused.  Indeed, a second after that, it _is_ unused.
> 
> One more reason not to launch Explorer, if you ask me ;-)  But maybe you 
> have valid reasons to do that.  All I can say is that I never saw such 
> problems, but then I don't usually run programs that rewrite files in a 
> frenzy.

Funny.  Last time I checked the toolbar went away, as well as the desktop, 
when I killed explorer.exe.

Ciao,
Dscho
