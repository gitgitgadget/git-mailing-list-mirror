From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #06; Sat, 24)
Date: Sun, 25 Jan 2009 13:51:50 -0500
Message-ID: <20090125185150.GA12727@sigill.intra.peff.net>
References: <7v8wp0kmj4.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901251308430.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 25 19:53:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRA6f-0004A1-6b
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 19:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbZAYSvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 13:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbZAYSvx
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 13:51:53 -0500
Received: from peff.net ([208.65.91.99]:33722 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbZAYSvw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 13:51:52 -0500
Received: (qmail 27223 invoked by uid 107); 25 Jan 2009 18:52:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 25 Jan 2009 13:52:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jan 2009 13:51:50 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901251308430.14855@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107079>

On Sun, Jan 25, 2009 at 01:17:33PM +0100, Johannes Schindelin wrote:

> BTW a test run on my machine resulted in a few koku of valgrind errors; 
> This was done in my personal tree which contains dozens of extra patches, 
> so I want to repeat the exercize with 'next' first, but I think we will 
> get quite some patches due to the valgrind support...

Hmm. I hope not. "master" was testing clean on valgrind a few months ago
(and took only a handful of cleanups to get that way after years of
development), so either you are getting false positives, my original
work was getting false negatives, or the code quality has dropped
dramatically in the last 3 months. :)

-Peff
