From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 17:55:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301754110.3586@pacific.mpi-cbg.de>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <7v4ozhd1wp.fsf@gitster.siamese.dyndns.org> <7vwscdbkpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901301423120.3586@pacific.mpi-cbg.de>
 <20090130163317.GB6963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 17:57:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSwfx-0006r2-Ms
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbZA3QzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbZA3QzP
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:55:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:60124 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750824AbZA3QzN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 11:55:13 -0500
Received: (qmail invoked by alias); 30 Jan 2009 16:55:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 30 Jan 2009 17:55:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19oYe1Z2kRoXV1fNVIJWpLEojg5F+V5xcxCg7cWno
	YKc4mql4lyNX+M
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090130163317.GB6963@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107849>

Hi,

On Fri, 30 Jan 2009, Jeff King wrote:

> On Fri, Jan 30, 2009 at 02:24:57PM +0100, Johannes Schindelin wrote:
> 
> > Let's reap all the opinions about this issue, and then I'll do the 
> > wrap-up patch.
> 
> I thought what Junio said was very reasonable (improve the message and 
> give it some more time to work).
> 
> But I honestly do not care that much either way. I probably would have 
> made the original patch default to "deny" if not for discussion 
> recommending to be conservative. On the other hand, I don't think we 
> have really given the "warning" approach enough time to see whether it 
> is working (and I don't necessarily disagree with your gut feeling that 
> it won't work; I am undecided, which leads me to want more data).

It is not working:

http://groups.google.com/group/msysgit/msg/55b1aa03fbbbefba?dmode=source

(I am simply assuming that the mentioned 1.6.1-preview has the 
warning, since denyCurrentBranch is in v1.6.1-rc1~59^2, and I am too short 
on time to check it in detail (which would mean finding a Windows machine 
and running a test)).

Ciao,
Dscho
