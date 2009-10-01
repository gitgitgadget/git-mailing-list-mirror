From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: Do not show 'patch' link in 'commit' view for
 merges
Date: Wed, 30 Sep 2009 23:11:40 -0400
Message-ID: <20091001031140.GA30094@coredump.intra.peff.net>
References: <20090930201953.22301.73887.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 05:11:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtC5B-0003vR-Iq
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 05:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526AbZJADLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 23:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755522AbZJADLo
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 23:11:44 -0400
Received: from peff.net ([208.65.91.99]:48514 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755491AbZJADLo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 23:11:44 -0400
Received: (qmail 11636 invoked by uid 107); 1 Oct 2009 03:15:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 30 Sep 2009 23:15:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Sep 2009 23:11:40 -0400
Content-Disposition: inline
In-Reply-To: <20090930201953.22301.73887.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129374>

On Wed, Sep 30, 2009 at 10:21:53PM +0200, Jakub Narebski wrote:

> Show 'patch' link in the 'commit' view only for commits which have
> exactly one parent, otherwise call to git-format-patch would fail for
> the hyperlinked 'patch' action.

Fail in what way? From my cursory reading of the code, it looks like the
'patch' action calls into git_commitdiff, which handles the multi-parent
case.

I assume I'm reading wrong, since you obviously know gitweb much better
than I do. :) But can you expand a little on the nature of the problem
in the commit message?

-Peff
