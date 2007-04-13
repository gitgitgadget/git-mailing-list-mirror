From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: SoC git projects announced
Date: Fri, 13 Apr 2007 18:19:27 -0400
Message-ID: <20070413221927.GB944@spearce.org>
References: <200704120845.56793.andyparkins@gmail.com> <20070412164357.GD12979@spearce.org> <evostf$6ab$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 00:19:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcU7D-0006qN-Gk
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 00:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030656AbXDMWTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 18:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030859AbXDMWTc
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 18:19:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38803 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030656AbXDMWTb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 18:19:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HcU6x-0000l5-Tz; Fri, 13 Apr 2007 18:19:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7CA4720FBAE; Fri, 13 Apr 2007 18:19:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <evostf$6ab$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44437>

Jakub Narebski <jnareb@gmail.com> wrote:
> Could you tell us which projects were applied to (and if there were more
> than one application per project, how many applicants there were), and
> which ones of that were good?

Sure.  The other projects were (and in no particular order except
the way my brain functions on Fridays):

- Shell script to C conversions: 6 other projects submitted.  Those 6
  are in addition to the one that we did accept by Carlos Rica
  Espionsa, so we actually received 7 applications for this project.

  Dscho and I wanted to accept one more of these projects, but we
  just ran out of slots.  That other student has already said he
  is still interested and may try to contibute a little bit this
  summer anyway.

- Git backed Subversion server: 2 projects submitted.  One of the
  students has started to become a regular on #git, and has said
  he may still work on this project, assuming he can find the time.

  That student's project was also one that we wanted to accept,
  but again, we just ran out of slots.  Martin Langhoff had
  volunteered to mentor him, along with Sam Vilain.  So we may
  still see something from this.

- EGit enhancements: 1 project submitted.  I wanted to accept this
  project too, but throw new google.NotEnoughSlotsException().

- .gitlink lightweight checkouts: 2 projects submitted.  One of these
  projects had a very well written proposal.  It got ranked pretty
  high, and was one we were considering accepting.  But uh, ENOSLOT.

- Blame based merge strategy: 1 project submitted.  Personally I
  like the idea of this project, so I had I bias to wanting to see
  it get accepted.  But we had a merge conflict on slots... :-)

- More complete test suite: 1 project submitted.

- Revision control plugin for GNOME GVfs/Nautilus: 1 project
  submitted.  This particular project wasn't in our ideas list.
  We liked it, we just did not feel we had a mentor who could do the
  project justice.  A little too far away from our area of expertise.

- Managed C# implementation of Git for Mono: 1 project.  This student
  actually submitted this project also to Mono, and Mono actually did
  pick it up (with Miguel as the mentor).  Since Mono got more spots
  than we did, and accepted him, I'm happy we didn't accept him.  :-)

  I've actually gotten in touch with this student, and with Miguel,
  and offered up what co-mentoring assistance we can provide,
  since the student is reimplementing Git in C#...

As you can see, we did have a recurring theme, ENOSLOT.  Google only
offered us 3.  We had 8 on our short list.  The 3 that we did select
were partly just luck on the student's part, as to some extent
we really did just flip a coin to select between the available
project ideas.  It was a very difficult decision for us.


In the end it really came down to the following reasons why we
selected the 3 particular projects that we did:

- We only had one Gittorrent proposal, and it was very good.
  Srijak Rijal was working off-list with Sam during a good part of
  the application review process to discuss it.  Gittorrent is a
  nice idea that has had a difficult time getting off the ground.
  Perhaps having Srijak work on it full-time this summer will
  do just that.

- Dscho really wants to get more of the core utility programs
  rewritten in C, as it makes the system more portable, and easier to
  work on.  (His opinion, which I share.  Junio is free to disagree,
  and sometimes does.)  We had a really good application for that
  from Carlos Rica Espinosa, and again, Carlos worked through the
  application review period on it with Pasky, Dscho and myself.

- I want a library API for Git, from C, as sometimes dammit its
  easier to call the C routines than it is to deal with pipelines.
  The only application we received for this was from Luiz Capitulino,
  it was excellent, and he discussed the topic to some length here
  on the mailing list, and off.

In all three cases the students showed (even if only off-list)
qualities that some of our better on-list contributors show:
willingness to work, initiated things on their own, are smart,
capable of analyzing the problem and producing a solution, they
followed through on things, etc... It was difficult for us to not
appreciate these qualities in them.

Of course they were not the only students that showed those qualities.
Many of the projects we didn't accept were equally good.

Trust me, this selection process has been very difficult on me.
I haven't felt well all week, simply because we couldn't take
everyone we wanted to.  I have felt (and am stilling feeling)
pain for the students we could not accept.

-- 
Shawn.
