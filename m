From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What to expect after 0.99.8
Date: Mon, 3 Oct 2005 17:33:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510031709360.23242@iabervon.org>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510031522590.23242@iabervon.org> <7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 23:29:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMXri-0003rs-81
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 23:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVJCV2v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 17:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbVJCV2v
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 17:28:51 -0400
Received: from iabervon.org ([66.92.72.58]:772 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932522AbVJCV2s (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2005 17:28:48 -0400
Received: (qmail 29984 invoked by uid 1000); 3 Oct 2005 17:33:29 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Oct 2005 17:33:29 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9654>

On Mon, 3 Oct 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Are these all before 1.0, or are some of them supposed to happen 
> > eventually but later?
> 
> The latter.

Good. It would be nice to mark things as being post-1.0 or not.

> > I'd also like to add:
> >
> >  * Accept patches to fetch multiple objects by HTTP in parallel.
> >
> > I think this may be necessary to get good performance without rsync for 
> > repositories hosted without specific git support.
> 
> Surely.  I'd love to see you work with Nick Hengeveld on this
> one, perhaps even before 1.0.  Looking out the fetch.c code, I
> think you already have set up a reasonable "work queue" during
> the last round, with a lot of simplification thanks to Sergey,
> and parallel fetching would be a very nice addition.

The code in ssh-fetch already does parallel fetching, actually (only over 
one connection, but requests are sent before responses are read), so 
multiple requests are in progress at the same time.

	-Daniel
*This .sig left intentionally blank*
