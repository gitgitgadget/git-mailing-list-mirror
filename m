From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Patch (apply) vs. Pull
Date: Tue, 21 Jun 2005 14:02:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506211337400.30848-100000@iabervon.org>
References: <1119308502.3926.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 19:58:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dkn0l-0007lO-KC
	for gcvg-git@gmane.org; Tue, 21 Jun 2005 19:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVFUSEI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 14:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVFUSEI
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jun 2005 14:04:08 -0400
Received: from iabervon.org ([66.92.72.58]:34309 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262157AbVFUSEB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2005 14:04:01 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Dkn4Y-0002wb-00; Tue, 21 Jun 2005 14:02:06 -0400
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <1119308502.3926.18.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 20 Jun 2005, Darrin Thompson wrote:

> On Mon, 2005-06-20 at 10:22 -0700, Junio C Hamano wrote:
> >  (6) Throw away my HEAD, making Linus HEAD my HEAD, while
> >      preserving changes I have made since I forked from him.  I
> >      use "jit-rewind" for this.
> 
> When you say it that way it sounds so _bad_. :-)

The reason is actually that he has to end up with a different history,
which is the history of the project mainline, rather than the history of
his tree. He could, of course, follow his own history, but then
communication with people who use a different history becomes difficult.

> Would it make sense to come up with a way to make an emailed series of
> patches represent a series of commits? Could patches still be
> cherrypicked?

Commits are fundamentally resistant to cherrypicking, because they give
the state of the tree rather than expressing changes in that
state. Long-term, I think that something like StGIT should be integrated
into the system and deal with generating the HEAD you get after getting
patches in.

	-Daniel
*This .sig left intentionally blank*

