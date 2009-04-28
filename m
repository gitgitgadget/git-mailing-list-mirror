From: Jeff King <peff@peff.net>
Subject: Re: How is git used as other than the project's version control?
Date: Mon, 27 Apr 2009 21:44:34 -0400
Message-ID: <20090428014434.GA6462@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3EC48@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 03:44:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LycNK-000613-Uz
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 03:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415AbZD1Boi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 21:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755111AbZD1Boi
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 21:44:38 -0400
Received: from peff.net ([208.65.91.99]:43210 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754695AbZD1Boi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 21:44:38 -0400
Received: (qmail 23666 invoked by uid 107); 28 Apr 2009 01:44:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 27 Apr 2009 21:44:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Apr 2009 21:44:34 -0400
Content-Disposition: inline
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70AE3EC48@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117740>

On Mon, Apr 27, 2009 at 06:55:38PM -0400, John Dlugosz wrote:

> I'm interested in finding out how people use git "on the side", when it
> is not the project's actual version control system.

Thomas already mentioned using "git diff" separate from a git
repository; I find that "git diff --color-words" is much nicer than
"wdiff", which does something similar (though I rarely use it outside of
a repo only because I put _everything_ into git :) ).

One of the nice things about git (and other distributed VCS's) is that
creating a repo is very lightweight. If I am going to write a patch for
some other software, the first thing I'll do after untarring it is "git
init; git add .; git commit -m import". So it kind of blurs the concept
of "what is the project's actual version control system" as you wrote
above. If you consider the project to be my patch, it _is_ the VCS. Even
though upstream may not be using it.

And of course, if I am going to do multiple patches, then I may convert
and track upstream's history via git.

If you are looking for exotic uses of git, you may be interested in
Dscho's "Using Git For What It Is Not Intended" contest:

  http://search.gmane.org/?query=UGFWIINI

-Peff
