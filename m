From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] diff text conversion filter
Date: Sun, 5 Oct 2008 17:41:14 -0400
Message-ID: <20081005214114.GA21875@coredump.intra.peff.net>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr> <20080928041040.GA24214@coredump.intra.peff.net> <vpqd4io1tla.fsf@bauges.imag.fr> <20080928161106.GA30199@coredump.intra.peff.net> <vpqk5ctfyp6.fsf@bauges.imag.fr> <20080930164545.GA20305@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Oct 05 23:42:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmbN3-0001Dj-GJ
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 23:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbYJEVlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 17:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754650AbYJEVlS
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 17:41:18 -0400
Received: from peff.net ([208.65.91.99]:2840 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754601AbYJEVlS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 17:41:18 -0400
Received: (qmail 17824 invoked by uid 111); 5 Oct 2008 21:41:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 05 Oct 2008 17:41:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Oct 2008 17:41:14 -0400
Content-Disposition: inline
In-Reply-To: <20080930164545.GA20305@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97537>

On Tue, Sep 30, 2008 at 12:45:45PM -0400, Jeff King wrote:

> I am about 90% done cleaning it up for preparation (there is a bit of
> refactoring, and I want to make sure I get that just right). I'll post
> it in the next day or so.

Sorry, I didn't get a chance to look at this until today. Patch series
will follow. It is still missing documentation updates and tests, but I
wanted to get you something to look at (and as I am proposing a new
meaning for "diff driver", I would be curious to hear the general
comments).

This is on top of 'next', because it would otherwise conflict with the
funcname pattern changes there.

-Peff
