From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add 'ours' merge strategy.
Date: Wed, 2 Nov 2005 16:45:22 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511021616290.25300@iabervon.org>
References: <7vll071ug5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511021134100.6501@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 22:47:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXQQS-0003IC-E1
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 22:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965268AbVKBVpl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 16:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965267AbVKBVpl
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 16:45:41 -0500
Received: from iabervon.org ([66.92.72.58]:41234 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S965268AbVKBVpk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 16:45:40 -0500
Received: (qmail 29367 invoked by uid 1000); 2 Nov 2005 16:45:22 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Nov 2005 16:45:22 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511021134100.6501@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11045>

On Wed, 2 Nov 2005, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 1 Nov 2005, Junio C Hamano wrote:
> 
> >  This can be used to terminate an old maintenance branch without
> >  leaving people's repositories behind.
> 
> How about optionally do something similar when git-rebase'ing? Especially 
> "pu"?

For that, you'd additionally want to have the parent whose content was 
ignored be listed as "optional" in a sense; users shouldn't have to 
download all the commits that "pu" went through that have been superceded, 
unless they're actually trying to get back from a superceded commit; the 
log on that line isn't interesting (because all the useful messages are in 
the rebased line, too, in potentially better versions), and so forth.

	-Daniel
*This .sig left intentionally blank*
