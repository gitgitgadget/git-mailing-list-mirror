From: Theodore Tso <tytso@mit.edu>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 16:57:06 -0400
Message-ID: <20070418205706.GH24963@thunk.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site> <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org> <17958.19499.813637.324723@lisa.zopyra.com> <vpqejmhy3x2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 22:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeHDI-00052l-23
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 22:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbXDRU5N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 16:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753674AbXDRU5N
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 16:57:13 -0400
Received: from thunk.org ([69.25.196.29]:46039 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537AbXDRU5M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 16:57:12 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HeHJa-0003g0-PZ; Wed, 18 Apr 2007 17:03:47 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HeHD8-00050T-Q0; Wed, 18 Apr 2007 16:57:06 -0400
Content-Disposition: inline
In-Reply-To: <vpqejmhy3x2.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44947>

On Wed, Apr 18, 2007 at 07:43:05PM +0200, Matthieu Moy wrote:
> As a beginner, I went to http://git.or.cz/, clicked "crash courses",
> and since I didn't find "git from scratch", I clicked "git for CVS
> users" (I know CVS, but haven't used it for a long time, I'm mostly a
> bzr user converted from GNU Arch).
> 
> There, the commands are not "git something", but "cg something". Well,
> not always, at least. Indeed, there's still a "git blame", a reference
> to "git-rev-parse manpage".
> 
> Then, I can't even find it in the tutorial, but somewhere, it should
> be mentionned to say who I am in ~/.gitconfig.

Yeah, one of the biggest source of confusion is that a lot of the
resources available on http://git.or.cz refers very heavily to cg, but
most of the discussion on the git mailing list doesn't involve using
cg, and as some have argued, it's not clear cg is very useful; at this
point, given the advances in git's usability in the 1.5 series.

So what I normally tell new users is to *not* look at
http://git.or.cz, since more than once people have taken off points on
git's usability because of the fact that some of the tutorials (in
particular the "git for CVS users") are really talkinga about cogito,
not git, and this gets highly confusing for many new users.

Instead, I tell people they should look at this:

	http://www.kernel.org/pub/software/scm/git/docs/

... and reference the tutorials off of this site.  It seems to me that
the documentation and tutorials on this site tends to get update much
more frequently and religiously than the resources on http://git.or.cz
--- although there is still some good stuff there that isn't
elsewhere.  But unfortunately, for a new user, the fact that they have
to filter out information that might be out of date, or
cogito-specific, from what is relevant, makes it such that I can't
really recommend that site to new users.

> So, cogito has probably been of a real use at the beginning, where git
> was said to be almost unuseable without anything else (I didn't try
> git at that time), but I don't think it's the case anymore.

Yep; and unfortunately, at this point, using cg probably is more
confusing compared to just simply using raw git all by itself.

						- Ted
