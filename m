From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Thu, 03 Feb 2011 01:16:10 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102030036420.12104@xanadu.home>
References: <20110202022909.30644.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 07:16:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PksUK-0006cR-FG
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 07:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982Ab1BCGQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 01:16:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19052 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab1BCGQL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 01:16:11 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG100GCC2QY3W90@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 03 Feb 2011 01:16:10 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20110202022909.30644.qmail@science.horizon.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165960>

On Tue, 1 Feb 2011, George Spelvin wrote:

> For what it's worth, I don't see the "cleanup".
> 
> If it significantly reduced the size of the largest directory,
> that would be a win.  But moving everything into src/ doesn't
> do that.
> 
> If there's a way to divide the source into cohesive subunits, that
> would be great.  A programmer could ignore whole subdirectories
> when working on something.
> 
> But just moving the whole existing pile into a subdirectory "because
> everyone else does it" is not a reason; that's superstition.

There is no superstition here, simply basic elegance.

When you pick up a book from a shelf, do you see the actual content of 
the book printed right from the inside of the cover page, and the table 
of content tossed in the margin?  Would you construct a book yourself 
that way?

A nice source tree should be organized with a minimum of hierarchical 
structure.  To a newbie wanting to contribute to Git, it is rather 
frightening to cd into the git directory and see that ls generates more 
than 280 entries.  That simply looks sloppy.  And this gets much worse 
after a make.

The top directory should make different things stand out much more 
clearly, like a preface and a table of content.  You have the 
documentation here, the source there, the tests there, a clearly visible 
README file, etc.  If the src directory has about the same relative 
number of files after a move that's fine.  At least you should expect 
_only_ source files in there (and possibly their by-products), and not 
other types of data buried into the mix.

> Having to type "src/" a lot more often is definitely a downside.

Come on.  This is a rather egocentric argument without much substance.

> Heck, that's one thing I actively dislike about GNU autoconf conventions.

This has _nothing_ about any autoconf convention.  GNU autoconf requires 
stupid things like having a bunch of files such as CREDITS, INSTALL, 
CHANGELOG, and other whatnots even if you have nothing to put in them, 
in which case they still have to be there but empty.  It also dictates 
the exact name your directories must have, etc.

I'm not proposing a tree reorganization because GNU autoconf commands 
it, but rather because this is a sensible thing to do.

> If there's a compelling reason to change, could someone please describe it?

It's about the third time I'm putting forward arguments for this.  
Please see the list archive.

P.S. the netiquette on busy mailing lists recommends that you preserve 
all the email addresses that were listed as recipients on the message 
you reply to.  That would be highly appreciated.


Nicolas
