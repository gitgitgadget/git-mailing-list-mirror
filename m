From: Jeff King <peff@peff.net>
Subject: Re: Mistake in git-reset documentation
Date: Sun, 28 Oct 2012 09:46:35 -0400
Message-ID: <20121028134635.GA25519@sigill.intra.peff.net>
References: <CABPGWqr7=Rq4qS7yP09t2vMBUJ98NFTSmHUUgMzUQ5=WVrjfqg@mail.gmail.com>
 <20121028083610.GA26374@shrek.podlesie.net>
 <20121028110715.GB11434@sigill.intra.peff.net>
 <m2zk36hg0q.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Krzysztof Mazur <krzysiek@podlesie.net>,
	Bojan =?utf-8?B?UGV0cm92acSH?= <bojan85@gmail.com>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Oct 28 14:46:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSTCU-0004Bq-IW
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 14:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311Ab2J1Nqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 09:46:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41372 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868Ab2J1Nqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 09:46:38 -0400
Received: (qmail 8940 invoked by uid 107); 28 Oct 2012 13:47:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 28 Oct 2012 09:47:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Oct 2012 09:46:35 -0400
Content-Disposition: inline
In-Reply-To: <m2zk36hg0q.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208546>

On Sun, Oct 28, 2012 at 02:39:49PM +0100, Andreas Schwab wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Sun, Oct 28, 2012 at 09:36:10AM +0100, Krzysztof Mazur wrote:
> >
> >>  DESCRIPTION
> >>  -----------
> >> @@ -43,7 +43,7 @@ This means that `git reset -p` is the opposite of `git add -p`, i.e.
> >>  you can use it to selectively reset hunks. See the ``Interactive Mode''
> >>  section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
> >>  
> >> -'git reset' --<mode> [<commit>]::
> >> +'git reset' [--<mode>] [<commit>]::
> >>  	This form resets the current branch head to <commit> and
> >>  	possibly updates the index (resetting it to the tree of <commit>) and
> >>  	the working tree depending on <mode>, which
> >
> > Should we say something like "if --<mode> is omitted, defaults to
> > "--mixed"?
> 
> Under --mixed it already says "This is the default action", though.

I know, but that is somewhat buried for somebody who is seeing that the
"--<mode>" bit is optional and wondering what it means to omit it.

-Peff
