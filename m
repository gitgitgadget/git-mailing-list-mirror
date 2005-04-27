From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 19:50:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504271939100.30848-100000@iabervon.org>
References: <426FF8C4.8080809@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 01:46:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQwDu-0004S4-4Z
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 01:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVD0XvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 19:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVD0XvH
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 19:51:07 -0400
Received: from iabervon.org ([66.92.72.58]:36869 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262102AbVD0XvF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 19:51:05 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DQwIH-0006bM-00; Wed, 27 Apr 2005 19:50:13 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <426FF8C4.8080809@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Apr 2005, H. Peter Anvin wrote:

> One can simply say "we don't do that"; finding an unknown tag is always 
> a fatal error.  That means the format is more brittle, but brittle does 
> mean it breaks as opposed to getting deformed in some, potentially 
> undesirable way.

If you find an object with an unknown tag, you can't do much with it
anyway, even if it has a format that matches generic rules. Sure, you
could trace reachability through it, but that's only helpful for a couple
of generic programs (fsck and pull), and those programs ought to
additionally have some clue about what's going on if they're going to act
appropriately.

On the other hand, it is probably true that programs should be able to
deal abstractly with new tags if built with a libgit that supports them,
but that's something that we can arrange a bit later.

	-Daniel
*This .sig left intentionally blank*

