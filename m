From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 19:11:40 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
References: <m24owgqy0j.fsf@boostpro.com>  <200904240051.46233.johan@herland.net>  <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>  <200904242230.13239.johan@herland.net>  <alpine.LNX.2.00.0904241655090.2147@iabervon.org> 
 <20090424213848.GA14493@coredump.intra.peff.net>  <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com> <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 01:13:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUaR-0006Nr-7r
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbZDXXLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752870AbZDXXLm
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:11:42 -0400
Received: from iabervon.org ([66.92.72.58]:33564 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674AbZDXXLl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:11:41 -0400
Received: (qmail 18216 invoked by uid 1000); 24 Apr 2009 23:11:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Apr 2009 23:11:40 -0000
In-Reply-To: <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117511>

On Fri, 24 Apr 2009, Michael Witten wrote:

> On Fri, Apr 24, 2009 at 17:18, Michael Witten <mfwitten@gmail.com> wrote:
> > In fact, I think masking this kind of thing with a catch-all word
> > 'reference' is a bad idea. Rather than being hidden, it should be
> > exposed: I think it would be beneficial to use the word 'address'
> > rather than 'reference' when talking about the SHA-1 names. Then HEAD
> > could be called a pointer variable, etc.
> >
> > So, a pointer variable's value is an object address that is the
> > location of an object in git 'memory'. I think using this approach
> > would make things significantly more transparent.
> 
> In fact, it's not particularly important that SHA-1 is used to compute
> the address into git memory. The only thing that's important is that
> the address is determined by content alone (I'm not even sure that
> specifying that the address is a cryptographically sound hash of the
> content is important; shouldn't that follow from the declaration that
> it must be uniquely based on content alone?); the fact that's a SHA-1
> is purely an implementation detail, and so it shouldn't appear
> prominently in the documentation.
> 
> So, what do you say?
> 
> Let's start a reformation of the git terminology to use analogies that
> have been around since the dawn of computing: 'memory', 'address', and
> 'pointer'.

I actually think calling them "sha1s" is better, simply because this bit 
of jargon doesn't mean anything else (git deals with email, so "address" 
is overloaded). And the term is already in use for this particular case, 
and it doesn't mean anything else at all (since, of course, the crypto 
thing is "SHA-1", not "sha1"), and it's short (which is important for 
making it easy to look at usage help).

	-Daniel
*This .sig left intentionally blank*
