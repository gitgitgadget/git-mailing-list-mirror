From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Welcome to Git's GSoC 2008!
Date: Sat, 26 Apr 2008 14:59:43 -0400
Message-ID: <20080426185943.GF29771@spearce.org>
References: <20080422013201.GA4828@spearce.org> <m3d4odq3w1.fsf@localhost.localdomain> <20080426172945.GD29771@spearce.org> <200804262028.09746.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 21:00:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JppdS-0002v1-QK
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 21:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761110AbYDZS7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 14:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760786AbYDZS7r
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 14:59:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49637 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760581AbYDZS7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 14:59:46 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JppcX-0005Fi-L0; Sat, 26 Apr 2008 14:59:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6597320FBAE; Sat, 26 Apr 2008 14:59:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200804262028.09746.jnareb@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80386>

Jakub Narebski <jnareb@gmail.com> wrote:
> On Sat, 26 Apr 2008, Shawn O. Pearce wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:
> >>
> >> I have found three another Git-related Google Summer of Code 2008
> >> projects by other organizations:
> 
> By the way, it is a bit strange that Google Summer of Code 2008 pages 
> are not fully indexed.

It is strange.  But I'm sure its something like the site is indexed
by Google itself, and the page rank algorithm is classifying most
of the pages as too low to be worth returning due to the low number
of hyperlinks going in.

> Currently searching for "git soc 2008" from 
> "Search Google Code:" search form finds only organization info for Git 
> Community, "Git plugin for Anjuta IDE" project, SoC2008Template 
> (Note, this template is blatantly plagiarized from Git's SoC 
> template ;-)

Apparently our GSoC work has been useful to others outside of Git.
Excellent.  GSoC has started to become even more of a pet project
of mine, so I'm glad to see people outside of our community have
found our work useful.
  
> >>     Git plugin for Anjuta IDE  (GNOME)
> > 
> > This project was new to me; prior to your message I did not know
> > about it.  Thanks.
> 
> Have they contacted Git Community (IRC channel, mailing list, individual 
> developers) for help, or did you contacted them, as with "KDevelop DVCS 
> support"?

They haven't contacted me or anyone I know.  I looked up an email
address for the mentor (couldn't locate one for the student)
and sent them an email, as I did for KDevelop.  Except I wrote it
after my reply to you so I didn't mention it in my reply to you.
Ok, so now I have mentioned it.  ;-)

> >>     KDevelop DVCS support      (KDE)
> 
> With these two projects, and egit/jgit for Eclipse, and also planned Git 
> support in NetBeans IDE, there would be Git support in I think most 
> used IDEs... What's left is something akin to AnkhSVN, i.e. support for 
> Git in Visual Studio; perhaps Git# projects would help with it...

I haven't heard anything about Git in NetBeans lately.  I'm hoping
that one day a devoted NetBeans user will come along and pester
us to break jgit out of the egit repository, so that they can
use it within NetBeans without lugging around Eclipse code they
don't need.  The code is already built with that in mind, it just
has the unfortunate fate of being mingled in the same repository
as the egit code.
  
> I wonder how much will be done; I guess it can borrow at least a bit 
> from QGit (history viewer) and KGit (commit tool).
>  
> >>     Git# implementation        (Mono Project)
> >
> > There is some concern from people who are close to the summer of code
> > program that two students working on the same project this summer may
> > result in one's success being dependent upon the other's success.
> > This sort of dependency is not permitted under the Summer of Code
> > rules, as it can be quite unfair to an otherwise successful student.
> 
> I was wondering how this have passed GSoC projects screening...

Marek Zawirski (the Git GSoC student adding push support to jgit)
mentioned something about this to me earlier this week.  I made a
remark about it on #gsoc, and the Google folks who do most of the
work for GSoC had not heard about it before my comment.  With so
many students and projects I am not surprised that they cannot
screen everything.

Most of the screening is left up to the mentors themselves.  So in
this case the Mono mentors must have felt that this project was
large enough and important enough to justify using two student
slots, and that either they didn't know about the rule, were going
to ignore the rule, or would be able to structure the projects to
avoid this dependency.

I hadn't realized Git was so important to the Mono folks.  I thought
they were still on SVN.  In any event, it is interesting that they
are building IDE support.  Its depressing that Microsoft managed to
fracture the development communities into Java vs. C# and that they
use different VMs, resulting in it being more likely that code will
be rewritten rather than reused.

-- 
Shawn.
