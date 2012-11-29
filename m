From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] git-fast-import.txt: improve documentation for
 quoted paths
Date: Thu, 29 Nov 2012 13:54:04 -0500
Message-ID: <20121129185404.GC17309@sigill.intra.peff.net>
References: <vpq624omjn4.fsf@grenoble-inp.fr>
 <1354208455-21228-1-git-send-email-Matthieu.Moy@imag.fr>
 <20121129181141.GA17309@sigill.intra.peff.net>
 <vpqhao8gsaj.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Nov 29 19:54:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te9Fg-0004bF-6B
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 19:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898Ab2K2SyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 13:54:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41343 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003Ab2K2SyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 13:54:07 -0500
Received: (qmail 24633 invoked by uid 107); 29 Nov 2012 18:55:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Nov 2012 13:55:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2012 13:54:04 -0500
Content-Disposition: inline
In-Reply-To: <vpqhao8gsaj.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210861>

On Thu, Nov 29, 2012 at 07:47:32PM +0100, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So technically, your modification to the beginning of the sentence is
> > not correct.
> 
> I'd say the resulting sentence is somehow incorrect, but not more than
> the previous one (both say "if ..." without really telling what the
> condition was).

That's fair. There is a lot left unsaid in the original. :)

> >> If an `LF`, backslash or double quote must be encoded
> >                        ^
> >                        missing comma as list delimiter
> 
> Google tells me that my version was UK-correct but not US-correct. As
> french, I have no opinion on the subject, I take yours ;-).

Thanks, I had a vague recollection that it might be regional. I probably
should have looked it up myself.

> How about this:
> 
> A path can use the C-style string quoting (this is accepted in all
> cases and mandatory if the filename starts with double quote or
> contains `LF`). In C-style quoting, `LF`, backslash, and double quote
> characters must be escaped by preceding them with a backslash. Also,
> the complete name should be surrounded with double quotes (e.g.
> `"path/with\n, \\ and \" in it"`).
> 
> This should be technically correct, and "this is accepted in all cases"
> should encourrage people to use it.

I think that is much better, but it reads a little more easily to me if
we rearrange the second sentence. To complete my English bikeshedding,
here is how I would have written the whole paragraph:

  A path can use C-style string quoting; this is accepted in all cases
  and mandatory if the filename starts with double quote or contains
  `LF`. In C-style quoting, the complete name should be surrounded with
  double quotes, and any `LF`, backslash, or double quote characters
  must be escaped by preceding them with a backslash (e.g.,
  `"path/with\n, \\ and \" in it"`).

Feel free to incorporate or ignore any of my tweaks from that version.

-Peff
