From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove dependency on IO::String from Git.pm test
Date: Wed, 18 Jun 2008 20:37:06 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806182036080.6439@racer>
References: <1213796224-995-1-git-send-email-michael@ndrix.org> <m37icmol6y.fsf@localhost.localdomain> <alpine.DEB.1.00.0806181756540.6439@racer> <7vzlpiy2sm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 21:39:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K93VK-0007T1-Rf
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 21:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbYFRTio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 15:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbYFRTio
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 15:38:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:52344 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752016AbYFRTin (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 15:38:43 -0400
Received: (qmail invoked by alias); 18 Jun 2008 19:38:42 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp021) with SMTP; 18 Jun 2008 21:38:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SZHJ6iYISaLliOjP/JfFM/eUS0KghHXgjvBQarX
	e9unVFSJUKeUxR
X-X-Sender: gene099@racer
In-Reply-To: <7vzlpiy2sm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85403>

Hi,

On Wed, 18 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It is fascinating through how much _pain_ we go with the shell scripts 
> > to maintain portability, even with _very_ old or obscure systems (see 
> > the SCO server patches that came in not long ago!), and just walk over 
> > that portability when it comes to Perl...
> 
> Hey, calm down a bit and give me a bit more credit.  I am not that 
> stupid. I've looked at the patch, and it is parked in 'pu', not near 
> 'next'.

Heh.  The part about the shell scripts was actually meant as a genuine 
praise.  And I did not mean to criticize _you_ for introducing IO::Stream.

Ciao,
Dscho
