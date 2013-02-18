From: Jeff King <peff@peff.net>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 16:13:21 -0500
Message-ID: <20130218211321.GD27308@sigill.intra.peff.net>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
 <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
 <20130218185801.GA25673@sigill.intra.peff.net>
 <CALkWK0kFYP4k5=237PZ3XHhxkzF-RWwwe=3+Thb_xU2Jw5tg2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 22:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Y2B-0004uV-3a
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 22:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321Ab3BRVNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 16:13:25 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52323 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755329Ab3BRVNX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 16:13:23 -0500
Received: (qmail 24852 invoked by uid 107); 18 Feb 2013 21:14:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 16:14:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 16:13:21 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0kFYP4k5=237PZ3XHhxkzF-RWwwe=3+Thb_xU2Jw5tg2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216532>

On Tue, Feb 19, 2013 at 01:15:49AM +0530, Ramkumar Ramachandra wrote:

> Take what I'm about to say with a pinch of salt, because I've never mentored.
> 
> Mentors often don't provide much technical assistance: students should
> just post to the list with queries, or ask on #git-devel.  Mentors
> serve a different purpose; their primary responsibility, in my
> opinion, is to teach the student a sustainable productive workflow.
> This means: profiling them to figure out where they're losing out.  Do
> they have the habit of:
> - posting to the list regularly?
> - CC'ing the right people?
> - iterating quickly after reviews?
> - using gdb efficiently to quickly understand parts?
> - using git efficiently for the rebase/ patch workflow?

I think you are spot-on. Those are the things that students need to
learn to do, and what mentors should be pushing them towards. But it
seems like we have the same problems with it year after year, and I know
mentors have worked on it. I'm not sure where the problem is.

> > I very much agree with you here. One problem is that those smaller
> > projects often do not sound as grand or as interesting, and so students
> > do not propose them. We have to work with the applicants we get.
> 
> We have to post well-crafted proposals like this to pique their interest.

True. I think we can bear some of the blame in the proposal writing. But
if you look at the applications each year, they tend to cluster around
one or two projects, and most projects get no hits at all. It could be
because they're badly written. But I think it is also that they are not
in areas that are as flashy (and the flashiness often correlates with
complexity).

> No, I'm against using the GitHub Wiki for neutrality reasons.

Fair enough. I have the same reservations.

> There is one easy way to fight spam: don't expose a web-based editing
> interface at all.  It's mainly going to be maintained by the
> community, and we're all much more comfortable in our editors and git.
> We can give the regulars direct commit access and ask the rest to
> submit pull requests.  Make it cost pennies, so any of us can easily
> afford it: just a cheap domain, DNS, and static HTML hosting.

I'd be totally fine with that. You'd need to pick a static generator
framework (I don't think it is a good idea for everybody to be writing
raw html). I suspect kernel.org would be happy to host the static pages,
but if not, GitHub can pick up the hosting tab (and we could probably do
it as a subdomain under git-scm.com, too, if people want).

-Peff
