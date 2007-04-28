From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/5] Update tracking refs when pushing
Date: Sat, 28 Apr 2007 13:04:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704281259370.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 19:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhqMe-0001A2-71
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 19:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756413AbXD1RFd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 13:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161875AbXD1RFc
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 13:05:32 -0400
Received: from iabervon.org ([66.92.72.58]:4830 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756413AbXD1RE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 13:04:57 -0400
Received: (qmail 7637 invoked by uid 1000); 28 Apr 2007 17:04:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Apr 2007 17:04:55 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45783>

This series allows git-push to update local tracking refs when it updates 
the remote heads it tracks. Along the way, it adds library code for 
holding the remote configuration.

Total diffstat is:

 Makefile          |    4 +-
 builtin-push.c    |  199 ++++++-------------------------------------
 commit.c          |    8 --
 git-compat-util.h |    8 ++
 remote.c          |  241 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h          |   25 ++++++
 send-pack.c       |   54 ++++++++++--
 7 files changed, 349 insertions(+), 190 deletions(-)

	-Daniel
*This .sig left intentionally blank*
