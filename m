From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Deprecate git-fetch-pack?
Date: Sat, 10 Nov 2007 18:11:53 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711101752490.29952@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 00:12:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqzUo-0002ke-EK
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 00:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbXKJXLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 18:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755057AbXKJXLz
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 18:11:55 -0500
Received: from iabervon.org ([66.92.72.58]:44441 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754978AbXKJXLz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 18:11:55 -0500
Received: (qmail 10738 invoked by uid 1000); 10 Nov 2007 23:11:53 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Nov 2007 23:11:53 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64387>

Now that git-fetch is in C, built in, and doing the fetch-pack in the same 
process, the normal usage patterns don't involve actually executing 
git-fetch-pack. Can we deprecate it at this point, or it is plausibly 
being used by scripts? As it is now, I'm not entirely confidant that the 
tests in t5500 won't be fooled by git-fetch working even with 
git-fetch-pack being broken in various ways, which should be fixed if we 
want to keep it.

We also might as well deprecate peek-remote now that it's a synonym for 
ls-remote.

	-Daniel
*This .sig left intentionally blank*
