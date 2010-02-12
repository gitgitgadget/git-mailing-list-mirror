From: Jeff King <peff@peff.net>
Subject: Re: Separate default push/pull?
Date: Thu, 11 Feb 2010 20:05:49 -0500
Message-ID: <20100212010549.GA23303@coredump.intra.peff.net>
References: <m2zl3fg26j.fsf@boostpro.com>
 <a038bef51002111057l382ed55fy6b4042d1115a830c@mail.gmail.com>
 <20100212001417.GC21930@coredump.intra.peff.net>
 <7veikrl1m1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Packham <judge.packham@gmail.com>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 02:05:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfjyj-0007cE-77
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 02:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757539Ab0BLBFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 20:05:48 -0500
Received: from peff.net ([208.65.91.99]:44143 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756961Ab0BLBFr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 20:05:47 -0500
Received: (qmail 24220 invoked by uid 107); 12 Feb 2010 01:05:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 11 Feb 2010 20:05:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2010 20:05:49 -0500
Content-Disposition: inline
In-Reply-To: <7veikrl1m1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139651>

On Thu, Feb 11, 2010 at 04:49:26PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think what he would need is a "push.defaultRemote" config option,
> > which universally overrides branch.*.remote for pushing.
> 
> Or "branch.*.pushremote".

That doesn't address my point 2, which is needing to set it up for every
branch.

> But does it really make sense to get changes from one place and send
> changes to somewhere completely unrelated?

It depends on your workflow. For git.git, your kernel.org repository is
my "origin", but I publish my state to a mirror for backup purposes (and
I don't publish for others to view, but I could very well do that, too).
I type "git push peff.net" and that is not too much trouble. Typing just
"git push" would be slightly more convenient, though.

In a distributed setup, I don't think it is that uncommon to not want to
push to the place you pull from. You are generally pulling and building
on somebody else's work, so if there is no central repo, you will be
pushing to somewhere that is not where you pulled it.

-Peff
