From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Comments in read-tree about #nALT
Date: Sat, 27 Aug 2005 02:07:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508270151590.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 08:04:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8tn7-0003M5-2a
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 08:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbVH0GDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 02:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbVH0GDj
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 02:03:39 -0400
Received: from iabervon.org ([66.92.72.58]:10514 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030322AbVH0GDj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2005 02:03:39 -0400
Received: (qmail 27042 invoked by uid 1000); 27 Aug 2005 02:07:17 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Aug 2005 02:07:17 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7841>

I've gotten to the point of having all of the entries for a given path
ready to put into the cache at the same, and now I want to convert the
merge functions to take their data directly, rather than in the cache, so
that they can take extra entries for extra ancestors.

Part of threeway_merge, however, wants to search the rest of the cache for
interfering entries in some cases, which would have to happen differently,
because I won't have the cache completely filled out beforehand. I'm
trying to figure out what the comments are talking about, and they seem to
refer to a list of the possible cases. Is that list somewhere convenient?

	-Daniel
*This .sig left intentionally blank*
