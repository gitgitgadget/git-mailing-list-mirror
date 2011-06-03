From: Jeff King <peff@peff.net>
Subject: Re: Unable to fork off sideband demultiplexer
Date: Fri, 3 Jun 2011 10:49:07 -0400
Message-ID: <20110603144907.GA11273@sigill.intra.peff.net>
References: <loom.20110601T161508-689@post.gmane.org>
 <7vk4d5h3qt.fsf@alter.siamese.dyndns.org>
 <20110601173524.GF7132@sigill.intra.peff.net>
 <loom.20110601T210757-955@post.gmane.org>
 <loom.20110602T172442-653@post.gmane.org>
 <20110602192927.GA21262@sigill.intra.peff.net>
 <loom.20110603T151012-143@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Randy Brandenburg <randy.brandenburg@woh.rr.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 16:49:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSVgc-0003ES-ES
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 16:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab1FCOtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 10:49:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54046
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693Ab1FCOtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 10:49:12 -0400
Received: (qmail 8537 invoked by uid 107); 3 Jun 2011 14:49:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Jun 2011 10:49:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2011 10:49:07 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110603T151012-143@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175009>

On Fri, Jun 03, 2011 at 01:30:00PM +0000, Randy Brandenburg wrote:

> > If you build without NO_PTHREADS set on a Solaris 9 box, does it
> > work on that same box? That would confirm or deny my ABI
> > compatibility theory (and hopefully point us in the right direction
> > for the sunfreeware people to build a binary that works on Solaris 9
> > and 10).
> > 
> 
> Building without NO_PTHREADS set results in the original "broken"
> behaviour. I am staying with the working version in the interest of
> time. May investigate more later.

Thanks, that's a good data point. I know you are probably out of time
for fooling with such things, but if you get a chance, could you try
building also with "-pthreads" in PTHREAD_CFLAGS? I'm wondering if the
problem is as simple as that.

-Peff
