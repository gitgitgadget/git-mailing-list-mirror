From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 07:43:20 -0500
Message-ID: <20061018124320.GT75501@over-yonder.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org> <45359B2A.1070102@utoronto.ca> <4535E844.8010604@op5.se> <20061018103220.GS75501@over-yonder.net> <45360DAE.8000702@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 18 14:44:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaAm2-0006o9-8h
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 14:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWJRMn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 08:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWJRMn2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 08:43:28 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:54237 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S1030257AbWJRMn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 08:43:27 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 29B9928431;
	Wed, 18 Oct 2006 07:43:21 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id 92E6D61C57; Wed, 18 Oct 2006 07:43:20 -0500 (CDT)
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <45360DAE.8000702@op5.se>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29227>

On Wed, Oct 18, 2006 at 01:19:10PM +0200 I heard the voice of
Andreas Ericsson, and lo! it spake thus:
> 
> It's just that we have this one place where gitweb is installed,
> which management likes whereas devs don't have that on their laptop.
> It's also convenient to have one place to find all changes rather
> than pulling from 1-to-N different people just to have a look at
> what they've done.

I think this just by itself lends support to:

> The point I'm trying to make here is that the star config might be
> the most common case today because

c) Stars work well as a mental model for humans.

Heck, in large, Linux is star-ish.  There s "2.6.1", "2.6.2", etc;
that's a trunk.  Any time you have releases, you're establishing a
"master" branch.  For most people using Linux, there's a trunk,
whether it's the kernel.org trunk, or the "What Redhat ships" trunk,
etc.  The closer you drill to the day-to-day work on the kernel, the
farther it gets from trunks, but if it were full-mesh at all levels I
don't think it would be nearly as usable for regular computing tasks
as it is.


Perhaps someday a heavy full-mesh setup will be the common case for
VCS usage.  I find that very difficult to buy for various reasons, but
it could happen.  If it does, bzr may well revisit the choice and
decide revnos contribute little enough marginal value as to be a loss,
and discard them.  But that's not today.


> But they *do* exist, and they *usually* work, so people are bound to
> try them first. Teaching them when they work and when they don't (or
> rather, when they should and when they shouldn't, cause they will
> work by accident sometimes too) is bound to be a lot harder than
> sending them a 10 char irc message.

Perhaps, for some projects.  And in those cases, perhaps you'd want to
flip a hypothetical "dump those numbers in the bin" switch.  That
doesn't mean every project wants to, or that those projects who don't
and have no trouble and discernible gain from revno usage are
hypothetical.


> So what's the point in having them? You can't seriously tell me that
> you think of 123.5.2.17 as something you can easily remember, do
> you? Count the times, during one day, where you use the revnos and
> type them manually.

No, I don't.  But I don't use merge revnos for various reasons, one of
the primary ones being that they don't currently intuitively follow
from me (and that intuitiveness is the major attraction of revnos in
the first place).

I rarely refer to non-mainline revisions at all, in fact.  And I use
revnos for mainline revisions regularly.  Heck, I communicate revnos
_verbally_; people handle that easily with numbers, not so easily with
hex strings.  The vast majority of my branches are simple cases, and I
like simple tools that match simple mental models for them.  For the
more intricate cases, revids provide a more rigorous tool, and I WANT
a VCS that lets me choose which is appropriate.  If I wanted a
computer to tell me how to work, I'd run Windows    ;)


> Not really. It's just that case 3 is the most flexible of them all.

Yes, but this doesn't necessarily mean everything you seem to try and
cover with it.  The more rigorous tool will cover the simplest case
(those being just a degenerate form of the more complex after all),
but that doesn't mean it's the EASIEST way of handling that case.


> Everything works *exactly* as it would have done without it in all
> repos around the world.

And if you use the UUID's, the same applies to bzr.

That is, if you use git like you use git, the above is true.  If you
use bzr like you use git, the above is ALSO true.

The difference is that bzr ALSO chooses to support and optimize for a
different case in the default UI presentation, because We[0] consider
that far and away the common case on the one hand, and that people
trying to use the more complex case are ipso facto more able to use a
behavior differing from the norm on the other.


[0] Note how adroitly I again speak for other people.  Practice,
    practice!


> >That's one way of phrasing it, I guess.  I'd say rather "a
> >particular feature isn't applicable to a completely distributed
> >setup".
> 
> So how come it's in the same list of features as the "distributed
> repository model", and both are marked as supported when they're
> apparently mutually exclusive?

I assume in this you're referring to the RcsComparisons page that
started the thread.  First off, I don't agree with all the
characterizations on the page, so don't expect me to support it as
gospel.  That said, they're not "mutually exclusive"; one is just
inapplicable in extreme cases of the other.  "Plugins" is on the same
list as "distributed repository model" too.  And you can't count on
other people having the same plugins as you, so it's just as "mutually
exclusive" with distributed.


> The main point, the *important* point about git is that everything
> it shows always makes sense and works in exactly the same way no
> matter which setup you use.  There are no features in git that are
> mutually exclusive, or only sane in one particular setup but not in
> others.

I find it really hard to believe that that's strictly true, just as a
general rule.  For that matter, I think it's demonstrably false: using
SHA1 hashes as revision identifiers in a simple linear tree with 5
revs doesn't strike me as "sane".  But that aside...

I don't think of that as a positive thing.  There are lots of things
that make sense in certain setups that don't in others.  We have two
techniques, A and B, and two general cases, X and Y.  A works really
well for X, and is useless with Y.  B works ok for X, and handles Y
well.  "Use A for X and B for Y" seems like a heck of a lot better
answer than "Only support B".  You certainly CAN shape wood joints
with just a claw hammer, but I wouldn't want to.  A jigsaw makes it
much easier, no matter how useless it may be for forging iron.


Your position seems to be, in essence, "This feature can be misused,
therefore it should be eliminated".  And you should certainly use a
tool that provides the behavior you want.  So, too, should other
people.

I don't want to use git for any number of reasons, which sum up
concisely if undescriptively as "It doesn't work for me", but it seems
to work great for the community it was built for, and that's
excellent.  Not all aspects of that design work well for other people,
though, no matter how poorly some capability "fits" you
(non-specific), it can still fit others very well.  This particular
item certainly seems one of those significant divides.



-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
