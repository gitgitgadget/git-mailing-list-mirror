From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] push: fix local refs update if already up-to-date
Date: Tue, 4 Nov 2008 21:51:16 -0500
Message-ID: <20081105025116.GB20907@coredump.intra.peff.net>
References: <20081104000745.GA28480@localhost> <20081104042643.GA31276@coredump.intra.peff.net> <20081104205743.GA26788@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Nov 05 03:52:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxYVU-0008Hd-CY
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 03:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbYKECvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 21:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754392AbYKECvS
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 21:51:18 -0500
Received: from peff.net ([208.65.91.99]:3133 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753950AbYKECvS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 21:51:18 -0500
Received: (qmail 11452 invoked by uid 111); 5 Nov 2008 02:51:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 04 Nov 2008 21:51:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2008 21:51:16 -0500
Content-Disposition: inline
In-Reply-To: <20081104205743.GA26788@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100136>

On Tue, Nov 04, 2008 at 09:57:43PM +0100, Clemens Buchacher wrote:

> On Mon, Nov 03, 2008 at 11:26:44PM -0500, Jeff King wrote:
> > Nit: Just reading the test, it is hard to see what is interesting about
> > it (though obviously I can blame it back to your commit :) ). Maybe a
> > more descriptive title like 'push updates uptodate local refs' would
> > make sense.
> 
> That is all I changed in this update. Pending an Ack/Nack from Jeff I feel
> that I'm done.

I have to NAK, because the extra written ref is still a problem (see my
other mail). But with that fix (and I hope you both will agree with the
style fixup on removing new_sha1, too), I think it should be good.

-Peff
