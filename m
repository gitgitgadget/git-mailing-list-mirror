From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Extract Git classes from git-svn (1/10)
Date: Wed, 25 Jul 2012 02:55:07 +0000
Message-ID: <20120725025507.GB13236@dcvr.yhbt.net>
References: <5004B772.3090806@pobox.com>
 <20120717174446.GA14244@burratino>
 <5005F139.8050205@pobox.com>
 <20120717233125.GF25325@burratino>
 <7vy5mhwrdl.fsf@alter.siamese.dyndns.org>
 <500F23E4.9090306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	robbat2@gentoo.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 04:55:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Strkv-00081R-8W
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 04:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575Ab2GYCzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 22:55:11 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33508 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754886Ab2GYCzK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 22:55:10 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12BBF3596F;
	Wed, 25 Jul 2012 02:55:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <500F23E4.9090306@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202093>

Michael G Schwern <schwern@pobox.com> wrote:
> On 2012.7.17 10:49 PM, Junio C Hamano wrote:
> > By allowing people to easily publish a completed work, and making it
> > easier for them to let others peek at their work, Git hosting
> > services like GitHub are wonderful.  But I am not conviced that
> > quality code reviews like we do on the mailing list can be done with
> > existing Web based interface to a satisfactory degree.
> 
> In this instance, I was just using Github for repository storage.  I was
> hoping I could just submit a remote git repository and people would look at it
> from there.  No Github required.
> 
> I understand this makes things very convenient for you to review patches, let
> me convey my POV...
> 
> After I'm exhausted from volunteering all the coding work, rather than
> submitting a URL to a remote repository I find I have to learn new specialized
> tools.  It's extra learning and work, an extra step to screw up, and foreign
> to me (even as a experienced git user).  It is of little benefit to me as a
> casual volunteer submitter.

Except git is also a "new specialized tool".  Your examples are exactly
why I'm saddened many projects only adopted git, but not the workflow
which _built_ git (and Linux).

> I can see if you've been on the git mailing list for a while and have git-am
> and all that set up, this system is great.  But it comes at a cost which is
> offloaded onto new and casual contributors.

Email is integral to Free/Open Source development and remains one of the
few things on the Internet not (yet) controlled by any central entity.
Once setup, the same email setup can work across all projects which use
email.  These projects need not be hosted on the same websites/servers
at all.

> This sort of specialized setup makes people bounce right off the submission
> process.  At OSCON I was asking around for help getting things setup so I
> could submit patches here properly.  As soon as they said "which mail daemon
> are you running?", I said "stop!  I don't want to know any more".  I have too
> many things to do to be fiddling with my mailer configuration just to submit
> volunteer work in the right form (that said, I'm pleased as punch that
> git-send-email now has instructions for sending via GMail).  You're
> volunteers, too.  We're all volunteers, so a more balanced submission process
> would be nice.

How about we educate users about a proper email setup instead?  If
they're capable of learning git, they're surely capable of setting up an
email client properly, and perhaps more projects can adopt an
email-centric workflow.

> But since you brought Github up... (I get the impression its kind of a dirty
> word around here)

(Not speaking for the git project)   I'm entirely against the way GitHub
(or Ohloh or similar services) gamifies software development and tries
to tie a person to all their other projects.

Much of my code is public, but I am a private person.  I want code to be
judged solely on its own merits of that code; not from what the author's
achieved or how "popular" the person might be in the development world.
Unfortunately, GitHub (and other social networks) is structured to
encourage that sort of thing (which I know is appealing to many).

For me, the whole social network followers/timeline thing also has a
_huge_ creepiness factor to it.  How one prioritizes and spends time
between different different (especially unrelated) projects should be
nobody else's business.

I don't make it /easy/ for someone (e.g. Junio) to know I'm slacking
off on my git work to hack on ProjectNoOneUses :)

One could try using a different account for every project, but that's
also violating the terms of service.

> If all the clicking and opening tabs in a browser feels uncomfortable to
> you... its something you learn like anything else.  Less and less people are
> comfortable in mail clients.  Who is the system optimized for?  It doesn't
> have to be a zero sum game.

(Still not speaking for others)  I believe GUIs are (mostly) harmful.

Graphical browsers don't interact well with command-line tools.
Browsers have no concept of a working directory; I can't fire up a
browser tab/window for each project I work on and edit/apply patches
directly from the browser like I can with an MUA.

We need to figure out how to teach folks to use email (properly)
instead.
