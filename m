From: Jeff King <peff@peff.net>
Subject: Re: tag scheme
Date: Tue, 25 Nov 2014 12:09:42 -0500
Message-ID: <20141125170941.GA23258@peff.net>
References: <CACY+HvouE0GBH=e4iu7hsFfBJmeZiPKgAC0870S5vPADSYXcJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Carsten Mattner <carstenmattner@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 18:09:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtJca-0001kF-FC
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 18:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbaKYRJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 12:09:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:44847 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751110AbaKYRJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 12:09:43 -0500
Received: (qmail 29663 invoked by uid 102); 25 Nov 2014 17:09:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 11:09:43 -0600
Received: (qmail 32632 invoked by uid 107); 25 Nov 2014 17:09:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 12:09:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Nov 2014 12:09:42 -0500
Content-Disposition: inline
In-Reply-To: <CACY+HvouE0GBH=e4iu7hsFfBJmeZiPKgAC0870S5vPADSYXcJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260225>

On Tue, Nov 25, 2014 at 05:17:52PM +0100, Carsten Mattner wrote:

> I'm looking for advice on a tagging scheme, especially pros/cons
> of using a 'v' prefix as in v2.1.0 like git does.
> 
> My impression is that using a common prefix for tags makes it
> simple to distinguish from maintenance branches for past releases
> but it seems that most repositories use tags without a prefix.
> Before I settle on using vX.Y.Z (which I favor right now), I'd like to
> understand why some projects do not prefix tags.

I cannot speak definitely for people who prefer no prefix, but I imagine
that they simply see it as useless noise.

Personally, I like the prefix because it lets me wildcard-match only the
releases (and not other random tags I might have):

  git tag -l 'v*'

Of course I quite often want to drop release-candidate tags from such a
list, too, and I have to resort to "grep -v -- -rc" to do so. :)

-Peff
