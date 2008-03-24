From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Introduce receive.guardCurrentBranch
Date: Mon, 24 Mar 2008 12:01:33 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803241200560.4353@racer.site>
References: <alpine.LSU.1.00.0803232142460.4353@racer.site> <20080324012139.GV14567@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Mar 24 12:02:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdkRS-0005C0-FP
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 12:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757500AbYCXLBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 07:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757495AbYCXLBd
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 07:01:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:33635 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756521AbYCXLBd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 07:01:33 -0400
Received: (qmail invoked by alias); 24 Mar 2008 11:01:31 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp042) with SMTP; 24 Mar 2008 12:01:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193Un8SptV3bhmXGgWS9GqERyZuqojMXGCWHUaaVV
	LxI8P6NYPowUcp
X-X-Sender: gene099@racer.site
In-Reply-To: <20080324012139.GV14567@genesis.frugalware.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78021>

Hi,

On Mon, 24 Mar 2008, Miklos Vajna wrote:

> On Sun, Mar 23, 2008 at 09:43:43PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > +receive.guardCurrentBranch::
> > +	If set to true, git-receive-pack will deny to update the ref that
> > +	HEAD points to, if HEAD is not detached.  This configuration
> > +	variable is set when initializing a non-bare repository.
> 
> probably i want too much, but it would be really nice if receive-pack 
> could just make HEAD detached. so that the user later can do a 'git 
> checkout -m master' to resolve possible conflicts.

As I wrote earlier, you can do that with a hook.

I do not want any official support for this, since I think it is an 
absolutely horrible idea.  I think I said that earlier, too.

Ciao,
Dscho
