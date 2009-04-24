From: Jeff King <peff@peff.net>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 19:25:31 -0400
Message-ID: <20090424232531.GA15136@coredump.intra.peff.net>
References: <m24owgqy0j.fsf@boostpro.com> <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <alpine.LNX.2.00.0904241911590.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Apr 25 01:27:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUnv-0001IJ-HC
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbZDXXZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753566AbZDXXZm
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:25:42 -0400
Received: from peff.net ([208.65.91.99]:40948 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515AbZDXXZl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:25:41 -0400
Received: (qmail 32539 invoked by uid 107); 24 Apr 2009 23:25:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 19:25:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 19:25:31 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0904241911590.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117518>

On Fri, Apr 24, 2009 at 07:21:26PM -0400, Daniel Barkalow wrote:

> (And, actually, I think git has a few usability warts due to relying too 
> much on command line arguments being objects; it would be quite nice if 
> "git blame 1a2b3c:Makefile" worked despite this technically being 
> incoherent.)

Yeah, I think another is that "git show master:file" will not do CRLF or
other filters, and "git diff master:file other:file" will not respect
diff settings. I think all of those could be solved by path lookup
attaching a "here is a pathname I used to get to this object" string,
which can then be accessed as appropriate.

It is not all that different conceptually than what "git rev-list
--objects" does.

-Peff
