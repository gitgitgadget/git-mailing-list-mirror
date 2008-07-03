From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Non-inetd git-daemon hangs in syslog(3)/fclose(3) if --syslog
 --verbose accessing non-repositories
Date: Thu, 3 Jul 2008 15:32:23 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807031531320.9925@racer>
References: <200807031400.36315.brian.foster@innova-card.com> <alpine.DEB.1.00.0807031343440.9925@racer> <200807031552.26615.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 16:36:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEPui-000619-Mh
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 16:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758907AbYGCOeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 10:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755678AbYGCOeT
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 10:34:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:36364 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754012AbYGCOeS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 10:34:18 -0400
Received: (qmail invoked by alias); 03 Jul 2008 14:34:15 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp064) with SMTP; 03 Jul 2008 16:34:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19L/AlFspNLXBFy3qzILrUum6qlhoCvIgv8E7nlxN
	mqribtfyyRAI6I
X-X-Sender: gene099@racer
In-Reply-To: <200807031552.26615.brian.foster@innova-card.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87292>

Hi,

On Thu, 3 Jul 2008, Brian Foster wrote:

> On Thursday 03 July 2008 Johannes Schindelin wrote:
> > On Thu, 3 Jul 2008, Brian Foster wrote:
> > >[... describes that git-daemon -v syslog()s in a signal handler,
> > >  which is unsupported ...]
> > 
> > I reported this bug earlier [ ... ]
> 
>  Ah, yes, I've (now) found the (long!) thread, about log-rotation 
>  (which, as you observe, is not the problem).

Yeah, sorry, should have mentioned that.

> Sorry for the duplication.

No need to be sorry.  It may raise awareness so much that somebody gets a 
clever idea how to cope with it.

Ciao,
Dscho
