From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] send-pack: check ref->status before updating
	tracking refs
Date: Sat, 17 Nov 2007 08:53:22 -0500
Message-ID: <20071117135322.GA3992@sigill.intra.peff.net>
References: <20071117125323.GA23125@sigill.intra.peff.net> <20071117125515.GB23186@sigill.intra.peff.net> <20071117134546.GC2716@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 14:53:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItO7D-0002m7-Ov
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 14:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbXKQNx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 08:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbXKQNx0
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 08:53:26 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4855 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926AbXKQNx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 08:53:26 -0500
Received: (qmail 4183 invoked by uid 111); 17 Nov 2007 13:53:24 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 17 Nov 2007 08:53:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 08:53:22 -0500
Content-Disposition: inline
In-Reply-To: <20071117134546.GC2716@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65279>

On Sat, Nov 17, 2007 at 02:45:46PM +0100, Alex Riesen wrote:

> > +test_expect_success 'deleted branches have their tracking branches removed' '
> > +	git push origin :b1 &&
> > +	test "$(git rev-parse origin/b1)" = "origin/b1"
> > +'
> > +
> >  test_done
> 
> Oh, missed that.
> 
> Completely-Acked-By: Alex "Sleepy" Riesen <raa.lkml@gmail.com>

Yes, I didn't put it in the first patch, because it was broken there. ;)

-Peff
