From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] Split up default "core" config parsing into helper
	routine
Date: Wed, 18 Jun 2008 21:23:10 -0400
Message-ID: <20080619012310.GA25307@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org> <20080618224919.GA22599@sigill.intra.peff.net> <alpine.LFD.1.10.0806181552590.2907@woody.linux-foundation.org> <20080618231316.GB23053@sigill.intra.peff.net> <alpine.LFD.1.10.0806181632080.2907@woody.linux-foundation.org> <20080619000842.GA25117@sigill.intra.peff.net> <alpine.LFD.1.10.0806181721580.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 03:24:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K98sk-0000vs-4E
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 03:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbYFSBXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 21:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754006AbYFSBXO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 21:23:14 -0400
Received: from peff.net ([208.65.91.99]:1606 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753960AbYFSBXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 21:23:13 -0400
Received: (qmail 16045 invoked by uid 111); 19 Jun 2008 01:23:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 18 Jun 2008 21:23:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2008 21:23:10 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806181721580.2907@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85440>

On Wed, Jun 18, 2008 at 05:23:21PM -0700, Linus Torvalds wrote:

> > Have you read "man git-config" lately?
> 
> That whole program is there just for scripting. Of _course_ it talks about 
> the machine format!

Forget the command git-config; all of the config _variables_ are
documented in "foo.bar" form. Name one place in all of the documentation
where the user can find out about core.pager, but the "foo.bar" form is
not used.

-Peff
