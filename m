From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Thu, 26 Jul 2007 15:26:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707261526090.14781@racer.site>
References: <Pine.LNX.4.64.0707260630570.14781@racer.site>
 <46A84E06.2ED4CFBC@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 16:27:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE4J4-0002fz-8H
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 16:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761632AbXGZO1G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 10:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761281AbXGZO1F
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 10:27:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:43389 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760844AbXGZO1D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 10:27:03 -0400
Received: (qmail invoked by alias); 26 Jul 2007 14:27:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 26 Jul 2007 16:27:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/T7SczWPTTifha1R0CUYmiQoh6Zd5CJGaB3ok/HL
	zwIWmerWEliI/V
X-X-Sender: gene099@racer.site
In-Reply-To: <46A84E06.2ED4CFBC@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53834>

Hi,

On Thu, 26 Jul 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> > 
> > When you select the context menu item "Split Hunk" in the diff area,
> > git-gui will now split the current hunk so that a new hunk starts at
> > the current position.
> > 
> > For this to work, apply has to be called with --unidiff-zero, since
> > the new hunks can start or stop with a "-" or "+" line.
> 
> For chrissake, NO!
> 
> I tried this already, and it immediately corrupted my data.
> 
> The problem case is when the hunk you want to apply is not the first one
> and the first one does not add and remove the same number of lines. In
> this case, all that git-apply can do is to rely on line numbers. But
> they are WRONG and apply the patch at the WRONG spot.
> 
> First, I didn't believe Linus when he preached that --unidiff-zero is
> bad; it took only a day to become a follower. ;)

Okay, convinced.  But I have some issues there, which I will outline in 
the reply to Shawn.

Ciao,
Dscho
