From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: revised: [PATCH] Color support added to git-add--interactive.
Date: Wed, 17 Oct 2007 04:11:28 -0400
Message-ID: <20071017081128.GC13801@spearce.org>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <20071013172745.GA2624@coredump.intra.peff.net> <20071013175127.GA3183@coredump.intra.peff.net> <47112491.8070309@gmail.com> <20071015034338.GA4844@coredump.intra.peff.net> <20071016194709.3c1cb3a8@danzwell.com> <20071017015152.GN13801@spearce.org> <cff973550710170057i7a09eff6m5bd8268498774238@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 10:11:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii40O-0006eo-Ut
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 10:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763634AbXJQILj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 04:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763609AbXJQILi
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 04:11:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34098 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763239AbXJQILf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 04:11:35 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ii400-0000ns-Iy; Wed, 17 Oct 2007 04:11:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A1D5120FBAE; Wed, 17 Oct 2007 04:11:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <cff973550710170057i7a09eff6m5bd8268498774238@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61352>

Dan Zwell <dzwell@gmail.com> wrote:
> Sorry, that I didn't read the document on submitting patches before
> this. I will make the other changes you mention and re-send this in
> the proper formatting.

I really should have pointed you to Documentation/SubmittingPatches
when I responded to your email in the first place.  Sorry I didn't
do that.  Looks like you already found it though so good.
 
> > > +Note: these are not the same colors/attributes that the
> > > +rest of git supports, but are specific to git-add--interactive.
> >
> > This is a problem in my opinion.  Why can't it match the same
> > names that the C code recognizes?  What if we one day were to
> > see git-add--interactive.perl converted to C?  How would we then
> > reconcile the color handling at that point in time?
> 
> Makes sense. I am adding a bit of code to parse git color strings into
> perl color strings (so the user can use the same color names as with
> the rest of git). I know this is a small change, but I'm learning perl
> as I go, and I have exams this week, so it will take at least a day or
> two. I will fix the color issue, and send a properly formatted and
> signed-off patch. (Yes, I do agree to the Developer's Certificate of
> Origin wrt to this patch.)
> 
> Thanks for your patience,

Thanks for working on this.  I played around with your patch tonight
and although I use git-gui more often than `git add -i` for hunk
manipulation I really preferred your colorized version of git-add
-i over the non-colorized one.  So I'm looking forward to seeing
the final result of this and getting it into the main tree.

Of course there is also no rush to getting your change in.  We don't
have any sort of release deadlines.  So don't stress out about it
too much.  :)

-- 
Shawn.
