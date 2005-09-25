From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Sat, 24 Sep 2005 23:04:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509242248440.23242@iabervon.org>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509232220330.30718@localhost.localdomain>
 <Pine.LNX.4.58.0509241102450.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509241129300.31327@localhost.localdomain>
 <7vbr2iw6l3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Davide Libenzi <davidel@xmailserver.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 05:02:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJMlW-0005Xk-Nj
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 05:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVIYDAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 23:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbVIYDAV
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 23:00:21 -0400
Received: from iabervon.org ([66.92.72.58]:525 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751064AbVIYDAU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2005 23:00:20 -0400
Received: (qmail 7930 invoked by uid 1000); 24 Sep 2005 23:04:46 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Sep 2005 23:04:46 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr2iw6l3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9255>

On Sat, 24 Sep 2005, Junio C Hamano wrote:

> Making really really core part usable on Windows would not need
> this, but there is another thing: .git/HEAD symlink.

Cygwin supports symlinks without underlying filesystem support. It does 
basically the standard UNIX thing for symlinks, but inefficiently in 
userspace.

	-Daniel
*This .sig left intentionally blank*
