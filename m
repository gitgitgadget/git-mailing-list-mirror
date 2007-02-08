From: Kalle Pokki <kalle.pokki@iki.fi>
Subject: Re: Git rescue mission
Date: 09 Feb 2007 00:03:35 +0200
Message-ID: <87bqk4z4qw.fsf@host94.eke.fi>
References: <17866.27739.701406.722074@lisa.zopyra.com>
	<Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
	<87fy9gz9vu.fsf@host94.eke.fi>
	<Pine.LNX.4.64.0702081321040.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kalle Pokki <kalle.pokki@iki.fi>, Bill Lear <rael@zopyra.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 23:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFHNS-0000Dn-EC
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 23:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945914AbXBHWDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 17:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945916AbXBHWDx
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 17:03:53 -0500
Received: from [194.100.36.62] ([194.100.36.62]:32971 "EHLO host94.eke.fi"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1945914AbXBHWDw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 17:03:52 -0500
Received: from host94.eke.fi (localhost.localdomain [127.0.0.1])
	by host94.eke.fi (8.13.4/8.13.4/Debian-3) with ESMTP id l18M3aDF004943;
	Fri, 9 Feb 2007 00:03:36 +0200
Received: (from kp@localhost)
	by host94.eke.fi (8.13.4/8.13.4/Submit) id l18M3ZjY004940;
	Fri, 9 Feb 2007 00:03:35 +0200
In-Reply-To: <Pine.LNX.4.64.0702081321040.8424@woody.linux-foundation.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39101>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 8 Feb 2007, Kalle Pokki wrote:
> > 
> > I usually undo a pull by throwing away just the merge commit by
> > 
> >         git reset --hard HEAD^
> 
> Don't do this.
> 
> If the merge just fast-forwarded, you'll do the wrong thing.

Yes, I know. But when looking at the history with gitk, it feels
quite intuitive to just get rid of the one new commit that appeared
on top of the "good" history. Without that kind of visualisation
I would surely always just use ORIG_HEAD as a reference.

Perhaps gitk could (optionally) also show ORIG_HEAD. That way we could
just do

        gitk --all

after a pull and see what got pulled, and everything else was already
there, too, if needed.
