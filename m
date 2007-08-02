From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 2 Aug 2007 16:05:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708021605170.14781@racer.site>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
 <vpq4pji3zwm.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021315510.14781@racer.site>
 <20070802132541.GA9247@localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joel Reed <joelwreed@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 17:06:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGcFh-0003yO-PN
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 17:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbXHBPGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 11:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbXHBPGH
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 11:06:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:59095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752353AbXHBPGF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 11:06:05 -0400
Received: (qmail invoked by alias); 02 Aug 2007 15:06:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 02 Aug 2007 17:06:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cGl4itrAcZo8d8d3ubHQRjnnCr/CWuxttbAcUw1
	DYLWJABk6Em1tP
X-X-Sender: gene099@racer.site
In-Reply-To: <20070802132541.GA9247@localdomain>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54557>

Hi,

On Thu, 2 Aug 2007, Joel Reed wrote:

> On Thu, Aug 02, 2007 at 01:19:55PM +0100, Johannes Schindelin wrote:
> 
> <snip>
> 
> > For performance reasons, git always compares the files' stat information 
> > with that stored in the index.
> > 
> > By updating the file, you make that check fail always.
> > 
> > Without updating the index (which is not a read-only operation, and 
> > therefore must not be done when doing a read-only operation like diff), 
> > you will therefore _destroy_ the main reason of git's kick-ass 
> > performance.
> 
> The idea that read-only operation like diff shouldn't update the
> index makes a lot of sense.
> 
> But, as a user of git and not a git developer, I certainly _thought_
> that git-status was a read-only operation as well. Now I know it
> isn't, but this doesn't seem very consistent.

I'll not go into details again.  See 
http://thread.gmane.org/gmane.comp.version-control.git/40205/focus=40339

Ciao,
Dscho
