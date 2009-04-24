From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 17:34:00 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
References: <m24owgqy0j.fsf@boostpro.com> <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>, Jeff King <peff@peff.net>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 23:35:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxT3c-0006e0-Gf
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 23:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357AbZDXVeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 17:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757231AbZDXVeB
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 17:34:01 -0400
Received: from iabervon.org ([66.92.72.58]:39242 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698AbZDXVeB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 17:34:01 -0400
Received: (qmail 9112 invoked by uid 1000); 24 Apr 2009 21:34:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Apr 2009 21:34:00 -0000
In-Reply-To: <200904242230.13239.johan@herland.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117493>

On Fri, 24 Apr 2009, Johan Herland wrote:

> On Friday 24 April 2009, Michael Witten wrote:
> > On Thu, Apr 23, 2009 at 17:51, Johan Herland <johan@herland.net> wrote:
> > > There's also http://www.eecs.harvard.edu/~cduan/technical/git/ which I
> > > think is a great bottom-up introduction:
> > > - not too heavy on the concepts
> >
> > I really don't understand this mentality. Concepts are the only things
> > that are important. From concepts falls all else.
> 
> Sorry for not being clear: Concepts are indeed (and should be) important. 
> What I mean is that the concepts introduced are short and simple enough for 
> novice users to understand (without much VCS experience, if any at all). If 
> we start off _too_ detailed, we risk loosing the audience, and no one is 
> better off.
> 
> Like Jeff King said elsewhere in this thread: We want to start a little 
> higher from the bottom. The above introduction does not focus on blobs or 
> trees, but manages to introduce Git in a useful manner by starting off with 
> only two concepts: commits and refs.

I'd say that blobs and trees are an implementation detail of "the full 
content of a version of the project", not something conceptually 
important. Likewise, the date representation used in commits isn't 
important. It might be worth saying that git purposefully discards any 
information in your filesystem that is just incidental and not project 
content, like whether other users on the system where the working 
directory is can access your files; but a full enumeration of what the 
"content" and "incidental" categories contain can go in an appendix or 
something.

(FWIW, git originally didn't use tree objects for subdirectories or mask
out the g+w bit from tree entries. These weren't conceptual changes, but 
implementation details.)

	-Daniel
*This .sig left intentionally blank*
