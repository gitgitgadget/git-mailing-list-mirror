From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] avoid trailing whitespace in zero-change diffstat
	lines
Date: Sat, 14 Jun 2008 03:30:12 -0400
Message-ID: <20080614073012.GA17568@sigill.intra.peff.net>
References: <20080614064857.GA8930@sigill.intra.peff.net> <20080614065614.GC9006@sigill.intra.peff.net> <7vtzfwh45d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 09:31:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7QEA-0000GK-Q1
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbYFNHaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753021AbYFNHaQ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:30:16 -0400
Received: from peff.net ([208.65.91.99]:4269 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722AbYFNHaP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 03:30:15 -0400
Received: (qmail 31285 invoked by uid 111); 14 Jun 2008 07:30:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 14 Jun 2008 03:30:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jun 2008 03:30:12 -0400
Content-Disposition: inline
In-Reply-To: <7vtzfwh45d.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84986>

On Sat, Jun 14, 2008 at 12:22:38AM -0700, Junio C Hamano wrote:

> > This isn't a huge problem, but in cleaning up the output we are able to
> > eliminate some trailing whitespace from a test vector.
> 
> This is why I love your patches.  Not merely fixing superficial issues but
> doing so with _real thinking_ ;-)

Heh. I am still trying to remove the brown paper bag from sending
patches to the test scripts that don't even pass!

-Peff
