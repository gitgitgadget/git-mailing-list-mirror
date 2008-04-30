From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] commit: Show the committer ident when is different
	from the parent
Date: Wed, 30 Apr 2008 12:37:01 -0400
Message-ID: <20080430163701.GA6544@sigill.intra.peff.net>
References: <1209545236-4266-1-git-send-email-sbejar@gmail.com> <1209545236-4266-4-git-send-email-sbejar@gmail.com> <20080430145017.GA922@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 18:38:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrFJu-0002Kq-FM
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 18:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757688AbYD3QhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 12:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757664AbYD3QhG
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 12:37:06 -0400
Received: from peff.net ([208.65.91.99]:4254 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755767AbYD3QhF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 12:37:05 -0400
Received: (qmail 24764 invoked by uid 111); 30 Apr 2008 16:37:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Apr 2008 12:37:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Apr 2008 12:37:01 -0400
Content-Disposition: inline
In-Reply-To: <20080430145017.GA922@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80845>

On Wed, Apr 30, 2008 at 10:50:17AM -0400, Jeff King wrote:

> A few other comments (I like the idea overall):

Actually, thinking about this a bit more (and using it), I'm not sure
that the best rule for showing the committer is "differs from the
previous committer." For example, if I am building on Junio's git.git,
the committer name is shown, even though I have made many commits in
this repo already.

So if the goal is to show the committer name only when it "matters", I
don't think you have succeeded.

-Peff
