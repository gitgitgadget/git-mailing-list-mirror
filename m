From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 15 Feb 2008 00:08:57 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802150007480.30505@racer.site>
References: <200802081828.43849.kendy@suse.cz> <m3y79nb8xk.fsf@localhost.localdomain> <alpine.LSU.1.00.0802142054080.30505@racer.site> <200802142300.01615.jnareb@gmail.com> <alpine.LSU.1.00.0802142334480.30505@racer.site> <20080214235129.GU27535@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Fri Feb 15 01:09:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPo94-0005RC-MI
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 01:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757784AbYBOAJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 19:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757888AbYBOAJE
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 19:09:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:41772 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756466AbYBOAJB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 19:09:01 -0500
Received: (qmail invoked by alias); 15 Feb 2008 00:08:59 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO [192.168.1.75]) [86.138.198.40]
  by mail.gmx.net (mp009) with SMTP; 15 Feb 2008 01:08:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Deagb9sbDLXiN58QCDSN+ldPdhnKWYzPHwptfRo
	aboaru5X915t2u
X-X-Sender: gene099@racer.site
In-Reply-To: <20080214235129.GU27535@lavos.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73932>

Hi,

On Thu, 14 Feb 2008, Brian Downing wrote:

> On Thu, Feb 14, 2008 at 11:38:24PM +0000, Johannes Schindelin wrote:
> > Heh.  I was too lazy to look up the usage, so I just did what I 
> > thought would make sense...
> > 
> > So here it goes:
> > 
> > $ git verify-pack -v 
> > objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack | 
> > ~/git/contrib/stats/packinfo.pl | tee packinfo.txt
> >       all sizes: count 601473 total 2855826280 min 0 max 62173032 mean 
> > 4748.05 median 232 std_dev 221254.37
> >  all path sizes: count 601473 total 2855826280 min 0 max 62173032 mean 
> > 4748.05 median 232 std_dev 221254.37
> >      tree sizes: count 601473 total 2855826280 min 0 max 62173032 mean 
> > 4748.05 median 232 std_dev 221254.37 tree path sizes: count 601473 
> > total 2855826280 min 0 max 62173032 mean 4748.05 median 232 std_dev 
> > 221254.37
> >          depths: count 2477715 total 70336238 min 0 max 250 mean 28.39 
> > median 4 std_dev 55.49
> > 
> > Something in my gut tells me that those four repetitive lines are not 
> > meant to look like they do...
> 
> Do you by chance have repack.usedeltabaseoffset turned on?

Ouch.  That must have been a leftover from earlier attempts.  I did not 
_mean_ to keep it, but now that I have a pretty packed repository, I think 
I'll just keep it as-is.

Ciao,
Dscho
