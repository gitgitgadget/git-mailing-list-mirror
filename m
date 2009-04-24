From: Jeff King <peff@peff.net>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 19:14:36 -0400
Message-ID: <20090424231436.GA15058@coredump.intra.peff.net>
References: <m24owgqy0j.fsf@boostpro.com> <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com> <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com> <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Witten <mfwitten@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Apr 25 01:16:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUd2-000713-LE
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbZDXXOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbZDXXOr
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:14:47 -0400
Received: from peff.net ([208.65.91.99]:51221 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528AbZDXXOr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:14:47 -0400
Received: (qmail 32355 invoked by uid 107); 24 Apr 2009 23:14:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 19:14:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 19:14:36 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117512>

On Fri, Apr 24, 2009 at 07:11:40PM -0400, Daniel Barkalow wrote:

> > Let's start a reformation of the git terminology to use analogies that
> > have been around since the dawn of computing: 'memory', 'address', and
> > 'pointer'.
> 
> I actually think calling them "sha1s" is better, simply because this bit 
> of jargon doesn't mean anything else (git deals with email, so "address" 
> is overloaded). And the term is already in use for this particular case, 
> and it doesn't mean anything else at all (since, of course, the crypto 
> thing is "SHA-1", not "sha1"), and it's short (which is important for 
> making it easy to look at usage help).

Junio suggested "object name" in another thread, which I think is nicely
descriptive.

FWIW, I think the pointer nomenclature has terrible connotations. I
think everyone who works on git groks pointers just fine, but aren't
they generally reviled among the progrmaming populace as the most
complex and error-prone part of learning to program? Do we really need
to increase git's reputation as complex and error-prone? ;)

-Peff
