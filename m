From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] prune: heed --expire for stale packs, add a test
Date: Wed, 6 Feb 2008 07:41:45 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802060741380.8543@racer.site>
References: <Pine.GSO.4.63.0802051844220.15867@suma3> <alpine.LFD.1.00.0802051357420.2732@xanadu.home> <alpine.LSU.1.00.0802052005200.8543@racer.site> <alpine.LFD.1.00.0802051512370.2732@xanadu.home> <7v7ihi64xm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	David Steven Tweed <d.s.tweed@reading.ac.uk>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 08:43:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMevt-0006Mm-9X
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 08:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760069AbYBFHm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 02:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760067AbYBFHm3
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 02:42:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:39774 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760044AbYBFHm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 02:42:28 -0500
Received: (qmail invoked by alias); 06 Feb 2008 07:42:26 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp021) with SMTP; 06 Feb 2008 08:42:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184KpgKqXM4+uWyO0K5DaXz9uvvqkg9vbHzL7DTUg
	oDVojK3yt+0N3g
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7ihi64xm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72765>

Hi,

On Tue, 5 Feb 2008, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Tue, 5 Feb 2008, Johannes Schindelin wrote:
> >
> >> Follow the same logic as for loose objects when removing stale packs: they
> >> might be in use (for example when fetching, or repacking in a cron job),
> >> so give the user a chance to say (via --expire) what is considered too
> >> young an age to die for stale packs.
> >> 
> >> Also add a simple test to verify that the stale packs are actually
> >> expired.
> >> 
> >> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Acked-by: Nicolas Pitre <nico@cam.org>
> >
> > Nicolas
> 
> They are not "stale packs", but temporary files that wanted to
> become pack but did not succeed.  Perhaps "stale temporary
> packs"?
> 
> Shouldn't we do something similar to objects/pack/pack-*.temp
> files and objects/??/*.temp that http walker leaves?

Yep.

Ciao,
Dscho
