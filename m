From: Jeff King <peff@peff.net>
Subject: Re: teach git diff -v/--invert-match?
Date: Tue, 26 Aug 2008 20:38:18 -0400
Message-ID: <20080827003818.GD7347@coredump.intra.peff.net>
References: <48AED264.60600@visi.com> <20080822193947.GA31322@coredump.intra.peff.net> <48B27E51.2020709@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Ericson <bme@visi.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 02:39:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY94J-0006S2-At
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 02:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbYH0AiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 20:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754052AbYH0AiV
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 20:38:21 -0400
Received: from peff.net ([208.65.91.99]:2518 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754030AbYH0AiU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 20:38:20 -0400
Received: (qmail 3256 invoked by uid 111); 27 Aug 2008 00:38:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 26 Aug 2008 20:38:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2008 20:38:18 -0400
Content-Disposition: inline
In-Reply-To: <48B27E51.2020709@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93843>

On Mon, Aug 25, 2008 at 11:41:37AM +0200, Paolo Bonzini wrote:

> > I would have thought "-v" meant "match any changes which do not have
> > this pattern". But you want "match any changes that have any line which
> > does not have this pattern."
> 
> Yours could be "-L/--without-match" (in grep, -L/--files-without-match
> only prints the names of files containing no match).

Ah, yes, that would be better. I think we decided that Brian's original
problem didn't really work with -S, and I don't actually need this
behavior enough to implement it. But your suggestion is a good one if
somebody cares to do so.

-Peff
