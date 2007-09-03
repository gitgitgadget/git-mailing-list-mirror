From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Mon, 3 Sep 2007 12:39:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709031238400.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DB0478.8050402@trolltech.com>
 <46DB0F9C.2090306@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com>
 <46DBA672.9050308@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 13:39:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISAHU-0000Kh-4g
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 13:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbXICLjo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 07:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753018AbXICLjn
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 07:39:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:43599 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752330AbXICLjn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 07:39:43 -0400
Received: (qmail invoked by alias); 03 Sep 2007 11:39:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 03 Sep 2007 13:39:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jLWQTQGajLQgM8Nj+0PwOPAps9ISRMJWxxeQ2/7
	Oq7z4L5+tvuWS/
X-X-Sender: gene099@racer.site
In-Reply-To: <46DBA672.9050308@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57471>

Hi,

On Mon, 3 Sep 2007, Marius Storm-Olsen wrote:

> Robin Rosenberg said the following on 02.09.2007 22:27:
> > s?ndag 02 september 2007 skrev Marius Storm-Olsen:
> > > (Also, since Windows doesn't really handle symlinks, it's fine that 
> > > stat just uses lstat)
> > 
> > It does now: See 
> > http://msdn2.microsoft.com/en-us/library/aa363866.aspx
> 
> Yeah, I know about Vista's improved support for symbolic links. However, 
> I think we can let that lay for a while, until we decide to make Git 
> generate proper symlinks on Vista. I don't see it as a 1st priority at 
> the moment, and we can always add the needed functionality in a separate 
> stat() function later.

... and force everybody to upgrade to Vista, thereby working for Microsoft 
for free?  You _know_ that I will oppose that change.

Ciao,
Dscho
