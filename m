From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] t0000: drop "known breakage" test
Date: Sun, 29 Dec 2013 02:22:27 -0500
Message-ID: <20131229072227.GB31788@sigill.intra.peff.net>
References: <20131228092731.GA26337@sigill.intra.peff.net>
 <20131228093340.GC21109@sigill.intra.peff.net>
 <20131228205104.GA5544@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Thomas Rast <tr@thomasrast.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 29 08:22:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxAhl-0000AW-Nn
	for gcvg-git-2@plane.gmane.org; Sun, 29 Dec 2013 08:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab3L2HWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Dec 2013 02:22:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:51928 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750971Ab3L2HW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Dec 2013 02:22:29 -0500
Received: (qmail 31317 invoked by uid 102); 29 Dec 2013 07:22:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 29 Dec 2013 01:22:29 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Dec 2013 02:22:27 -0500
Content-Disposition: inline
In-Reply-To: <20131228205104.GA5544@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239795>

On Sat, Dec 28, 2013 at 12:51:04PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > I am not _that_ bothered by the "known breakage", but AFAICT there is
> > zero benefit to keeping this redundant test.
> 
> Devil's advocate: it ensures that anyone wrapping git's tests (like
> the old smoketest infrastructure experiment) is able to handle an
> expected failure.

Thanks. One of the things I love about open source is that as soon as I
say "I can't see how...", the answer is crowd-sourced for me. :)

That being said, even if the test has a non-zero possible value...

> But in practice I don't mind the behavior before or after this patch.
> If the test harness is that broken, we'll know.  And people writing
> code that wraps git's tests can write their own custom sanity-checks.

...I think for these reasons that the value is smaller than the
disruption caused by the test, and the patch is a net win.

-Peff
