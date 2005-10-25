From: Daniel Barkalow <barkalow@iabervon.org>
Subject: git status and commit from subdirectory?
Date: Tue, 25 Oct 2005 17:51:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0510251735500.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Oct 25 23:53:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUWib-0003FN-SQ
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 23:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbVJYVw1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 17:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbVJYVw1
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 17:52:27 -0400
Received: from iabervon.org ([66.92.72.58]:47633 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750858AbVJYVw0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 17:52:26 -0400
Received: (qmail 8762 invoked by uid 1000); 25 Oct 2005 17:51:54 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Oct 2005 17:51:54 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10623>

It seems like everything that "git status" does can now be done from a 
subdirectory (giving, of course, the status of the contents of the 
subdirectory). I think the same might be true of "git commit", but I 
haven't checked on everything. Is there anything that has to be done to 
enable this properly other than removing the "|| die" part of the first 
line?

	-Daniel
*This .sig left intentionally blank*
