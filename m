From: Jeff King <peff@peff.net>
Subject: Re: Has the git shell revert been done so master should work?
Date: Mon, 25 Aug 2008 17:03:51 -0400
Message-ID: <20080825210351.GB28482@coredump.intra.peff.net>
References: <alpine.LNX.1.10.0808240659350.16122@xenau.zenez.com> <alpine.LNX.1.10.0808251325540.19079@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXjFM-0004PP-Ub
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 23:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbYHYVDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 17:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753516AbYHYVDy
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 17:03:54 -0400
Received: from peff.net ([208.65.91.99]:2940 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428AbYHYVDx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 17:03:53 -0400
Received: (qmail 24201 invoked by uid 111); 25 Aug 2008 21:03:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 25 Aug 2008 17:03:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2008 17:03:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0808251325540.19079@suse104.zenez.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93677>

On Mon, Aug 25, 2008 at 01:30:23PM -0600, Boyd Lynn Gerber wrote:

> $ git clone git://git.kernel.org/pub/scm/git/git.git git
> $ cd git
> $ git checkout master
> Already on "master"
> $ git cherry-pick 4cfc24af
> fatal: exec merge-recursive failed.
> Automatic cherry-pick failed.  After resolving the conflicts,
> mark the corrected paths with 'git add <paths>' or 'git rm <paths>' and  
> commit the result.
> When commiting, use the option '-c 4cfc24a' to retain authorship and  
> message.
>
> So I was attempting to do it right, but it just did not work.

Hmm. Something is broken if it was unable to run merge-recursive. You
could maybe try running with GIT_TRACE=1, or stracing cherry-pick to see
what was going on.

> BTW, is there a way to get all the messages sent since last night.  Some  
> how I lost my subscription to the git email list.  I re-subscribe at  
> around 1:30 MDT.  I really would like to get all the email I mised.

Gmane maintains an archive. You can either just read the messages via
the web, grab them via nntp, or you can even persuade them to send you
an mbox of a set of messages:

  http://gmane.org/export.php

-Peff
