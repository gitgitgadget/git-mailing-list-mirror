From: Jeff King <peff@peff.net>
Subject: Re: Adding color to git-add--interactive
Date: Tue, 9 Oct 2007 19:40:20 -0400
Message-ID: <20071009234020.GA20952@coredump.intra.peff.net>
References: <91EBB71E-BB4E-4089-8C33-6B0C4A61223A@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 01:40:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfOgk-0007Ad-Rw
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 01:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbXJIXk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 19:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbXJIXkZ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 19:40:25 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2777 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbXJIXkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 19:40:25 -0400
Received: (qmail 26956 invoked by uid 111); 9 Oct 2007 23:40:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 09 Oct 2007 19:40:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Oct 2007 19:40:20 -0400
Content-Disposition: inline
In-Reply-To: <91EBB71E-BB4E-4089-8C33-6B0C4A61223A@steelskies.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60456>

On Tue, Oct 09, 2007 at 02:06:31PM +0100, Jonathan del Strother wrote:

> For me at least, adding color would make the interactive mode far more
> readable.   I hacked in basic color support (just coloring PROMPT &
> HEADER in list_and_choose, and the "Stage this hunk?" prompt) - which
> helped a lot - but then reached the limits of my perl knowledge.  For
> instance, I can't see a sensible way of reusing git-svn's
> log_use_color function without importing the entire file, and I can't
> figure out how you'd go about diff-coloring the hunks.  Is anyone with
> more perl knowledge than me interested in taking this on?

Why don't you post what you have, and we can make comments on it?

As far as reusing code from git-svn, there is a 'Git.pm' module in the
perl/ subdirectory. You can move the code there and 'use Git' in
git-add--interactive.perl (git-svn already uses it).

-Peff
