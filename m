From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/3] Add "remote" library
Date: Wed, 9 May 2007 22:03:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705092149060.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 04:04:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hly0s-0001ep-3V
	for gcvg-git@gmane.org; Thu, 10 May 2007 04:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbXEJCEG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 22:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753940AbXEJCEG
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 22:04:06 -0400
Received: from iabervon.org ([66.92.72.58]:4822 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753906AbXEJCEF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 22:04:05 -0400
Received: (qmail 32688 invoked by uid 1000); 10 May 2007 02:04:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 May 2007 02:04:00 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46820>

This series makes a library for handling remotes, by moving code from less 
appropriate places into a new header and source file pair. It shouldn't 
have any major changes in behavior at this point, aside from a few 
behavior improvements ("git push not-a-remote-name" before would give the 
wrong error message; newer configuration methods should override older 
ones; we should use the same default remote for push that we do for pull, 
all else being equal).

Patches 1 and 2 mostly move code into remote.c from other files. Patch 3 
adds useful code for the fetch side, corresponding to the code for the 
push side, but this code isn't used yet, because the code that would use 
it is still in shell. Patches 1 and 2 make sense without patch 3, however.

	-Daniel
*This .sig left intentionally blank*
