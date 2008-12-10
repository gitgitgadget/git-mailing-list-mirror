From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] diff: fix handling of binary rewrite diffs
Date: Wed, 10 Dec 2008 04:04:07 -0500
Message-ID: <20081210090407.GB11367@coredump.intra.peff.net>
References: <20081209081227.GA19626@coredump.intra.peff.net> <7vvdts1l92.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 10:05:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAL0a-0002sc-3l
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 10:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbYLJJEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 04:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbYLJJEK
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 04:04:10 -0500
Received: from peff.net ([208.65.91.99]:1579 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbYLJJEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 04:04:09 -0500
Received: (qmail 7518 invoked by uid 111); 10 Dec 2008 09:04:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 10 Dec 2008 04:04:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2008 04:04:07 -0500
Content-Disposition: inline
In-Reply-To: <7vvdts1l92.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102677>

On Wed, Dec 10, 2008 at 12:34:49AM -0800, Junio C Hamano wrote:

> > +		for j in 1 2 3 4 5 6 7 9 10; do
> Hmm... "1 2 3 4 5 6 7 9 10"?

Heh. Oops.

I see you fixed this up as 1 through 9. My intent was 1 through 10, but
it really doesn't matter. The point is just to hit the minimum break
size, and I left a lot of leeway in case it ever gets increased later.

-Peff
