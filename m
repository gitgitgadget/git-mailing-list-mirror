From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] strbuf: make sure buffer is zero-terminated
Date: Sun, 10 Apr 2011 17:05:35 -0400
Message-ID: <20110410210534.GA2522@sigill.intra.peff.net>
References: <1302468858-7376-1-git-send-email-kusmabite@gmail.com>
 <20110410205711.GA2069@sigill.intra.peff.net>
 <BANLkTinKzatY-1kxLJ73TeDyMW175pr77A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jwa@urbancode.com, drew.northup@maine.edu
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 23:05:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q91pL-0008Cr-Fb
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 23:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757385Ab1DJVFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 17:05:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52735
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755303Ab1DJVFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 17:05:41 -0400
Received: (qmail 26632 invoked by uid 107); 10 Apr 2011 21:06:27 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.197.88.253)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Apr 2011 17:06:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Apr 2011 17:05:35 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinKzatY-1kxLJ73TeDyMW175pr77A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171291>

On Sun, Apr 10, 2011 at 11:04:26PM +0200, Erik Faye-Lund wrote:

> > It is more than just detach, though; the
> > NUL-termination is supposed to be an invariant of strbuf, so any code
> > just looking at "sb.buf" would be broken. So your code looks fine, but
> > you may want to mention that in the commit message.
> >
> 
> You're right. How about something like this instead?
> 
> strbuf_init does not zero-terminate the initial buffer when hint is
> non-zero. Fix this so we can rely on the string to be zero-terminated
> even if we haven't filled it with anything yet.

Sure, that's fine.

-Peff
