From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] undo and redo
Date: Wed, 24 Aug 2005 16:44:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508241634350.23242@iabervon.org>
References: <20050824172339.GA7083@hpsvcnb.fc.hp.com> <20050824181004.GA18790@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.58.0508241148480.3317@g5.osdl.org> <20050824195615.GA693@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 22:42:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E823i-0003go-5z
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 22:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVHXUlP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 16:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVHXUlP
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 16:41:15 -0400
Received: from iabervon.org ([66.92.72.58]:55044 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932165AbVHXUlP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 16:41:15 -0400
Received: (qmail 23820 invoked by uid 1000); 24 Aug 2005 16:44:48 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Aug 2005 16:44:48 -0400
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20050824195615.GA693@hpsvcnb.fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7728>

On Wed, 24 Aug 2005, Carl Baldwin wrote:

> This brings up a good point (indirectly).  "git prune" would destroy the
> undo objects.  I had thought of this but decided to ignore it for the
> time being.

If you made undo store the tree under refs somewhere, git prune would
preserve it.

	-Daniel
*This .sig left intentionally blank*
