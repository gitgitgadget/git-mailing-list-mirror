From: Jeff King <peff@peff.net>
Subject: Re: HTTP tests fail on OS X
Date: Fri, 21 Jun 2013 00:49:54 -0400
Message-ID: <20130621044953.GA5962@sigill.intra.peff.net>
References: <C44E969B-A5AE-44EF-BFCA-CAEF69516BEB@gernhardtsoftware.com>
 <20130621043052.GA5318@sigill.intra.peff.net>
 <20130621044236.GA5798@sigill.intra.peff.net>
 <26902D6D-D105-4943-BC67-461CEF82D888@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 06:50:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UptIS-0003zl-Dl
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 06:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464Ab3FUEt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 00:49:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:34934 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757112Ab3FUEt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 00:49:59 -0400
Received: (qmail 13867 invoked by uid 102); 21 Jun 2013 04:50:58 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 23:50:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 00:49:54 -0400
Content-Disposition: inline
In-Reply-To: <26902D6D-D105-4943-BC67-461CEF82D888@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228572>

On Fri, Jun 21, 2013 at 12:45:25AM -0400, Brian Gernhardt wrote:

> > I'm not sure if there is something different between 2.2.16 and 2.2.22,
> > or something with the particular build. Here's my -V output, in case it
> > helps:
> [...]
> Doesn't look terribly different from mine.

It turns out that 2.2.22 is in Debian testing, so it was easy for me to
downgrade from 2.4 and try it. Seems to also work fine for me. So I
don't think it's an apache version issue.

I also installed the prefork mpm in case that was part of the problem.
But it all seems fine here, and my build parameters look quite similar
to yours.

I'm not sure what else to look at...I guess try ratcheting up the
debugging/log level on your failing copy and see if it prints anything
useful.

-Peff
