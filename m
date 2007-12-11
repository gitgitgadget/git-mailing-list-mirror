From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: v1.5.4 plans
Date: Tue, 11 Dec 2007 12:57:28 +0000 (UTC)
Message-ID: <Pine.LNX.4.64.2903301355300.27959@racer.site>
References: <20071022061115.GR14735@spearce.org> <7vodeecyni.fsf@gitster.siamese.dyndns.org>
 <7vpryqwtt7.fsf@gitster.siamese.dyndns.org> <7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
 <7vy7d43ptc.fsf@gitster.siamese.dyndns.org> <7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
 <7vy7cwsi3p.fsf@gitster.siamese.dyndns.org> <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
 <7v63zjgoel.fsf@gitster.siamese.dyndns.org> <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
 <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> <7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
 <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.0.99999.0712102249180.555@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 13:57:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J24g4-0002la-3e
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 13:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbXLKM5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 07:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbXLKM5L
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 07:57:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:54743 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752107AbXLKM5K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 07:57:10 -0500
Received: (qmail invoked by alias); 11 Dec 2007 12:57:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 11 Dec 2007 13:57:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+nH7lRntGn/7O+I/hFIdupP0T+WHWPrtl2gdzNAL
	WFUZMuz7leMMIq
Date: Fri, 30 Mar 2029 13:56:20 +0100 (BST)
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.99999.0712102249180.555@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67848>

Hi,

On Mon, 10 Dec 2007, Nicolas Pitre wrote:

> On Mon, 10 Dec 2007, Junio C Hamano wrote:
> 
> > There are outstanding issues that need to be resolved:
> > 
> >  * We need to do something about "gc --aggressive".  The documentation
> >    removal patch from Linus, if it ever materializes, would be better
> >    than nothing, but I have this nagging suspicion that the explosion is
> >    merely a bad interation between -A and -f option to the repack, which
> >    are not meant to be used together.
> 
> Well, with the gcc repo, simply using 'git repack -a -f' with current 
> default window size does produce a 2.1GB pack, while changing the window 
> size to 100 (keeping default delta depth) produces a 400MB pack for me.
> 
> So this is really a matter of not having a sufficiently large window for 
> some data sets.

So my dumb patch to simply default to window and depth 250 with 
aggressive was not _that_ dumb after all?

Ciao,
Dscho
