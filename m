From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Patch (apply) vs. Pull
Date: Wed, 22 Jun 2005 16:08:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506221350130.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506221009120.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 22:06:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlBUq-0002d9-93
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 22:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVFVUMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 16:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVFVUM3
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 16:12:29 -0400
Received: from iabervon.org ([66.92.72.58]:10244 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262019AbVFVUJw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 16:09:52 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DlBWD-00046U-00; Wed, 22 Jun 2005 16:08:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221009120.2353@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 22 Jun 2005, Linus Torvalds wrote:

> Anyway, it's not a trivial problem. You can search for patch matches in
> the patch history, but the thing is, that will fail whenever a patch was
> edited for whitespace etc (which does end up happening often enough to
> matter). The same goes even more for the commit messages (I routinely not
> only add my sign-off, of course, but also fix typo's I notice and often
> end up reformatting whitespace).

If each patch is given an ID by the author (not committer) which is
preserved across various later modifications, we could at least recognize
which patch it was. Then we could present the author with the information
that the patch was accepted and was modified, and give the author the
option of replacing it in the series with one that reverts some or all of
the modifications (including re-adding dropped portions). I don't see any
reason that it would be better to search for similarity rather than just
having things explicitly tagged (I think, although I'm not sure, that
authors will care about the difference between someone applying an
alternative patch and someone applying the author's patch with
modifications.

	-Daniel
*This .sig left intentionally blank*

