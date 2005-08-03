From: barkalow@iabervon.org
Subject: git-local-pull?
Date: Wed, 3 Aug 2005 13:11:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0508031259430.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 03 19:09:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0Mj5-0004zj-SP
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 19:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVHCRID (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 13:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVHCRID
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 13:08:03 -0400
Received: from iabervon.org ([66.92.72.58]:36619 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262329AbVHCRH7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 13:07:59 -0400
Received: (qmail 7761 invoked by uid 1000); 3 Aug 2005 13:11:00 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Aug 2005 13:11:00 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

IIRC, git-local-pull still doesn't work for a packed source repository, 
because it doesn't include the possibility of copying a pack (or 
extracting an object) if the requested object is in a pack.

I can probably fix it if anyone cares, but it's not something I use 
personally, so I don't know if it's worthwhile. It should probably be 
removed if we don't fix it, since it will fail on any popular repository 
at this point.

	-Daniel
*This .sig left intentionally blank*
