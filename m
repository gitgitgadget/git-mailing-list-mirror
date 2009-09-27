From: Jeff King <peff@peff.net>
Subject: Re: Interim maintainer tree
Date: Sun, 27 Sep 2009 04:54:37 -0400
Message-ID: <20090927085437.GA10828@coredump.intra.peff.net>
References: <20090925160504.GW14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 27 10:54:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrpWz-000544-PY
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 10:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbZI0Iyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 04:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbZI0Iyg
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 04:54:36 -0400
Received: from peff.net ([208.65.91.99]:36510 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534AbZI0Iyg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 04:54:36 -0400
Received: (qmail 19131 invoked by uid 107); 27 Sep 2009 08:58:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 27 Sep 2009 04:58:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Sep 2009 04:54:37 -0400
Content-Disposition: inline
In-Reply-To: <20090925160504.GW14660@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129205>

On Fri, Sep 25, 2009 at 09:05:04AM -0700, Shawn O. Pearce wrote:

> Junio is on vaction for the next week.  In his absence Peff and I
> are trying to keep up with current patches in my fork:
> 
>   git://repo.or.cz/git/spearce.git
>   http://repo.or.cz/r/git/spearce.git

I've collected a few more topics in my repo:

  git://github.com/peff/git.git

Rather than cook my own, slightly different 'next', I'm just publishing
the tips of the topics themselves. Which means they are subject to
rewinding until you merge them into 'next', at which point I will leave
them stable.

What's in there now is:

  as/parseopt-ambiguous
    Fix for "git branch --no-merge" with my test added. Should be ready
    for next.

  jk/reflog-date
    My reflog fix. Should be ready for next.

  mr/gitweb-snapshot
    v5, replacing what Junio had in pu. Should probably stay in pu until
    we hear from Jakub.

  mr/instaweb
    Looked OK to me, but I have no capacity to actually test it.
    Unlikely to break anything else, though, so probably ready to cook
    in next.

  mv/lock-error
    My tweaked version, which got the OK from Miklos. Ready for next, I
    think.

  np/clone-smaller
    Nico's fix to stop copying unnecessary objects during clone. Patch
    looks sane, I confirmed that it fixes the issue, and it doesn't seem
    to break normal clones. Ready to cook in next, I think.

-Peff
