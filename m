From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Use %as and %cs as pretty format flags
Date: Thu, 28 Aug 2008 19:15:48 -0400
Message-ID: <20080828231547.GD29609@coredump.intra.peff.net>
References: <d77df1110808280409o9445f9fybcab2c8d1066a8d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nathan Panike <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:16:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqjX-0007wr-6N
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbYH1XPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754819AbYH1XPu
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:15:50 -0400
Received: from peff.net ([208.65.91.99]:1237 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754632AbYH1XPu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:15:50 -0400
Received: (qmail 8925 invoked by uid 111); 28 Aug 2008 23:15:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Aug 2008 19:15:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2008 19:15:48 -0400
Content-Disposition: inline
In-Reply-To: <d77df1110808280409o9445f9fybcab2c8d1066a8d8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94204>

On Thu, Aug 28, 2008 at 06:09:37AM -0500, Nathan Panike wrote:

> The patch series below allows git to use %as and %cs as flags for
> pretty-printing the format of a date.

Your description leaves a little to be desired (here and in the patches
themselves). I had to read the patch to figure out that these are
formatting specifiers for the date format "short".

That being said, I think this is probably reasonable just for the sake
of completeness (and I doubt we are wasting a useful formatting combo,
since %a* is likely to remain dedicated to author information). I wonder
if there should be "%al" for "local".

However, it makes me wonder even more if '%ad' should simply respect the
--date= parameter (this wouldn't allow you to mix and match dates in a
single format, but I don't think that is what is desired). Or whether we
should have some syntax for "%ad(short)" or something, where the
argument would be handed off to the date format parser. But that is
probably overengineering.

-Peff

PS Junio, I think this will make your "git one" alias much shorter. :)
