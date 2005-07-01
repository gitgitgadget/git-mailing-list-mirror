From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Tags
Date: Fri, 1 Jul 2005 18:27:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507011818540.30848-100000@iabervon.org>
References: <42C5BB33.5010304@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 00:21:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoTtC-0007vS-1e
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 00:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbVGAW3N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 18:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbVGAW3N
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 18:29:13 -0400
Received: from iabervon.org ([66.92.72.58]:42245 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262969AbVGAW3L (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 18:29:11 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DoTyR-0007x0-00; Fri, 1 Jul 2005 18:27:03 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C5BB33.5010304@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 1 Jul 2005, H. Peter Anvin wrote:

> You're missing the whole point of the discussion.  Right now the only 
> thing that makes a global object store impossible is the potential for a 
> tag conflict, either intentional or accidental.

Is there some issue remaining with having a global *object* store,
symlinked from multiple repositories, each with its own tags and
such? (I'd think that, in the refs, there would be more contention over
the heads than the tags, in any case; refs/heads/master is kind of
popular)

	-Daniel
*This .sig left intentionally blank*
