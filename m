From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/.gitattributes: only ignore whitespace errors in
	test files
Date: Fri, 13 Jun 2008 02:06:30 -0400
Message-ID: <20080613060629.GC26768@sigill.intra.peff.net>
References: <1213310159-28049-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 08:07:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K72Rb-0002O3-28
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 08:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbYFMGGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 02:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbYFMGGd
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 02:06:33 -0400
Received: from peff.net ([208.65.91.99]:1350 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbYFMGGc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 02:06:32 -0400
Received: (qmail 28725 invoked by uid 111); 13 Jun 2008 06:06:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 02:06:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 02:06:30 -0400
Content-Disposition: inline
In-Reply-To: <1213310159-28049-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84839>

On Fri, Jun 13, 2008 at 12:35:59AM +0200, Lea Wiemann wrote:

> Only ignore whitespace errors in t/tNNNN-*.sh and the t/tNNNN
> subdirectories.  Other files (like test libraries) should still be
> checked.

Why?

What is the difference between test-lib.sh and tNNNN-*.sh that makes one
subject to whitespace checking and the other not?

(I suspect the answer is "shoving all the code in tNNNN-*.sh into eval'd
strings screws up the whitespace checking", but my point is that I
shouldn't have to guess; the justification should go in the commit
message).

-Peff
