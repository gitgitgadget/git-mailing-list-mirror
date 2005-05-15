From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Sat, 14 May 2005 23:23:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505142306021.30848-100000@iabervon.org>
References: <20050513233738.GL32232@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun May 15 05:24:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DX9jE-0006Yu-GU
	for gcvg-git@gmane.org; Sun, 15 May 2005 05:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVEODXw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 23:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVEODXw
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 23:23:52 -0400
Received: from iabervon.org ([66.92.72.58]:15111 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261460AbVEODXu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 23:23:50 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DX9io-0008K7-00; Sat, 14 May 2005 23:23:18 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050513233738.GL32232@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 14 May 2005, Petr Baudis wrote:

> So what about just something like
> 
> 	git-wormhole-pull remote:refs/head/master wormhole://localhost/
> 
> That is, you could just specify remote:path_relative_to_url instead of
> SHA1 id as the commit.

Do you have any sensible alternatives to "remote:refs/<something>" in
mind? I suppose that "remote:HEAD" would also work. How are you thinking
of having the value get written locally?

Do you also have some idea for user-invoked rpush? It has to call
something that writes the value on the other side (and I'd ideally like it
to do the update atomically and locked against other clients). This series
uses the same mechanism to write it that it uses to write hashes fetched
from remote machines.

	-Daniel
*This .sig left intentionally blank*

