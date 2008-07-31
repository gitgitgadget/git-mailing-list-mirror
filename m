From: Jeff King <peff@peff.net>
Subject: Re: Git vs Monotone
Date: Thu, 31 Jul 2008 16:32:06 -0400
Message-ID: <20080731203206.GA8668@sigill.intra.peff.net>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <20080731190209.GA8372@sigill.intra.peff.net> <bd6139dc0807311219h670f782cm8bed74bed2b4558@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Craig L. Ching" <cching@mqsoftware.com>,
	Petr Baudis <pasky@suse.cz>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Jul 31 22:33:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOeph-0007li-QW
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 22:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbYGaUcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 16:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753813AbYGaUcJ
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 16:32:09 -0400
Received: from peff.net ([208.65.91.99]:3490 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296AbYGaUcI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 16:32:08 -0400
Received: (qmail 29509 invoked by uid 111); 31 Jul 2008 20:32:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 31 Jul 2008 16:32:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jul 2008 16:32:06 -0400
Content-Disposition: inline
In-Reply-To: <bd6139dc0807311219h670f782cm8bed74bed2b4558@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90981>

On Thu, Jul 31, 2008 at 09:19:41PM +0200, Sverre Rabbelier wrote:

> I repacked with --depth=100 and --window=100, I tried out 500 at first
> but it was just insanely slow (on a VM with one 2.4Ghz Core
> available). This resulted in a .git dir of 76MB. With that dir I did
> the following:

I tried 200/200 and got a 74M packfile. So I think we're getting into
diminishing returns.

> $ du -sh .
> 742M    .
> 
> So... monotone, eat your heart out ;).

:)

-Peff
