From: David Kastrup <dak@gnu.org>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 11:39:55 +0200
Message-ID: <87bnvl6bdg.fsf@fencepost.gnu.org>
References: <535C47BF.2070805@game-point.net>
	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
	<535D4085.4040707@game-point.net>
	<CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
	<535D6EB1.9080208@game-point.net>
	<535e18cdc7bce_338911e930c72@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 14:05:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WekJJ-0005Au-I5
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 14:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbaD1MFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 08:05:17 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:33263 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186AbaD1MFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 08:05:13 -0400
Received: from localhost ([127.0.0.1]:60533 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WekJ6-0001Nf-3X; Mon, 28 Apr 2014 08:05:12 -0400
Received: by lola (Postfix, from userid 1000)
	id 9AE11E0669; Mon, 28 Apr 2014 11:39:55 +0200 (CEST)
In-Reply-To: <535e18cdc7bce_338911e930c72@nysa.notmuch> (Felipe Contreras's
	message of "Mon, 28 Apr 2014 04:01:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247304>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Jeremy Morton wrote:
>> 
>> Sounds like the default behaviour of "git pull" might not be ideal if
>> it easily causes these problems.
>
> It's not idea. Virtually everyone agrees with that, even Linus
> Torvalds, and we have the patches to fix it, but it's not going to
> change.
>
> The Git project doesn't welcome change.

I can think of a few other things that "the Git project" or actually
pretty much everybody doesn't welcome.

It becomes easier to actually change things when communicating in a less
abrasive and destructive manner.

At any rate, releases involve time plans and testing periods.
Personally I think that the automerging behavior of "git pull" is one of
the most stupid traps Git has available for beginning contributors to
make a royal mess of their contributions.  It's unbelievable that this
has not been defused a decade ago already.

But it hasn't, and such a change is no longer in a useful time frame for
a 2.0 release.  Unless one wants to push back the 2.0 release
considerably for this alone.  But then everybody will have a favorite
pet peeve, some likely more justified, some less, that he wants to get
into 2.0.  I mean, I just sped up git-blame for serious use cases by a
factor of 3 or so at least, and there will be _no_ API changes and
user-visible consequences with that change.

So what?

If the thing has been important enough to get into 2.0, it has been
important enough to push for it _timely_ so that it had a chance at
considerable testing exposure.

That's what has been done with the "git push" changes.  They were put in
timely, with quite a bit of warning about what will change and what
people are supposed to be doing about it.  Again: bad enough that it
took as long as that to fix this insanely reckless default.  The scale
of the git-pull problem is small in comparison as it only messes up a
single local branch instead of a whole set of upstream branches.

-- 
David Kastrup
