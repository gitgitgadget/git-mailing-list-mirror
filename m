From: Jeff King <peff@peff.net>
Subject: Re: can't push refs/stash?
Date: Thu, 11 Feb 2010 20:10:03 -0500
Message-ID: <20100212011003.GB23303@coredump.intra.peff.net>
References: <20100212005632.GA3684@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 02:10:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfk2s-0001RR-J8
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 02:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479Ab0BLBKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 20:10:04 -0500
Received: from peff.net ([208.65.91.99]:44148 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab0BLBKB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 20:10:01 -0500
Received: (qmail 24274 invoked by uid 107); 12 Feb 2010 01:10:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 11 Feb 2010 20:10:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2010 20:10:03 -0500
Content-Disposition: inline
In-Reply-To: <20100212005632.GA3684@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139652>

On Thu, Feb 11, 2010 at 07:56:32PM -0500, Larry D'Anna wrote:

> If i try to push to refs/stash i get remote rejected (funny refname).  Is this
> the intended behavior?

Yes. The stash ref itself isn't all that useful. The list of stashes is
actually in the reflog, which is not pushable. And that is also
intentional; stashes were really meant to be short-term. If you want
something longer term that can be pushed, make a branch.

-Peff
