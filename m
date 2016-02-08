From: Jeff King <peff@peff.net>
Subject: Re: man git-config inconsistency (*.fsckObjects)
Date: Mon, 8 Feb 2016 13:41:10 -0500
Message-ID: <20160208184109.GA29332@sigill.intra.peff.net>
References: <56B8A928.4000802@cl.cam.ac.uk>
 <20160208150856.GB13664@sigill.intra.peff.net>
 <CAPig+cQZ2LWsy1VC7Aqm+V3cWG7Y3rb0dGfyS_c3BCVM3Dekgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Kuhn <Markus.Kuhn@cl.cam.ac.uk>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 19:41:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSqkl-0005H9-6D
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 19:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbcBHSlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 13:41:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:39366 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752983AbcBHSlM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 13:41:12 -0500
Received: (qmail 10190 invoked by uid 102); 8 Feb 2016 18:41:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 13:41:12 -0500
Received: (qmail 7708 invoked by uid 107); 8 Feb 2016 18:41:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 13:41:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 13:41:10 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cQZ2LWsy1VC7Aqm+V3cWG7Y3rb0dGfyS_c3BCVM3Dekgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285789>

On Mon, Feb 08, 2016 at 01:00:50PM -0500, Eric Sunshine wrote:

> On Mon, Feb 8, 2016 at 10:08 AM, Jeff King <peff@peff.net> wrote:
> > On Mon, Feb 08, 2016 at 02:41:44PM +0000, Markus Kuhn wrote:
> >> Suggested rephrasing:
> >>
> >>            If not set, the value of transfer.fsckObjects is used
> >>            instead, which defaults to false.
> >
> > Yeah, I agree your phrasing is much clearer.
> 
> Should we worry about this becoming outdated if the default of
> transfer.fsckObjects ever changes, or is that being overcautious? If
> it is a legitimate concern, then perhaps drop "which defaults to
> false" from the end of the sentence.

I agree that is a potential maintenance pitfall, but I think it is
outweighed by the benefit: namely that the information the user wants is
right there, without them having to cross-reference themselves.

Flipping the default for transfer.fsckObjects would hopefully cause us
to examine matching fetch.*, and we would notice this during review.

-Peff
