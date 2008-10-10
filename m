From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: gitster is getting back to normal, slowly
Date: Fri, 10 Oct 2008 08:54:15 -0700
Message-ID: <20081010155415.GF8203@spearce.org>
References: <7vej2omplg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 17:55:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoKKu-0007zK-JG
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 17:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758037AbYJJPyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 11:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757858AbYJJPyQ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 11:54:16 -0400
Received: from george.spearce.org ([209.20.77.23]:60675 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757324AbYJJPyP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 11:54:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 195E63835F; Fri, 10 Oct 2008 15:54:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vej2omplg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97943>

Junio C Hamano <gitster@pobox.com> wrote:
> I am back from a Japan trip to attend the one-year-after-funeral service
> for my stepfather and a vacation.  I did not plan to touch keyboard while
> in there but I ended up giving a 3-hour git talk to about two dozen git
> users (but none of the people I know from this list) and would-be users [*1*].

Welcome back.  ;-)
 
> I am going through my mailing list backlog, and it will probably be a few
> more days before I can fully catch up.  In the meantime, I've pulled from
> Shawn, who again did a wonderful job of being an interim maintainer [*2*],
> and pushed the result out, but I am afraind that my trees will lag behind
> his for a few more days.  If things go well, I expect to ask Shawn to stop
> applying patches at the end of Sunday and take it over from there.

Thanks.  I think I made two minor flubs; there's a git-svn commit with
an unwrapped commit message (0a1a1c8615 git-svn: call 'fatal' correctly)
and a "maint" topic branch was accidentally based on master.  It merged
to next that way, but I caught it and cherry-picked only the necessary
change into maint.

There is new content in my tree again today (just pushed there).
So we would still appreciate people tracking (and testing) my
branches for a bit.

I'll send out a "what's in" summary pair around Sunday to help ease
the transition for Junio, so he has a summary of what's where.

> *2* Thanks, Shawn.  Part of me is very much tempted to ask him being an
> interim maintainer for a few more weeks so that I can see how it feels
> like to be a contributor again, but I'd refrain from doing so ;-)

About 2 or 3 days into your absence I realized (again) how difficult
and time consuming your job of maintainer is.  I honestly do not know
how you do it, day in and day out, for as long as you have.

I think I've been tracking about 4-5 hours per day on git maintenance
lately.  Its a wonder you are able to even write patches.  My hat's
off to you, sir.  ;-)

Anyway, I'm more than happy to continue playing patch monkey for a
few weeks if you want to take a some time and just be a contributor
again.  I know you have a number of WIP branches that haven't been
able to move along... I've been skipping over them with Meta/RB. :-\

Either way we really should be thinking about freezing and rolling
a 1.6.0.3 soon-ish.

-- 
Shawn.
