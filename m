From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Wed, 13 May 2015 01:37:06 -0400
Message-ID: <20150513053706.GA7783@peff.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net>
 <20150513045650.GA6070@peff.net>
 <xmqqzj59aw4c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 07:37:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsPM3-00033o-20
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 07:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbbEMFhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 01:37:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:57643 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750709AbbEMFhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 01:37:09 -0400
Received: (qmail 5087 invoked by uid 102); 13 May 2015 05:37:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 00:37:09 -0500
Received: (qmail 7301 invoked by uid 107); 13 May 2015 05:37:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 01:37:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 01:37:06 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzj59aw4c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268937>

On Tue, May 12, 2015 at 10:23:47PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here are the patches. They do not include the code-fence fixes from
> > Jean-Noel and myself that were already posted, but could easily go on
> > top.
> 
> Thanks. Will queue.
> 
> Why are you guys using AsciiDoctor again?  Speed over accuracy is an
> acceptable answer, as I know how slow my documentation codechain is.

I'm not sure who "you guys" is. I do not use AsciiDoctor locally, though
I would be happy to see it mature to a point where that is feasible
(because it's way faster, and also because it seems like a much more
active project at this point; it may have more bugs, but the rate of
fixing means it should overtake python AsciiDoc at some point).

If it is "why does git-scm.com use it", I think it is that python
AsciiDoc was hard to embed in a web app. AsciiDoctor started as
git-scm.com's home-grown "just enough asciidoc to render the git
manpages" library, and grew from there. I don't know why they didn't
make a decision to just pre-render outside the app for each version. I
didn't pay much attention at the time.

-Peff
