From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make use of stat.ctime configurable
Date: Tue, 29 Jul 2008 12:49:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807291246270.4631@eeepc-johanness>
References: <7vr69lihkt.fsf@gitster.siamese.dyndns.org> <20080723164614.GB5283@blimp.local> <alpine.DEB.1.00.0807231757550.8986@racer> <20080723191647.GF5283@blimp.local> <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org> <20080725055547.GA3699@blimp.local>
 <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness> <20080726153802.GA16868@blimp.local> <7v1w1f155p.fsf@gitster.siamese.dyndns.org> <20080728063128.GA4234@blimp.local> <20080728160446.GA16351@old.davidb.org> <alpine.LFD.1.10.0807280906530.3486@nehalem.linux-foundation.org>
 <7vbq0ho5g7.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807281817230.3486@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, David Brown <git@davidb.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 12:50:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNmm9-00012I-Mv
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 12:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbYG2Ksr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 06:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755522AbYG2Ksr
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 06:48:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:56282 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754936AbYG2Ksq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 06:48:46 -0400
Received: (qmail invoked by alias); 29 Jul 2008 10:48:45 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp022) with SMTP; 29 Jul 2008 12:48:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Evt07kFBEVpB1ETYHij8XetNGj/M4d8zMh0s9LI
	aRWHqMEXSBw3gH
X-X-Sender: user@eeepc-johanness
In-Reply-To: <alpine.LFD.1.10.0807281817230.3486@nehalem.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90612>

Hi,

On Mon, 28 Jul 2008, Linus Torvalds wrote:

> On Mon, 28 Jul 2008, Junio C Hamano wrote:
> > >
> > > Anybody who uses extended attributes as part of a indexing scheme is 
> > > just insane. Modifying the file you are indexing is not just 
> > > fundamentally wrong to begin with, but it will then also be 
> > > incredibly inefficient to read those entries one at a time.
> > 
> > It's a typo and you are saying it _is_ fundamentally wrong, aren't 
> > you?
> 
> Not a typo, and I'm sayin that "it's not _just_ fundamentally wrong"
> 
> So yes, it's fundamentally wrong, but it's worse than that. It's 
> fundamentally wrong _and_ it's inefficient as hell.

I haven't looked at Beagle's source code either, but as a _user_ I can say 
that it really became horribly, horribly slow after half a year of normal 
usage.

And yes, uninstalling Beagle, backing up the files, reformatting and 
putting the files back (to really get rid of the extended attributes 
already in the file system) helped.

So the first thing I did, back when I still used openSUSE, was to 
uninstall Beagle after the system install.

Ciao,
Dscho
