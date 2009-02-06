From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] Tests: let --valgrind imply --verbose and --tee
Date: Fri, 6 Feb 2009 15:24:26 -0500
Message-ID: <20090206202425.GA19959@coredump.intra.peff.net>
References: <cover.1233702893u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0902040026250.9822@pacific.mpi-cbg.de> <20090206190815.GB19494@coredump.intra.peff.net> <alpine.DEB.1.00.0902062038420.7377@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 21:26:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVXH2-0005Gj-MO
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 21:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbZBFUYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 15:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbZBFUYa
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 15:24:30 -0500
Received: from peff.net ([208.65.91.99]:50252 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753048AbZBFUY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 15:24:29 -0500
Received: (qmail 24606 invoked by uid 107); 6 Feb 2009 20:24:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Feb 2009 15:24:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2009 15:24:26 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902062038420.7377@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108781>

On Fri, Feb 06, 2009 at 08:40:59PM +0100, Johannes Schindelin wrote:

> > On the other hand, I think "--verbose --tee >/dev/null" would probably 
> > accomplish the same thing, so it probably isn't worth too much effort.
> 
> No.  Why would I want 'make test' to hide the fact from me that something 
> did not work, and how it happened to fail?

Because "make test" with "--verbose" generates megabytes of output which
you don't want mailed to you by cron, and that information is already
being saved in a file by "--tee"?

-Peff
