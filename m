From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: grep portability fixes
Date: Tue, 30 Sep 2008 08:45:22 -0400
Message-ID: <20080930124522.GA22182@coredump.intra.peff.net>
References: <20080930080355.GA19605@sigill.intra.peff.net> <48E1FB76.1040500@op5.se> <48E1FF6D.1050907@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 30 14:46:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkecd-0000d1-Bq
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 14:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbYI3MpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 08:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbYI3MpZ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 08:45:25 -0400
Received: from peff.net ([208.65.91.99]:1863 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbYI3MpY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 08:45:24 -0400
Received: (qmail 9081 invoked by uid 111); 30 Sep 2008 12:45:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Sep 2008 08:45:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Sep 2008 08:45:22 -0400
Content-Disposition: inline
In-Reply-To: <48E1FF6D.1050907@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97105>

On Tue, Sep 30, 2008 at 12:29:01PM +0200, Johannes Sixt wrote:

> Andreas Ericsson schrieb:
> > Jeff King wrote:
> >> -    if ! grep -qe "Invalid gitfile format" .err
> >> +    if ! grep "Invalid gitfile format" .err
> > 
> > Doesn't output need to be redirected when you drop '-q'?
> 
> In standard mode, the test output is directed to /dev/null anyway, and in
> verbose mode the extra output doesn't hurt at all, and is usually useful
> because you know that a pattern matched.

Exactly. This is the more of the same as aadbe44f (grep portability fix:
don't use "e" or "-q") but I was too lazy to rewrite the justification
completely (but I did reference it).

-Peff
