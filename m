From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: My patches
Date: Fri, 18 Oct 2013 11:30:09 -0400
Message-ID: <20131018153009.GA23704@thunk.org>
References: <20131012072450.GA21165@nysa>
 <xmqqtxgjg35a.fsf@gitster.dls.corp.google.com>
 <525c64ebe2390_197a905e84c@nysa.notmuch>
 <xmqq8uxrzn9h.fsf@gitster.dls.corp.google.com>
 <52605a36eef0f_448145fe7466@nysa.notmuch>
 <9A62D872-0FCF-41B9-B185-7061B25F1CBC@quendi.de>
 <52611e75bdc8d_2b6dcb7e7459@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <max@quendi.de>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 17:30:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXC0M-0000ql-3y
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 17:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694Ab3JRPaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 11:30:15 -0400
Received: from imap.thunk.org ([74.207.234.97]:47715 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753163Ab3JRPaN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 11:30:13 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1VXC0A-00084m-IQ; Fri, 18 Oct 2013 15:30:10 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 8005D580F5A; Fri, 18 Oct 2013 11:30:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=thunk.org; s=mail;
	t=1382110209; bh=RHbUxSz+ll9xC+eA7zAdC/uYP0SENBv+OGqnMCUw/Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbFfPnV7ITz0Ym/TfOeLO97wVb32PRxUji0CnJx9roBMVuLRsnSobM+sh/Jy5lACK
	 ypo29fyaT9bt/CasqCwt5uKC61xwJ8NSoRfi7h7SYD+EKzXNaB74LDWqaLShtaaqir
	 o4aBnlMfqQR5EvNUI4M7z22XOZwummVHNsh5ATrs=
Content-Disposition: inline
In-Reply-To: <52611e75bdc8d_2b6dcb7e7459@nysa.notmuch>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236354>

On Fri, Oct 18, 2013 at 06:41:41AM -0500, Felipe Contreras wrote:
> > And I hazard to guess that the vast majority agree with Junio on this (based,
> > again, on email evidence). Not with you.
> 
> That is irrelevant, and a fallacy. The vast majority of people thought the
> Earth was the center of the universe, and they were all wrong.
> 
> It's called ad populum fallacy, look it up. Wether the majority of Git
> developers agree that there's something more than a disagreement is irrelevant,
> their opinion doesn't change the truth.

Look, the problem is that you insist on being "right", even on matters
which may be more about taste and preference than anything that can be
proven mathematically.  Worse, you insist on trying to convince people
even when it might be better to just give up and decide that maybe
something not's worth the effort to get the last word in.  This is how
we get to centithreads.  If every time someone disagrees, you insist
on replying, and then if people give up in disgust, you then try to
use that as "proof" that you must be right, since you've dazzled them
with your brilliance, that's not good for the development community.

Sometimes a question is important enough that it's worth doing this.
But I'd suggest to you that you should ask yourself whether you're
doing it too often.

After all, this is open source.  If you are convinced that you are
right, and everyone else in the community is wrong, it is within your
power to fork the code base, and to prove us wrong by creating a
better product.

Or you can decide to just keep a patch set to yourself, or perhaps
post it periodically, if it is some key feature that you are certain
you or your company can't live with out.  Heck, I've done this with
ext4, even though I'm the maintainer --- there have been features that
I know are critical for my company, but the rest of the ext4
development community are stridently against.  I've just simply posted
the patch set once, and if it gets strongly opposed, I'll just keep it
as a out-of-tree patch.

The fallocate NO_HIDE_STALE flag is a good example of that; it's used
in production on thousands and thousands of servers by Google and Tao
Bao, but since there was strong opposition on the ext4 list, we've
kept it as an out-of-tree patch.  Note what I did not do.  I did not
force the patch in, even though it might be within my power as the
maintainer; nor did I try to convince people over and OVER and OVER
again about the rightness of my position, and turn it into a
centithread.

> My claim is that all I did was disagree with Junio. You can invalidate that
> claim easily by providing *a single* example where I did more than disagree.

The problem is when you disagree with a number of people (not just
Junio), and you are, in my opinion, overly persistent.  We can argue
whether you've stepped over the line in terms of impugning people's
motives or sanity, but that's not necessarily the most important
issue.  People sometimes step over the line, and while that's
unfortunate, it's when it becomes a persistent pattern, and it happens
frequently enough, that it becomes a real problem.

Alternatively, if you are right that Junio is mad, and he's being
capriciously insulting, then I'm sure that when you establish your own
fork, lots of developers will come flocking to your flag.  If they do
not, then perhaps you might want to take that as some objective
evidence that the community is perhaps, more willing to work with him,
then they are to work with you.

Best regards,

						- Ted

P.S.  There are plenty of things that I consider to be unfortunate
about git's command line interface, in terms of inconsistencies and
confusing terminology.  Over the past 5+ years, I've observed that I
think the way commit selection in "git format-patch" is inconsistent
with how we handle commit selection for other commands, e.g., "git log
<commit>" vs and "git format-patch <commit>".  Even if you think that
this is a matter of self-inherent "truth", versus just a matter of
taste, there is also the consideration of backwards compatibility, and
the question of how important consistency and easy of learning gets
traded off against backwards compatibility and invalidating
potentially huge numbers of shell scripts and documentation.  So it's
not something where I've made a nuisance of myself, because it's a
settled issue.

As another example, people have agreed for a long time that the fact
that tab characters are significant in Makefiles is highly
unfortunate.  However, no one is running around calling the GNU Make
maintainers "insane" for not being willing to make a change that would
break huge numbers of Makefiles in the world.  More importantly,
people aren't brining up the same subject over and over and over again
on the GNU Makefile mailing list.  Perhaps you might consider what
would be the appropriate response if someone insisteted on creating
centithreads on the GNU Makefile discuss list on that subject.
