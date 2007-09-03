From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Mon, 3 Sep 2007 13:33:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709031329590.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DB0478.8050402@trolltech.com>
 <46DB0F9C.2090306@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com>
 <46DBA672.9050308@trolltech.com> <Pine.LNX.4.64.0709031238400.28586@racer.site>
 <46DBF5AC.6070400@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 14:33:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISB7W-0003OS-D1
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 14:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbXICMda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 08:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbXICMda
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 08:33:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:35255 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751428AbXICMd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 08:33:29 -0400
Received: (qmail invoked by alias); 03 Sep 2007 12:33:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 03 Sep 2007 14:33:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+d8lJ/1yOd3pKdCgXUV10BDS2UDh0+upegeZQ1dN
	10D+iVoreCvP/k
X-X-Sender: gene099@racer.site
In-Reply-To: <46DBF5AC.6070400@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57479>

Hi,

On Mon, 3 Sep 2007, Marius Storm-Olsen wrote:

> Johannes Schindelin said the following on 03.09.2007 13:39:
> > On Mon, 3 Sep 2007, Marius Storm-Olsen wrote:
> > > Robin Rosenberg said the following on 02.09.2007 22:27:
> > > > It does now: See http://msdn2.microsoft.com/en-us/library/aa363866.aspx
> > > Yeah, I know about Vista's improved support for symbolic links.
> > > However, I think we can let that lay for a while, until we decide
> > > to make Git generate proper symlinks on Vista. I don't see it as
> > > a 1st priority at the moment, and we can always add the needed
> > > functionality in a separate stat() function later.
> > 
> > ... and force everybody to upgrade to Vista, thereby working for
> > Microsoft for free?  You _know_ that I will oppose that change.
> 
> ;-) I wouldn't dream of it!

Hehe.

> Nah, my comment was more 'allow usage of proper Symlinks on Vista' at a 
> later point. I would still argue that the default would be what we have 
> today. So, it would have to be an option.

Okay, I could live with that.

> But seeing what they've done to the symlinks there, it might be far 
> fetched. We'll worry about that (much) later..

Yes, it is funny how they do it over and over and over again.  Embrace, 
"Extend", Extinguish.  And I thought that eventually people would be 
clever enough to realise...

Ciao,
Dscho
