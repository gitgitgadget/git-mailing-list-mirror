From: Jeff King <peff@cc.gatech.edu>
Subject: Re: [PATCH] Generalize and libify index_is_dirty() to
	index_differs_from(...)
Date: Mon, 9 Feb 2009 19:12:20 -0500
Message-ID: <20090210001220.GB5551@sigill.intra.peff.net>
References: <1234222843-15577-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 01:20:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWgMe-0004TH-06
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 01:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbZBJATK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 19:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbZBJATH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 19:19:07 -0500
Received: from peff.net ([208.65.91.99]:44362 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbZBJATG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 19:19:06 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Feb 2009 19:19:06 EST
Received: (qmail 8421 invoked by uid 107); 10 Feb 2009 00:12:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 09 Feb 2009 19:12:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Feb 2009 19:12:20 -0500
Content-Disposition: inline
In-Reply-To: <1234222843-15577-1-git-send-email-s-beyer@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109166>

On Tue, Feb 10, 2009 at 12:40:43AM +0100, Stephan Beyer wrote:

>   Peff is on Cc because he introduced index_is_dirty() in
>   builtin-revert.c.

Certainly it looks to me like a straight-forward libification of what I
had added before.

Acked-by: Jeff King <peff@peff.net>

-Peff
