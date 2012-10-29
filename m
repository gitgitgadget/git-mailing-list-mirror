From: Jeff King <peff@peff.net>
Subject: Re: Mistake in git-reset documentation
Date: Mon, 29 Oct 2012 01:38:20 -0400
Message-ID: <20121029053820.GC30186@sigill.intra.peff.net>
References: <CABPGWqr7=Rq4qS7yP09t2vMBUJ98NFTSmHUUgMzUQ5=WVrjfqg@mail.gmail.com>
 <20121028083610.GA26374@shrek.podlesie.net>
 <20121028110715.GB11434@sigill.intra.peff.net>
 <m2zk36hg0q.fsf@igel.home>
 <20121028134635.GA25519@sigill.intra.peff.net>
 <20121028141327.GB16686@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Bojan =?utf-8?B?UGV0cm92acSH?= <bojan85@gmail.com>,
	git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 06:38:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSi3X-0004af-Um
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 06:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab2J2FiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 01:38:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41794 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682Ab2J2FiX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 01:38:23 -0400
Received: (qmail 15436 invoked by uid 107); 29 Oct 2012 05:39:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 01:39:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 01:38:20 -0400
Content-Disposition: inline
In-Reply-To: <20121028141327.GB16686@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208585>

On Sun, Oct 28, 2012 at 03:13:27PM +0100, Krzysztof Mazur wrote:

> The --mixed mode is also described as second mode, and saying that --mixed
> is default earlier may save some time wasted on reading --soft
> description.
> 
> There is also small inconsequence in what <mode> is, just "mixed" or
> "--mixed".

Yeah, agreed on both.

> -- >8 --
> Subject: [PATCH] doc: git-reset: make "<mode>" optional
> 
> The git-reset's "<mode>" is an optional argument, however it was
> documented as required.
> 
> The "<mode>" is documented as one of: --soft, --mixed, --hard, --merge
> or --keep, so "<mode>" should be used instead of "--<mode>".
> 
> Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>

Thanks, this looks good to me.

-Peff
