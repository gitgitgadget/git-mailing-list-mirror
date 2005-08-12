From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add "--sign" option to git-format-patch-script
Date: Fri, 12 Aug 2005 11:56:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508121146210.12816@iabervon.org>
References: <Pine.LNX.4.63.0508121532051.25606@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vr7czxj6s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 17:54:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3bqX-0001dQ-Mw
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 17:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVHLPxW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 11:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVHLPxW
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 11:53:22 -0400
Received: from iabervon.org ([66.92.72.58]:34316 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750831AbVHLPxW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 11:53:22 -0400
Received: (qmail 19495 invoked by uid 1000); 12 Aug 2005 11:56:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Aug 2005 11:56:36 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7czxj6s.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 12 Aug 2005, Junio C Hamano wrote:

> Good intentions, but I'd rather see these S-O-B lines in the
> actual commit objects.  Giving format-patch this option would
> discourage people to do so.  Maybe a patch to git commit would
> be more appropriate, methinks.

Maybe also something in format-patch to check that the commit has one? I, 
at least, tend to have unsigned commits for tracking stuff I've done but 
not cleaned up and signed ones that I want to send off as patches. I've 
confused the branches on occasion, although never when sending stuff, and 
it would be nice to have format-patch tell you if the commit didn't look 
right.

	-Daniel
*This .sig left intentionally blank*
