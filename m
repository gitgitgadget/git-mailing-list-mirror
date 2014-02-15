From: David Kastrup <dak@gnu.org>
Subject: Re: Git GSoC 2014
Date: Sat, 15 Feb 2014 14:03:57 +0100
Message-ID: <87fvnk1q9u.fsf@fencepost.gnu.org>
References: <20140213091037.GA28927@sigill.intra.peff.net>
	<87bnya8z6q.fsf@thomasrast.ch> <87d2iq58qk.fsf@fencepost.gnu.org>
	<87fvnk4ljl.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sat Feb 15 14:04:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEeuc-0005U2-Bk
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 14:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbaBONEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 08:04:00 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:53042 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbaBOND7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 08:03:59 -0500
Received: from localhost ([127.0.0.1]:52080 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WEeuT-0000cF-OG; Sat, 15 Feb 2014 08:03:58 -0500
Received: by lola (Postfix, from userid 1000)
	id 541D8E7EF7; Sat, 15 Feb 2014 14:03:57 +0100 (CET)
In-Reply-To: <87fvnk4ljl.fsf@thomasrast.ch> (Thomas Rast's message of "Sat, 15
	Feb 2014 13:17:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242191>

Thomas Rast <tr@thomasrast.ch> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> This definitely should not be "we'll think about it if and when that
>> project is finished" material.
>
> Yes, all of this is true.  However, you are painting a big devil on
> the wall.

[...]

> Your scenario above mostly applies if and when we really go the way of
> my dream and scrap the code that is in git.

So it's not "a big devil" I am painting but rather the consequences if
everything goes according to plan.

> (I have similar long-term dreams for other git components like ref
> storage and diffs, but that's just me.)
>
> Second, how many contributions would actually have been prevented by
> GPLv2+LE licensing?

That's not as much the question as to how many will be prevented in
future by such a step.

The libgit2 community is different from that of Git and with a different
focus.  If you take a look at its front page, you'll see statements like
"Link with open and proprietary software.  No strings attached." and
"Trusted and used in production by GitHub, Microsoft, [...]".

A fusion with this project and its aims and licensing will have
consequences regarding which developers and users are attracted to Git.

The "act first, think later" approach is not really doing anybody
favors, and I don't consider it fair to GSoC students to employ them for
making this proposal gain leverage: one should first think this through
on behalf of the project before putting students to work on this so that
they know reasonably well what will happen with their work.

The kind of "Now that we made $x do $y, we are obliged to do $z."
scenario is easy to avoid by _first_ contemplating whether or not $z is
where one wants to go.

That's not "painting a devil" but common sense.  I'm not saying that the
answer is in any way self-evident.  Merely that the best time to answer
it is _before_ getting invested.

> The only data I have on this is libgit2/git.git-authors, which records
> who has consented for their _existing_ code to be relicensed.  I
> consider this to be a higher barrier than contributing new code, since
> there's no clear gain for the author in the relicensing.

I consider it a lower barrier since the work is already done, and the
authors did not when doing it think about proprietary spinoffs.

But that's a minor point.  All I am saying is that there are different
opinions possible, and picking a particular path for future development
will in either way influence who wants to be part of the respective
communities.

-- 
David Kastrup
