From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 11/11] Support bundles in builtin-clone
Date: Sun, 9 Mar 2008 21:56:54 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803092155450.3975@racer.site>
References: <alpine.LNX.1.00.0803081804280.19665@iabervon.org> <alpine.LSU.1.00.0803090027570.3975@racer.site> <alpine.LNX.1.00.0803091447230.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 21:57:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYSaY-0007LA-Kk
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 21:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbYCIU4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 16:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560AbYCIU4w
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 16:56:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:41933 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751023AbYCIU4v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 16:56:51 -0400
Received: (qmail invoked by alias); 09 Mar 2008 20:56:49 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO [192.168.1.89]) [86.138.198.40]
  by mail.gmx.net (mp009) with SMTP; 09 Mar 2008 21:56:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199CTFa5Ip9dZUqYvhTBRG+PcNhkqEJHV+Wmq5n55
	81SSwuokshIPm7
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0803091447230.19665@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76671>

Hi,

On Sun, 9 Mar 2008, Daniel Barkalow wrote:

> On Sun, 9 Mar 2008, Johannes Schindelin wrote:
> 
> > On Sat, 8 Mar 2008, Johannes Schindelin wrote:
> > 
> > > This forward-ports c6fef0bb(clone: support cloning full bundles) to 
> > > the builtin clone.
> > > 
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > 
> > Wow... Is this a new send-email feature?  I did not send this email...
> 
> Nope, it's an old format-patch feature. format-patch generates the 
> messages with the From: being the commit author, and my MTA doesn't 
> complain about the fact that I'm sending email with some entirely 
> different From:. It would probably be more clever to have format-patch 
> use the committer or the current user as the From:, and put an 
> additional From: in the message body with the author if it's not the 
> email From:.

I think that makes sense.

> Of course, you did sort of send that email 
> (http://permalink.gmane.org/gmane.comp.version-control.git/75743).

Sort of.

Of course, I am okay with it, but I consider the From: issue a real bug in 
send-email (or format-patch, if you want).

Ciao,
Dscho
