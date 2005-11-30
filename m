From: Daniel Barkalow <barkalow@iabervon.org>
Subject: gitignore and directories
Date: Wed, 30 Nov 2005 13:21:59 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511301318100.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Nov 30 19:57:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhWaC-0007jb-B0
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 19:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbVK3SV3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 13:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbVK3SV3
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 13:21:29 -0500
Received: from iabervon.org ([66.92.72.58]:23817 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751499AbVK3SV3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 13:21:29 -0500
Received: (qmail 30152 invoked by uid 1000); 30 Nov 2005 13:21:59 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Nov 2005 13:21:59 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13011>

There's a bug in .gitignore handling with respect to directories, but I'm 
not sure which behavior is intended. If you have some pattern in 
.gitignore in your working tree root directory, and you run git-status in 
that directory, it will ignore files that match in subdirectories. 
However, if you're in a subdirectory when you run git-status, it won't 
ignore things that match the pattern. One of these must be a bug, but I'm 
not sure which one matches the intent.

	-Daniel
*This .sig left intentionally blank*
