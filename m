From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow setting default diff options via
	diff.defaultOptions
Date: Thu, 9 Apr 2009 04:31:15 -0400
Message-ID: <20090409083115.GA17622@coredump.intra.peff.net>
References: <20090320194930.GB26934@coredump.intra.peff.net> <1237600853-22815-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de> <alpine.GSO.2.00.0904081741410.15657@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Thu Apr 09 10:32:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrpgs-0006zg-AU
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 10:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757021AbZDIIbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 04:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756491AbZDIIbV
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 04:31:21 -0400
Received: from peff.net ([208.65.91.99]:49081 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989AbZDIIbT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 04:31:19 -0400
Received: (qmail 14920 invoked by uid 107); 9 Apr 2009 08:31:19 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 09 Apr 2009 04:31:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Apr 2009 04:31:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.GSO.2.00.0904081741410.15657@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116151>

On Wed, Apr 08, 2009 at 05:44:29PM -0700, Keith Cascio wrote:

> Hi.  Was my last message understandable or should I add more explanation?
>   http://comments.gmane.org/gmane.comp.version-control.git/115506

Your point made sense to me, and is the expected difference between the
two approaches (as we discussed before).

I'm sorry I haven't had a chance to review your patch in detail. It is
pleasantly much shorter than previous iterations, but I wanted to very
carefully check a few of the diff callsites to make sure they work
properly (e.g., some of the cases I laid out earlier in the thread).

I have a lot of regular life responsibilities right now, but I'll try
take a close look this weekend.

-Peff
