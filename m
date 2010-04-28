From: Jeff King <peff@peff.net>
Subject: Re: [patch 00/16] Portability Patches for git-1.7.1 (v4)
Date: Wed, 28 Apr 2010 08:17:56 -0400
Message-ID: <20100428121756.GA17244@sigill.intra.peff.net>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <4BD7032D.9050508@drmicha.warpmail.net>
 <20100427175442.GB13626@coredump.intra.peff.net>
 <m2iq7cejsh.fsf@igel.home>
 <20100428020816.GC16107@coredump.intra.peff.net>
 <20100428091922.GF36271@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 14:18:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O76DR-0005Bx-St
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 14:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472Ab0D1MSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 08:18:00 -0400
Received: from peff.net ([208.65.91.99]:36632 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859Ab0D1MR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 08:17:59 -0400
Received: (qmail 15485 invoked by uid 107); 28 Apr 2010 12:18:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 28 Apr 2010 08:18:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Apr 2010 08:17:56 -0400
Content-Disposition: inline
In-Reply-To: <20100428091922.GF36271@thor.il.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145989>

On Wed, Apr 28, 2010 at 09:19:22AM +0000, Gary V. Vaughan wrote:

> > > > Furthermore, if we do take such changes, how are we going to manage
> > > > portability going forward? Some constructs (like non-constant
> > > > initializers) make the code much easier to read. People _will_ submit
> > > > patches that use them. Is somebody going to be auto-building on all of
> > > > these platforms with vendor compilers to confirm that nothing is broken?
> 
> And that's fine.  People who are trying to build will notice the
> breakage on their platforms and likely submit patches in due course.

That was sort of implicit in my questions. _Is_ there somebody who is
going to be building on these platforms that will notice the breakage?

But it sounds from the rest of your mail like you are willing to do so,
which is at least encouraging.

-Peff
