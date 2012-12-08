From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git(1): remove a defunct link to "list of authors"
Date: Sat, 8 Dec 2012 06:02:53 -0500
Message-ID: <20121208110253.GA24518@sigill.intra.peff.net>
References: <7vobi5hhn9.fsf@alter.siamese.dyndns.org>
 <7vk3sthhfy.fsf@alter.siamese.dyndns.org>
 <CAJo=hJsT+ChAr8vLQ99QPyrCXYAtuEUWn5Wdb-k1brBxk6V45A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 12:03:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThIC7-0005eE-Pi
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 12:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758018Ab2LHLDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2012 06:03:05 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37647 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753495Ab2LHLDE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2012 06:03:04 -0500
Received: (qmail 15912 invoked by uid 107); 8 Dec 2012 11:04:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 08 Dec 2012 06:04:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Dec 2012 06:02:53 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJsT+ChAr8vLQ99QPyrCXYAtuEUWn5Wdb-k1brBxk6V45A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211210>

On Fri, Dec 07, 2012 at 01:09:51PM -0800, Shawn O. Pearce wrote:

> On Fri, Dec 7, 2012 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> The linked page has not been showing the promised "more complete
> >> list" for more than 6 months by now, and nobody has resurrected
> >> the list there nor elsewhere since then.
> >>
> >> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >> ---
> >>  * If somebody has a working replacement URL, we could use that
> >>    instead, of course.  Takers?
> >
> > A possible alternative could be https://www.ohloh.net/p/git/contributors/summary
> 
> Eh, I think just removing the link is sufficient.

FYI, I just submitted a patch to add a contributors page to git-scm.com
that looks similar to the old one. That patch being the sum total of my
ruby and rails experience, I'd expect some re-working to be necessary
before it is merged:

  https://github.com/github/gitscm-next/pull/216

So it probably makes sense to go ahead and drop the link from the
manpage for now, and we can re-add it if the contributors page gets
merged (in my patch, it has a different path, so we would need to tweak
the URL eventually anyway).

-Peff
