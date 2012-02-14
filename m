From: Jeff King <peff@peff.net>
Subject: Re: git-latexdiff: Git and Latexdiff working together
Date: Tue, 14 Feb 2012 18:31:51 -0500
Message-ID: <20120214233151.GA25651@sigill.intra.peff.net>
References: <vpq7gzph7mi.fsf@bauges.imag.fr>
 <20120214211629.GA23649@sigill.intra.peff.net>
 <vpq4nut6maj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 15 00:32:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxRqr-0000jl-HT
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 00:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761321Ab2BNXb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 18:31:56 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36075
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757328Ab2BNXbz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 18:31:55 -0500
Received: (qmail 14314 invoked by uid 107); 14 Feb 2012 23:39:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 18:39:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 18:31:51 -0500
Content-Disposition: inline
In-Reply-To: <vpq4nut6maj.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190796>

On Wed, Feb 15, 2012 at 12:13:40AM +0100, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > My latex usage is all from a past life, so I didn't even try out your
> > tool.  But I did wonder what your rationale was in making a separate
> > command as opposed to providing a script that could be plugged in as an
> > external diff.
> 
> My LaTeX documents are usually sets of .tex files including each other,
> plus figures and possibly Makefiles. So, git-latexdiff does a full
> checkout of the old and new tree, then runs latexdiff on the main file,
> and then compiles the result.
> [...]

Ah, yeah. I didn't think about the fact that there's a whole ecosystem
of files that go into producing the output.

> That said, that may be just me not knowing diff drivers or difftools
> well enough.

No, your analysis is right. A diff driver wouldn't work well at all.

Thanks for satisfying my curiosity.

-Peff
