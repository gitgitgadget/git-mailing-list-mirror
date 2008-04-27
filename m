From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git push --mirror" update mirrors
Date: Sun, 27 Apr 2008 13:34:46 -0400
Message-ID: <20080427173446.GM29771@spearce.org>
References: <4812DA50.3000702@gnu.org> <20080426170126.GC29771@spearce.org> <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org> <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org> <7vabjflvlh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 19:35:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqAmp-0005qd-LR
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369AbYD0Rew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757284AbYD0Rev
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:34:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45447 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606AbYD0Rev (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:34:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JqAlt-0004RD-SW; Sun, 27 Apr 2008 13:34:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 99B3520FBAE; Sun, 27 Apr 2008 13:34:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vabjflvlh.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80466>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > I _hate_ the default remote. [...]
> 
> It sounds as if you want to say it a bit stronger than that --- to you,
> defaulting to 'origin' is not of "little to no" but "negative" value, is
> it?
> 
> But I think we are minotiry.  To people with "CVS migrant" workflow,
> cloning from _the_ central repo, hacking, and then pushing back will never
> involve anything other than 'origin' and local repositories, and I am
> sympathetic when they want to say "git push" and have it default to that
> single other repository.

Yes, I think we are in the minority.  Many people come to Git from
a centralized system so the idea of just a single place to pull/push
from makes perfect sense to them.

But then they later wonder why they need `git pull origin branch`
to merge in branch, when they usually just say `git pull`.  What is
the need for that funny keyword `origin`?  Why do I have to say
where to get the branch from sometimes and not others?

I think this argument is like the one we had with `git pull . branch`
vs. `git merge branch`.  However we probably could have gotten users
to accept `git merge . branch`, as the main argument there was the
fact that git-merge (the natural command to invoke) didn't actually do
what the user wanted, and git-pull did.

Just take the above as the rantings of someone who knows git a
little too well, and has tried to teach it to people who don't,
and they all have asked about the funny (to them) need for origin
in git-pull/git-push command line sometimes (no refspecs) and not
others (with refspecs).

-- 
Shawn.
