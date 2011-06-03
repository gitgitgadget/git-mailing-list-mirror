From: Jeff King <peff@peff.net>
Subject: Re: Unable to fork off sideband demultiplexer
Date: Fri, 3 Jun 2011 15:24:45 -0400
Message-ID: <20110603192445.GA26977@sigill.intra.peff.net>
References: <loom.20110601T161508-689@post.gmane.org>
 <7vk4d5h3qt.fsf@alter.siamese.dyndns.org>
 <20110601173524.GF7132@sigill.intra.peff.net>
 <loom.20110601T210757-955@post.gmane.org>
 <loom.20110602T172442-653@post.gmane.org>
 <20110602192927.GA21262@sigill.intra.peff.net>
 <loom.20110603T151012-143@post.gmane.org>
 <20110603144907.GA11273@sigill.intra.peff.net>
 <loom.20110603T204919-581@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Randy Brandenburg <randy.brandenburg@woh.rr.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 21:24:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSZzJ-0000i2-V0
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 21:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509Ab1FCTYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 15:24:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41021
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753953Ab1FCTYs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 15:24:48 -0400
Received: (qmail 12088 invoked by uid 107); 3 Jun 2011 19:24:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Jun 2011 15:24:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2011 15:24:45 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110603T204919-581@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175022>

On Fri, Jun 03, 2011 at 06:52:32PM +0000, Randy Brandenburg wrote:

> OK, rebuilt with NO_PTHREADS=0 and PTHREAD_CFLAGS=-pthreads and it seems to be 
> working. Just tested quickly for the basics (push and pull). I will be able to 
> test more in depth next week, but I would assume that all will be
> okay.

I think that will still build without pthreads at all, as we check
"ifdef NO_PTHREADS" in the Makefile. You have to use "NO_PTHREADS=".

-Peff
