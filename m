From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 2 Aug 2007 16:12:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708021612080.14781@racer.site>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
 <vpq4pji3zwm.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021315510.14781@racer.site>
 <vpqir7y15sr.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021537490.14781@racer.site>
 <vpq7ioeyosh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 02 17:13:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGcMd-000752-66
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 17:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbXHBPNU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 11:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754120AbXHBPNU
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 11:13:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:47192 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750962AbXHBPNT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 11:13:19 -0400
Received: (qmail invoked by alias); 02 Aug 2007 15:13:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 02 Aug 2007 17:13:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Gw2xFkJtGO+yM4wEXKk1oQQd6aTTdfaBAISwb5H
	uvvhSciSTw/dKv
X-X-Sender: gene099@racer.site
In-Reply-To: <vpq7ioeyosh.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54560>

Hi,

On Thu, 2 Aug 2007, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> The question remains: why should someone running git-diff get this,
> >> and someone running git-status not get this?
> >
> > Because git-status is an index-updating operation.  That's why.
> 
> That sounds like "it is this way because it is not the other way
> around".
> 
> So, yes, git-status updates the index because it's an index-updating
> operation, while git-diff does not update the index because it's a
> non-index-updating operation.
> 
> Then, I'll rephrase my sentence as "*why* is git-status an
> index-updating operation while git-diff is not". But you'll probably
> find another way to avoid answering.

Yes.  I do.  The issue whether or not git status should be a read-only 
operation has been discussed -- in _length_ -- here:

http://thread.gmane.org/gmane.comp.version-control.git/40205/focus=40339

Ciao,
Dscho
