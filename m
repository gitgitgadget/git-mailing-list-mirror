From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] some shell portability fixes
Date: Wed, 7 Nov 2007 14:47:29 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711071446190.4362@racer.site>
References: <20071106201518.GA6361@ins.uni-bonn.de>  <7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
  <20071106210210.GA32159@glandium.org>  <Pine.LNX.4.64.0711062324590.4362@racer.site>
 <e2b179460711070617h7e9af64egcde5122808a4d924@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 15:47:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpmC6-0003wJ-CL
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 15:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154AbXKGOrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 09:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756796AbXKGOre
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 09:47:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:33256 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755002AbXKGOrd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 09:47:33 -0500
Received: (qmail invoked by alias); 07 Nov 2007 14:47:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 07 Nov 2007 15:47:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191S4ku/m11o1IsFfDrCf5zFYiwDwKjU6fvl10uWJ
	E5Ry3S+zO45RtY
X-X-Sender: gene099@racer.site
In-Reply-To: <e2b179460711070617h7e9af64egcde5122808a4d924@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63811>

Hi,

On Wed, 7 Nov 2007, Mike Ralphson wrote:

> Junio C Hamano wrote on Tue, Nov 06, 2007 at 09:46:35PM CET:
> > [2/5] Gaah, AIX sed X-<.  I am not opposed to this patch but
> >       would want to get Yays from people with non GNU sed.  Is
> >       busybox sed good enough to grok our scripts these days?
> >       Please ask help and collect Acks at least from folks on
> >       Solaris, MacOS, FBSD, and OBSD.
> 
> On Nov 6, 2007 11:25 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > As Junio commented in the part you did not quote, there are better shells
> > in Solaris.  Use those.
> 
> Equally GNU sed is available as a drop-in rpm for AIX. I wonder if it
> would be worth adding
> Makefile support for a PATH prefix for the git scripts, so they could
> prepend (in this case)
> something like /opt/freeware/bin or /usr/linux/bin ?
> 
> In our AIX environment many GNU tools are installed but I can't
> guarantee they come first
> in the paths of the git users.
> 
> I'm willing to work up a patch if there's any interest.

Would that be a task for configure?  Because I am not sure if the GNU 
tools are installed in the same place on all AIX boxen...

Ciao,
Dscho
