From: Eric Wong <normalperson@yhbt.net>
Subject: Re: OT: mail-based interfaces and web-based interfaces (Re: Extract
Date: Wed, 25 Jul 2012 23:48:38 +0000
Message-ID: <20120725234838.GA16020@dcvr.yhbt.net>
References: <5004B772.3090806@pobox.com>
 <20120717174446.GA14244@burratino>
 <5005F139.8050205@pobox.com>
 <20120717233125.GF25325@burratino>
 <7vy5mhwrdl.fsf@alter.siamese.dyndns.org>
 <500F23E4.9090306@pobox.com>
 <20120725025507.GB13236@dcvr.yhbt.net>
 <500F860E.5010909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	robbat2@gentoo.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 01:49:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuBKU-0004gp-NE
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 01:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab2GYXsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 19:48:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40383 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200Ab2GYXsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 19:48:39 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD291F439;
	Wed, 25 Jul 2012 23:48:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <500F860E.5010909@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202217>

Michael G Schwern <schwern@pobox.com> wrote:
> On 2012.7.24 7:55 PM, Eric Wong wrote:
> > Except git is also a "new specialized tool".  Your examples are exactly
> > why I'm saddened many projects only adopted git, but not the workflow
> > which _built_ git (and Linux).
> 
> Github also has broad spectrum utility.  I learn how to fork and work with a
> Github pull request once, and I can repeat that on thousands of different
> projects of all different sorts of things.
> 
> This commonality of tools and techniques is very important to easing the on
> ramp for new (to-your-project) developers.

I agree commonality is important.

But to me, it's not worth the cost of reliance on centralized,
single-vendor solutions.  My distrust and dissatisfaction with
centralized/single-vendor solutions is the reason I'm involved with Free
Software (and decentralized version control) in the first place.

> > Email is integral to Free/Open Source development and remains one of the
> > few things on the Internet not (yet) controlled by any central entity.
> > Once setup, the same email setup can work across all projects which use
> > email.  These projects need not be hosted on the same websites/servers
> > at all.
> 
> While I hear your concern about being centrally controlled, it is largely
> irrelevant to the new user experience.  And remaining independent does not
> mean you can't use web tools.  Be wary of a false dichotomy between Free and web.

Of course, I'd be in favor of shifting development to something less
centralized than a mailing list.  OStatus may become a good choice one
day, but the adoption/tools just aren't there right now.

> "We use a mailing list" is by no means an indication of commonality.  Every
> project of the "send patches to the list" form has their own quirks and ways
> of doing it.  Usually they're not written down.  This is what I've been
> struggling with.  I've been sending patches to mailing lists for decades and I
> can tell you everybody does it differently.  "Send a patch to the list" is one
> of the steeper project on-ramps.

Sure, every project/culture has different norms.  It's no big deal,
learn them, or avoid them.

Projects all have different coding styles, different conventions for
writing commit messages, changelogs and so on...  I live with that and
I'll do my best to adjust my style/editor settings/grammar/vocabulary
accordingly for each project I contribute to.

I won't send patches to mailing lists of projects which prefer
patches/pull-requests on their web tracker, either.  If the project is
important enough to me, I'll (grudgingly) use whatever tools/formats the
maintainers prefer.

> > How about we educate users about a proper email setup instead?  If
> > they're capable of learning git, they're surely capable of setting up an
> > email client properly, and perhaps more projects can adopt an
> > email-centric workflow.
> 
> SubmittingPatches would be helped by that, particularly with a clear
> step-by-step example of using git-send-email and all its numerous command line
> switches.

It's documented in the gitworkflows(7) manpage.  They should probably be
linked somehow.

> And, finally, the last thing most people want is more email.  Seriously.  It
> sounds like you live in your mailer, but fewer and fewer people do that.  Me?
>  I don't want to join another mailing list.  My email management is a disaster!

I live in my mailer/$EDITOR/shell and I'm happy with that.

The last thing I want is more cookies, non-Free JavaScript code, logins,
user tracking/profiling, memory/CPU usage.  I doubt either of us will
get what we want, though :<

> What it comes down to is this: is it enough to contribute to git.git to know
> how to work on git.git?  Or do you also need to live in your mailer?  Bolt on
> that extra requirement and you lose a large swath of contributors.

We need to use something.  Right now our choice of mailer is the best
choice for _existing_ contributors.

> > For me, the whole social network followers/timeline thing also has a
> > _huge_ creepiness factor to it.  How one prioritizes and spends time
> > between different different (especially unrelated) projects should be
> > nobody else's business.
> > 
> > I don't make it /easy/ for someone (e.g. Junio) to know I'm slacking
> > off on my git work to hack on ProjectNoOneUses :)
> 
> You want to know what's creepy?  That you'd think people work like that.
> 
> It doesn't work out that way.  People have far better things to do than stalk
> your Github commits to see how you're spending your time.  You're just not
> that interesting.  Neither am I!
> 
> (If I really wanted to I could just compile your activity from public list
> archives and repositories, so you're really not broadcasting any less
> information about yourself by staying off Github.  But I wouldn't want to,
> because you're just not that interesting and I have better things to do with
> my time!)

There's a big difference between making information easy-to-access vs.
merely possible-to-access.

For the most part, people don't care about me (which I'm glad for), but
it has creeped me out when somebody did (especially people I've never
interacted with before).  People do often look to other well-known
developers as role models and GitHub's made it easier for folks who
welcome that attention.

> >> If all the clicking and opening tabs in a browser feels uncomfortable to
> >> you... its something you learn like anything else.  Less and less people are
> >> comfortable in mail clients.  Who is the system optimized for?  It doesn't
> >> have to be a zero sum game.
> > 
> > (Still not speaking for others)  I believe GUIs are (mostly) harmful.
> 
> You can hate GUIs, but you should also realize that just about everyone out
> there likes them, and they're not all morons.  If you deny GUIs as a tool for
> git.git developers because of your blind spot, then you're losing potential
> contributors.  More and more as time goes on.

I disagree, there's a healthy number of users learning to do more and
more on the command-line.  There'll likely always be more GUI users, but
the command-line isn't going away.

> Recognize it as a personal blind spot, don't punish your users because of it.

Users of my software are already command-line users.
I'm certain of this because I don't develop GUI software :)

> > Graphical browsers don't interact well with command-line tools.
> > Browsers have no concept of a working directory; I can't fire up a
> > browser tab/window for each project I work on and edit/apply patches
> > directly from the browser like I can with an MUA.
> 
> I'm not sure what you're talking about, or what sort of workflow you've got
> going with your mailer, but I'm sure with just as much time and effort as
> you've put into your CLI and MUA setup you can be just as efficient or moreso
> GUI.  One can do crazy shit in browsers these days either in Javascript or by
> writing or using an add-on.  But also, one doesn't have to do EVERYTHING with
> a single tool.  Amazing But True!

I run my mailer from different machines which I usually control remotely
(on links insufficient for X11 forwarding, but enough for regular
ssh/mosh).

I write email/code with my $EDITOR of choice, and can pipe messages from
my mailer to arbitrary command-line programs (e.g. git am, patch, ssh).
My mailer lets me edit patches/commit messages as needed (fixing minor
grammar/spelling mistakes, adding Acked-by/Tested-by/Signed-off-by:
lines) before piping them.  I use multiple tools, but I can do all this
without the overhead of switching terminals/windows (which can cause a
loss of mental focus).

A web browser is significantly clunkier and would require extra
steps/tabs/windows to put/run code where I want it.

One could develop/improve CLI programs for a REST API, too, but
right now that API is still owned and controlled by a central entity.
If the web-based API weren't centrally controlled, I'm not opposed to a
workflow which allows me to interact with the API via curl or
purpose-built CLI tools (with offline capability).

> You should consider sitting down with somebody who works very differently from
> how you do and see how they do it.  You might learn something you don't know
> you don't know!

Sure I've tried, but I have yet to be impressed by anything I've seen
from GUI users.  On the other hand, I have learned much from other
command-line users over the years (and developed my own workflows this
way).

> And again, it *does not have to be zero sum*.  It doesn't have to be email VS
> GUI.  You can have your cake and eat it too.

I agree we can do both, but we already have email.

I think the git project endorsing any /workflow/ based on a centralized,
non-Free service would be damaging to the viability of Free,
decentralized version control.
