From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH] Add support for figuring out where in the git archive
 we are
Date: Tue, 16 Aug 2005 20:25:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508162005070.23242@iabervon.org>
References: <Pine.LNX.4.58.0508161536390.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 02:23:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5BhG-0007RV-6v
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 02:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVHQAWR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 20:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVHQAWR
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 20:22:17 -0400
Received: from iabervon.org ([66.92.72.58]:64262 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750772AbVHQAWQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 20:22:16 -0400
Received: (qmail 29281 invoked by uid 1000); 16 Aug 2005 20:25:37 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Aug 2005 20:25:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508161536390.3553@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 16 Aug 2005, Linus Torvalds wrote:

> If you use the GIT_DIR environment variable approach, it assumes that all
> filenames you give it are absolute and acts the way it always did before.
>
> Comments? Like? Dislike?

I'm all in favor, at least in the general case. I suspect there'll be some
things where we have to discuss the behavior, but we can argue that when
it comes up.

I think, slightly before 1.0, we should sort the library functions into a
new set of object files with matching header files, because "setup" is not
really distinctive, and there's at least one duplicate implementation
(the ssh subprocess code in your connect.c is the same as my rsh.c in what
it does, although yours uses two pipes and mine uses a socket).

	-Daniel
*This .sig left intentionally blank*
