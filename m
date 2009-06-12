From: Jeff King <peff@peff.net>
Subject: Re: Who uses Signed-off-by and DCO?
Date: Fri, 12 Jun 2009 10:02:29 -0400
Message-ID: <20090612140229.GA14628@coredump.intra.peff.net>
References: <20090612084207.6117@nanako3.lavabit.com> <4A32366A.6090608@op5.se> <1244807741-sup-7206@ntdws12.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Fri Jun 12 16:04:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF7MP-00063y-Mq
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 16:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758410AbZFLOCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 10:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755158AbZFLOCg
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 10:02:36 -0400
Received: from peff.net ([208.65.91.99]:58656 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753382AbZFLOCf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 10:02:35 -0400
Received: (qmail 19431 invoked by uid 107); 12 Jun 2009 14:02:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 12 Jun 2009 10:02:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jun 2009 10:02:29 -0400
Content-Disposition: inline
In-Reply-To: <1244807741-sup-7206@ntdws12.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121422>

On Fri, Jun 12, 2009 at 07:58:50AM -0400, Ben Walton wrote:

> We're using it for shared admin edits.  The author is root (or
> whatever the shared account happens to be in other cases) and the SoB
> is the admin that made the change.  It's not enforced by anything
> other than convention, but it's still helpful for us.

Out of curiosity, how do you set the SoB? Does each user do it manually
when making a commit?

Is there a particular reason to favor this over setting GIT_AUTHOR_NAME
and GIT_AUTHOR_EMAIL (this would lose the fact that the commit was made
from the shared account, but has better tool support for finding changes
by a given author)?

-Peff
