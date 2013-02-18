From: Jeff King <peff@peff.net>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 12:42:39 -0500
Message-ID: <20130218174239.GB22832@sigill.intra.peff.net>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 18 18:43:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Uk9-00053P-6O
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 18:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756424Ab3BRRmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 12:42:43 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52026 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756339Ab3BRRmm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 12:42:42 -0500
Received: (qmail 22169 invoked by uid 107); 18 Feb 2013 17:44:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 12:44:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 12:42:39 -0500
Content-Disposition: inline
In-Reply-To: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216486>

On Mon, Feb 18, 2013 at 06:23:01PM +0100, Thomas Rast wrote:

> * We need an org admin.  AFAIK this was done by Peff and Shawn in
>   tandem last year.  Would you do it again?

I will do it again, if people feel strongly about Git being a part of
it. However, I have gotten a little soured on the GSoC experience. Not
because of anything Google has done; it's a good idea, and I think they
do a fine of administering the program. But I have noticed that the work
that comes out of GSoC the last few years has quite often not been
merged, or not made a big impact in the codebase, and nor have the
participants necessarily stuck around.

And I do not want to blame the students here (some of whom are on the cc
list :) ). They are certainly under no obligation to stick around after
GSoC ends, and I know they have many demands on their time. But I am
also thinking about what Git wants to get out of GSoC (and to my mind,
the most important thing is contributors).

As far as merged code, I think part of the problem is that git is fairly
mature at this point. The most interesting projects are of a bigger
scope than a student with no experience in the code base can do in a
summer project. Maybe that means we need to do a better job of breaking
projects down into reasonably sized sub-components. Or maybe it means
the project is hitting a point of diminishing returns for GSoC. I don't
know.

There are a few counterpoints I can think of:

  - Even though not all projects are winners, _some_ are. I see Carlos
    and Ram on the cc list, two people who started as GSoC students and
    stuck around.

  - There is also the angle that even if _Git_ doesn't benefit directly
    from people sticking around, those people may float into other open
    source projects and work on them. Which makes the world a better
    place on the whole.

So I don't know. Those are just some things that have been floating
around in my head. Feel free to ignore or discuss.

But thanks for getting the ball rolling, Thomas. If we are going to do
it, sooner is better, and if we aren't, then we should probably do so
consciously, and not just miss the deadline accidentally. :)

> * We should prepare an "ideas page".  Last year, Peff made one on
> 
>     https://github.com/peff/git/wiki/SoC-2012-Ideas
> 
>   I couldn't edit it there over git access[1], so I made a clone in "my"
>   github wiki:
> [...]
> [1]  That's a bit silly really, since I *can* edit it via the web
> interface.  Peff, perhaps you can get that fixed?

Ugh, I would have to write ruby code to fix that. I'll try to trick
somebody else here into fixing it. :)

> [2]  Unless Peff wants to take it over again?  You could just pull it
> from the git version, it's based on your history.

I think it is as good on your repo as on mine. The kernel.org wiki is
also up, and the github/peff/git one was supposed to be temporary. But I
really hate any wiki that I cannot edit with vim. I guess we need to
have a discussion as a group about where the "official" wiki should
live, and it should go there (I can also put it at github/git/git, which
is a more sane place; but I do not want to compete with kernel.org's
wiki unless there is community consensus that we are moving).

-Peff
