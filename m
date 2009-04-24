From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 19:21:26 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0904241911590.2147@iabervon.org>
References: <m24owgqy0j.fsf@boostpro.com> <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
 <20090424213848.GA14493@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 01:23:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUjW-0000Hi-3O
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbZDXXV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbZDXXV2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:21:28 -0400
Received: from iabervon.org ([66.92.72.58]:44030 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbZDXXV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:21:27 -0400
Received: (qmail 19835 invoked by uid 1000); 24 Apr 2009 23:21:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Apr 2009 23:21:26 -0000
In-Reply-To: <20090424213848.GA14493@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117517>

On Fri, 24 Apr 2009, Jeff King wrote:

> On Fri, Apr 24, 2009 at 05:34:00PM -0400, Daniel Barkalow wrote:
> 
> > I'd say that blobs and trees are an implementation detail of "the full 
> > content of a version of the project", not something conceptually 
> > important. Likewise, the date representation used in commits isn't 
> 
> I disagree. I think it's important to note that trees and blobs have a
> name, and you can refer to them. Once you know that, the fact that you
> can do:
> 
>   git show master
>   git show master:Documentation
>   git show master:Makefile
> 
> just makes sense. You are always just specifying an object, but the type
> is different for each (and show "does the right thing" based on object
> type).
> 
> No, that isn't critical for understanding how _commit_ operations work,
> but I think that is exactly the sort of conceptual knowledge that let
> people use git more fully.

Yeah, I'll agree with that. They're good to explain as "these are things 
git can tell you about", but they're not relevant to the discussion of 
"what is history".

(And, actually, I think git has a few usability warts due to relying too 
much on command line arguments being objects; it would be quite nice if 
"git blame 1a2b3c:Makefile" worked despite this technically being 
incoherent.)

	-Daniel
*This .sig left intentionally blank*
