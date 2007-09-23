From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Uninstalling Git
Date: Sun, 23 Sep 2007 20:31:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709232029490.28395@racer.site>
References: <46F6B0CC.3040000@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: in-call@gmx.net
X-From: git-owner@vger.kernel.org Sun Sep 23 21:32:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZXBg-0006ba-89
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 21:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbXIWTcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 15:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbXIWTcI
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 15:32:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:41889 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751730AbXIWTcH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 15:32:07 -0400
Received: (qmail invoked by alias); 23 Sep 2007 19:32:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 23 Sep 2007 21:32:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DCWlxDQFDZRVYvM0W3VAXHI8bGHCE5ZoBX9eIIC
	mbNwqrGmYdKUks
X-X-Sender: gene099@racer.site
In-Reply-To: <46F6B0CC.3040000@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58980>

Hi,

On Sun, 23 Sep 2007, in-call@gmx.net wrote:

> $ make configure
> $ ./configure --prefix=/usr/local
> $ make all doc
> $ sudo make install install-doc
> 
> First, I'd like to uninstall the thing completely, how do I do that?

I'd use checkinstall to install it (again), and then use the distro's 
regular tools; in case of Ubuntu, that would be dpkg I believe.

> Second, what would be the correct procedure to follow if I would like 
> just to upgrade to a newer version? install over the older perhaps? Is 
> that always safe in the sense that there won't be any dangling piece of 
> bin nor doc?

On Linux this should be safe at all times.

Hth,
Dscho
