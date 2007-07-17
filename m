From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Do a better job at guessing unknown character sets
Date: Tue, 17 Jul 2007 20:56:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707172053030.14781@racer.site>
References: <alpine.LFD.0.999.0707171027100.19166@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 21:56:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAtAA-0007Gj-O0
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 21:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759941AbXGQT4p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 15:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760608AbXGQT4o
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 15:56:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:57724 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753470AbXGQT4o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 15:56:44 -0400
Received: (qmail invoked by alias); 17 Jul 2007 19:56:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 17 Jul 2007 21:56:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/skiR7oabsFi7vrb2F1ZEUoxvq3/naKsWdNfFNy0
	LBp2VcT7lAWaQS
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.999.0707171027100.19166@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52793>

Hi,

On Tue, 17 Jul 2007, Linus Torvalds wrote:

> I think this makes sense from a "the world is moving to utf-8" 
> standpoint, even if obviously some people might consider it a bit ugly 
> to do per-line "guessing".
> 
> Comments?

IMHO this is a good change.  Encodings are such a hassle, and probably 
only because the inventors of ASCII just were narrow-minded enough not to 
care.  With this patch, the hassle factor diminishes AFAICT.

Ciao,
Dscho

P.S.: I think that in case of undesired behaviour, even if it is detected 
late in the game, filter-branch/rewrite-commits will help.
