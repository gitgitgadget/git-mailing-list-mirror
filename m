From: Jeff King <peff@peff.net>
Subject: Re: diff/Checking out by date specification
Date: Mon, 30 Jun 2008 01:26:12 -0400
Message-ID: <20080630052612.GA22699@sigill.intra.peff.net>
References: <486843C3.30402@rea-group.com> <20080630032744.GA18930@sigill.intra.peff.net> <48686339.60205@rea-group.com> <20080630052105.GA21954@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Toby Corkindale <toby.corkindale@rea-group.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 07:27:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDBux-0006gp-AQ
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 07:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbYF3F0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 01:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbYF3F0O
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 01:26:14 -0400
Received: from peff.net ([208.65.91.99]:2845 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbYF3F0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 01:26:13 -0400
Received: (qmail 25189 invoked by uid 111); 30 Jun 2008 05:26:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 30 Jun 2008 01:26:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2008 01:26:12 -0400
Content-Disposition: inline
In-Reply-To: <20080630052105.GA21954@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86873>

On Mon, Jun 30, 2008 at 01:21:05AM -0400, Jeff King wrote:

> Depending on what you want to do, that may be enough. But more likely,
> you are interested in the actual shape of history, so looking at the
> individual commits with something like "gitk --since=2008-01-01
> --until=2008-01-08" is probably going to be more instructive.

Side note: what you may have _really_ wanted was "what is the difference
between what was in Junio's 'master' branch on those dates". I.e.,
looking at the sequence of states at the tip of some "official" git
repo.

In that case, you could get the answer you want by looking in Junio's
reflog. However, that information is not generally available through
git. There is no support for downloading reflogs, and most people don't
have reflogs enabled on their published bare repos. If Junio enabled
reflogs on pushing to his bare repo, then you could manually download
them into your .git/logs/ hierarchy and pretend that that was your
history of your refs.

-Peff
