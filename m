From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/4] Add a --cover-letter option to format-patch
Date: Mon, 18 Feb 2008 16:17:37 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802181616530.5816@iabervon.org>
References: <alpine.LNX.1.00.0802171335520.5816@iabervon.org> <alpine.LSU.1.00.0802181245270.30505@racer.site> <alpine.LNX.1.00.0802181254060.5816@iabervon.org> <7vejbanf8l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 22:18:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRDNP-0002LI-FE
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 22:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbYBRVRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 16:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754499AbYBRVRl
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 16:17:41 -0500
Received: from iabervon.org ([66.92.72.58]:58564 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbYBRVRk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 16:17:40 -0500
Received: (qmail 2656 invoked by uid 1000); 18 Feb 2008 21:17:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Feb 2008 21:17:37 -0000
In-Reply-To: <7vejbanf8l.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74355>

On Mon, 18 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >> > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> >> > index 651efe6..53e6d2e 100644
> >> > --- a/Documentation/git-format-patch.txt
> >> > +++ b/Documentation/git-format-patch.txt
> >> > @@ -17,6 +17,7 @@ SYNOPSIS
> >> >                     [--in-reply-to=Message-Id] [--suffix=.<sfx>]
> >> >                     [--ignore-if-in-upstream]
> >> >                     [--subject-prefix=Subject-Prefix]
> >> > +                   [--cover-letter]
> >> >  		   [ <since> | <revision range> ]
> >> 
> >> Since you are already there, and it is really a small change, why not fix 
> >> the whitespace?
> >
> > What *is* the correct whitespace for alignment in documentation?
> 
> The last time I checked, AsciiDoc output did not change before
> and after running "expand" and then "unexpand" in all *.txt
> files in Documentation/ directory, so if it is indenting to
> multiple of 8, HT is fine.
> 
> Don't we have Documentation/.gitattributes that says indentation
> to 8*N-th column must be done with N HTs these days?

Ah, yes, that's right; I'll fix that block.

	-Daniel
*This .sig left intentionally blank*
