From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Fri, 9 Nov 2012 19:33:31 -0500
Message-ID: <20121110003331.GA12567@sigill.intra.peff.net>
References: <20121109192336.GA9401@sigill.intra.peff.net>
 <CAMP44s3yVtQ4wGqVTyHN-VfAM7iRo9WfNnAu+ns7Zkc_cPBH3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 01:33:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWz19-0001iG-Ds
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 01:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438Ab2KJAde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 19:33:34 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40557 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581Ab2KJAdd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 19:33:33 -0500
Received: (qmail 13205 invoked by uid 107); 10 Nov 2012 00:34:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Nov 2012 19:34:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2012 19:33:31 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s3yVtQ4wGqVTyHN-VfAM7iRo9WfNnAu+ns7Zkc_cPBH3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209253>

On Sat, Nov 10, 2012 at 12:21:48AM +0100, Felipe Contreras wrote:

> > * fc/fast-export-fixes (2012-11-08) 14 commits
> >  - fast-export: don't handle uninteresting refs
> >  - fast-export: make sure updated refs get updated
> >  - fast-export: fix comparison in tests
> >  - fast-export: trivial cleanup
> >  - remote-testgit: make clear the 'done' feature
> >  - remote-testgit: report success after an import
> >  - remote-testgit: exercise more features
> >  - remote-testgit: cleanup tests
> >  - remote-testgit: remove irrelevant test
> >  - remote-testgit: get rid of non-local functionality
> >  - Add new simplified git-remote-testgit
> >  - Rename git-remote-testgit to git-remote-testpy
> >  - remote-testgit: fix direction of marks
> >  - fast-export: avoid importing blob marks
> >
> >  Improvements to fix fast-export bugs, including how refs pointing to
> >  already-seen commits are handled. An earlier 4-commit version of this
> >  series looked good to me, but this much-expanded version has not seen
> >  any comments.
> >
> >  Needs review.
> 
> I can send the previous 4-commit version if needed, the only thing
> that changed is the commit messages.

In the actual code, perhaps, but aren't there significant changes to the
git-remote-testgit infrastructure that were not originally present? That
could use some review.

I also seem to recall that the tests in this version rely on the presence of bash;
don't we still need to mark the tests with a prerequisite?

> > * fc/completion-test-simplification (2012-10-29) 2 commits
> >  - completion: simplify __gitcomp test helper
> >  - completion: refactor __gitcomp related tests
> >
> >  Clean up completion tests.
> >
> >  There were some comments on the list.
> >
> >  Expecting a re-roll.
> 
> The second patch I can re-roll, but the first patch needs some
> external input. My preference is that tests should also be simple and
> maintainable, SZEDER's preference is that tests are better being
> explicit and verbose (even if harder to maintain) to minimize possible
> issues in the tests.

I think it is better to keep the tests simple and maintainable. If there
are multiple ways to do things and they all need testing, then that
should be clear from the tests, not done haphazardly because some tests
happen to use a different way of doing things.

I seem to recall there was a one-liner fix that needed to be rolled in,
which is why I held it out of next.

> > * fc/remote-bzr (2012-11-08) 5 commits
> >  - remote-bzr: update working tree
> >  - remote-bzr: add support for remote repositories
> >  - remote-bzr: add support for pushing
> >  - remote-bzr: add simple tests
> >  - Add new remote-bzr transport helper
> >
> >  New remote helper for bzr.
> >
> >  Will merge to 'next'.
> 
> I already have a newer version of this with support for special modes:
> executable files, symlinks, etc. I think a reroll would make sense.

Thanks for letting me know.

-Peff
