From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
 to
Date: Thu, 26 Jun 2008 13:09:10 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806261308420.9925@racer>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer> <486220CE.3070103@viscovery.net>
 <alpine.DEB.1.00.0806251334060.9925@racer> <20080625135100.GF20361@mit.edu> <vpqy74scsln.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 26 14:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBqKe-0000G5-7I
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 14:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYFZMLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 08:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbYFZMLM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 08:11:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:58454 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751458AbYFZMLL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 08:11:11 -0400
Received: (qmail invoked by alias); 26 Jun 2008 12:11:09 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp009) with SMTP; 26 Jun 2008 14:11:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1802dtIoCg0hQnfLo6w08oG56uYe5L0HUr+6w8cTj
	UfUGV7QyNx4mGo
X-X-Sender: gene099@racer
In-Reply-To: <vpqy74scsln.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86443>

Hi,

On Thu, 26 Jun 2008, Matthieu Moy wrote:

> Theodore Tso <tytso@mit.edu> writes:
> 
> > for i in $*
> 
> Detail: you meant "$@", your version isn't whitespace-robust.

In that case, you'd have to quote the variables in "$prefix$i" and "> $i", 
too.

Ciao,
Dscho
