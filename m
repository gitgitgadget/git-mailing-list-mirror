From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Sun, 2 Sep 2007 22:26:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709022133190.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DB0478.8050402@trolltech.com>
 <46DB0F9C.2090306@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 23:27:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRwyH-0001mr-FY
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 23:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040AbXIBV05 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 17:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754867AbXIBV04
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 17:26:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:44822 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750719AbXIBV0z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 17:26:55 -0400
Received: (qmail invoked by alias); 02 Sep 2007 21:26:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 02 Sep 2007 23:26:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rfh1olVFrggn318l7Q+uH8QhoLiUD/MPcPK+Tdu
	wQPxoHKObT3RnD
X-X-Sender: gene099@racer.site
In-Reply-To: <200709022228.00733.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57389>

Hi,

On Sun, 2 Sep 2007, Robin Rosenberg wrote:

> s?ndag 02 september 2007 skrev Marius Storm-Olsen:
> > (Also, since Windows doesn't really handle symlinks, it's fine that stat just uses lstat)
> 
> It does now: See http://msdn2.microsoft.com/en-us/library/aa363866.aspx

Oh?  *goes and tries to create one on a USB stick* No.  Besides, IIRC you 
cannot even create symlinks to another partition.  Copying a symlink will 
copy the _linked_ file.  So to call this "symlink" is a little... uhm... 
preposterous.

Plus, on a page linked from the link you posted, it says that it is 
only supported from Vista onwards.  So you must be kidding me.

Ciao,
Dscho
