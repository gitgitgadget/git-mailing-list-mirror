From: Jeff King <peff@peff.net>
Subject: Re: git log filtering
Date: Thu, 8 Feb 2007 20:59:25 -0500
Message-ID: <20070209015925.GD10574@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org> <Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v64ad7l12.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org> <7vps8l65fh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org> <20070208061654.GA8813@coredump.intra.peff.net> <Pine.LNX.4.63.0702081905570.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070208223336.GA9422@coredump.intra.peff.net> <Pine.LNX.4.63.0702090115180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 09 02:59:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFL2x-0000O5-DX
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 02:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946003AbXBIB72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 20:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946014AbXBIB72
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 20:59:28 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1696 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1946003AbXBIB71 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 20:59:27 -0500
Received: (qmail 32327 invoked from network); 8 Feb 2007 20:59:29 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 8 Feb 2007 20:59:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Feb 2007 20:59:25 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702090115180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39148>

On Fri, Feb 09, 2007 at 01:18:01AM +0100, Johannes Schindelin wrote:

> Yes, I do. Not because of the extra lines, but because of the inconsistent 
> interface.

OK, so we may either:
  1. always use the lowest common denominator (i.e., no pcre support)
  2. force a dependency for new features (i.e., require pcre)
  3. have inconsistency between builds (i.e., conditional dependency)
  4. include all dependencies, or re-write them natively

I agree that 4 can make some sense in limited situations, but I worry
that it will eventually cease to be scalable (we don't get improvements
or bugfixes automatically from other packages, we potentially re-invent
the wheel). We already have '3' for other things: openssl, curl, expat,
even perl.

-Peff
