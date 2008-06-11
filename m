From: Jeff King <peff@peff.net>
Subject: Re: git-reflog infinite loop
Date: Wed, 11 Jun 2008 03:03:26 -0400
Message-ID: <20080611070326.GA9980@sigill.intra.peff.net>
References: <484EBD92.8040603@obry.net> <20080611034718.GB7198@sigill.intra.peff.net> <484F66A5.6070205@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Wed Jun 11 09:04:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6KNc-0002eO-IQ
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 09:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbYFKHDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 03:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbYFKHDa
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 03:03:30 -0400
Received: from peff.net ([208.65.91.99]:2594 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbYFKHDa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 03:03:30 -0400
Received: (qmail 12126 invoked by uid 111); 11 Jun 2008 07:03:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 11 Jun 2008 03:03:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jun 2008 03:03:26 -0400
Content-Disposition: inline
In-Reply-To: <484F66A5.6070205@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84595>

On Wed, Jun 11, 2008 at 07:46:13AM +0200, Pascal Obry wrote:

>> can you make a tarball of your .git directory available?
>
> No I can't :(
>
> Is there some git-reflog options I can try to help finding this problem?

Not that I can think of offhand. If I had gotten a copy of the
repository, I would have run it under strace and/or gdb to see what it
was doing while it hung. If you're comfortable with running a debugger,
you might be able to point us to the right part of the code (I'm
assuming there is an infinite loop in there somewhere).

-Peff
