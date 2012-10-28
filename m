From: Jeff King <peff@peff.net>
Subject: Re: Mistake in git-reset documentation
Date: Sun, 28 Oct 2012 07:07:15 -0400
Message-ID: <20121028110715.GB11434@sigill.intra.peff.net>
References: <CABPGWqr7=Rq4qS7yP09t2vMBUJ98NFTSmHUUgMzUQ5=WVrjfqg@mail.gmail.com>
 <20121028083610.GA26374@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bojan =?utf-8?B?UGV0cm92acSH?= <bojan85@gmail.com>,
	git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 12:07:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSQiJ-0002cQ-EK
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 12:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab2J1LHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 07:07:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41259 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559Ab2J1LHR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 07:07:17 -0400
Received: (qmail 7891 invoked by uid 107); 28 Oct 2012 11:07:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 28 Oct 2012 07:07:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Oct 2012 07:07:15 -0400
Content-Disposition: inline
In-Reply-To: <20121028083610.GA26374@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208537>

On Sun, Oct 28, 2012 at 09:36:10AM +0100, Krzysztof Mazur wrote:

> -- >8 --
> Subject: [PATCH] doc: git-reset: make "--<mode>" optional
> 
> The git-reset's "--<mode>" is an optional argument, however it was
> documented as required.
> 
> Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>

I think this is sane, but...

>  DESCRIPTION
>  -----------
> @@ -43,7 +43,7 @@ This means that `git reset -p` is the opposite of `git add -p`, i.e.
>  you can use it to selectively reset hunks. See the ``Interactive Mode''
>  section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
>  
> -'git reset' --<mode> [<commit>]::
> +'git reset' [--<mode>] [<commit>]::
>  	This form resets the current branch head to <commit> and
>  	possibly updates the index (resetting it to the tree of <commit>) and
>  	the working tree depending on <mode>, which

Should we say something like "if --<mode> is omitted, defaults to
"--mixed"?

-Peff
