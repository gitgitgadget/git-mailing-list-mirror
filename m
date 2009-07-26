From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Performance issue of 'git branch'
Date: Sun, 26 Jul 2009 12:16:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907261214220.8306@pacific.mpi-cbg.de>
References: <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain> <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain> <20090724234648.GA4616@Pilar.aei.mpg.de>
 <20090725004122.GA28477@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907251046140.3960@localhost.localdomain> <20090725215739.d074e947.tihirvon@gmail.com> <20090725203130.GB1640@glandium.org> <alpine.LFD.2.01.0907251353410.3960@localhost.localdomain>
 <20090726075455.GA22525@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 12:16:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV0mZ-00053G-9j
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 12:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbZGZKQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 06:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbZGZKQe
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 06:16:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:50003 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753363AbZGZKQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 06:16:34 -0400
Received: (qmail invoked by alias); 26 Jul 2009 10:16:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 26 Jul 2009 12:16:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LM1083/iLr7NWPRrZwwOjWuhckWsblaSblw8aBX
	lWP4uwtmad1BFD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090726075455.GA22525@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124117>

Hi,

On Sun, 26 Jul 2009, Mike Hommey wrote:

> On Sat, Jul 25, 2009 at 02:02:19PM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Sat, 25 Jul 2009, Mike Hommey wrote:
> > 
> > > On Sat, Jul 25, 2009 at 09:57:39PM +0300, Timo Hirvonen wrote:
> > > > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > > 
> > > > > So curl really must die. It may not matter for the expensive operations, 
> > > > > but a lot of scripting is about running all those "cheap" things that just 
> > > > > add up over time.
> > > > 
> > > > SELinux is the problem, not curl.
> > > 
> > > I think it's NSS, the problem, not SELinux. Linus's libcurl is built
> > > against NSS, which is the default on Fedora.
> > 
> > Well, it kind of doesn't matter. The fact is, libcurl is a bloated 
> > monster, and adds zero to 99% of what git people do.
> 
> Especially consideting the http transport fails to be useful in various
> scenarios.

I beg your pardon?  Maybe "s/useful/desirable/"?

In many scenarios, http transport is the _last resort_ against overzealous 
administrators.  The fact that you might be lucky enough not to need that 
resort is a blessing, and does not give you the right to ridicule those 
who are unfortunate enough not to share your good luck.

Ciao,
Dscho
