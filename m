From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Non-http dumb protocols
Date: Sat, 30 Jun 2007 16:19:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706301613410.14638@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 30 22:19:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4jPP-0006k5-Vc
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 22:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbXF3UTF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 16:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbXF3UTE
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 16:19:04 -0400
Received: from iabervon.org ([66.92.72.58]:4970 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057AbXF3UTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 16:19:03 -0400
Received: (qmail 2499 invoked by uid 1000); 30 Jun 2007 20:19:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jun 2007 20:19:00 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51254>

Do we actually support local-fetch and ssh-fetch/ssh-push any more? They 
seem to me to have been entirely supplanted with respect to functionality 
for a long time now, but the programs are still there. This complicates 
http-fetch, because only one -fetch can be linked into a binary as 
currently designed, and we may want to make http-fetch builtin at some 
point. Can we remove the other dumb protocols and merge fetch.c into 
http-fetch.c?

	-Daniel
*This .sig left intentionally blank*
