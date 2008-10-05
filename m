From: Jeff King <peff@peff.net>
Subject: Re: git apply: git diff header lacks filename information for git
	diff --no-index patch
Date: Sun, 5 Oct 2008 15:21:28 -0400
Message-ID: <20081005192128.GC6173@coredump.intra.peff.net>
References: <500f3d130810021127j570bb540p901f6a73f58a6cb1@mail.gmail.com> <20081004041714.GA12413@coredump.intra.peff.net> <alpine.LFD.2.00.0810040918290.3208@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810041004290.3208@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810041031580.3208@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Oct 05 21:22:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmZBh-0005q1-BL
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 21:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138AbYJETVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 15:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755684AbYJETVc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 15:21:32 -0400
Received: from peff.net ([208.65.91.99]:4160 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757348AbYJETVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 15:21:30 -0400
Received: (qmail 17120 invoked by uid 111); 5 Oct 2008 19:21:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 05 Oct 2008 15:21:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Oct 2008 15:21:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810041031580.3208@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97525>

On Sat, Oct 04, 2008 at 10:48:08AM -0700, Linus Torvalds wrote:

> Ok, so here's a much better version, I think.

Yes, this approach makes sense to me after reading your other
explanation as well as Jakub's pointer to git-diff(1).

And it passes my test. ;)

I'll squash in my test case, add a little context to the commit message,
and send it to Shawn.

-Peff
