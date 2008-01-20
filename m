From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sun, 20 Jan 2008 14:15:26 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801201352340.5731@racer.site>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
 <alpine.LSU.1.00.0801200142170.5731@racer.site> <07FDB6ED-EBE0-4F66-9167-6A0F8AD58E2B@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 15:16:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGayA-0005Yb-Gp
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 15:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbYATOPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 09:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbYATOPt
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 09:15:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:36325 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753319AbYATOPs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 09:15:48 -0500
Received: (qmail invoked by alias); 20 Jan 2008 14:15:45 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp042) with SMTP; 20 Jan 2008 15:15:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19M6AYZZI1MuKvfCz51oVe8ZyqUXrtq8Np2+ioNwo
	oCvvqskPamTfWP
X-X-Sender: gene099@racer.site
In-Reply-To: <07FDB6ED-EBE0-4F66-9167-6A0F8AD58E2B@zib.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71176>

Hi,

On Sun, 20 Jan 2008, Steffen Prohaska wrote:

> On Jan 20, 2008, at 2:48 AM, Johannes Schindelin wrote:
> 
> > > I bet you'll see a much bigger performance improvement from this on 
> > > Windows in particular.
> > 
> > I bet so, too.  Traditionally, filesystem calls are painfully slow on 
> > Windows.
> > 
> > But I cannot test before Monday, so I would not be mad if somebody 
> > else could perform some tests on Windows.
> 
> Has someone collected the whole series on a topic branch?  I did not 
> follow the discussion closely and apparently more than Linus' patch is 
> needed.  I couldn't immediately figure out which of the patches from the 
> thread should be applied in what order.

AFAICT Linus' patch relies on Junio's lstat() patch that was the OP in 
this thread.

FWIW I applied both patches to current "master" and pushed to the "lstat" 
branch of http://repo.or.cz/w/git/dscho.git

Hth,
Dscho
