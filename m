From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] provide advance warning of some future pack default
 changes
Date: Tue, 18 Dec 2007 12:06:23 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712181204500.23902@racer.site>
References: <20071215004230.GF7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712142114400.8467@xanadu.home> <20071217200920.GB19816@mail.oracle.com>
 <alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
 <7v3au16myj.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999999.0712171641460.8467@xanadu.home>
 <7vbq8o4yxc.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999999.0712172212110.8467@xanadu.home>
 <46a038f90712171952i4f53876fv55b0e6993d5f4b0a@mail.gmail.com>
 <7vlk7s38aq.fsf@gitster.siamese.dyndns.org> <20071218111136.GA6266@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Nicolas Pitre <nico@cam.org>,
	Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 13:07:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4bDw-0004qn-6k
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 13:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbXLRMGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 07:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbXLRMGj
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 07:06:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:39744 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752861AbXLRMGi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 07:06:38 -0500
Received: (qmail invoked by alias); 18 Dec 2007 12:06:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 18 Dec 2007 13:06:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/uPBRPG+vuDIqKLnAUgZfSWeiuxiUgFEpt7uOopb
	KF+FvHl1h6rAYr
X-X-Sender: gene099@racer.site
In-Reply-To: <20071218111136.GA6266@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68734>

Hi,

On Tue, 18 Dec 2007, Jeff King wrote:

> On Mon, Dec 17, 2007 at 09:01:49PM -0800, Junio C Hamano wrote:
> 
> > There indeed are handful scheduled removals.  I do not mind declaring 
> > that 1.6.0 comes after 1.5.4, or just relabel the removal schedule for 
> > 1.6.0 and keep the scheduled change on hold a bit longer.
> 
> I can think of two other user-visible changes which have been discussed 
> that might warrant such a version bump:
>
>   - option parsing tweaks (hopefully these should be minor, but it is
>     clear that we cannot be 100% consistent while retaining the
>     identical previous behavior)

IMHO this does not warrant a version bump.  It should be mostly 
behind-the-scenes, after all.

>   - moving dashed forms out of paths

Playing it safe, and waiting with this after announcing it more obviously, 
is something that I appreciate.  Too many scripts can break, and I am sure 
quite a few of mine will; I simply do not have the time right now to audit 
them.

Ciao,
Dscho
