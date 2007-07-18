From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] Add git-rewrite-commits
Date: Wed, 18 Jul 2007 12:05:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707181204300.14781@racer.site>
References: <11842671631744-git-send-email-skimo@liacs.nl>
 <11842671631635-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0707141140510.14781@racer.site>
 <20070715144435.GH999MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707160054340.14781@racer.site> <20070716200404.GT999MdfPADPa@greensroom.kotnet.org>
 <20070716214756.GA15007MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Wed Jul 18 13:06:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB7Ll-0001VP-4t
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 13:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515AbXGRLFm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 07:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756401AbXGRLFm
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 07:05:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:51433 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754355AbXGRLFm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 07:05:42 -0400
Received: (qmail invoked by alias); 18 Jul 2007 11:05:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 18 Jul 2007 13:05:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Y3ScLs57YuTRpqiUOVrorImAJXPJJw2VIhXD6Ey
	KaROdF/3u5vzud
X-X-Sender: gene099@racer.site
In-Reply-To: <20070716214756.GA15007MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52851>

Hi,

On Mon, 16 Jul 2007, Sven Verdoolaege wrote:

> On Mon, Jul 16, 2007 at 10:04:04PM +0200, Sven Verdoolaege wrote:
> > - a SHA1 of a commit that appears in a commit message is replaced
> >   by the rewritten commit iff it was rewritten to a single commit.
> >   That is, if the commit was pruned or rewritten (through a commit
> >   filter) to more than one commit, then the SHA1 is left alone.
> 
> Sorry.  I misremembered.  I considered doing it this way, but then 
> thought it was better to replace the SHA1 with a(n abbreviated) null 
> SHA1 to signify that the commit had gone.

Yes.  This shows that you did not get my objection.  The commit is not 
replaced with _no_ commits, but with _multiple_ commits.

Ciao,
Dscho
