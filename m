From: Jeff King <peff@peff.net>
Subject: Re: git-diff should not fire up $PAGER, period!
Date: Wed, 17 Dec 2008 22:31:16 -0500
Message-ID: <20081218033116.GC20749@coredump.intra.peff.net>
References: <20081216005658.GB3679@coredump.intra.peff.net> <8763lixyps.fsf_-_@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Thu Dec 18 04:32:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD9ct-0005Ic-3H
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 04:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbYLRDbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 22:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbYLRDbT
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 22:31:19 -0500
Received: from peff.net ([208.65.91.99]:2071 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbYLRDbS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 22:31:18 -0500
Received: (qmail 31732 invoked by uid 111); 18 Dec 2008 03:31:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 17 Dec 2008 22:31:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Dec 2008 22:31:16 -0500
Content-Disposition: inline
In-Reply-To: <8763lixyps.fsf_-_@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103429>

On Thu, Dec 18, 2008 at 05:45:35AM +0800, jidanni@jidanni.org wrote:

> Gentlemen, I have found the solution to your problem.
> 
> Unbundle git-diff and $PAGER.

If you are going to argue this, please at least go back and read the
numerous times it has been brought up in the past on the list archive.

The last discussion ended up showing that some people really like the
automatic pager for some commands, and some people really detest it.
So I implemented 4e10738 (Allow per-command pager config, 2008-07-03),
and now you can do:

  git config pager.diff false

and be happy (or, as you obviously disocvered, simply unsetting
core.pager will disable all).

-Peff
