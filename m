From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove dependency on IO::String from Git.pm test
Date: Wed, 18 Jun 2008 18:00:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806181756540.6439@racer>
References: <1213796224-995-1-git-send-email-michael@ndrix.org> <m37icmol6y.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Hendricks <michael@ndrix.org>, gitster@pobox.com,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 19:03:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K913W-0003rY-Kh
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 19:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbYFRRBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 13:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbYFRRBw
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 13:01:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:49600 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750749AbYFRRBv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 13:01:51 -0400
Received: (qmail invoked by alias); 18 Jun 2008 17:01:49 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp062) with SMTP; 18 Jun 2008 19:01:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GCG9wQNfG2EfSfhXjvJBnMVKg4lpI9IA9LWvXmx
	jc/iBHtbRG7u1j
X-X-Sender: gene099@racer
In-Reply-To: <m37icmol6y.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85392>

Hi,

On Wed, 18 Jun 2008, Jakub Narebski wrote:

> Michael Hendricks <michael@ndrix.org> writes:
> 
> > Instead of using IO::String to create an in-memory filehandle, use 
> > open() with a scalar reference as the filename.  This feature has been 
> > available since Perl 5.8.0 (which was released in 2002), so it should 
> > be available pretty much everywhere by now.
> 
> Besides if I understand correctly gitweb very much requires Perl >= 5.8 
> because of required Unicode support.

Did I miss something?  Was this patch not more about Git.pm?

BTW I think it is not nice at all how the dependency hell with Git.pm is 
made worse recently.

It is fascinating through how much _pain_ we go with the shell scripts to 
maintain portability, even with _very_ old or obscure systems (see the SCO 
server patches that came in not long ago!), and just walk over that 
portability when it comes to Perl...

Ciao,
Dscho
