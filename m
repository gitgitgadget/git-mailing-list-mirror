From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] README: use markdown syntax
Date: Wed, 24 Feb 2016 05:18:57 -0500
Message-ID: <20160224101857.GB20807@sigill.intra.peff.net>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
 <1456249229-30454-2-git-send-email-Matthieu.Moy@imag.fr>
 <xmqqoab71c09.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1602240801550.3152@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	emma.westby@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 11:19:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYWXE-0002nS-BD
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 11:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360AbcBXKTC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 05:19:02 -0500
Received: from cloud.peff.net ([50.56.180.127]:48176 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752858AbcBXKTA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 05:19:00 -0500
Received: (qmail 27793 invoked by uid 102); 24 Feb 2016 10:19:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 05:19:00 -0500
Received: (qmail 6754 invoked by uid 107); 24 Feb 2016 10:19:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 05:19:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 05:18:57 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1602240801550.3152@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287188>

On Wed, Feb 24, 2016 at 08:08:52AM +0100, Johannes Schindelin wrote:

> > Markdown when rendered may be easier to read, but plain text is even
> > easier, and it somehow feels backward to cater to those who browse
> > at GitHub sacrificing those who use "less" in the source tree.
> 
> That assumes that the primary audience of the README file is the
> developers who already decided to clone the repository, as opposed to
> people browsing the README file in the browser to determine whether they
> found the correct project, or to read up on the background of the project
> without downloading the entire source code.
> 
> I'd wager real money (without scientific evidence. just going on common
> sense) that your 'less' people are in the vast minority.
> 
> Since I am convinced that markdown'ed READMEs enhance the user experience
> dramatically, Git for Windows has one already for a long time.

Yeah, I agree. I cannot imagine why I would read Git's README at this
point in time.  And I find I primarily consume READMEs on the web these
days, as they are the first step in me figuring out whether a project is
worth looking into.

Whereas I _do_ care what things like Documentation/technical look like,
or CodingGuidelines, because I actually refer to them locally.

IMHO the title formatting is somewhat moot, though, as we can have our
cake and eat it, too, with the "====" underlines. I don't think they are
any worse than the lines of slashes in the original. :)

I'd worry more about the [] links from patch 2, but even those are fine
by me.

-Peff
