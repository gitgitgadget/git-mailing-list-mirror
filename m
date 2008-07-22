From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Wed, 23 Jul 2008 00:23:27 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807230019480.8986@racer>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <20080722231153.GN2925@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:25:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLRDY-0000Fp-IP
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 01:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756795AbYGVXX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 19:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757303AbYGVXX3
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 19:23:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:50207 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757452AbYGVXX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 19:23:27 -0400
Received: (qmail invoked by alias); 22 Jul 2008 23:23:25 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp023) with SMTP; 23 Jul 2008 01:23:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JkMdGcIIJ2AJAU7ihGkkmV9T1vPL2+MUDz/XGaz
	cS8h0C2rs3xu93
X-X-Sender: gene099@racer
In-Reply-To: <20080722231153.GN2925@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89563>

Hi,

On Wed, 23 Jul 2008, Dmitry Potapov wrote:

> On Tue, Jul 22, 2008 at 10:56:04PM +0100, Johannes Schindelin wrote:
> > 
> > When a file's crlf attribute is explicitely set, it does not make 
> > sense to ignore it, just because the config variable core.autocrlf has 
> > not been set.
> 
> Hmm... About a week ago, I was about to propose the same change, but 
> after reading documentation and some thinking I was not able to convince 
> myself that this change would be the right thing to do.

Well, I have a shared repository, where I set the attribute.  Now, every 
once in a while, people check in text _with_ CR/LF.  Yes, that is right, I 
marked it explicitely as crlf, yet I am on the whim of the people choosing 
to set the config variable or not.

And I could not care less what the documentation says: if it does not make 
sense, it does not make sense.

> > +test_expect_success 'attribute crlf is heeded even without core.autocrlf' '
> 
> s/heeded/needed/

Nope.  "heeded" is what I meant.  I am not a native speaker, so this could 
be wrong.  But "needed" is not what I meant (the sentence would not make 
sense with "needed").

Ciao,
Dscho
