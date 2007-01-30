From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 16:38:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701301635050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701292320.43888.johannes.sixt@telecom.at>
 <Pine.LNX.4.64.0701291438580.3611@woody.linux-foundation.org>
 <Pine.LNX.4.63.0701301524360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070130151803.GA25779@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 16:45:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBv3s-000520-5y
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 16:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbXA3PiN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 10:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbXA3PiN
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 10:38:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:36823 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750723AbXA3PiN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 10:38:13 -0500
Received: (qmail invoked by alias); 30 Jan 2007 15:38:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 30 Jan 2007 16:38:11 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070130151803.GA25779@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38160>

Hi,

On Tue, 30 Jan 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On the git repository, using MinGW:
> > Using cygwin:
> > 
> > IOW MinGW wins hands down with an average 0.33s vs cygwin with an average 
> > 0.75s. (I am fairly certain that you must not trust sys times.)
> 
> Just curious, but were these tests run with mmap(), or NO_MMAP?

Both with NO_MMAP=YesPlease.

> Clearly, for a packed repository most of the overhead should be in 
> getting to the pack data itself (as everything else is pure userspace).

Right. That's why I did the test on the _same_ repository. (Not just both 
git repositories, but in the same path on the same machine.)

That said, I find the numbers quite convincing. On a (much weaker 
equipped) Linux bux, it takes 0.65s and 1.2s, respectively.

Ciao,
Dscho
