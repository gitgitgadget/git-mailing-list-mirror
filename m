From: Jeff King <peff@peff.net>
Subject: Re: For real now: bug tracking and secretary tasks in git
Date: Tue, 26 Jan 2010 07:26:55 -0500
Message-ID: <20100126122654.GA28179@coredump.intra.peff.net>
References: <20100109013850.16f82412@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue Jan 26 13:27:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZkVb-0000EA-E5
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 13:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab0AZM07 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2010 07:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398Ab0AZM07
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 07:26:59 -0500
Received: from peff.net ([208.65.91.99]:50714 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022Ab0AZM06 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 07:26:58 -0500
Received: (qmail 23806 invoked by uid 107); 26 Jan 2010 12:26:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 26 Jan 2010 07:26:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jan 2010 07:26:55 -0500
Content-Disposition: inline
In-Reply-To: <20100109013850.16f82412@perceptron>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138034>

[This reply is a bit late, but there doesn't seem to have been much
discussion, so...]

On Sat, Jan 09, 2010 at 01:38:50AM +0100, Jan Kr=C3=BCger wrote:

> Mass consensus in previous discussions[1][2] goes a bit like this:
>=20
> 1. It would be desirable to have people who do the work of interfacin=
g
>    between bug reporters and developers. These same people could make
>    sure reports didn't get lost. These people are the *secretaries*.
>    They should be pretty reliable.
>=20
> 2. People who contribute to git shouldn't be forced to work with the
>    tracker. Having a tracker that isn't actively maintained by dedica=
ted
>    secretaries is pretty much worthless anyway, so there's no need to
>    pretend that forcing developers to use a tracker interface is any
>    kind of improvement.
>=20
> 3. The "human element" is important. For example, automatic reminders
>    are a lot less valuable than reminders from an actual person.

I more or less agree with your approach, though I am a bit concerned
that because the process of moving information between the list and the
bug tracker is manual, bits of information will be lost unless the
secretaries are on their toes. Which means that people who submit bugs
will see no activity on their bug, even though it may have been
discussed on the list, and will consider the tracker to be crufty and
useless.

But that is not so much a criticism of your proposal, as a possible
thing that might go wrong. It's worth giving it a try and seeing what
happens.

I notice that there are not too many bugs in the tracker right now. If
this is going to be useful for ordinary users to submit bugs, it needs
to be publicized. JH suggested hosting it at kernel.org. I think that i=
s
a reasonable idea, and certainly it needs a link from other git sites
(the wiki, and probably git-scm.org).

As far as the choice of flyspray, I'm not strongly against it, though I
suspect you would get more up-take from git developers (well, me,
anyway) if it was something that had a more git-ish interface. It would
be really nice to clone the bug db, edit, commit, and push bug updates.
Many of the distributed trackers support that. I recognize that for
ordinary users, we do still want some kind of web-based submitting and
bug reading interface. Surely somebody has built a git backend on one o=
f
the existing trackers, or somebody has built a nice web interface on on=
e
of the distributed trackers? It has been a while since I looked
seriously at this area, and I remember being a bit disappointed last
time.

And finally, thanks for starting a discussion on this issue. We talked =
a
little about it at the GitTogether, and what you proposed is in line
with what was said there, I think. My plan going forward from that
discussion (which I hadn't actually started implementing, though) was t=
o
clean up my own personal todo list and start making it a bit more
public. The reason being that my list is not simply personal features,
but lots of bugs posted to the list that have not been dealt with, and
that I have either decided are probably actual bugs that need fixing, o=
r
even ones that I have reproduced but need prodding to move forward on.
So sometime in the near future I'd like to clean up that list and dump
it into whatever sort of bug tracking we end up with.

-Peff
