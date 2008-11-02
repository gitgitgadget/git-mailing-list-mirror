From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Sun, 2 Nov 2008 00:41:59 -0400
Message-ID: <20081102044159.GF5261@coredump.intra.peff.net>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 05:43:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwUo4-0001yL-N3
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 05:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbYKBEmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 00:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbYKBEmE
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 00:42:04 -0400
Received: from peff.net ([208.65.91.99]:3229 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbYKBEmC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 00:42:02 -0400
Received: (qmail 22607 invoked by uid 111); 2 Nov 2008 04:42:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Nov 2008 00:42:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Nov 2008 00:41:59 -0400
Content-Disposition: inline
In-Reply-To: <1225468527-29694-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99813>

On Fri, Oct 31, 2008 at 04:55:27PM +0100, Pierre Habouzit wrote:

>  I've not kept the auto-edit feature of git-revert for the git-cherry-pick -R
>  case as I don't believe it makes a lot of sense. But if people are unhappy
>  with that, I can easily "fix" it.

I disagree. I write a new commit message for every revert I do.

When you cherry-pick, you are pulling a good commit from somewhere else.
So its commit message should suffice to explain why you are making the
change (and infrequently, you might want to give more context or say
"and here is where this comes from").

But when you revert, you are saying "this other commit was bad, so let's
reverse it." So you can look at the other commit to see what it did, but
you still don't know _why_ it was bad. A revert should always give
information about what you know _now_ that you didn't know when you
made the commit originally.

-Peff
