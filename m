From: barkalow@iabervon.org
Subject: Re: [PATCH] Use the template mechanism to set up refs/ hierarchy as
 well.
Date: Thu, 4 Aug 2005 18:08:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0508041804120.23721@iabervon.org>
References: <7v3bprjzzg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508042038200.23886@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vll3hxykj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508042215430.24657@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 00:40:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0oNX-0007PE-9t
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 00:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVHDWjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 18:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbVHDWI2
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 18:08:28 -0400
Received: from iabervon.org ([66.92.72.58]:35344 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262722AbVHDWFr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 18:05:47 -0400
Received: (qmail 20182 invoked by uid 1000); 4 Aug 2005 18:08:47 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Aug 2005 18:08:47 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508042215430.24657@wgmdd8.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 4 Aug 2005, Johannes Schindelin wrote:

> > * Make git-init-db create an absolute minimum $GIT_DIR
> > structure itself, if the template directory is not available,
> > possibly with a warning.
> 
> This would be exactly what I'd like. Let git-init-db create
> .git/objects/[0-9a-f]{2}/, .git/refs/heads/, .git/refs/tags and .git/HEAD.
> Everything else is taken from the templates directory, if that exists. I would
> not warn if it does not.

Are .git/refs/heads and .git/refs/tags still needed? I seem to recall a 
patch to create subdirectories of .git/refs on demand (needed for 
tags/v99/1). I'd say just .git/objects/(everything), .git/refs, and 
.git/info.

(Plus template, if available, of course)

	-Daniel
*This .sig left intentionally blank*
