From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 4/5] stash list: drop the default limit of 10
 stashes
Date: Wed, 14 Oct 2009 01:02:48 -0400
Message-ID: <20091014050248.GC31810@coredump.intra.peff.net>
References: <cover.1255380039.git.trast@student.ethz.ch>
 <137df1f7295576345f5aefe46c882399e107c321.1255380039.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 14 07:04:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxw2R-0003iP-Lj
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 07:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbZJNFDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 01:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbZJNFDY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 01:03:24 -0400
Received: from peff.net ([208.65.91.99]:56526 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894AbZJNFDY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 01:03:24 -0400
Received: (qmail 24529 invoked by uid 107); 14 Oct 2009 05:06:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Oct 2009 01:06:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 01:02:48 -0400
Content-Disposition: inline
In-Reply-To: <137df1f7295576345f5aefe46c882399e107c321.1255380039.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130247>

On Mon, Oct 12, 2009 at 11:06:06PM +0200, Thomas Rast wrote:

> 'git stash list' had an undocumented limit of 10 stashes, unless other
> git-log arguments were specified.  This surprised at least one user,
> but possibly served to cut the output below a screenful without using
> a pager.
> 
> Since the last commit, 'git stash list' will fire up a pager according
> to the same rules as the 'git log' it calls, so we can drop the limit.

Having slept on it, I think I agree that this is a good change. It fixes
the ugly corner cases I mentioned, and it is easier to explain.

-Peff
