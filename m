From: Andreas Krey <a.krey@gmx.de>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Fri, 24 May 2013 19:11:10 +0200
Message-ID: <20130524171110.GB9448@inner.h.apk.li>
References: <20130522115042.GA20649@inner.h.apk.li> <7v4ndukhx0.fsf@alter.siamese.dyndns.org> <20130523090657.GB23933@inner.h.apk.li> <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com> <20130523102959.GP9448@inner.h.apk.li> <20130523110839.GT27005@serenity.lan> <7vd2shheic.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 19:11:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfvX1-0003mP-9C
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 19:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757000Ab3EXRLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 13:11:47 -0400
Received: from continuum.iocl.org ([217.140.74.2]:41309 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab3EXRLq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 13:11:46 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r4OHBAE02083;
	Fri, 24 May 2013 19:11:10 +0200
Content-Disposition: inline
In-Reply-To: <7vd2shheic.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225382>

On Thu, 23 May 2013 09:01:15 +0000, Junio C Hamano wrote:
...
> Instead of having a nice "these six commits marked as 'x' were done
> on a branch forked some time ago, to address only this one issue and
> to address it fully" history that explains how these commits were
> related and these commits are the full solution to a single issue:
> 
>       x---x---x---x---x---x
>      /                     \
>  ---o---o---o---o---o---o---M---o---o---...
> 
> they end up with something like this, even with the "flip the heads
> of a merge" option, by pulling too often:
> 
>       x---x   x---x---x   x
>      /     \ /         \ / \
>  ---o---o---M---o---o---M---M---o---o---...

Wouldn't that be (you don't want to put your work back into master before
it's done) the following?

       x---x---M---x---x---M--x
      /       /           /    \
  ---o---o---M---o---o---M--o---M---o---o---...

With a bit of luck the first-parent strands will also run like this.

I know that rebasing topic branches is better than updating, but my
monetary upstream is busy letting go a clearcase-minted mindset.
Teaching them rebasing will take a while, and as long as tthat we
will have the picture above.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
