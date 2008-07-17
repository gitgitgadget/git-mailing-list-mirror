From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Testsuite: Unset CVS_SERVER
Date: Thu, 17 Jul 2008 13:53:03 -0400
Message-ID: <20080717175303.GA8197@sigill.intra.peff.net>
References: <1216288877-12140-1-git-send-email-lars@public.noschinski.de> <1216288877-12140-2-git-send-email-lars@public.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, fabian.emmes@rwth-aachen.de
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 19:54:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJXgD-0003eB-99
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 19:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758099AbYGQRxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 13:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757721AbYGQRxJ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 13:53:09 -0400
Received: from peff.net ([208.65.91.99]:2920 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757429AbYGQRxH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 13:53:07 -0400
Received: (qmail 16617 invoked by uid 111); 17 Jul 2008 17:53:04 -0000
Received: from lawn-128-61-17-22.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.17.22)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 17 Jul 2008 13:53:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jul 2008 13:53:03 -0400
Content-Disposition: inline
In-Reply-To: <1216288877-12140-2-git-send-email-lars@public.noschinski.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88893>

On Thu, Jul 17, 2008 at 12:01:13PM +0200, Lars Noschinski wrote:

> The CVS_SERVER environment variable cane cause some of the cvsimport tests
> to fail. So unset this variable at the beginning of the test script.

This is definitely an improvement. However, the cvs manual lists a
number of CVS* variables. Perhaps it would be better to simply scrub the
environment of any variable matching that pattern? I don't know how
commonly used some of the other ones are.

-Peff
