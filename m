From: Jeff King <peff@peff.net>
Subject: Re: GSoC 2014: Summary so far, discussion starter: how to improve?
Date: Thu, 21 Nov 2013 05:04:21 -0500
Message-ID: <20131121100421.GA14066@sigill.intra.peff.net>
References: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
 <87txf6jgmi.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ben Straub <bs@github.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Christian Couder <christian.couder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Edward Thomson <ethomson@microsoft.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Martin Woodward <martin.woodward@microsoft.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Michael Schubert <schu@schu.io>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Philip Kelley <phkelley@hotmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Russell Belfer <rb@github.com>,
	Scott Chacon <schacon@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Thomas Gummerer <
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Nov 21 11:04:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjR7d-0004Q6-U0
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 11:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124Ab3KUKE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 05:04:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:43104 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752020Ab3KUKEY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 05:04:24 -0500
Received: (qmail 7602 invoked by uid 102); 21 Nov 2013 10:04:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Nov 2013 04:04:25 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Nov 2013 05:04:21 -0500
Content-Disposition: inline
In-Reply-To: <87txf6jgmi.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238115>

On Thu, Nov 21, 2013 at 09:36:37AM +0100, Thomas Rast wrote:

> Thomas Rast <tr@thomasrast.ch> writes:
> 
> > * Does libgit2 want to remain under the Git umbrella, or participate
> >   on its own?
> >
> > * Figure out the wiki situation.  In previous years the project
> >   proposals and other important information were hosted at k.org [5] and
> >   github wikis [6].  Other options were floated, such as an official
> >   wiki hosted by github.  (This is somewhat of a contentious issue that
> >   spans beyond GSoC.)
> >
> > * Find an org admin and backup.  In previous years Shawn and Peff did
> >   this.  Would you do it again?
> 
> Any opinions on these points?

I'll answer them in reverse order. :)

I'm happy to be org admin again (or happy to give up the mantle if
somebody else is interested).

Regarding the wiki, my main complaints about the k.org wiki have been:

  1. It was down last time we tried to use it for GSoC. :) This has
     since been fixed.

  2. I had the impression that spam was a problem and it needed a crew
     of scourers to find and remove it. That's a thankless job that I
     don't personally want to do. It looks like there is not much spam
     these days (perhaps due to k.org's login restrictions?), and people
     do remove it. So if there are sufficient volunteers, it may be a
     non-issue.

  3. You can't use git to edit it or view the history. These days we
     have the git-remote-mediawiki helper. I haven't done any real work
     with it, but I have played around and I think it may be sufficient.

  4. Mediawiki syntax sucks compared to Markdown. :)

     That's my personal feeling, but I recognize others may disagree. A
     syntax change might be seen as a disadvantage of moving by some. I
     can live with it (but I want to throw it out there in case
     everybody feels the same way).

The disadvantages / complications of moving to a different wiki (e.g., a
GitHub wiki) are:

  1. It's non-zero work to set up, especially if we do not just use an
     out-of-the-box solution. I'd be in favor of some kind of static
     site generator, but then we have to pick one, style it, set up
     auto-build-on-push, etc. GitHub Pages would do most of the dirty
     work there, if we want to use it.

  2. Some solutions involve using non-free software or services, which
     some people may not like.

  3. What happens to the old wiki? Other sites link there, and it has
     content. Do we migrate the content? Do they both exist simultaneously?
     Is one just for GSoC stuff (which seems unnecessarily confusing to
     me)?

For libgit2, I think it makes sense to leave them under the Git umbrella
and give them a slot or two as appropriate, as it saves administrative
effort. But it is up to them if they want to split off into their own
GSoC org. If that is the case, they will need an admin and to do a bunch
of application paperwork. I believe we can give them a recommendation to
help ease the process along.

-Peff
