From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Design of name-addressed data portion
Date: Sun, 24 Apr 2005 19:12:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504241903500.30848-100000@iabervon.org>
References: <200504250058.15901.FabianFranz@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Apr 25 01:07:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPqCX-0001vt-1L
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 01:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVDXXMY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 19:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVDXXMY
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 19:12:24 -0400
Received: from iabervon.org ([66.92.72.58]:53510 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262476AbVDXXMT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 19:12:19 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPqH2-0007uD-00; Sun, 24 Apr 2005 19:12:24 -0400
To: Fabian Franz <FabianFranz@gmx.de>
In-Reply-To: <200504250058.15901.FabianFranz@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 25 Apr 2005, Fabian Franz wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Am Sonntag, 24. April 2005 20:17 schrieb Daniel Barkalow:
> > I'd propose the following structure:
> >
> > [...]
> >    tags/     the tags
> >      ...     files with the symbolic name of the tags, containing the hash
> 
> Couldn't you use symbolic or hard links here and in references/?

For most uses of the refs/ directory (of which tags/ is a subdirectory),
we want to get from it the hash, not just the contents of the referenced
object, and we potentially want to get the hash from something like a web
server. Finding out what http://.../foo.git/refs/heads/DEFAULT is a
symlink (or, wrose, hard link) to so that you can decide if it's different
from what you have would be a major pain.

	-Daniel
*This .sig left intentionally blank*

