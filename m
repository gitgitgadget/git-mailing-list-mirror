From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Oddity in git commit summary
Date: Sat, 15 Dec 2007 15:29:18 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712151507420.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 21:29:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3ddn-0007y6-2e
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 21:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902AbXLOU3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 15:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753615AbXLOU3U
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 15:29:20 -0500
Received: from iabervon.org ([66.92.72.58]:51624 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753335AbXLOU3T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 15:29:19 -0500
Received: (qmail 13828 invoked by uid 1000); 15 Dec 2007 20:29:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Dec 2007 20:29:18 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68413>

I just noticed that I got a strange summary from git commit -a --amend 
with the current master. It said:

Created commit f16cb29: Build in checkout
 5 files changed, 482 insertions(+), 299 deletions(-)
 create mode 100644 builtin-checkout.c
 delete mode 100755 git-checkout.sh

But git show --stat says:
 7 files changed, 780 insertions(+), 306 deletions(-)

And git show --stat -C says:
 6 files changed, 482 insertions(+), 8 deletions(-)

The commit that I noticed this on is available from:

 git://iabervon.org/~barkalow/git.git builtin-checkout

I've never particularly paid attention to this message before, so I don't 
know if it's saying something accurate I'm not understanding, or if it's 
actually inaccurate about what it's trying to show.

	-Daniel
*This .sig left intentionally blank*
