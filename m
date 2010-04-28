From: Jeff King <peff@peff.net>
Subject: Re: [patch 00/16] Portability Patches for git-1.7.1 (v4)
Date: Tue, 27 Apr 2010 22:08:16 -0400
Message-ID: <20100428020816.GC16107@coredump.intra.peff.net>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <4BD7032D.9050508@drmicha.warpmail.net>
 <20100427175442.GB13626@coredump.intra.peff.net>
 <m2iq7cejsh.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Apr 28 04:08:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6whN-0006tL-Ma
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 04:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796Ab0D1CIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 22:08:20 -0400
Received: from peff.net ([208.65.91.99]:37829 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859Ab0D1CIT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 22:08:19 -0400
Received: (qmail 5913 invoked by uid 107); 28 Apr 2010 02:08:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 27 Apr 2010 22:08:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Apr 2010 22:08:16 -0400
Content-Disposition: inline
In-Reply-To: <m2iq7cejsh.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145965>

On Tue, Apr 27, 2010 at 10:13:02PM +0200, Andreas Schwab wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Furthermore, if we do take such changes, how are we going to manage
> > portability going forward? Some constructs (like non-constant
> > initializers) make the code much easier to read. People _will_ submit
> > patches that use them. Is somebody going to be auto-building on all of
> > these platforms with vendor compilers to confirm that nothing is broken?
> 
> You can use "gcc -pedantic" to find these portability problems.

Sort of. It reports much more than we necessarily need to fix to remain
portable to even remotely sane platforms. So it's a nice tool for
finding problems, but somebody needs to do the work of figuring out
which are important and which are not, and then periodically run with
-pedantic and sort out the results.

-Peff
