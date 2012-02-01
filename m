From: Jeff King <peff@peff.net>
Subject: Re: logging disjoint sets of commits in a single command
Date: Tue, 31 Jan 2012 22:03:01 -0500
Message-ID: <20120201030300.GA9969@sigill.intra.peff.net>
References: <20120201005332.GC30969@sigill.intra.peff.net>
 <CB4DCD5C.747%bryano@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Bryan O'Sullivan <bryano@fb.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 04:03:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsQTW-0001um-02
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 04:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788Ab2BADDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 22:03:04 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51362
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755759Ab2BADDD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 22:03:03 -0500
Received: (qmail 4833 invoked by uid 107); 1 Feb 2012 03:10:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 Jan 2012 22:10:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jan 2012 22:03:01 -0500
Content-Disposition: inline
In-Reply-To: <CB4DCD5C.747%bryano@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189496>

On Wed, Feb 01, 2012 at 01:02:57AM +0000, Bryan O'Sullivan wrote:

> By the way, the reason I'm even interested in this in the first place is
> that the performance of commands like "git blame" and "git log" on files
> and subtrees has become a problem for us (> 10 seconds per invocation,
> forecast to get much worse), and I wanted to see whether I could feed "git
> log" a specific list of revisions, and if so, whether that could yield
> good performance.

That sounds kind of slow. Is your repository really gigantic? Have you packed
everything? I'm just curious if there's some other way to make things
faster. Is the repository publicly available?

-Peff
