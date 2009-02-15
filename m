From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-remote: better handling of multiple remote
	HEADs
Date: Sun, 15 Feb 2009 10:12:59 -0500
Message-ID: <20090215151259.GA15342@sigill.intra.peff.net>
References: <20090214034345.GB24545@coredump.intra.peff.net> <1234607430-5403-1-git-send-email-jaysoffian@gmail.com> <20090215052740.GA11522@coredump.intra.peff.net> <76718490902150613i79517e6dwcec8e1e40c56bcc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 16:14:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYihq-0003ff-7a
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 16:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbZBOPNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 10:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbZBOPNG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 10:13:06 -0500
Received: from peff.net ([208.65.91.99]:38497 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbZBOPNF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 10:13:05 -0500
Received: (qmail 7899 invoked by uid 107); 15 Feb 2009 15:13:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 15 Feb 2009 10:13:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 10:12:59 -0500
Content-Disposition: inline
In-Reply-To: <76718490902150613i79517e6dwcec8e1e40c56bcc8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110014>

On Sun, Feb 15, 2009 at 09:13:09AM -0500, Jay Soffian wrote:

> >> +     (cd test &&
> >> +      test_must_fail git remote set-head --auto two >& output &&
> >> +     test_cmp expect output)
> >
> > I missed it before, but there is a typo in this test (>&) that causes it
> > to barf.
> 
> Didn't barf for me, but it turns out it's because it's a bash'ism[1],
> and that's the default /bin/sh on OS X. Out of curiosity, on what
> platform did it fail for you?

Ah, I didn't realize that was valid under any shell. ;) My /bin/sh is
dash, which explains it.

-Peff
