From: Jeff King <peff@peff.net>
Subject: Re: git format-patch should honor notes
Date: Tue, 7 Dec 2010 17:11:52 -0500
Message-ID: <20101207221151.GC1036@sigill.intra.peff.net>
References: <4CFEACC5.70005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 23:12:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ5lP-0006gI-Mz
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 23:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab0LGWLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 17:11:55 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:36675 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275Ab0LGWLy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 17:11:54 -0500
Received: (qmail 29084 invoked by uid 111); 7 Dec 2010 22:11:54 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 07 Dec 2010 22:11:54 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Dec 2010 17:11:52 -0500
Content-Disposition: inline
In-Reply-To: <4CFEACC5.70005@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163144>

On Tue, Dec 07, 2010 at 02:53:09PM -0700, Eric Blake wrote:

> My workflow is that I post patch series for upstream review via 'git
> send-email'.  Often, that results in feedback that requires me to
> amend/rebase my series, and post a v2 or v3 of the series.  By adding
> 'git config notes.rewriteRef refs/notes/commits', I can add notes that
> will carry across my rebase, and remind me what I changed in v2 (for
> example, git notes add -m 'v2: fix foo, per mail xyz@example.com').
> This is handy for me, and I think it is also handy for reviewers -
> someone who took the time to read through v1 should know what I changed
> in response to their comments, and only have to focus in on commits with
> changes, rather than on the entire resent series.

Yeah, that is a workflow that some others have mentioned using here,
too. And I think there is general agreement that notes should go after
the "---" in format-patch. We just need a working patch.

Thomas posted one in February:

  http://article.gmane.org/gmane.comp.version-control.git/140819

But there were some issues and it never got polished. Michael suggested
that he does something similar here:

  http://article.gmane.org/gmane.comp.version-control.git/140819

but there was no indication on whether it happens manually or if he has
a patch. I don't know if anything else has happened in that area. I'm
sure if you feel like working on a patch it would be well received.

-Peff
