From: Jeff King <peff@peff.net>
Subject: Re: Licensing a file format (was Re: SVN Branch Description Format)
Date: Tue, 20 Mar 2012 18:59:18 -0400
Message-ID: <20120320225918.GA31958@sigill.intra.peff.net>
References: <4F5C85A3.4080806@pileofstuff.org>
 <4F668BD4.70808@pileofstuff.org>
 <20120319013422.GC19680@burratino>
 <4F6797AD.2070501@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Andrew Sayers <andrew-20120318@pileofstuff.org>,
	Git Mailing List <git@vger.kernel.org>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Nathan Gray <n8gray@n8gray.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>, semen.vadishev@tmatesoft.com
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 23:59:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA81W-0005iL-4S
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 23:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759291Ab2CTW7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 18:59:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54727
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759266Ab2CTW7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 18:59:20 -0400
Received: (qmail 15393 invoked by uid 107); 20 Mar 2012 22:59:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Mar 2012 18:59:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2012 18:59:18 -0400
Content-Disposition: inline
In-Reply-To: <4F6797AD.2070501@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193546>

On Mon, Mar 19, 2012 at 08:31:41PM +0000, Andrew Sayers wrote:

> > Yes.  By the way, I think fear of forking/discussion of potential
> > improvements/translation into other languages in the context of
> > standards is misguided.  If you would like legal protection for your
> > standard, that is what trademark law is for.
> [...]
> 
> Could you expand on this?  A quick tour of the git codebase suggests
> your objection is just to the "no derivatives" bit for documentation,
> and not to the MIT license for code?
> 
> It sounds like you're saying that forking isn't a big real-world
> problem, which I guess makes sense - it'll all work out in the end as
> long as a single standard is in everybody's interests.  So the CC-BY
> license is my favourite for now.

I think the problem is that there are two levels of forking. You want
people to be able to build off of your standard for a number of
legitimate reasons. Perhaps they are publishing a draft proposal of
enhancements. Perhaps they are adapting parts of the content of your
standard to a different domain. Perhaps the original author has become
unresponsive and somebody else wants to pick up maintainership. Those
are all things we do with code, and they help the ecosystem.

What _isn't_ good is somebody modifying your standard and then claiming
that their implementation is "the real SVN History Description" format.

I think Jonathan's point is that CC-BY-ND doesn't allow the legitimate
things in the top paragraph. And your real problem (in the second
paragraph) is not derivatives, but derivatives claiming to be something
they are not (the official standard). And trademarks are the legal tool
for avoiding confusion like that.

In practice, I don't think this kind of name-hijacking is a big deal.
There are many forks of git, and somebody could make a derivative git
that is buggy, interacts badly with existing repository formats, or
interacts badly with other git clients via the network protocol. But
people are usually kind enough not to call their other implementations
"git", and it just works out in practice. So you could probably get by
with just a regular source code license (but I am far from an expert, so
take the appropriate grain of salt).

-Peff
