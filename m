From: Jeff King <peff@peff.net>
Subject: Re: new behaviour in git merge
Date: Thu, 24 Feb 2011 03:15:53 -0500
Message-ID: <20110224081553.GD25595@sigill.intra.peff.net>
References: <20110224143353.ddaa316a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: git-owner@vger.kernel.org Thu Feb 24 09:15:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsWMe-0008Nl-Pw
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 09:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269Ab1BXIPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 03:15:52 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50810 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755217Ab1BXIPv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 03:15:51 -0500
Received: (qmail 20758 invoked by uid 111); 24 Feb 2011 08:15:50 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 08:15:50 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 03:15:53 -0500
Content-Disposition: inline
In-Reply-To: <20110224143353.ddaa316a.sfr@canb.auug.org.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167780>

On Thu, Feb 24, 2011 at 02:33:53PM +1100, Stephen Rothwell wrote:

> I am not sure when this started, but I think git has changed its behaviour
> when merging.   As you all know, I do a lot of merging of trees for
> linux-next each day.  Today I noticed that when I merge a tree, sometimes
> the timestamps are modified for files that are not modified on one side
> of the merge.  It is not consistent and it is not all the files that are
> modified on the HEAD side (relative to the merge-base).
>
> [...]
>
> I am pretty sure that git did not used to do this. Has anyone else seen
> this?  I am running git version 1.7.4.1 from Debian unstable.

I don't think any such change was intentional.  I couldn't reproduce
with a trivial example. Can you give the commit IDs of the two heads in
your example merge? I'd like to try bisecting if I can reproduce the
issue.

-Peff
