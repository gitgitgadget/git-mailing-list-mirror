From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Fri, 6 Feb 2009 14:15:11 -0500
Message-ID: <20090206191511.GD19494@coredump.intra.peff.net>
References: <20090205204436.GA6072@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:16:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVWBv-0004US-41
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 20:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbZBFTPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 14:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753642AbZBFTPP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 14:15:15 -0500
Received: from peff.net ([208.65.91.99]:56934 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501AbZBFTPO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 14:15:14 -0500
Received: (qmail 24215 invoked by uid 107); 6 Feb 2009 19:15:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Feb 2009 14:15:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2009 14:15:11 -0500
Content-Disposition: inline
In-Reply-To: <20090205204436.GA6072@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108774>

On Thu, Feb 05, 2009 at 09:44:36PM +0100, Jonas Fonseca wrote:

>  - Blame view: load blame for parent commit. For merge commits the parent
>    is queried. Bound to ',' by default via the existing "parent" action.

Thanks for this, btw. I've already used it at least half a dozen times
in the past week or so.

It looks like you just keep the view on the same line number when moving
to the new blame output. In practice, this has very mixed results. Most
of the time it does exactly what I want, but if the file changes
significantly, you get dumped at a totally unrelated part of the file.
I'm not sure if there is a more clever solution, though.

-Peff
