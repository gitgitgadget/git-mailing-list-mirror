From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Last mile for 1.0 again
Date: Mon, 4 Jul 2005 18:41:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507041801040.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0507041459030.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 00:43:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpZeu-0005nl-97
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 00:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVGDWnR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 18:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVGDWnR
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 18:43:17 -0400
Received: from iabervon.org ([66.92.72.58]:22790 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261724AbVGDWnN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2005 18:43:13 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DpZct-000219-00; Mon, 4 Jul 2005 18:41:19 -0400
To: Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0507041459030.3570@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 4 Jul 2005, Linus Torvalds wrote:

> On Mon, 4 Jul 2005, Daniel Barkalow wrote:
> > 
> > How about an option to git-rev-list to take a path, and (1) exclude any
> > branch where the version at that path ends up ignored in a merge and
> > (2) not list any revision where the version at that path is identical to a
> > parent?
> 
> Hmm. How is that different from "git-whatchanged path", really?

It would short-circuit going up areas of the history which don't
contribute (i.e., lead up to a merge which took its version from a
different parent). It could also stop when it ran out of branches that
have the file at all. Neither of these is all that significant, I guess.

Junio: what's missing from annotate/blame?

	-Daniel
*This .sig left intentionally blank*
