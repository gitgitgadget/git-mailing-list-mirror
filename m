From: Jeff King <peff@peff.net>
Subject: Re: Git Confusion
Date: Fri, 29 May 2009 09:52:42 -0400
Message-ID: <20090529135242.GA30926@coredump.intra.peff.net>
References: <815c8c330905290043i4c99a753jd5ad9bdd4cf18bbc@mail.gmail.com> <20090529125853.GB11785@sigill.intra.peff.net> <m3d49sauru.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Tarjan <ptarjan@gmail.com>, git@vger.kernel.org,
	yury239@gmail.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 15:53:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA2W4-0002Ps-EJ
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 15:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760576AbZE2Nwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 09:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760768AbZE2Nwu
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 09:52:50 -0400
Received: from peff.net ([208.65.91.99]:45982 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760705AbZE2Nwu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 09:52:50 -0400
Received: (qmail 26763 invoked by uid 107); 29 May 2009 13:52:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 29 May 2009 09:52:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 May 2009 09:52:42 -0400
Content-Disposition: inline
In-Reply-To: <m3d49sauru.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120279>

On Fri, May 29, 2009 at 06:44:26AM -0700, Jakub Narebski wrote:

> > Usually such a repo is bare, and gets updates only by push. In that
> > case, enabling the update hook to run update-server-info is sufficient.
> > But in your case, you are actually working on the remote repo via commit
> > and other means, so there is no convenient way to always
> > update-server-info after a change.
> 
> Well, he can always add git-update-server-info to post-commit hook.

That covers committing, but what about reset, rebase, "branch -f", etc?
I don't think there is a catch-all for all the ways that a repo can be
updated locally.

> > Is there a particular reason you cloned over http instead of over ssh?
> Or git protocol?

Yes, that would work fine, too. I mentioned ssh because he already
indicated that he was able to ssh into the box (and may or may not have
the git daemon set up).

-Peff
