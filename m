From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [2/4] Sorting commits by date
Date: Mon, 18 Apr 2005 22:52:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504182236050.30848-100000@iabervon.org>
References: <42646EB3.8070701@dwheeler.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 04:48:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNimh-0007bt-Ko
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 04:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVDSCwW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 22:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVDSCwW
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 22:52:22 -0400
Received: from iabervon.org ([66.92.72.58]:13319 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261288AbVDSCwU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 22:52:20 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNiqg-0006aW-00; Mon, 18 Apr 2005 22:52:26 -0400
To: "David A. Wheeler" <dwheeler@dwheeler.com>
In-Reply-To: <42646EB3.8070701@dwheeler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 18 Apr 2005, David A. Wheeler wrote:

> Petr Baudis wrote:
> > [Re: Daniel Barkalow <barkalow@iabervon.org>'s patch] 
> > Note that you are breaking gcc-2.95 compatibility when using declarator
> > in the middle of a block. Not that it might be a necessarily bad thing
> > ;-) (although I still use gcc-2.95 a lot), just to ring a bell so that
> > it doesn't slip through unnoticed and we can decide on a policy
> > regarding this.
> 
> I, at least, would REALLY like to see _highly_ portable C code;
> I'm looking at git as a potential long-term useful SCM tool for
> LOTS of projects, and if you're going to write C, it'd be nice
> to just write it portably to start with. There's certainly
> no crisis in using separate declarators.

Mixing declarations and code is the least of portability issues; it's in
the current C standard unlike a number of other things. I've personally
never found a system where -lz has deflateBound but gcc doesn't support
C99, although they obviously exist. I have no problem with fixing things
up for old GCC, although I'm going to have a hard time finding such things
because I can't find a way to make recent GCC reject C99 features but not
old GNU extensions.

	-Daniel
*This .sig left intentionally blank*

