From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid C++ comments, use C comments instead
Date: Tue, 11 Jul 2006 00:55:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607110049470.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060710065751.22902.43316.stgit@dv.roinet.com>
 <7vzmfhdhrf.fsf@assigned-by-dhcp.cox.net> <20060710094653.GA52962@dspnet.fr.eu.org>
 <Pine.LNX.4.63.0607101306030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060710114117.GA62514@dspnet.fr.eu.org> <44B2A709.8020500@serice.net>
 <20060710202412.GA8189@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Serice <paul@serice.net>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 00:56:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G04fg-0003jv-Np
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 00:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965309AbWGJW4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 18:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbWGJW4E
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 18:56:04 -0400
Received: from mail.gmx.de ([213.165.64.21]:45731 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965309AbWGJW4C (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 18:56:02 -0400
Received: (qmail invoked by alias); 10 Jul 2006 22:56:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 11 Jul 2006 00:56:00 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Olivier Galibert <galibert@pobox.com>
In-Reply-To: <20060710202412.GA8189@dspnet.fr.eu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23663>

Hi,

On Mon, 10 Jul 2006, Olivier Galibert wrote:

> On Mon, Jul 10, 2006 at 02:14:17PM -0500, Paul Serice wrote:
> > If you want to write portable code, you have to take into account
> > different operating systems _and_ different compilers.  Writing your
> > code for just a single compiler is almost as bad as writing your code
> > for just a single operating system.
> 
> Hmmm, that was not so much about gcc-specific code than which kind of
> C you want to code to, the one from 1973, the one from 1989 or the one
> from 1999?  I personally don't have much sympathy for the OS vendors
> giving you an older standard C compiler and selling you the up-to-date
> one.

Judging by what you say, one could get the impression you'd have not much 
sympathy for people being stuck with non-C99 compilers.

Just look at it: if the OS vendor just does not _care_, and you blame the 
vendor for not providing something newer, the vendor does not _care_ about 
your complaint either. But the user does.

However, there is a more important point to be made. If you are complying 
with an older standard, you get more users. More users = more bug testers.

And there were quite a few occasions where I found bugs by trying to run 
on a different platform, which was less forgiving than Linux. These are 
bugs you have a harder time to spot on Linux, _because_ Linux is so nice. 
But they will surface. And they will be a PITA to find.

Anyway, it is best practice for a reason to program portably. (Well, at 
least if you are not living in Redmont.)

Ciao,
Dscho
