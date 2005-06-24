From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Fri, 24 Jun 2005 17:11:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506241659070.30848-100000@iabervon.org>
References: <pan.2005.06.24.13.16.10.406827@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 23:09:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlvQ1-0006bB-CJ
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 23:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbVFXVPA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 17:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbVFXVPA
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 17:15:00 -0400
Received: from iabervon.org ([66.92.72.58]:29445 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S263277AbVFXVNd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 17:13:33 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DlvS2-0007sH-00; Fri, 24 Jun 2005 17:11:02 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.06.24.13.16.10.406827@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jun 2005, Matthias Urlichs wrote:

> Hi, Petr Baudis wrote:
> 
> > Switching branches in place will be supported soon (although I have
> > doubts about its usefulness).
> 
> Well, I don't. Main reason: It's simply a lot faster to create+switch to a
> branch locally for doing independent work, than to hardlink the whole
> Linux directory tree into a clone tree.

There's another option, which I may be the only person currently
using: have a repo (.git directory) not in a working directory, and have
the objects/ and refs/ subdirectories of the .git directories in your
working directories symlinked to those subdirectories of the repo. Then
you can have any number of functionally identical working directories,
each of which is set to some branch. If you have a reasonably small number
of branches at any time, they can each have a working directory switched
to them. On the other hand, all of the branches are accessible from any of
them.

	-Daniel
*This .sig left intentionally blank*

